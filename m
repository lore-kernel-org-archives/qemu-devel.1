Received: from eggs.gnu.org ([2001:4830:134:3::10]:33413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5J0G-0001yn-QY
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5J0C-0000T9-Q1
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:09:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5J0C-0000Sc-GD
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:09:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DE1933A188
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 22:09:19 +0000 (UTC)
References: <20171016131644.9565-1-kraxel@redhat.com>
	<20171016131644.9565-8-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e41b2fbc-98ed-cabb-4236-2126b887626c@redhat.com>
Date: Thu, 19 Oct 2017 17:09:13 -0500
MIME-Version: 1.0
In-Reply-To: <20171016131644.9565-8-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oUkBEocNNnoAvCBQLMvmAP62X1naDOVpV"
Subject: Re: [Qemu-devel] [PULL 07/11] tools: add qemu-keymap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oUkBEocNNnoAvCBQLMvmAP62X1naDOVpV
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e41b2fbc-98ed-cabb-4236-2126b887626c@redhat.com>
Subject: Re: [Qemu-devel] [PULL 07/11] tools: add qemu-keymap
References: <20171016131644.9565-1-kraxel@redhat.com>
 <20171016131644.9565-8-kraxel@redhat.com>
In-Reply-To: <20171016131644.9565-8-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/16/2017 08:16 AM, Gerd Hoffmann wrote:
> qemu-keymap generates qemu reverse keymaps from xkb keymaps,
> which can be used with the qemu "-k" command line switch.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-id: 20171005153330.19210-2-kraxel@redhat.com
> ---
>  configure     |  23 ++++++
>  Makefile      |   5 ++
>  qemu-keymap.c | 258 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 286 insertions(+)
>  create mode 100644 qemu-keymap.c

For in-tree builds, this forgot to update .gitignore so that
'qemu-keymap' isn't accidentally checked in via 'git add -a'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oUkBEocNNnoAvCBQLMvmAP62X1naDOVpV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnpIokACgkQp6FrSiUn
Q2qDgAgAmL2gjH/zV1aBme0MEiX1f4+qUBn8h4jpB3qJzt1g1joH5IXWScFJMdoe
F+g4/BZrUe5zrjrd4foBaQ9EjZGUEko0FV5E+KnHCPeOUOomyw0CegUJkZd9hWCw
Kh8DrqhL4OL3059GJWhAq/GZ0x49TZuFkRaekeD8fGu2fkofjKF1GUAFbx+tutmg
IFSOqZ2pkEKoDWdrS8wUDhLkvNnqKnr2wW0W1Y1RtByPaaNdDkuDZHxq1sUDL+Wr
yk0/o9/OZPBt3D49svKOHeREEMiRh2U2Bk9vKiFEiQSdEL0WZbr2/8H/6DV197yQ
2nnFaS6+ufmRI+MWTSQgfaiqPmZvQA==
=trf0
-----END PGP SIGNATURE-----

--oUkBEocNNnoAvCBQLMvmAP62X1naDOVpV--
