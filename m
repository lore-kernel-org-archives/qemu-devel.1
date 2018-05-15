Received: from eggs.gnu.org ([2001:4830:134:3::10]:39048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fIVUQ-0002lZ-2r
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fIVUM-000542-5c
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:39:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fIVUM-00053W-0k
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:39:18 -0400
Date: Tue, 15 May 2018 09:39:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180515083912.GE24129@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180510230739.28459-1-peter@lekensteyn.nl>
	<20180510230739.28459-2-peter@lekensteyn.nl>
	<20180515083009.eo6bh6x2flzhmogv@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180515083009.eo6bh6x2flzhmogv@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] gtk: disable the F10 menubar key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Wu <peter@lekensteyn.nl>, qemu-devel@nongnu.org

On Tue, May 15, 2018 at 10:30:09AM +0200, Gerd Hoffmann wrote:
> On Fri, May 11, 2018 at 01:07:39AM +0200, Peter Wu wrote:
> > The F10 key is used in various applications, disable it unconditionally
> > (do not limit it to grab mode). Note that this property is deprecated
> > and might be removed in the future (GTK+ commit b082fb598d).
> 
> Any replacement provided by gtk?

It doesn't look like it

> I don't feel like adding new code depending on already deprecated
> features ...
> 
> Also note that there is the "grab-on-hover" option in the view menu,
> which will make qemu grab the keyboard if the mouse pointer is inside
> the qemu window.  Which is pretty convinient for hotkeys, they go to the
> guest if you work in the qemu window and to the host otherwise.

IMHO the right thing todo long term is to kill the menu bar from the
GTK UI entirely, and replace with the GTK HeaderBar. This allows the
menu items to be provided via popups directly from the title bar of
the windows, which is more vertically space efficient. This would
probably have to wait for us to ditch GTK2, so I think this fix is
reasonable until that time.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
