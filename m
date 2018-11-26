Received: from eggs.gnu.org ([2001:4830:134:3::10]:60652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gRMMJ-0003MR-54
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gRMME-0007pM-GD
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:15:50 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gRMMB-0007cc-TR
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:15:44 -0500
Received: by mail-pf1-x442.google.com with SMTP id 64so7041910pfr.9
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:15:43 -0800 (PST)
Date: Mon, 26 Nov 2018 11:15:41 -0800 (PST)
In-Reply-To: <CAKmqyKPVif8MQs_aGXxx=aOi9mrRJz94AFv2B41JVETqY9BQRA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-3ba5a1be-87c9-4028-9442-8773ce4100bd@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 5/6] hw/riscv/sifive_u: Connect
 the Xilinx PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: logang@deltatee.com, linux@roeck-us.net, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, abologna@redhat.com

On Wed, 21 Nov 2018 18:23:26 PST (-0800), alistair23@gmail.com wrote:
> On Wed, Nov 21, 2018 at 6:13 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Wed, 21 Nov 2018 15:26:01 PST (-0800), logang@deltatee.com wrote:
>> >
>> >
>> > On 2018-11-21 4:10 p.m., Guenter Roeck wrote:
>> >> FWIW, I absoutely agree. If the board can only be used to boot an initrd,
>> >> it is quite pointless to have it around. Actually it is worse than pointless,
>> >> since it will result in people wasting their time trying to get it to work.
>> >
>> > As someone who has wasted their time on it, I second this sentiment.
>>
>> So it sounds like I should target that deprecation patch set for 3.1?  Who
>> wants to review it?
>
> I think it's a little late for 3.1. Let's leave it for 3.2

That was my original thought as well, so I'm happy sticking with the plan.
