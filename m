Received: from eggs.gnu.org ([2001:4830:134:3::10]:48651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBSLr-0000ik-To
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBSLn-0002HI-Ug
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:48:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBSLn-0002Gi-OX
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:48:47 -0400
References: <f0c4de76-77a7-90c4-6a99-10ddda953b19@landley.net>
	<c07840b7-29ce-1866-d739-ebe2646a040d@redhat.com>
	<20170518201038.ytrkrqvrioavcudq@aurel32.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <12c57fbe-d9f1-a54c-b2a8-e7dffcb6670b@redhat.com>
Date: Thu, 18 May 2017 22:48:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170518201038.ytrkrqvrioavcudq@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-sh4 -M r2d serial is broken.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org



On 18/05/2017 22:10, Aurelien Jarno wrote:
> On 2017-05-18 21:57, Paolo Bonzini wrote:
>> Anyway, Uli Hecht is saying SCIF "asserts DR even if the FIFO threshold
>> has not been reached if no data is received for 1.5 frames".  If that's
>> just a register and doesn't trigger an interrupt, you can compute the
>> bit's value dynamically based on the current clock.
>>
>> This is for example how the x86 RTC chip computes the "update in
>> progress" bit, which is set for 220 us before the RC updates.  Doing
>> that with a timer would be really imprecise.
> 
> Unfortunately, the DR bit is set to 1 after 1.5 frames (so the exact
> timing depends on the actual baud rate), and that also triggers an
> interrupt if the RIE bit is set to 1. I haven't checked yet if the
> kernel relies on the bit or the interrupt or both.

DR only generates interrupts in asynchronous mode according to the data
sheet I found
(http://datasheet.octopart.com/DF72115D160FPV-Renesas-datasheet-11797591.pdf).

Paolo
