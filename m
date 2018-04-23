Received: from eggs.gnu.org ([2001:4830:134:3::10]:48113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simark@simark.ca>) id 1fAQQY-00012G-GF
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 21:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simark@simark.ca>) id 1fAQQV-0004ss-8K
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 21:37:58 -0400
Received: from simark.ca ([158.69.221.121]:34392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simark@simark.ca>) id 1fAQQV-0004sZ-2C
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 21:37:55 -0400
References: <20180404103440.19546-1-stefanha@redhat.com>
	<008ac6e8-1e68-b0f6-7e75-77453721d031@virtuozzo.com>
	<20180410020823.GB11203@stefanha-x1.localdomain>
From: Simon Marchi <simark@simark.ca>
Message-ID: <fefd54c0-d5f2-dc31-ff3c-24eb29fd2101@simark.ca>
Date: Sun, 22 Apr 2018 21:37:52 -0400
MIME-Version: 1.0
In-Reply-To: <20180410020823.GB11203@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scripts/qemugdb: support coroutine
 backtrace in coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, gdb@sourceware.org

On 2018-04-09 10:08 PM, Stefan Hajnoczi wrote:
> I wonder what the point of select-frame is then...
> 
> I have CCed the GDB mailing list.  Maybe someone can help us.  Context:
> 
> QEMU implements coroutines using jmpbuf.  We'd like to print coroutine
> call stacks in GDB and have a script that works when a process is being
> debugged (it sets the registers).
> 
> Now we'd like to extend the script to work on core dumps where it's not
> possible to set registers (since there is no process being debugged).
> 
> Is there a way to backtrace an arbitrary call stack in a core dump?

Not that I know of.  The "frame <stack-addr> <pc-addr>" form of the frame
command sounds like it should be usable to achieve that, but it doesn't
seem to work in that way.  I really wonder if it's working as it was
intended initially.  I guess using that form of the frame command should
override/mask the real current values of $sp and $pc?

Simon
