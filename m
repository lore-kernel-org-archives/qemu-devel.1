Received: from eggs.gnu.org ([2001:4830:134:3::10]:56760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgESz-0007as-DY
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgESy-00072l-Fa
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:19:57 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgESy-00072O-6W
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:19:56 -0400
Received: by mail-pg1-x541.google.com with SMTP id g2-v6so4617070pgs.6
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:19:56 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-17-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <712c50ae-4b2e-5f00-3af6-4736eca82abe@linaro.org>
Date: Thu, 19 Jul 2018 12:19:52 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-17-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 16/40] target/mips: Implement emulation
 of nanoMIPS ROTX instruction
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

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> From: Matthew Fortune <matthew.fortune@mips.com>
> 
> Added a helper for ROTX based on the pseudocode from the
> architecture spec. This instraction was not present in previous
> MIPS instruction sets.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/helper.h    |  2 ++
>  target/mips/op_helper.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
>  target/mips/translate.c | 15 ++++++++
>  3 files changed, 111 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
