Received: from eggs.gnu.org ([2001:4830:134:3::10]:56532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheD6-0005q5-9p
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheD5-0005en-KJ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:01:24 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fheD5-0005ef-CG
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:01:23 -0400
Received: by mail-pg1-x543.google.com with SMTP id v13-v6so801500pgr.10
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 10:01:23 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-34-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <01bea541-4e52-e543-713d-f9408b3adba0@linaro.org>
Date: Mon, 23 Jul 2018 10:01:19 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-34-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 33/40] elf: Relax MIPS' elf_check_arch()
 to accept EM_NANOMIPS too
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

On 07/19/2018 05:55 AM, Stefan Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Starting from nanoMIPS introduction, machine variant can be
> EM_MIPS or EM_NANOMIPS.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  linux-user/elfload.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
