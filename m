Received: from eggs.gnu.org ([209.51.188.92]:45032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1guLja-0008Cq-6G
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1guLjZ-0003Cv-Cc
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:27:42 -0500
References: <1550008033-26540-1-git-send-email-sandra@codesourcery.com>
	<CAFEAcA8eFexmymsaur-DtgYdKcyJB0ia7dW_vp358hbySsyBDw@mail.gmail.com>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <fdba9c20-3ffb-7862-51c5-f78852b68238@codesourcery.com>
Date: Thu, 14 Feb 2019 11:27:28 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8eFexmymsaur-DtgYdKcyJB0ia7dW_vp358hbySsyBDw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Send a reply to the vKill packet.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 2/14/19 10:48 AM, Peter Maydell wrote:
> On Tue, 12 Feb 2019 at 21:52, Sandra Loosemore <sandra@codesourcery.com> wrote:
>>
>> Per the GDB remote protocol documentation
>>
>> https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#index-vKill-packet
>>
>> the debug stub is expected to send a reply to the 'vKill' packet.  At
>> least some versions of GDB crash if the gdb stub simply exits without
>> sending a reply.  This patch fixes QEMU's gdb stub to conform to the
>> expected behavior.
>>
>> Note that QEMU's existing handling of the legacy 'k' packet is
>> correct: in that case GDB does not expect a reply, and QEMU does not
>> send one.
>>
>> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
> 
> Thanks, applied to target-arm.next.
> 
> As an aside, do you know if there is any kind of test suite for
> the remote protocol that implementors of a debug stub can use to
> check that they're conforming to it?

Well, I discovered this problem by running the GDB testsuite (using QEMU 
for nios2-elf target with the other target-specific patches I recently 
posted).  I'm not sure if it's designed to exhaustively test the entire 
remote protocol, but it does a pretty good job of covering user-visible 
GDB features that depend on the remote target doing something 
reasonable, even if it's just saying "Huh?  I don't know how to do 
that."  :-)

-Sandra
