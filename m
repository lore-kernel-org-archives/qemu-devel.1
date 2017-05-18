Received: from eggs.gnu.org ([2001:4830:134:3::10]:50177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBUQS-0006Qm-PV
	for qemu-devel@nongnu.org; Thu, 18 May 2017 19:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBUQR-0003Vr-TU
	for qemu-devel@nongnu.org; Thu, 18 May 2017 19:01:44 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:34694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dBUQR-0003VZ-Nt
	for qemu-devel@nongnu.org; Thu, 18 May 2017 19:01:43 -0400
Date: Fri, 19 May 2017 01:01:41 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170518230141.75xhr7mul6lci3sj@aurel32.net>
References: <f0c4de76-77a7-90c4-6a99-10ddda953b19@landley.net>
	<20170518190052.qxzzcpurulnghlog@aurel32.net>
	<53613c44-1785-28f1-ae60-22adac96c8ad@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53613c44-1785-28f1-ae60-22adac96c8ad@landley.net>
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
Cc: qemu-devel@nongnu.org, Rich Felker <dalias@libc.org>

On 2017-05-18 17:37, Rob Landley wrote:
> 
> 
> On 05/18/2017 02:00 PM, Aurelien Jarno wrote:
> > On 2017-05-18 11:08, Rob Landley wrote:
> >> Serial input hangs after the first character in the 4.11 kernel:
> >>
> >>   http://www.spinics.net/lists/linux-sh/msg51183.html
> >>
> >> Because they enabled support for a buffer size thing QEMU doesn't
> >> emulate right:
> >>
> >>   http://www.spinics.net/lists/linux-sh/msg51189.html
> > 
> > Indeed the SCIF emulation in QEMU is quite limited. The problem is that
> > it exposes many internal states to the software (and that's the same for
> > the SH4 CPU in general), and that's not really compatible with quick
> > emulation. In that case the timer should depend on the baud rate which
> > we don't really emulate.
> > 
> > I'll try to have a look, that said my test environment is stuck with
> > kernel 4.8 due to the broken futex support on UP in kernel 4.9 (and
> > that's not QEMU specific). I'll try to build a more recent kernel with
> > additional patches.
> 
> I thought Rich fixed that. Rich?
> 

I have sent a patch already, but TTBOMK it hasn't been applied yet.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
