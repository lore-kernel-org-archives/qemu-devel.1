Received: from eggs.gnu.org ([2001:4830:134:3::10]:45298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coHTk-0002Sx-41
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 18:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coHTg-0001CH-4L
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 18:33:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1coHTf-0001C9-SB
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 18:33:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C083C3B731
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 22:33:07 +0000 (UTC)
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-7-eblake@redhat.com>
	<20170313200752.GG5512@work-vm>
	<89b9b8e6-b5ca-8056-783b-598e07bf5da0@redhat.com>
	<20170314113234.GE2445@work-vm>
	<8f837495-f773-9cad-004b-1f1f592c4244@redhat.com>
	<9199bbb8-a6c5-be00-3bba-be128d68dd9f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36931d24-36ac-ee87-8314-b7ad3f09544a@redhat.com>
Date: Wed, 15 Mar 2017 17:33:03 -0500
MIME-Version: 1.0
In-Reply-To: <9199bbb8-a6c5-be00-3bba-be128d68dd9f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n9vneP0nPRbLEs78vjH7llMcN2J7I320N"
Subject: Re: [Qemu-devel] [PATCH v2 06/30] trace: Fix parameter types in
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n9vneP0nPRbLEs78vjH7llMcN2J7I320N
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Juan Quintela <quintela@redhat.com>
Message-ID: <36931d24-36ac-ee87-8314-b7ad3f09544a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/30] trace: Fix parameter types in
 migration
References: <20170313195547.21466-1-eblake@redhat.com>
 <20170313195547.21466-7-eblake@redhat.com> <20170313200752.GG5512@work-vm>
 <89b9b8e6-b5ca-8056-783b-598e07bf5da0@redhat.com>
 <20170314113234.GE2445@work-vm>
 <8f837495-f773-9cad-004b-1f1f592c4244@redhat.com>
 <9199bbb8-a6c5-be00-3bba-be128d68dd9f@redhat.com>
In-Reply-To: <9199bbb8-a6c5-be00-3bba-be128d68dd9f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 02:55 PM, Eric Blake wrote:

>> Okay, my next version will insert an explicit cast in any caller that =
is
>> otherwise passing a __u64 (since we can't guarantee what type __u64
>> resolves to, and therefore what format string is appropriate for it).
>=20
> Or maybe I will just omit those changes from my next version, in lieu o=
f
> a gcc bug report.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D80060 if you are intereste=
d

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--n9vneP0nPRbLEs78vjH7llMcN2J7I320N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYycEfAAoJEKeha0olJ0NqNU8H/14LKdlOaUE2BRz22o05hSUu
gallVYJ41VYXYDdtWmE4CD8VeaDOYgDSST4o1ZimjbDEO4e4KEZ73N3D2Ij1E/vI
2TULvCeATxnH2JKpquJgal6tt6C/0DEmS+LRfspDmVePdrTZa2nhTTxHuUNpc+dX
5hCtZ4zDsRT8Wbv4xvZEO7XxU44lvxYpfaENUY6Ji6dmTxuQcuSFCBi5cdf5nyPI
TxXyMcdqGux5c8LqJpdgoEQSvsk1tKuzv1zP53VEqv2sJgT4xDJPtlDWpmxt2OMY
etZfT9oICB1Ot6XMnr0OPNLISeQCPVZfjFI1BoZpnWdPCCDaoJhLQ9Yv5VAwPxk=
=nJPI
-----END PGP SIGNATURE-----

--n9vneP0nPRbLEs78vjH7llMcN2J7I320N--
