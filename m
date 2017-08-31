Received: from eggs.gnu.org ([2001:4830:134:3::10]:56456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dnNcK-0007VF-Py
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dnNcG-0008Af-Qm
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:26:36 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:37180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dnNcG-0008AB-EZ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:26:32 -0400
Received: by mail-lf0-f52.google.com with SMTP id y128so1540442lfd.4
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 04:26:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170831074215.GA13619@stefanha-x1.localdomain>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
	<20170830140738.GS18526@redhat.com>
	<20170831074215.GA13619@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 Aug 2017 13:26:29 +0200
Message-ID: <CABgObfYRUtdH9-7+zWx5Zur=iE_Qr5953+EOgcxRfVGnEonbmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 02/13] hvf: add code base from Google's
 QEMU repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Hajnoczi, Stefan" <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, vpalatin@chromium.org, izik@veertu.com, sergio.g.delreal@gmail.com

Il 31 ago 2017 9:43 AM, "Stefan Hajnoczi" <stefanha@gmail.com> ha scritto:

On Wed, Aug 30, 2017 at 03:07:38PM +0100, Daniel P. Berrange wrote:
> On Wed, Aug 30, 2017 at 03:26:51AM -0500, Sergio Andres Gomez Del Real
wrote:
> > diff --git a/target/i386/hvf-utils/x86.c b/target/i386/hvf-utils/x86.c
> > new file mode 100644
> > index 0000000000..e3db2c9c8b
> > --- /dev/null
> > +++ b/target/i386/hvf-utils/x86.c
> > @@ -0,0 +1,174 @@
> > +/*
> > + * Copyright (C) 2016 Veertu Inc,
> > + * Copyright (C) 2017 Google Inc,
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 or
> > + * (at your option) version 3 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
along
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
>
> Again  v2-or-v3-only.
>
> There's many more files with this same problem but I'll stop pointing
> them out now.
>
> If this is to be included in QEMU,  Veertu & Google (and any other
> copyright holders) would have to agree to change these files to
> v2-or-later

Sergio: Have you or Paolo had any contact with the Veertu or Google
authors about your Hypervisor.framework project?  If you're already in
contact with them you could raise the issue and ask them to join this
email thread.


Izik, Vincent (assuming you are the right person to contact at Google), can
you reply to Daniel and Stefan?

Sergio worked on completing the QEMU port to Hypervisor.framework. The
hvf-all.c file that Daniel pointed out as v2-only is derived from kvm-all.c
and hax-all.c, and should be under v2-or-later license. The others seem to
be either original or derived from Bochs, which is LGPL, so they could be
LGPL or GPLv2+.

Thanks,

Paolo


There are benefits to having this code upstream.  If they ever want to
rebase on qemu.git there will be less work for them.

Stefan
