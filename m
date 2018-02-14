Received: from eggs.gnu.org ([2001:4830:134:3::10]:46024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1em2W9-0006a2-IH
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1em2W5-0002rx-EA
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:14:57 -0500
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:37899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1em2W5-0002rn-7E
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:14:53 -0500
Received: by mail-pg0-x22c.google.com with SMTP id l24so2304222pgc.5
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 11:14:52 -0800 (PST)
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-10-git-send-email-mjc@sifive.com>
	<20180213215541.GA1816@flamenco>
	<731db20e-4d86-e288-504c-30c83b56fd33@linaro.org>
	<20180214001053.GA23702@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c2663cf3-54cc-d4fc-2cc5-151407d81c4b@linaro.org>
Date: Wed, 14 Feb 2018 11:14:48 -0800
MIME-Version: 1.0
In-Reply-To: <20180214001053.GA23702@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 09/23] RISC-V TCG Code Generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/13/2018 04:10 PM, Emilio G. Cota wrote:
> On Tue, Feb 13, 2018 at 14:10:20 -0800, Richard Henderson wrote:
>> On 02/13/2018 01:55 PM, Emilio G. Cota wrote:
>>> Are we planning to use BS_STOP in the future? I see it has no setters,
>>> although we check for it in gen_intermediate_code:
>>
>> No, but the whole port should be converted to exec/translator.h, which defines
>> DisasJumpType.  Not something I'm going to require on initial submission until
>> we've gotten most of the other targets cleaned up.
> 
> I see. I've just done the conversion for v5:
>   https://github.com/cota/qemu/commits/riscv-v5-trloop
> 
> Can you please take a look?

Looks ok.  Watch your formatting, e.g { } on the same line.


r~
