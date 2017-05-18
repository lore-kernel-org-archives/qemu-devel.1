Received: from eggs.gnu.org ([2001:4830:134:3::10]:37831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBRkw-0002o3-Sf
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBRkv-0004tj-Ud
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:10:42 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:33698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dBRkv-0004tV-OJ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:10:41 -0400
Date: Thu, 18 May 2017 22:10:38 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170518201038.ytrkrqvrioavcudq@aurel32.net>
References: <f0c4de76-77a7-90c4-6a99-10ddda953b19@landley.net>
	<c07840b7-29ce-1866-d739-ebe2646a040d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c07840b7-29ce-1866-d739-ebe2646a040d@redhat.com>
Subject: Re: [Qemu-devel] qemu-system-sh4 -M r2d serial is broken.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org

On 2017-05-18 21:57, Paolo Bonzini wrote:
> Anyway, Uli Hecht is saying SCIF "asserts DR even if the FIFO threshold
> has not been reached if no data is received for 1.5 frames".  If that's
> just a register and doesn't trigger an interrupt, you can compute the
> bit's value dynamically based on the current clock.
> 
> This is for example how the x86 RTC chip computes the "update in
> progress" bit, which is set for 220 us before the RC updates.  Doing
> that with a timer would be really imprecise.

Unfortunately, the DR bit is set to 1 after 1.5 frames (so the exact
timing depends on the actual baud rate), and that also triggers an
interrupt if the RIE bit is set to 1. I haven't checked yet if the
kernel relies on the bit or the interrupt or both.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
