Received: from eggs.gnu.org ([2001:4830:134:3::10]:40919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXFIP-0006uy-VJ
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXFIM-0007ZE-1h
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:23:53 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:44948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXFIL-0007Yn-JG
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:23:49 -0400
Received: by mail-pl0-x244.google.com with SMTP id m16-v6so1186135pls.11
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 17:23:49 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-19-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc997485-8f7e-f704-6577-4a56f1e735c4@linaro.org>
Date: Sun, 24 Jun 2018 17:23:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-19-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/35] target/mips: Add nanoMIPS branch
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net

On 06/20/2018 05:06 AM, Yongbok Kim wrote:
> +        if (rt == 0 && imm == 0) {
> +            /* Unconditional branch */
> +        } else if (rt == 0 && imm != 0) {
> +            /* Treat as NOP */
> +            goto out;

Given that there is a different unconditional BC opcode, I would expect to
never see rt=0 at all.  There's no point in special casing it.  And it would
seem that all of the "goto out" cases miss setting MIPS_HFLAG_FBNSLOT.


r~
