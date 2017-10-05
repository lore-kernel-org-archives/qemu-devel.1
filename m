Received: from eggs.gnu.org ([2001:4830:134:3::10]:34292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e08PE-0003iM-Qk
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e08PA-00065N-OL
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:49:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e08PA-00064W-F3
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:49:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EA62883D9
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 15:49:42 +0000 (UTC)
References: <20171005153330.19210-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24a93e2e-be18-c6f1-ee6c-18acba5fee53@redhat.com>
Date: Thu, 5 Oct 2017 10:49:39 -0500
MIME-Version: 1.0
In-Reply-To: <20171005153330.19210-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eaw1AsKVuK5xPB57hgm2HulVKI7fIc3fK"
Subject: Re: [Qemu-devel] [PATCH 0/3] update keymaps
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
--eaw1AsKVuK5xPB57hgm2HulVKI7fIc3fK
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <24a93e2e-be18-c6f1-ee6c-18acba5fee53@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] update keymaps
References: <20171005153330.19210-1-kraxel@redhat.com>
In-Reply-To: <20171005153330.19210-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/05/2017 10:33 AM, Gerd Hoffmann wrote:
>   Hi,
>=20
> This is a major of the qemu reverse keymaps in pc-bios/keymaps.
>=20
> First patch adds a new qemu-keymap tool which can generate these
> maps from xkbcommon data.  That allows to stop the error-prone
> manual maintainance of the reverse keymaps, and it allows to easily
> update reverse keymaps on keymap changes.
>=20
> Second patch adds a Makefile to pc-bios/keymaps, with the correct
> qemu-keymap arguments for all keymaps where I could figure what they
> are supposed to be.  Hints for the remaining ones are very welcome.
>=20
> Third patch updates all the keymaps.  If you want test the new keymaps
> it is enough to apply just that third patch.
>=20
> If you want play with the new qemu-keymap tool you should apply this
> series on top of daniel's keycodemapdb patch series.

Let's tell that to patchew:

Based-on:
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00918.html
([PULL 0/6] Ui 20171005 patches)

even if we know that pull request needs a v2 to solve parallel make races=
=2E

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eaw1AsKVuK5xPB57hgm2HulVKI7fIc3fK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnWVJMACgkQp6FrSiUn
Q2o8oAf/bu4TyZWGhCBgT38xAkGcHG+7t/5JrLyFmtf8qWWHj8dDWs+FsjmtzeBy
MfWvV+O2G10ay5hUmdKTngalpCQSfTGYB2TDuUNOYTroC2i9vU+U14sbPUS1Abm8
cqXbhFfzsufSnn+qAA3G7fX1FBzT6xB4VNzNhxQ2qz/Cz+iRBpfIQJcvFbJamWMG
JDj+A2fLKnpI9tKLb033Jpt++nA6wloT8vepWQui0oGodjfu/vKGb7O5ws9rI1BA
IGGD+GMrJbwuF3/Kal/3Q2jaRmnCO67vnRSqFwUTVQUGHbAQ5XuqSO49AjG3qTzM
KTVnzsPubPlvDwNvVB9bic6RROzKiQ==
=44In
-----END PGP SIGNATURE-----

--eaw1AsKVuK5xPB57hgm2HulVKI7fIc3fK--
