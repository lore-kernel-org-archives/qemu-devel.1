Received: from eggs.gnu.org ([2001:4830:134:3::10]:38205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fJIQr-00050B-59
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fJIQn-0005BS-7E
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:54:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35240 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fJIQn-0005BG-24
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:54:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81593805A530
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:54:52 +0000 (UTC)
Date: Thu, 17 May 2018 13:54:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180517125448.GK5657@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
	<20180517124403.GJ5657@redhat.com>
	<20180517125110.lhipiezmvifrg3n6@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180517125110.lhipiezmvifrg3n6@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH] ui: add x_keymap.o to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Thu, May 17, 2018 at 02:51:10PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > +ifeq ($(CONFIG_X11),y)
> > > +sdl.mo-objs += x_keymap.o
> > > +gtk.mo-objs += x_keymap.o
> > 
> > Would this cause symbol clash if both sdl & gtk modules are loaded
> > at the same time, or have we used linker scripts to limit what symbols
> > each module exposes ?
> 
> Related: can modules depend on modules, so we could make x_keymap a
> module of its own and have both gtk and sdl depend on it?
> 
> That would also be useful when trying to modularize spice.

Yes, you could create a  xkeymap.so, and link to that from both
sdl.so and gtk.so, so you'll only get one copy of xkeymap.so if
both are loaded.

I don't think it is worth it for this particular case though, since
we'll be deleting the SDL1 code when 2.14 dev cycle opens, leaving
GTK as the only user of it.  SDL2 already has abstracted keycodes.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
