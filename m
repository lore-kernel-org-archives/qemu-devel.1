Received: from eggs.gnu.org ([2001:4830:134:3::10]:54214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZJGf-0005Mu-6E
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZJGb-0001P5-UQ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:30:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eZJGb-0001NJ-O5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:30:17 -0500
Date: Wed, 10 Jan 2018 16:30:03 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180110163003.GO3205@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180107221455.25504-1-patricktsen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180107221455.25504-1-patricktsen@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/1] input-linux: provide hotkeys for
 evdev toggle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: byxk <patricktsen@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Sun, Jan 07, 2018 at 02:14:54PM -0800, byxk wrote:
> Added some functionality to change the key combo for evdev toggle.
> example:
> -object input-linux,rhotkey=29,lhotkey=56,evdev=[etc...]
> 
> Set the defaults to LCTRL and RCTRL if not provided.

This should really be part of the commit message for the patch itself, so it
gets recorded in git history.

There is some overlap here with the grab sequence work John has just posted
for cocoa frontend

  https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05115.html

I wonder if it is reasonable for ui/input-linux.c to honour the same
global '-ungrab' configuration option ?  If not, we should  at least
use the same syntax for describing the ungrab sequence. ie a list of
key code names, rather than a hardcoded pair of numeric values.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
