Received: from eggs.gnu.org ([2001:4830:134:3::10]:35237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgBGz-0001Wq-0V
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgBGv-0003gD-VW
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:55:21 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgBGv-0003fy-LK
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:55:17 -0400
Received: by mail-pg1-x542.google.com with SMTP id z8-v6so4140562pgu.8
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:55:17 -0700 (PDT)
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004727-13778-11-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <279be5d7-a9ce-eaf6-a581-d4a3b04fba27@linaro.org>
Date: Thu, 19 Jul 2018 08:55:13 -0700
MIME-Version: 1.0
In-Reply-To: <1532004727-13778-11-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 10/11] linux-user: Update MIPS syscall
 numbers up to kernel 4.18 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:52 AM, Stefan Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Synchronize content of linux-user/mips/syscall_nr.h and
> linux-user/mips64/syscall_nr.h with Linux kernel 4.18 headers.
> This adds 7 new syscall numbers, the last being NR_statx.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  linux-user/mips/syscall_nr.h   |  7 +++++++
>  linux-user/mips64/syscall_nr.h | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
