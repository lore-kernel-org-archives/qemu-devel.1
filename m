Received: from eggs.gnu.org ([2001:4830:134:3::10]:35801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgBIw-0003Cv-Vx
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgBIt-0004kq-WB
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:57:23 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgBIt-0004kR-P6
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:57:19 -0400
Received: by mail-pg1-x542.google.com with SMTP id v13-v6so4149376pgr.10
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:57:19 -0700 (PDT)
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004727-13778-12-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8541a994-5ab2-49da-cbe8-a92a53075d7c@linaro.org>
Date: Thu, 19 Jul 2018 08:57:16 -0700
MIME-Version: 1.0
In-Reply-To: <1532004727-13778-12-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 11/11] linux-user: Add availability
 control to some syscalls
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
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  linux-user/strace.c  | 14 +++++++++++++-
>  linux-user/syscall.c | 25 +++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 1 deletion(-)

We need a (any) description of why.  Is nanoMIPS going to reset the kernel abi
and do away with the "legacy" mips syscalls?


r~
