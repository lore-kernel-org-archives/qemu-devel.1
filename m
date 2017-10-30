Received: from eggs.gnu.org ([2001:4830:134:3::10]:48092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e99gi-0004X6-VK
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e99gd-0006KI-TA
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:01:07 -0400
References: <20171027104037.8319-1-eblake@redhat.com>
	<20171027104546.8582-1-eblake@redhat.com>
	<87d8006a-f345-452c-033d-1769982395bc@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d05bb732-2bfa-4df7-ce87-9d2985792c55@redhat.com>
Date: Mon, 30 Oct 2017 14:00:40 +0100
MIME-Version: 1.0
In-Reply-To: <87d8006a-f345-452c-033d-1769982395bc@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iWOnLAfBrBP8WXAs3svFN5QNxk16Aj9pi"
Subject: Re: [Qemu-devel] [RFC PATCH v6 13/12] tweak test 83 verbosity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iWOnLAfBrBP8WXAs3svFN5QNxk16Aj9pi
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <d05bb732-2bfa-4df7-ce87-9d2985792c55@redhat.com>
Subject: Re: [RFC PATCH v6 13/12] tweak test 83 verbosity
References: <20171027104037.8319-1-eblake@redhat.com>
 <20171027104546.8582-1-eblake@redhat.com>
 <87d8006a-f345-452c-033d-1769982395bc@virtuozzo.com>
In-Reply-To: <87d8006a-f345-452c-033d-1769982395bc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/30/2017 01:34 PM, Vladimir Sementsov-Ogievskiy wrote:
> 27.10.2017 13:45, Eric Blake wrote:
>> Commenting these two lines is enough to avoid the change to 083.out
>> in 12/12.=C2=A0 That is evidence that we may want these two lines to b=
e
>> trace points rather than error messages; or maybe we really do like
>> the extra verbosity in the case of an unexpected communication break.
>>
>> This patch does not meet coding guidelines, and I'm not proud enough
>> of it to give S-o-b, but I'm posting it for conversation.
>>

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report_err(local_err=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //error_report_err(local_e=
rr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>=20
> commenting is not ok, you should call error_free instead.

Indeed, and that's why I marked this RFC and used the wrong style
comment, to make it obvious that if we aren't going to print an error
message, there are better ways to go about doing that which don't leak
memory.  The question is whether the output is useful, or whether it
should be only via a trace (as it is, we aren't yet tracing anything in
block/nbd-client.c), or whether it is always just extra noise (in which
case passing the errp parameter around isn't helpful).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iWOnLAfBrBP8WXAs3svFN5QNxk16Aj9pi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln3IngACgkQp6FrSiUn
Q2p0UggAgCwNu5n6/UAyUVmfifFoap97tWzdWlT2AQniBTsvHmeUiUCBMupQNhbJ
6fu65gBIQuH4dqr0BETBDdDI6mlcrIyAQutGsQYf88btcHmsQ0U7LHWUTj3yqcpO
fs6ebmedlbUl41AEW7BHmAIwsXV19pVJ74V1VHFW8DEOiYL5dR3sMmt5lLgAbIlp
QtfxRBTzlSHYP2CQQIhWxZZkyNQvwobdWk4MkpuxuJQTom6hqwrH1XR/Hf6UBPRr
VRJpwsG7V8FzY9U+inbyCLTHkZZZLI+MYrJ3JRn+EwuW9LdY2JlnwH+jAm0OiqR0
ymdhqUcZX+/fnSGpYQrv+YUzH2QFOw==
=bGvk
-----END PGP SIGNATURE-----

--iWOnLAfBrBP8WXAs3svFN5QNxk16Aj9pi--
