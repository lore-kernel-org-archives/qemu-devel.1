Received: from eggs.gnu.org ([2001:4830:134:3::10]:49890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqOHj-0005z1-Kb
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqOHg-0004TS-10
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:50:19 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:46472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqOHf-0004Sa-P3
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:50:15 -0400
Received: by mail-pg1-x530.google.com with SMTP id f14-v6so2511615pgv.13
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 12:50:15 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-59-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <76d69150-0801-4f13-666f-cde0c53aff80@linaro.org>
Date: Thu, 16 Aug 2018 12:50:11 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-59-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 58/84] elf: On elf loading,
 treat both EM_MIPS and EM_NANOMIPS as legal for MIPS
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
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Modify load_elf32()/load_elf64() to treat EM_NANOMIPS as legal as
> EM_MIPS is.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  include/hw/elf_ops.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
