Received: from eggs.gnu.org ([2001:4830:134:3::10]:53236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPVV-0000dm-Cd
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPVS-0003SN-9j
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:51:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBPVS-0003Rx-2q
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:51:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98F57406C748
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 18:51:02 +0000 (UTC)
Received: from [10.10.123.175] (ovpn-123-175.rdu2.redhat.com [10.10.123.175])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6CEFB2026E0E
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 18:50:58 +0000 (UTC)
References: <20180425181915.577851-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ce83a80-38fc-4298-5be0-5e1e712e497f@redhat.com>
Date: Wed, 25 Apr 2018 13:50:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180425181915.577851-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AI5BrUZhENWFsm6g4tuxTMV4uGQPaIWht"
Subject: Re: [Qemu-devel] [PATCH 0/8] block: more byte-based cleanups:
 vectored I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AI5BrUZhENWFsm6g4tuxTMV4uGQPaIWht
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <2ce83a80-38fc-4298-5be0-5e1e712e497f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/8] block: more byte-based cleanups:
 vectored I/O
References: <20180425181915.577851-1-eblake@redhat.com>
In-Reply-To: <20180425181915.577851-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 01:19 PM, Eric Blake wrote:
> In my continuing quest to nuke pointless sector-based interfaces,
> here's another round of cleanups.  I spent some time on qcow,
> then was appalled at how long iotests took to prove that it did
> not regress; so for parallels, replication, and vhdx, I'll leave
> any further cleanups within those files to interested owners.
>=20
> There are now very few remaining calls into bdrv_{read,write}, so
> that will be my next cleanup.

Ignore this one; I sent a cover letter prematurely, before I added
Based-on tags for the real series:
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04444.html


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AI5BrUZhENWFsm6g4tuxTMV4uGQPaIWht
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrgzhEACgkQp6FrSiUn
Q2pFzAf8CXlWeA8wKfOWkj3JBjsbLYUXs4WSi5xg57KvcOFMS/adbhcN+Fopmt+z
HrgoX0h8YQd6IHQp7I+syWt6SwgkSmCUeuz6ZWpbE18C2itil1h8em94Hnvg2wcR
A53LueH3n/s6J8m5+3PiZ/5VGGfxbewbqDZXqlHUzqLgKmmTWmtARHrx9EYOiV1Y
qSUruMoPFbMhEki7YT3xxnHyx+qsnKMVpSbqnJyme/fwsx1ui/+EyQ4qZsCsmmeR
Dji3zssdcagOH+0/QYpfG9uCSNY7kFnsFnT/MCFxUI3mAFOG5w1pamQTdTbDntck
aARJwM1wQeKvPbe86fFAaNhM0Ii3Tg==
=w5B6
-----END PGP SIGNATURE-----

--AI5BrUZhENWFsm6g4tuxTMV4uGQPaIWht--
