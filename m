Received: from eggs.gnu.org ([2001:4830:134:3::10]:60463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgB1v-0003Ld-8B
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgB1r-0003wm-0c
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:39:47 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgB1q-0003wT-NH
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:39:42 -0400
Received: by mail-pg1-x542.google.com with SMTP id e6-v6so4118816pgv.2
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:39:42 -0700 (PDT)
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004727-13778-8-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e7ef7ab7-3b42-ccd3-cf66-0464906ebf56@linaro.org>
Date: Thu, 19 Jul 2018 08:39:39 -0700
MIME-Version: 1.0
In-Reply-To: <1532004727-13778-8-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 07/11] target/mips: Check ELPA flag only
 in some cases of MFHC0 and MTHC0
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
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> MFHC0 and MTHC0 used to handle EntryLo0 and EntryLo1 registers only,
> and placing ELPA flag checks before switch statement were technically
> correct. However, after adding handling more registers, these checks
> should be moved to act only in cases of handling EntryLo0 and
> EntryLo1.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
