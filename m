Received: from eggs.gnu.org ([209.51.188.92]:40163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwVMl-000511-GC
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwVMj-000621-Un
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:09:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gwVMj-00061M-Kq
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:09:01 -0500
Date: Wed, 20 Feb 2019 17:08:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190220170851.GS21870@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1550678735-25394-1-git-send-email-thuth@redhat.com>
	<20190220161508.GN21870@redhat.com>
	<87pnrms88i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pnrms88i.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui/gtk: Fix the license information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, qemu-devel@nongnu.org

On Wed, Feb 20, 2019 at 06:03:09PM +0100, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Wed, Feb 20, 2019 at 05:05:35PM +0100, Thomas Huth wrote:
> >> The license information in this file is very messy. A short note at
> >> the beginning says GPL first, but the long boilerplate code then
> >> talks about "GNU Lesser General Public License version 2.0". First,
> >> there is no such version of the "GNU Lesser GPL", it only started wi=
th
> >> version 2.1. In version 2.0, it was still called "GNU Library GPL"
> >> instead. Second, you can easily get the license of this file wrong
> >> if you only quickly glance at the long boilerplate code.
> >>=20
> >> Anyway, looking at the text of the LGPL (see COPYING.LIB in the top
> >> directory), the license clearly states in section "3." that one shou=
ld
> >> rather replace the license information with the GPL information in
> >> such a case of a mixture instead. Thus let's clean up the confusing
> >> statements and use the proper GPL text only.
> >>=20
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  ui/gtk.c | 20 ++++++++------------
> >>  1 file changed, 8 insertions(+), 12 deletions(-)
> >>=20
> >> diff --git a/ui/gtk.c b/ui/gtk.c
> >> index 949b143..af7e5b2 100644
> >> --- a/ui/gtk.c
> >> +++ b/ui/gtk.c
> >> @@ -6,9 +6,6 @@
> >>   * Authors:
> >>   *  Anthony Liguori   <aliguori@us.ibm.com>
> >>   *
> >> - * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
> >> - * See the COPYING file in the top-level directory.
> >
> > This part of the header was describing the license of the QEMU origin=
ated
> > code for gtk.c
> >
> >> - *
> >>   * Portions from gtk-vnc:
> >>   *
> >>   * GTK VNC Widget
> >> @@ -16,19 +13,18 @@
> >>   * Copyright (C) 2006  Anthony Liguori <anthony@codemonkey.ws>
> >>   * Copyright (C) 2009-2010 Daniel P. Berrange <dan@berrange.com>
> >>   *
> >> - * This library is free software; you can redistribute it and/or
> >> - * modify it under the terms of the GNU Lesser General Public
> >> - * License as published by the Free Software Foundation; either
> >> - * version 2.0 of the License, or (at your option) any later versio=
n.
> >> + * This program is free software; you can redistribute it and/or mo=
dify
> >> + * it under the terms of the GNU General Public License as publishe=
d by
> >> + * the Free Software Foundation; either version 2 of the License, o=
r
> >> + * (at your option) any later version.
> >>   *
> >> - * This library is distributed in the hope that it will be useful,
> >> + * This program is distributed in the hope that it will be useful,
> >>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GN=
U
> >> - * Lesser General Public License for more details.
> >> + * General Public License for more details.
> >>   *
> >> - * You should have received a copy of the GNU Lesser General Public
> >> - * License along with this library; if not, write to the Free Softw=
are
> >> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  0=
2110-1301 USA
> >> + * You should have received a copy of the GNU General Public Licens=
e
> >> + * along with this program; if not, see <http://www.gnu.org/license=
s/>.
> >
> > while this part of the header was describing the license of the origi=
nal
> > GTK-VNC code that was copied into this file.
> >
> > Changing this text is not correct, because now it no longer describes
> > the original gtk-vnc license.
> >
> > If you want to change this file you'll need the main license text for
> > QEMU further up, *before* the line starting "Portions from gtk-vnc:"
>=20
> No.  LGPL permits derived works to be licensed under GPL.
> https://www.gnu.org/licenses/gpl-faq.html#AllCompatibility

I wasn't debating that.

> Keeping the separate historical boiler-plate may feel polite.  But to
> figure out what exactly is LGPLed, you'd have to dig through history
> anyway.  So all it accomplishes is providing a hint that somewhere in
> history something could possibly be found that's still LGPLed and still
> useful.

I'm just saying that after this patch is applied, the text in the header
is misleading. It is suggesting that the GTK-VNC code that was copied
was under the GPLv2, where as it was actually under the LGPLv2 originally=
.

> > The bit about GTK-VNC could reasonably be simplified to
> >
> >     "Portions taken from gtk-vnc under the terms of the GNU
> >      Lesser General Public License 2.1 or later."

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
