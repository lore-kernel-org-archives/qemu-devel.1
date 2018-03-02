Received: from eggs.gnu.org ([2001:4830:134:3::10]:55859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1erpyl-0000nJ-36
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1erpyi-0001ce-Cw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:04:27 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1erpyi-0001Z6-7E
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:04:24 -0500
Received: by mail-pf0-x243.google.com with SMTP id d26so4389025pfn.5
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 11:04:22 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1519984765-15748-1-git-send-email-konrad@adacore.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8a0c9302-3c3a-6d2f-064c-231adc126dbd@twiddle.net>
Date: Fri, 2 Mar 2018 11:04:17 -0800
MIME-Version: 1.0
In-Reply-To: <1519984765-15748-1-git-send-email-konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sparc: fix leon3 casa instruction when MMU
 is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <konrad@adacore.com>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, frederic.konrad@adacore.com

On 03/02/2018 01:59 AM, KONRAD Frederic wrote:
> From: KONRAD Frederic <frederic.konrad@adacore.com>
> 
> Since the commit af7a06bac7d3abb2da48ef3277d2a415772d2ae8:
> `casa [..](10), .., ..` (and probably others alternate space instructions)
> triggers a data access exception when the MMU is disabled.
> 
> When we enter get_asi(...) dc->mem_idx is set to MMU_PHYS_IDX when the MMU
> is disabled. Just keep mem_idx unchanged in this case so we passthrough the
> MMU when it is disabled.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
> 
> Notes:
>     Changes RFC -> V1:
>      * emit the instruction with MMU_PHYS_IDX instead of checking that the MMU
>        is enabled in get_physical_address(..)
> 
>  target/sparc/translate.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
