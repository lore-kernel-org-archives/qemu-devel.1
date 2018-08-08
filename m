Received: from eggs.gnu.org ([2001:4830:134:3::10]:41186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fnO2w-0004Xm-IY
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fnO2t-00081a-Cw
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:58:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fnO2t-00081R-7e
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:58:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A996E40216E6
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 12:58:34 +0000 (UTC)
Date: Wed, 8 Aug 2018 13:58:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180808125726.GA22936@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180808104930.23133-1-berrange@redhat.com>
	<20180808112409.wazgnksmsvhl4sa6@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180808112409.wazgnksmsvhl4sa6@sirius.home.kraxel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] ui: remove deprecated UI frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com

On Wed, Aug 08, 2018 at 01:24:09PM +0200, Gerd Hoffmann wrote:
> On Wed, Aug 08, 2018 at 11:49:27AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > We deprecated GTK2 and SDL1.2 in the 2.12.0 release, so they are able=
 to
> > be removed entirely in the 3.1.0 release. The min GTK3 version can al=
so
> > be bumped up based the distros we aim to support.
>=20
> Yes for gtk2, finally the #ifdef mess is gone, yay!
>=20
> Not so sure for sdl1, that one was more controversial and sdl2
> regression fixes are still tickling in (although it seems we killed mos=
t
> of them meanwhile).  Also due to sdl1 being a separate source file
> anyway the maintanance costs are not that high.
>=20
> Comments?

There were some regressions wrt SDL2, but I don't think there's any
major problems still missing. If there are new problems reported, we
still have the entire of the 3.1.0 dev cycle to address them before
the release which removes it.

Even if code is separate, it still has a maint cost in testing and impact=
s
any refactoring we do, such as that around keymap handling which is a
non-trivial cost for something that is increasingly unused, since we
default to SDL2 ABI for many releases now. At least GTK2 still had bug-fi=
x
releases for any security problems or serious bugs, but SDL1 has received
no releases at all upstream since 2013

So I don't see any compelling reason to keep it alive given, and enough
downside given that it has been dead in its upstream community for years.=
=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
