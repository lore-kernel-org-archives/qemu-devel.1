Received: from eggs.gnu.org ([2001:4830:134:3::10]:58754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dugzN-0001cJ-IU
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dugzK-0001NE-8f
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:32:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dugzJ-0001MA-NP
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:32:34 -0400
References: <20170919180038.26056-1-dgilbert@redhat.com>
	<20170919180038.26056-6-dgilbert@redhat.com>
	<20170920035512.GF18491@lemon> <20170920142040.GE2449@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <80ea7936-97b1-7d82-1373-149d33a811f7@redhat.com>
Date: Wed, 20 Sep 2017 10:32:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170920142040.GE2449@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AxhdUuIgcAmLbbf8daeRbni1khqlCDxSr"
Subject: Re: [Qemu-devel] [PATCH 5/5] migration: Route more error paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: peter.maydell@linaro.org, quintela@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AxhdUuIgcAmLbbf8daeRbni1khqlCDxSr
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fam Zheng <famz@redhat.com>
Cc: peter.maydell@linaro.org, quintela@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, rth@twiddle.net
Message-ID: <80ea7936-97b1-7d82-1373-149d33a811f7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] migration: Route more error paths
References: <20170919180038.26056-1-dgilbert@redhat.com>
 <20170919180038.26056-6-dgilbert@redhat.com> <20170920035512.GF18491@lemon>
 <20170920142040.GE2449@work-vm>
In-Reply-To: <20170920142040.GE2449@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 09:20 AM, Dr. David Alan Gilbert wrote:

>>>      /* Save file with vmstate */
>>> -    vmstate_save_state(f, desc, obj, NULL);
>>> +    g_assert(!vmstate_save_state(f, desc, obj, NULL));
>>
>> Though this is test code, isn't putting anything with a side effect in=
to an
>> assert expression a very bad pattern in general?
>=20
> Hmm; ok I've changed this but I'm not really convinced; the whole point=

> of an asser in a test is to actually run it, and I think the g_assert
> prints the text that failed, so it gives you a much better error inline=
=2E

glib doesn't make life any easier by having two different flavors of
assertions.

g_assert() can be disabled at compile-time (side effects are lost).  It
is roughly akin to assert(); and the output when an assertion fails
isn't that much more useful than what you get with plain assert().

g_assert_cmpint() cannot be disabled at compile-time, but can have a
runtime switch on whether it abort()s or continues on.  Here, the output
when something fails is MUCH more pleasant to read.

But the fact that there are two separate families of g_assert* behaviors
just makes it easier to live by the mantra that side-effects don't
belong inside assertions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AxhdUuIgcAmLbbf8daeRbni1khqlCDxSr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCigoACgkQp6FrSiUn
Q2oUjAf/d0hvlq1aDlucSSMqXDzmCsg7hvAq9410AdKhY4Gq0rRRs23ouL9TfD10
NpRkM+oumz2bT1VZR19LKgy7ZbukHCDaLhhkDHN+mrYmYYyb73g9yyaYsTO5ivfJ
uTHINSPoC77nlXPOqpOjW408LjGeXTETceD7/RhI4krV0WVN0ls9dCfQKw2kjo6o
zE/AUNUAgYWao9uOsqRV7CXv/Vz8G4+mZLh44TJTynD987YvBmeeJh4Vpx2bYEZL
+x3VEUcNj1jov0/9JdTKap4CBdkm2cvgrGCM+oHNHJ0Z0g+yFKh7uAJcKnbsODy0
GcLCS0uuyADQcyHpcJ5qo3bUZLeBDQ==
=jX7h
-----END PGP SIGNATURE-----

--AxhdUuIgcAmLbbf8daeRbni1khqlCDxSr--
