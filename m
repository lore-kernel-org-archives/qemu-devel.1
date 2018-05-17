Received: from eggs.gnu.org ([2001:4830:134:3::10]:37355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJINH-0003BG-9l
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJINE-0003cF-6H
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:51:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJINE-0003b8-2a
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:51:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2C25BB414
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:51:11 +0000 (UTC)
Date: Thu, 17 May 2018 14:51:10 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180517125110.lhipiezmvifrg3n6@sirius.home.kraxel.org>
References: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
	<20180517124403.GJ5657@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517124403.GJ5657@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui: add x_keymap.o to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

  Hi,

> > +ifeq ($(CONFIG_X11),y)
> > +sdl.mo-objs += x_keymap.o
> > +gtk.mo-objs += x_keymap.o
> 
> Would this cause symbol clash if both sdl & gtk modules are loaded
> at the same time, or have we used linker scripts to limit what symbols
> each module exposes ?

Related: can modules depend on modules, so we could make x_keymap a
module of its own and have both gtk and sdl depend on it?

That would also be useful when trying to modularize spice.

cheers,
  Gerd
