Received: from eggs.gnu.org ([2001:4830:134:3::10]:53583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKkQ-00007d-Fe
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKkL-0001bf-V6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:19:18 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epKkL-0001aq-Oc
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:19:13 -0500
Received: by mail-pg0-x241.google.com with SMTP id q27so2223517pgn.8
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 13:19:13 -0800 (PST)
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
	<1519344729-73482-12-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <402898b1-0aa7-1bb7-2647-5f099030a388@linaro.org>
Date: Fri, 23 Feb 2018 13:19:09 -0800
MIME-Version: 1.0
In-Reply-To: <1519344729-73482-12-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 11/23] Add symbol table callback
 function interface to load_elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/22/2018 04:11 PM, Michael Clark wrote:
> The RISC-V HTIF (Host Target Interface) console device requires access
> to the symbol table to locate the 'tohost' and 'fromhost' symbols.
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  hw/core/loader.c     | 18 ++++++++++++++++--
>  include/hw/elf_ops.h | 34 +++++++++++++++++++++-------------
>  include/hw/loader.h  | 17 ++++++++++++++++-
>  3 files changed, 53 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
