Received: from eggs.gnu.org ([2001:4830:134:3::10]:34550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjqFh-0003YL-8X
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjqFc-0005Xx-Do
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:40:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjqFc-0005Xm-59
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:40:16 -0500
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
	<AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
	<20170303162128.GD13631@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7d5aa7e-46a9-efba-bcf2-934b71e3bb74@redhat.com>
Date: Fri, 3 Mar 2017 10:40:13 -0600
MIME-Version: 1.0
In-Reply-To: <20170303162128.GD13631@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xbdw4oAs2W2U8b2PMuolPrkFwB0RUIm7H"
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, G 3 <programmingkidx@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Greg Kurz <groug@kaod.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xbdw4oAs2W2U8b2PMuolPrkFwB0RUIm7H
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 G 3 <programmingkidx@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Greg Kurz <groug@kaod.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>
Message-ID: <e7d5aa7e-46a9-efba-bcf2-934b71e3bb74@redhat.com>
Subject: Re: [Qemu-devel] git master build failure in 9pfs
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
 <8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
 <20170303164426.42472535@bahia.lan>
 <AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
 <20170303162128.GD13631@redhat.com>
In-Reply-To: <20170303162128.GD13631@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 10:21 AM, Daniel P. Berrange wrote:

>>>> I remember years ago something like O_PATH was not defined on Mac OS=

>>>> X,
>>>> so the solution was to define the constant as zero. Something like
>>>> this:
>>>>
>>>> #ifndef O_PATH
>>>> 	#define O_PATH 0
>>>> #endif
>>>>
>>>> Maybe this might work in 9p-util.h.
>>>>

>>
>> +#ifndef O_PATH
>> +    #define O_PATH 0
>> +#endif
>=20
> Isn't the use of O_PATH required in order to fix the recent
> security vulnerability in 9p ?  If so, then defining it to
> 0 means the QEMU is silently becoming vulnerable once again
> which I don't think is a good idea.

My understanding is that O_PATH is an optimization. It lets openat()
succeed in some places where it would ordinarily fail (for example, it
can be used to open a dir with mode 0000) - the resulting fd is
limited-use (it cannot be used to read() or write(), but CAN be used as
the relative fd for a subsequent openat(), for example).  If you define
O_PATH to 0, then attempts to traverse paths will fail where the could
have otherwise succeeded, but failure is okay (the CVE was that we were
succeeding at opening through a guest-controlled symlink; whether we now
fail or guarantee that we are not going through a symlink is a quality
of implementation, but either way, we are at least immune from
succeeding through a symlink).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Xbdw4oAs2W2U8b2PMuolPrkFwB0RUIm7H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuZxtAAoJEKeha0olJ0NqZXcH/jCAZYuGNIJCsQlj1lvGcIbA
Pffpq6a9Zwvqw6bicbbWHmHSiQfkvOYYRyWG/QqOiJ3iZXAqBdudHbfARze+Gg3Y
Zx5IoZ74ZnJokV76XbmTLt4FYhtxXT3lkydIFo2W0CWOTrWD3cHHmQJFXOH/8plX
CdBBU8/Ro9Q+vJurx5Gm8J1bl8oeaTfFgj11OPHxrP5KF6iNfhHEKq7MDSbWZbHK
LbZWiV5ssKJsqQMH/jgiei1lGHGhMw+Gv4VjWl/iVrcl8Otg+uWl+GsCwxZxaUVF
iCfo6gmfOo3OVISPXXlkub9D49lgCufDjO+d3aNV5M5hNSegMkL1Tt/i37z8Pg0=
=sXh9
-----END PGP SIGNATURE-----

--Xbdw4oAs2W2U8b2PMuolPrkFwB0RUIm7H--
