Received: from eggs.gnu.org ([2001:4830:134:3::10]:40606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG3an-0003L6-TT
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG3an-0008BB-2L
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:23:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dG3am-0008Ah-QO
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:23:17 -0400
References: <20170530100736.3338-1-roman.penyaev@profitbricks.com>
	<20170531130609.GE16733@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3066658b-be68-a69a-6f9e-5c8801bc7091@redhat.com>
Date: Wed, 31 May 2017 15:22:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170531130609.GE16733@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JvxQLSVTQ0jQalVl0qGJkoqaa1Nx30VXK"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] coroutine-lock: do not touch
 coroutine after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Roman Pen <roman.penyaev@profitbricks.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JvxQLSVTQ0jQalVl0qGJkoqaa1Nx30VXK
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Roman Pen <roman.penyaev@profitbricks.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <3066658b-be68-a69a-6f9e-5c8801bc7091@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] coroutine-lock: do not touch
 coroutine after another one has been entered
References: <20170530100736.3338-1-roman.penyaev@profitbricks.com>
 <20170531130609.GE16733@stefanha-x1.localdomain>
In-Reply-To: <20170531130609.GE16733@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 31/05/2017 15:06, Stefan Hajnoczi wrote:
>> +
>> +    while ((next =3D QSIMPLEQ_FIRST(&tmp_queue_wakeup))) {
>> +        QSIMPLEQ_REMOVE_HEAD(&tmp_queue_wakeup, co_queue_next);
>>          qemu_coroutine_enter(next);
>>      }
>>  }
> What happens if co remains alive and qemu_coroutine_enter(next) causes
> additional coroutines to add themselves to co->co_queue_wakeup?

Wouldn't that happen only if co is entered again?  Then it will also
reenter qemu_co_queue_run_restart, which may cause a different wakeup
order but not any missing wakeups.

Paolo


--JvxQLSVTQ0jQalVl0qGJkoqaa1Nx30VXK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlkuw7YACgkQv/vSX3jH
roOYJggAr5jrBRwlAC8qeEpZEjaPoYQWZhOJ0lv6CntSmDuKTJBdrAiJTPGDfQpG
25vZ921xjMAOb0TXXRzw4DMNF8kln0WbfTFkq7fCz9NeNdBouZiYvfiUaaym+1lr
/mx+zXQo/X2A3YWOhelL1d0iml5U3pHvzdsUsPmg+4buRExZLaoNll2US6i0ESN7
6ESEvUv1ClcTpnCU/Nf6jMTO6ye8LAX8lmHAlRyQ1TZ2JPkuKvkkqWhL2eQDxCCE
mT1t5be5rN/QBSRqs8JKWA7h6QWoAMIUKpDfr0erFHNuEpMM7n1f1vIa7Mx5gkKb
50xLGTddnjvfX6C/MZ8vBUu+OXQFfw==
=tbFy
-----END PGP SIGNATURE-----

--JvxQLSVTQ0jQalVl0qGJkoqaa1Nx30VXK--
