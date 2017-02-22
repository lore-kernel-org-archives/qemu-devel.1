Received: from eggs.gnu.org ([2001:4830:134:3::10]:53800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgaLR-0000LI-ST
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:04:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgaLO-0003yt-LW
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:04:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgaLO-0003xr-Dr
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:04:46 -0500
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
	<20170207001533.3f18e4ea@bahia.lan> <20170207113231.44e35be6@bahia.lan>
	<6b702369-7891-4e38-7240-57ad643657bd@redhat.com>
	<20170207172933.05574f60@bahia.lan>
	<20170214132122.GH23310@stefanha-x1.localdomain>
	<20170222144153.131dee9d@bahia.lan>
	<18735c6a-e21e-6aaf-4283-53f980afae3f@redhat.com>
	<20170222175917.53c27906@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c3877ffd-4506-f8f3-57bc-0c00e4e3a6f4@redhat.com>
Date: Wed, 22 Feb 2017 11:04:42 -0600
MIME-Version: 1.0
In-Reply-To: <20170222175917.53c27906@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ClbBtacONKRAa3HH9TIFpwTqPtlToCiRp"
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ClbBtacONKRAa3HH9TIFpwTqPtlToCiRp
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Pradeep Jagadeesh <pradeepkiruvale@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alberto Garcia <berto@igalia.com>,
 Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org,
 Fam Zheng <famz@redhat.com>
Message-ID: <c3877ffd-4506-f8f3-57bc-0c00e4e3a6f4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
 <71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
 <20170207001533.3f18e4ea@bahia.lan> <20170207113231.44e35be6@bahia.lan>
 <6b702369-7891-4e38-7240-57ad643657bd@redhat.com>
 <20170207172933.05574f60@bahia.lan>
 <20170214132122.GH23310@stefanha-x1.localdomain>
 <20170222144153.131dee9d@bahia.lan>
 <18735c6a-e21e-6aaf-4283-53f980afae3f@redhat.com>
 <20170222175917.53c27906@bahia.lan>
In-Reply-To: <20170222175917.53c27906@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 10:59 AM, Greg Kurz wrote:

>>>> I see these parameter names as stable.  There is little risk that th=
ey
>>>> would change. =20
>>
>> We just need to be sure that when we do add QMP, that it doesn't use
>> names that differ from the command line (blockdev is an example where =
we
>> weren't careful in 2.8, and had to rename things in 2.9 to be
>> consistent, and I want to avoid repeating that mistake).
>>
>=20
> Can you provide some pointers on what had to be fixed in blockdev ?

See for example commits f67409a, 4230e5d, 1a417e4 showing several cases
where we had to fix up inconsistencies.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ClbBtacONKRAa3HH9TIFpwTqPtlToCiRp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrcSqAAoJEKeha0olJ0Nq0P4IAKPBDKrih876sME1pNjVPzx8
Eebu1OPKriP6zvNpWTf/Sn13tnWecE1HY235QkjJkmDHeWxTUbQlc63vTGBSfAdm
QsJ2sOB28NCLD1lNm0BL7s/hNz/BNpkm8IqmEsN12N8lE2b/ibUv2+a4TRGykfPC
oRWV27BDV6Cr2s0T+MRDK2juusoEKO+mquY/yS9I/aTeIfdbpwl26FHctY3Zwjhe
LeN1Yu/EUjUMCUcHYpRRnYDbBWjD0nhO7ceHB0iBuPd+W+wfjlftjKkNEbdKjVjh
xbQqyst4FWV0rRz6/siFwwZEqZLCPTtKgcmKC5Mv29WQYmD+xVBSjCnTxdXw1Rs=
=sb+K
-----END PGP SIGNATURE-----

--ClbBtacONKRAa3HH9TIFpwTqPtlToCiRp--
