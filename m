Received: from eggs.gnu.org ([2001:4830:134:3::10]:43411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwVQi-0001Q4-9S
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwVQf-0005o3-L8
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:04:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cwVQf-0005n3-Cr
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:04:01 -0400
References: <20170407143254.22061-1-dgilbert@redhat.com>
	<a9e3490a-0a70-7b9d-53cb-0a2fd389c796@redhat.com>
	<20170407145634.GA2623@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <130e1495-72f5-7ab5-0f25-0e3cb65006dc@redhat.com>
Date: Fri, 7 Apr 2017 10:03:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170407145634.GA2623@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kotnhcC115IgLbQOKIMlfJlsU4cvn4JLm"
Subject: Re: [Qemu-devel] [PATCH for 2.10] slirp/smb: Replace constant
 strings by glib string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kotnhcC115IgLbQOKIMlfJlsU4cvn4JLm
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org,
 jan.kiszka@siemens.com, berrange@redhat.com
Message-ID: <130e1495-72f5-7ab5-0f25-0e3cb65006dc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] slirp/smb: Replace constant strings
 by glib string
References: <20170407143254.22061-1-dgilbert@redhat.com>
 <a9e3490a-0a70-7b9d-53cb-0a2fd389c796@redhat.com>
 <20170407145634.GA2623@work-vm>
In-Reply-To: <20170407145634.GA2623@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2017 09:56 AM, Dr. David Alan Gilbert wrote:

>=20
>> The cleanup is useful, and resolves one of the build issues I pointed
>> out earlier on Rawhide (looks like it is now Fedora 26 in addition to
>> Rawhide that have new-enough gcc).  In that thread, we argued that it'=
s
>> not going to be essential to get this in for 2.9, but as more and more=

>> people move to newer gcc, it will probably be a candidate for
>> qemu-stable for 2.9.1 in addition to 2.10.
>=20
> Ah which thread is that?

https://lists.gnu.org/archive/html/qemu-devel/2017-03/threads.html#04552
in particular
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04567.html

> I just posted:
> https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg01294.html

Yes, I just saw that. And it is indeed hacky, but maybe it will spur
some proper patches.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kotnhcC115IgLbQOKIMlfJlsU4cvn4JLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY56peAAoJEKeha0olJ0Nqxw8H/1/fXcuw40iAVBkSDKgTvZHo
2lZBkyTag7nN8W08rvJ3myfrNt5ESyxK/tqdid3X+C0ywIUDu5A62iw4T/dbePU+
HalTLkwxk/MTm1KPc3sqAKSzMfpnaBWBeYtN9hB2OFT2e9W0wMJhW2j2PWaS3d/f
jFr67yMDptuC82xxzGrXu1+QdAhHXZ3KArSr+WnRXyBz1UmmmP+XOCQ7uEmmfouo
1s5y7ch3Pjx28aMXJ789oKp2/qScEONEKiYxMh7vh4LUomug5e9gd0UZIUkCugMb
yaI8K5UeYzyWuz7Laa3sIS+dOZxBhja2lbCDe5CHrMDE5btYap1FxKFSkAaSv3s=
=Exs0
-----END PGP SIGNATURE-----

--kotnhcC115IgLbQOKIMlfJlsU4cvn4JLm--
