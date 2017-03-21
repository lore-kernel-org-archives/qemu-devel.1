Received: from eggs.gnu.org ([2001:4830:134:3::10]:39021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqJjI-0002A9-1H
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqJjE-0000MC-Ut
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:21:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqJjE-0000M3-Lp
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:21:36 -0400
References: <20170321031705.22291-1-eblake@redhat.com>
	<20170321031705.22291-2-eblake@redhat.com>
	<fb42e59d-f196-84a3-420f-dc488ef62c53@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6cb7d791-8cf5-3a48-572e-30370b1bf608@redhat.com>
Date: Tue, 21 Mar 2017 08:21:33 -0500
MIME-Version: 1.0
In-Reply-To: <fb42e59d-f196-84a3-420f-dc488ef62c53@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u9nb3Sfd9fkqw3ifW0L5cnvH77H2Pk9Hj"
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: Expose regression in QemuOpts
 visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u9nb3Sfd9fkqw3ifW0L5cnvH77H2Pk9Hj
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <6cb7d791-8cf5-3a48-572e-30370b1bf608@redhat.com>
Subject: Re: [PATCH 1/2] tests: Expose regression in QemuOpts visitor
References: <20170321031705.22291-1-eblake@redhat.com>
 <20170321031705.22291-2-eblake@redhat.com>
 <fb42e59d-f196-84a3-420f-dc488ef62c53@redhat.com>
In-Reply-To: <fb42e59d-f196-84a3-420f-dc488ef62c53@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2017 04:01 AM, Laurent Vivier wrote:
> On 21/03/2017 04:17, Eric Blake wrote:
>> Commit 15c2f669e broke the ability of the QemuOpts visitor to
>> flag extra input parameters, but the regression went unnoticed
>> because of missing testsuite coverage.  Add a test to cover this.
>=20
> I don't know where I'm wrong, but when I run this test without the fix
> it never fails.

Intentional:


>> +    v =3D opts_visitor_new(opts);
>> +    /* FIXME: bogus should be diagnosed */
>> +    visit_type_UserDefOptions(v, NULL, &userdef, &error_abort);

The test is written with a FIXME here, then updated in the next patch to
remove the fixme and adjust the condition to what we really want, so
that 'make check-unit' is not broken in the meantime.

A similar approach was taken by Markus in commit 9cb8ef3 (add a test
that passes but shows undesirable behavior with a BUG: note), which also
gets fixed up by my 2/2.  Maybe I should use BUG: instead of FIXME; but
it all goes away in the next patch.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--u9nb3Sfd9fkqw3ifW0L5cnvH77H2Pk9Hj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0SjdAAoJEKeha0olJ0NqGYwH/Ap509f8/7rmUVqOF26YK0g5
vWm/mJ3EXNy4TF8Far6zBN7MfRn7En+NBmBXP1n2oXvvIDfPATtn9+U7BNmGkDR1
lRPLKb0eksbqoGkTI2crUrbCmwXpg0VJHRadwIRNbRhS0DYZZAczjt3haqJhqcxe
kr/OBQop9ZlqK58fq9cm1nTwAMpcFV2DXCrwN2oimLsJaWNWJVSBtmJ2zLEvfmXS
+4N1wht6BGK5in/pY8Llw3sSBFlK8iz7U+t9ELsySiaW0UfxB7dC5JEFbxFQDkmB
mVaNUqahBd9a5qWIGLX8Jkt62FR/6EqUnzQvnl228sQY37eDQS0F9ieKmoBJ5Yg=
=Ahxw
-----END PGP SIGNATURE-----

--u9nb3Sfd9fkqw3ifW0L5cnvH77H2Pk9Hj--
