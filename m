Received: from eggs.gnu.org ([2001:4830:134:3::10]:43537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebA96-0003Wq-H3
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebA93-0003uC-Aj
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:10:12 -0500
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:43728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebA93-0003tn-3U
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:10:09 -0500
Received: by mail-pg0-x22d.google.com with SMTP id n17so792603pgf.10
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:10:09 -0800 (PST)
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-11-richard.henderson@linaro.org>
	<CAFEAcA_bU-LWqtXL=2y_ztF4fCmr6WY0ruxFucXvUruQdKKtyA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef479a9f-50e1-41ec-12a8-2484097d55c8@linaro.org>
Date: Mon, 15 Jan 2018 11:10:04 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bU-LWqtXL=2y_ztF4fCmr6WY0ruxFucXvUruQdKKtyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/11] target/arm: Decode aa32 armv8.3
 3-same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 01/15/2018 10:46 AM, Peter Maydell wrote:
> This doesn't seem to line up with the Arm ARM decode. Your
> pattern and mask give
>   op0 = 0x, op1 = 100, op2 = 0 and also bit 8 = 0.
> The ARM has 3reg-same decoded with
>   op0 = 0x, op1 = 1x0, op2 = x
> 
> (and some insns in the 3reg-same group have bit 8 == 1, like
> VSDOT and VUDOT.)

Ah, more v8.2 instructions that I wasn't even looking at...

> How are you proposing to do the Thumb decoding? Try to share
> some of the 3same-vs-2reg+scalar decode part, or just have
> them both do a similar kind of decode and call the
> disas_neon_insn_cp8_3same/cp8_index functions?

Hmm.  I thought this was working via the "translate into the equivalent ARM
encoding" path.  But it couldn't possibly be doing so, since
disas_neon_insn_cp8_3same is not a subroutine of disas_neon_data_insn.

I guess I'll have to verify that RISU is testing what I thought it was...


r~
