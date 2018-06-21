Received: from eggs.gnu.org ([2001:4830:134:3::10]:34024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWCnW-0005bU-Cd
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWCnT-0000Nd-9o
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:31:42 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:44409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fWCnT-0000M7-1g
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:31:39 -0400
Received: by mail-pf0-x243.google.com with SMTP id h12-v6so2505374pfk.11
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 20:31:37 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-4-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6745eb30-764c-f640-01e8-e7b17055ff10@linaro.org>
Date: Thu, 21 Jun 2018 16:15:39 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-4-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/35] target/mips: Add nanoMIPS OPCODE
 table
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

On 06/20/2018 05:05 AM, Yongbok Kim wrote:
> From: Yongbok Kim <yongbok.kim@imgtec.com>
> 
> Add nanoMIPS OPCODE table
> 
> Reference:
> nanoMIPS Base ISA Technical Reference Manual
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> ---
>  target/mips/mips-defs.h |   4 +
>  target/mips/translate.c | 670 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 674 insertions(+)

I realize it's newish, and the mips target has a *lot* of legacy code and
decode, but have you looked at qemu/scripts/decodetree.py?  I think it would
make a lot of this code significantly simpler.

How about simply splitting out this new code to a new file?  After your patch,
target/mips/translate.c weighs in at 23698 lines; you're adding over 3000 to
that in this patch set.

That said, this patch matches a few spot checks I did of the manual.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
