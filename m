Received: from eggs.gnu.org ([2001:4830:134:3::10]:60169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDUhw-0004WI-FX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDUhq-0004gx-PP
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:20:52 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:55666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDUho-0004fu-WC
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:20:46 -0400
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-17-kbastian@mail.uni-paderborn.de>
	<ed4c028f-12b8-d940-c4ce-49b59c36a06e@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <3644d9c1-cb6c-1f73-0988-2e00579c0354@mail.uni-paderborn.de>
Date: Fri, 19 Oct 2018 15:20:42 +0200
MIME-Version: 1.0
In-Reply-To: <ed4c028f-12b8-d940-c4ce-49b59c36a06e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 16/28] target/riscv: Convert quadrant 1 of
 RVXC insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org


On 10/13/18 8:53 PM, Richard Henderson wrote:
> Choose return false or raise exception. Except...
> I wonder if we might write this as
>
>      int shamt = a->shamt;
>      if (shamt == 0) {
>          shamt = 64;
>      }


Good catch. I'll add a comment, that a shamt of 0 is intended for RV128.


Cheers,

Bastian
