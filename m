Received: from eggs.gnu.org ([2001:4830:134:3::10]:58209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLDL-000400-2I
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLDG-0004kB-JS
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:33:35 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqLDE-0004jH-QH
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:33:28 -0400
Received: by mail-pf1-x443.google.com with SMTP id i26-v6so2248138pfo.12
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:33:28 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-23-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ade97260-3d27-4a52-a040-c259a7545149@linaro.org>
Date: Thu, 16 Aug 2018 09:33:24 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-23-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 22/84] target/mips: Add emulation of
 nanoMIPS 16-bit branch instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> Add emulation of nanoMIPS 16-bit branch instructions.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

This patch needs the gen_compute_compact_branch_nm you add in patch 39.
All of the uses of gen_compute_branch are incorrect.


r~
