Received: from eggs.gnu.org ([2001:4830:134:3::10]:34627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1demOb-000398-G7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1demOW-0001Q5-Jt
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1demOW-0001PV-B7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:04:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB20E356F3
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 18:04:46 +0000 (UTC)
References: <1502124810-6930-1-git-send-email-dverma@redhat.com>
	<1502124810-6930-2-git-send-email-dverma@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8da5e54-bc7d-583c-0046-5c33040943b3@redhat.com>
Date: Mon, 7 Aug 2017 13:04:39 -0500
MIME-Version: 1.0
In-Reply-To: <1502124810-6930-2-git-send-email-dverma@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6j0vP82j5U9LjRsf0dwaGTMRa4Ggjx0G4"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] Fix format and styles;
 make code more pythonic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dverma <dverma@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, jen@redhat.com, quintela@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6j0vP82j5U9LjRsf0dwaGTMRa4Ggjx0G4
From: Eric Blake <eblake@redhat.com>
To: dverma <dverma@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, jen@redhat.com, quintela@redhat.com
Message-ID: <f8da5e54-bc7d-583c-0046-5c33040943b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] Fix format and styles; make code more
 pythonic
References: <1502124810-6930-1-git-send-email-dverma@redhat.com>
 <1502124810-6930-2-git-send-email-dverma@redhat.com>
In-Reply-To: <1502124810-6930-2-git-send-email-dverma@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 11:53 AM, dverma wrote:
> - Format fixes, cleaned up the print statement
> - Style fixes, e.g. changed "if not x in y" to "if x not in y"
> - Improved variable names
> ---

Missing a Signed-off-by: tag; without that, we can't accept the patch.
Can you please resubmit with that fixed?  More hints at
https://wiki.qemu.org/index.php/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6j0vP82j5U9LjRsf0dwaGTMRa4Ggjx0G4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIq7cACgkQp6FrSiUn
Q2p3HggAm5nY+kI0/z+5WXLVqCWbM1Pa0SpIxPmAPwa3Ku1uahWmrNTVjuznIjEN
lnwfv/DgJBHI/vHGj6C9BgluO3dRkL/OQy+pGfg4Zez02gXGajRkpuVqfz10tBdr
J53C1IZy4N5B+p1lzU1Ruo0WvlxsrRgCa7tgwYmVfVTFfmf4i92ksrX9Q3La1xte
XionU5PPuymy6ZDVPVG2ub2r0NOhWBmKBYsk71/1eZSo1+GigKxWo5A9uXCyyJGV
yfJz7KrZWNB7Ew9mB+z9X0jL2U/KrIljCXjIejqrcYC/LeTdkyRhxWcI8OSmBHUk
vyDS0IcNy3xSx8YqmYIPX/389KB4xw==
=IKAa
-----END PGP SIGNATURE-----

--6j0vP82j5U9LjRsf0dwaGTMRa4Ggjx0G4--
