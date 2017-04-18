Received: from eggs.gnu.org ([2001:4830:134:3::10]:35358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I5m-0008LI-HS
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I5l-00060O-Eq
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:38:06 -0400
References: <20170418013356.3578-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <965cc176-abea-f747-dd98-dcf16ee44d8f@redhat.com>
Date: Mon, 17 Apr 2017 20:37:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eTbKgTaO81jGB7LTQuFDwnpVFBp1xHljw"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/31] make
 bdrv_get_block_status byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eTbKgTaO81jGB7LTQuFDwnpVFBp1xHljw
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <965cc176-abea-f747-dd98-dcf16ee44d8f@redhat.com>
Subject: Re: [Qemu-block] [PATCH 00/31] make bdrv_get_block_status byte-based
References: <20170418013356.3578-1-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2017 08:33 PM, Eric Blake wrote:
> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
> but NBD wants to report status on byte granularity (even if the
> reporting will probably be naturally aligned to sectors or even
> much higher levels).  I've therefore started the task of
> converting our block status code to report at a byte granularity
> rather than sectors.

Apologies for botching Kevin's address in the mail; if you reply, you'll
want to edit the to list if you don't want a bounce message about an
undeliverable address ;(


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eTbKgTaO81jGB7LTQuFDwnpVFBp1xHljw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9W31AAoJEKeha0olJ0NqTE0H/R0i69qAExtywqdWkzuwmgWQ
VqGMUjh3IDGzDcd65TvtBkSvKTGhEtTipCO5AHbypU3dy6+HIkrpLYvzLqFWbR+c
Zv2J17YaZeC56oY/5LiquksgjC102D/g0oC5OgeOHuZRLVSQZ2CcIsPDPqNnwGUA
dg7L+RFrGQtDMSx8rLCMnFbWu95dvyN8Fvz3mOdkNkSLTjXhc8/4Yi3m1NuS6v7O
iq00R83uSw9aLyhyKwrKvzq/2sl8frfZH30pZ8KbpCJY8elbSq5Y9JY7najX0iPj
Hk6aeFZLLdsmw+ddrLlVAkkV42X75AczBafQd0iMksdN+uNoTXQK89e2COdhHXg=
=9rgq
-----END PGP SIGNATURE-----

--eTbKgTaO81jGB7LTQuFDwnpVFBp1xHljw--
