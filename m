Received: from eggs.gnu.org ([2001:4830:134:3::10]:52917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnLYh-0000V8-CX
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnLYe-0006RG-El
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:14:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnLYe-0006Qu-8P
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:14:40 -0400
Date: Thu, 31 Aug 2017 10:14:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170831091426.GB17315@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<20170829110357.GG3783@redhat.com>
	<877exllekz.fsf@dusky.pond.sub.org>
	<20170830101311.GB18526@redhat.com>
	<20170831033155.GI5920@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170831033155.GI5920@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, Aug 31, 2017 at 11:31:55AM +0800, Peter Xu wrote:
> Before getting to an conclusion, just want to make sure we have got a
> consensus on that at least we should start to move the monitor command
> handling into a separate thread rather than main thread, am I correct?

Certainly agree on that, moving dispatch of monitor commands out of
the main thread is critical IMHO. The main thread should only ever
be doing work that is gauranteed non-blockable and completable in a
short, finite amount of time. This means at most it should do I/O only
for the monitor.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
