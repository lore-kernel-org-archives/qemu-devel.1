Received: from eggs.gnu.org ([2001:4830:134:3::10]:46352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMCCJ-0002G1-8O
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMCCE-00058p-Rk
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:24:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMCCE-00057q-LF
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:24:06 -0500
Date: Mon, 12 Nov 2018 13:23:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181112132344.GO3602@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1542016830-19189-1-git-send-email-thuth@redhat.com>
	<20181112131402.kxoi724a2iw6kwsj@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112131402.kxoi724a2iw6kwsj@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [libvirt] [PATCH] bt: Mark the bluetooth subsystem
 as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com, qemu-devel@nongnu.org, Andrzej Zaborowski <andrew.zaborowski@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>

On Mon, Nov 12, 2018 at 02:14:02PM +0100, Gerd Hoffmann wrote:
> On Mon, Nov 12, 2018 at 11:00:30AM +0100, Thomas Huth wrote:
> > It has been unmaintained since years, and there were only trivial or
> > tree-wide changes to the related files since many years, so the
> > code is likely very bitrotten and broken. For example the following
> > segfaults as soon as as you press a key:
> > 
> >  qemu-system-x86_64 -usb -device usb-bt-dongle -bt hci -bt device:keyboard
> > 
> > Since we are not aware of anybody using bluetooth with the current
> > version of QEMU, let's mark the subsystem as deprecated, with a special
> > request for the users to write to the qemu-devel mailing list in case
> > they still use it (so we could revert the deprecation status in that
> > case).
> 
> I think that settles the bluetooth debate for now.  We deprecate it,
> wait for feedback, possibly un-deprecate (parts of) the code.  Next
> year we'll actually remove the unused code.
> 
> Patch queued for 3.1.

FWIW, libvirt has never exposed any of the bluetooth functionality, so
no objections to removing it from our side.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
