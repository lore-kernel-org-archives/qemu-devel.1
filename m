Received: from eggs.gnu.org ([2001:4830:134:3::10]:52293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebUOJ-0001Gd-Dh
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebUOD-0000rb-OQ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:47:15 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-12-andrew.smirnov@gmail.com>
	<b085a18b-84f4-6695-f664-c146ece47eee@amsat.org>
	<CAHQ1cqGtN+dvSP_q2QXRJ7wAwBZNGzVkpG3Zd9KS87OHkL7n5g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2be301ba-b417-e818-93f4-d43aa8b60b40@amsat.org>
Date: Tue, 16 Jan 2018 13:47:04 -0300
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqGtN+dvSP_q2QXRJ7wAwBZNGzVkpG3Zd9KS87OHkL7n5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 11/14] ARM: Add basic code to emulate
 A7MPCore DAP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Alistair Francis <alistai@xilinx.com>
Cc: "open list:ARM" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 01/16/2018 12:04 PM, Andrey Smirnov wrote:
> On Mon, Jan 15, 2018 at 8:32 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hi Andrey,
>>
>> On 01/15/2018 10:37 PM, Andrey Smirnov wrote:
>>> Add minimal code to emulate A7MPCore DAP block needed to boot Linux
>>> guest.
>>
>> I was not aware the DAP is accessed by upstream Linux...
>>
>> You sure this isn't rather part of some bootloader built-in self-test?
>>
> 
> Yes, I am positive:
> 
> a) I don't run any bootloader and boot directly into Linux, so it's
> just physically impossible
> b) Here's the code:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwtracing/coresight?h=v4.15-rc8

Wow :) pretty interesting!

Alistair:
Some features might be interesting to add to the multicore-gdb project idea.

Thanks Andrey for updating me :)

Phil.
