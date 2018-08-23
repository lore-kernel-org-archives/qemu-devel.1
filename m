Received: from eggs.gnu.org ([2001:4830:134:3::10]:52451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fslUq-0000Le-Qu
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fslUl-0005g9-0w
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:01:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fslUk-0005fu-Rz
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:01:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 531ED4000783
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:01:34 +0000 (UTC)
Date: Thu, 23 Aug 2018 17:01:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180823090125.GB6960@lemon.usersys.redhat.com>
References: <20180822131554.3398-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180822131554.3398-1-berrange@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com

On Wed, 08/22 14:15, Daniel P. Berrang=E9 wrote:
> We deprecated GTK2 and SDL1.2 in the 2.12.0 release, so they are able t=
o
> be removed entirely in the 3.1.0 release. The min GTK3 version can also
> be bumped up based the distros we aim to support.
>=20
> Note that before this can merge, the openbsd VM test image needs to be
> updated to have SDL2, as openbsd build mandates SDL availability.

I'll send a patch to upgrade and convert openbsd to use auto_install soon=
.

Fam

>=20
> The freebsd & netbsd images should also be updated, but they are not
> build blockers as they automatically disable SDL
>=20
> Changed in v2:
>=20
>  - Rebased to resolve conflicts
>=20
> Daniel P. Berrang=E9 (3):
>   ui: remove support for GTK2 in favour of GTK3
>   ui: increase min required GTK3 version to 3.14.0
>   ui: remove support for SDL1.2 in favour of SDL2
>=20
>  configure              |  111 +----
>  include/ui/gtk.h       |    9 -
>  qemu-deprecated.texi   |   16 -
>  ui/Makefile.objs       |    5 -
>  ui/gtk-egl.c           |   10 +-
>  ui/gtk.c               |  202 +-------
>  ui/sdl.c               | 1027 ----------------------------------------
>  ui/sdl_zoom.c          |   93 ----
>  ui/sdl_zoom.h          |   25 -
>  ui/sdl_zoom_template.h |  219 ---------
>  10 files changed, 33 insertions(+), 1684 deletions(-)
>  delete mode 100644 ui/sdl.c
>  delete mode 100644 ui/sdl_zoom.c
>  delete mode 100644 ui/sdl_zoom.h
>  delete mode 100644 ui/sdl_zoom_template.h
>=20
> --=20
> 2.17.1
>=20
