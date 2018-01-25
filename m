Received: from eggs.gnu.org ([2001:4830:134:3::10]:46136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eej8b-0002CQ-TF
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eej8S-00030L-Tq
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:08:25 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-5-git-send-email-walling@linux.vnet.ibm.com>
	<2a6618d7-566b-bec7-c267-26e4e7acb1a2@redhat.com>
	<ded3d6a0-3432-368a-3964-6641c7fef3fe@linux.vnet.ibm.com>
	<24ede72f-bc12-0911-a5c6-5d38fac2c060@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cfd9af56-8122-e195-f89f-e219bec9b23c@redhat.com>
Date: Thu, 25 Jan 2018 09:08:09 -0600
MIME-Version: 1.0
In-Reply-To: <24ede72f-bc12-0911-a5c6-5d38fac2c060@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BE0OW0nezxlyF8j6orp5eTtf3Xs7GIHyY"
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 04/10] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BE0OW0nezxlyF8j6orp5eTtf3Xs7GIHyY
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>,
 "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com,
 alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com
Message-ID: <cfd9af56-8122-e195-f89f-e219bec9b23c@redhat.com>
Subject: Re: [qemu-s390x] [Qemu-devel] [PATCH v4 04/10] s390-ccw: update libc
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
 <1516732013-18272-5-git-send-email-walling@linux.vnet.ibm.com>
 <2a6618d7-566b-bec7-c267-26e4e7acb1a2@redhat.com>
 <ded3d6a0-3432-368a-3964-6641c7fef3fe@linux.vnet.ibm.com>
 <24ede72f-bc12-0911-a5c6-5d38fac2c060@redhat.com>
In-Reply-To: <24ede72f-bc12-0911-a5c6-5d38fac2c060@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2018 06:06 AM, Thomas Huth wrote:
>>> That's not "any whitespace", but only spaces.=C2=A0 A fully compliant=

>>> implementation would be checking isspace(), but I don't expect you to=

>>> implement that; at a minimum, also checking '\t' would get you closer=

>>> (but not all the way to) compliance.
>>
>>
>> I'll fix the comment to be more clear.
>>
>> I think it's okay to just have the menu code treat any other kind
>> of whitespace as an error (it will check before calling atoi). I
>> added support for negatives in bothfunctions because it was easy
>> enough to do so and for the sakeof completeness.
>>
>> However, I worry trying to be 100% compliant will just bloat the
>> code when we only need it for very specific use cases.
>>
>> Would you say what we have (along with the fix to itostr below) is
>> sufficient enough?
>=20
> IMHO the current way is good enough for a BIOS implementation. We're no=
t
> doing a full replacement of glibc here ;-)

Documenting the issue is the best approach; don't bloat the code for
something that none of the callers care about.  Perhaps as simple as addi=
ng:

NOTE: This function is not quite like the standardized version in libc;
it does not handle all forms of leading space or INT_MIN.

(or whatever the actual differences are, based on your implementation
choices).

Another solution is to just not use the standardized name; keeping it
named _atoi() instead of atoi() makes it obvious that you are calling an
internal function that does not have to have standardized semantics.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BE0OW0nezxlyF8j6orp5eTtf3Xs7GIHyY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpp8tkACgkQp6FrSiUn
Q2prJwf9HzWp/8RXfqqNb1ejbWUDnSHeK9A87vxjtC/1Wzc0uNlaPZPYVYWCt2y7
Roh1hah7IVu0AnKa0vX1U4tFntmkks4V7PeaO3WdYKja5CcuZtrbevjbtL5fX6/C
iOgxi3KgZdbrSGCv22U7RyZIYClLLpeXxyr8IoVN7t6j024Cq/b5BjMbrezgWDoL
wmsQqdVP61t9PYh+AyE7onPUsqA3fXysC8ijeL4AOK0Kg7ZUyxMPj26aMroUfNzA
4B0aK8lELPql+DYPsEM6dyZuJT4mk0wOaHycQw8mELJYbmt6B6xpgbIxz+fsgNz9
3QW+izLKEzOBWLNK6YoeMX7MzjO+rA==
=iWTq
-----END PGP SIGNATURE-----

--BE0OW0nezxlyF8j6orp5eTtf3Xs7GIHyY--
