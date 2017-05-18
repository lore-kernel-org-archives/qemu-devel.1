Received: from eggs.gnu.org ([2001:4830:134:3::10]:49631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBUPB-0005oI-5p
	for qemu-devel@nongnu.org; Thu, 18 May 2017 19:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBUPA-00039L-58
	for qemu-devel@nongnu.org; Thu, 18 May 2017 19:00:25 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:34680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dBUP9-000394-W1
	for qemu-devel@nongnu.org; Thu, 18 May 2017 19:00:24 -0400
Date: Fri, 19 May 2017 01:00:18 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170518230018.r7u7ihcicjbhsgpw@aurel32.net>
References: <f0c4de76-77a7-90c4-6a99-10ddda953b19@landley.net>
	<c07840b7-29ce-1866-d739-ebe2646a040d@redhat.com>
	<fa9191ac-21dd-ee56-cd4b-b3b473625ae7@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa9191ac-21dd-ee56-cd4b-b3b473625ae7@landley.net>
Subject: Re: [Qemu-devel] qemu-system-sh4 -M r2d serial is broken.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rob Landley <rob@landley.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 2017-05-18 17:35, Rob Landley wrote:
> 
> 
> On 05/18/2017 02:57 PM, Paolo Bonzini wrote:
> > 
> > 
> > On 18/05/2017 18:08, Rob Landley wrote:
> >> Serial input hangs after the first character in the 4.11 kernel:
> >>
> >>   http://www.spinics.net/lists/linux-sh/msg51183.html
> >>
> >> Because they enabled support for a buffer size thing QEMU doesn't
> >> emulate right:
> >>
> >>   http://www.spinics.net/lists/linux-sh/msg51189.html
> > 
> > Hey,
> > 
> > regarding this:
> > 
> >> The really _fun_ thing about this is qemu broke it a couple years back
> >> and now if you hit ctrl-c it kills the _emulator_ rather than passing it
> >> through to the Linux console. (Just sh4, the rest do it right.)
> > 
> > Try replacing "-serial stdio" with "-serial mon:stdio".  You'll also be
> > able to use the QEMU monitor with "Ctrl-a c", so you can quit with
> > "Ctrl-a c quit <enter>".
> 
> Ctrl-c now goes through. Thanks!
> 
> Exiting the linux instance says "reboot: Restarting system\nUnauthorized
> access" and then hangs eating 100% cpu, but maybe I can fix that with
> kernel configuration changes.

I guess you mean rebooting the linux instance. This is because you do
not use a bootloader to load the kernel and the initrd. Then you might
be interested in:

  http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg03881.html

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
