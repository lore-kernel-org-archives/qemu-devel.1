Received: from eggs.gnu.org ([2001:4830:134:3::10]:43786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fsmZQ-0005sV-EL
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fsmZM-0000o7-7m
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:10:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1fsmZM-0000nj-1L
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:10:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 810F440216E6
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:10:23 +0000 (UTC)
Message-ID: <a2e32e0be3865b14974ee9f8ac7bce4928b20e88.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 23 Aug 2018 12:10:16 +0200
In-Reply-To: <20180822131554.3398-1-berrange@redhat.com>
References: <20180822131554.3398-1-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] ui: remove deprecated UI frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, 2018-08-22 at 14:15 +0100, Daniel P. Berrang=C3=A9 wrote:
> We deprecated GTK2 and SDL1.2 in the 2.12.0 release, so they are able t=
o
> be removed entirely in the 3.1.0 release. The min GTK3 version can also
> be bumped up based the distros we aim to support.
>=20
> Note that before this can merge, the openbsd VM test image needs to be
> updated to have SDL2, as openbsd build mandates SDL availability.
>=20
> The freebsd & netbsd images should also be updated, but they are not
> build blockers as they automatically disable SDL
>=20
> Changed in v2:
>=20
>  - Rebased to resolve conflicts
>=20
> Daniel P. Berrang=C3=A9 (3):
>   ui: remove support for GTK2 in favour of GTK3
>   ui: increase min required GTK3 version to 3.14.0
>   ui: remove support for SDL1.2 in favour of SDL2

Nit: you might want to tweak some parts of the commit messages,
because they're no longer accurate...

> The GTK 3.0 release was made in Feb, 2011:
>=20
>   https://blog.gtk.org/2011/02/10/gtk-3-0-released/
>=20
> That will soon be 7 years ago, which is enough time to consider
> the 3.x series widely supported.

It's been more than 7 years now.

> The SDL 2.0 release was made in Aug, 2013:
>=20
>   https://www.libsdl.org/release/
>=20
> That will soon be 4 + 1/2 years ago, which is enough time to consider
> the 2.0 series widely supported.

It's been more than 5 years now.

--=20
Andrea Bolognani / Red Hat / Virtualization
