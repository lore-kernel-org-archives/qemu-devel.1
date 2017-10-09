Received: from eggs.gnu.org ([2001:4830:134:3::10]:36184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d@vidbuchanan.co.uk>) id 1e1Wf5-0005XY-N4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d@vidbuchanan.co.uk>) id 1e1Wf2-0005xv-C8
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:55:55 -0400
Received: from mx.pawnmail.com ([107.191.103.103]:39728 helo=pawnmail.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d@vidbuchanan.co.uk>) id 1e1Wf2-0005wu-6o
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:55:52 -0400
References: <20170828122906.18993-1-kraxel@redhat.com>
From: David Buchanan <d@vidbuchanan.co.uk>
Message-ID: <e64a628c-3377-f3f5-0646-079a2a175354@vidbuchanan.co.uk>
Date: Mon, 9 Oct 2017 12:55:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170828122906.18993-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NWpfbg4Fc6ub1kicvm2conkMQJtEth5kM"
Subject: Re: [Qemu-devel] [PATCH v2] vga: stop passing pointers to
 vga_draw_line* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NWpfbg4Fc6ub1kicvm2conkMQJtEth5kM
From: David Buchanan <d@vidbuchanan.co.uk>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>
Message-ID: <e64a628c-3377-f3f5-0646-079a2a175354@vidbuchanan.co.uk>
Subject: Re: [PATCH v2] vga: stop passing pointers to vga_draw_line* functions
References: <20170828122906.18993-1-kraxel@redhat.com>
In-Reply-To: <20170828122906.18993-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I might be mistaken, but I don't think this patch actually fixes
CVE-2017-13672. I tested the latest git repo (last commit 530049bc1d)
against my initial reproducer, and QEMU still segfaults.

I think this is because the actual OOB read occurs inside pixman, which
of course is not affected by this patch. Perhaps bounds checks need to
be applied to the arguments passed into pixman?


--NWpfbg4Fc6ub1kicvm2conkMQJtEth5kM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEt87yIm65OG/7THLK9E3dinJwx5kFAlnbY7cACgkQ9E3dinJw
x5nmkwgAjagmq+GBHkHHULP/JR4+FsfWZDifMCt+Ha12HDzd2o9biw9tnWpzpsxf
DAk1BcaPLDIKQE2bT+x1Qso750RZRhTBTnPaPjP+PINVpPdaEbsX1RStISF5Kikn
5/W0UuYrzrVZYAdNoew8O7rkieZlU7ETV/07lueU9sB/8oNWU7eifg1zirIIKAzs
3Z45nw+p6a0a9yJk79EtIwO2PhHAf6JT4ulRD2CzZBGi1dgCrpDXH8/+Im0nClqZ
lkOA8VFAcsuJN92mGfoc7c+UxzlLwziNPHk2KNbF6PTnVSpZwd03/Ld7Bh2Youio
CN62RCPYFr3A74rGtNV+YNeI4dVs4g==
=uJxD
-----END PGP SIGNATURE-----

--NWpfbg4Fc6ub1kicvm2conkMQJtEth5kM--
