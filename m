Received: from eggs.gnu.org ([2001:4830:134:3::10]:55079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gOzwZ-0006dE-17
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gOzwV-0002UA-Pq
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:55:30 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:55367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gOzwV-0002SH-IC
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:55:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id y139so967816wmc.5
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 22:55:26 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<cd89e90aeb79ed438aaee6cfa02ca42a36d633b6.1542321076.git.alistair.francis@wdc.com>
	<2aa0f464-c9c4-3d59-81da-952279f56843@linaro.org>
	<CAKmqyKN9DQkZUp=+hRwC5AwaX+X0oYgt4=L2Pw8dWAauzS59QQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e04bac07-ad25-2715-1262-28e9324126a8@linaro.org>
Date: Tue, 20 Nov 2018 07:55:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAKmqyKN9DQkZUp=+hRwC5AwaX+X0oYgt4=L2Pw8dWAauzS59QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 20/23] riscv: tcg-target: Add the target
 init code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On 11/20/18 12:04 AM, Alistair Francis wrote:
> On Fri, Nov 16, 2018 at 9:26 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/15/18 11:36 PM, Alistair Francis wrote:
>>> +    tcg_regset_set_reg(s->reserved_regs, TCG_REG_L0);
>>> +    tcg_regset_set_reg(s->reserved_regs, TCG_REG_L1);
>>> +    tcg_regset_set_reg(s->reserved_regs, TCG_REG_RA);
>>
>> Why are these three reserved?
> 
> Do these not need to be? I thought we had to reserve them.

The return address, I presume, has been saved by the prologue.  I see no reason
why it can't be yet another call-clobbered register.

As for the other two... what are they supposed to be?


r~
