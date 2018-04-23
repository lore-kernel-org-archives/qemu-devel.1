Received: from eggs.gnu.org ([2001:4830:134:3::10]:47467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fAY59-0005k9-G4
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fAY56-0001Ka-EQ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:48:23 -0400
Received: from mail-eopbgr50123.outbound.protection.outlook.com
	([40.107.5.123]:56448
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1fAY56-0001Jv-27
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:48:20 -0400
References: <20180404103440.19546-1-stefanha@redhat.com>
	<008ac6e8-1e68-b0f6-7e75-77453721d031@virtuozzo.com>
	<20180410020823.GB11203@stefanha-x1.localdomain>
	<fefd54c0-d5f2-dc31-ff3c-24eb29fd2101@simark.ca>
	<20180423093334.GA4892@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2a42554b-58b2-2a15-6c39-68e83c9d852a@virtuozzo.com>
Date: Mon, 23 Apr 2018 12:48:12 +0300
MIME-Version: 1.0
In-Reply-To: <20180423093334.GA4892@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Stefan Hajnoczi <stefanha@redhat.com>, Simon Marchi <simark@simark.ca>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, gdb@sourceware.org

23.04.2018 12:33, Stefan Hajnoczi wrote:
> On Sun, Apr 22, 2018 at 09:37:52PM -0400, Simon Marchi wrote:
>> On 2018-04-09 10:08 PM, Stefan Hajnoczi wrote:
>>> I wonder what the point of select-frame is then...
>>>
>>> I have CCed the GDB mailing list.  Maybe someone can help us.  Context:
>>>
>>> QEMU implements coroutines using jmpbuf.  We'd like to print coroutine
>>> call stacks in GDB and have a script that works when a process is being
>>> debugged (it sets the registers).
>>>
>>> Now we'd like to extend the script to work on core dumps where it's not
>>> possible to set registers (since there is no process being debugged).
>>>
>>> Is there a way to backtrace an arbitrary call stack in a core dump?
>> Not that I know of.  The "frame <stack-addr> <pc-addr>" form of the frame
>> command sounds like it should be usable to achieve that, but it doesn't
>> seem to work in that way.  I really wonder if it's working as it was
>> intended initially.  I guess using that form of the frame command should
>> override/mask the real current values of $sp and $pc?
> Yes, that is what I was expecting.
>
> Vladimir has a script to copy the coredump file and manipulate the
> registers on disk, but it would be nicer to do stack-switching inside
> the GDB session without needing to create another coredump file.
>
> Vladimir: Would you like to write a GDB patch?  If GDB is fixed then
> workaround won't be necessary.

Hmm, unlikely. At least, not in the nearest future.

>
> Stefan


-- 
Best regards,
Vladimir
