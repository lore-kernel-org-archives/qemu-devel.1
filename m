Received: from eggs.gnu.org ([2001:4830:134:3::10]:55221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKmd4-0002wo-D1
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKmd0-0003h8-Hf
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:53:58 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKmd0-0003gm-AT
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:53:54 -0500
Received: by mail-wm1-x342.google.com with SMTP id r11-v6so1765942wmb.2
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 07:53:54 -0800 (PST)
References: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <97b143d6-5503-21ee-a836-cfa2597a5856@linaro.org>
Date: Thu, 8 Nov 2018 16:53:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] target/riscv: Bugfixes found in
 decodetree conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 11/8/18 1:06 PM, Bastian Koppelmann wrote:
> while going through the reviews of the riscv-decodetree patches, two bugs came
> up that I fix here. There is one more problem [1] mentioned by Richard but 
> I don't have the time to investigate it further.
> 
> [1] https://patchwork.kernel.org/patch/10650293/

That one's not a bug, but an optimization.

The other bug mentioned is shrw and shaw not sign-extending the result.


r~
