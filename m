Received: from eggs.gnu.org ([2001:4830:134:3::10]:37297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqfzJ-00034i-CG
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqfzF-0000kS-PP
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:44:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56240 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqfzF-0000j6-KN
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:44:25 -0400
Date: Fri, 17 Aug 2018 15:44:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180817144421.GS11124@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180816172722.GK23515@redhat.com>
	<83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
	<20180817085656.GA11124@redhat.com>
	<a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
	<20180817125808.GO11124@redhat.com>
	<b4872310-41f3-d2bc-22b2-0f41e8848a55@ubuntu.com>
	<20180817131226.GP11124@redhat.com>
	<e88687b0-f116-e6eb-0432-12e38ecece2f@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e88687b0-f116-e6eb-0432-12e38ecece2f@ubuntu.com>
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phillip Susi <psusi@ubuntu.com>
Cc: qemu-devel@nongnu.org

On Fri, Aug 17, 2018 at 10:36:14AM -0400, Phillip Susi wrote:
> I've been reading up here:
> http://www.win.tue.nl/~aeb/linux/kbd/scancodes-1.html
> 
> And man, what a mess keyboards are!  Worse than floppy controllers.
> According to that site, the scan code for \ should be 0x2b, so why does
> xev say the keycode is 51?  Is keycode something else entirely from scan
> codes and keysyms?  If so how can I see the scan code?

0x2b is 43 in hex.

xev reports the Xorg scancode, which is the same as the XT/AT-set1
scancodes, with an offset of 8 added

IOW, 51 from xev does actually match 0x2b from XT scancode set

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
