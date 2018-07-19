Received: from eggs.gnu.org ([2001:4830:134:3::10]:60280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgB1J-0002Qn-0V
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgB1I-0003TE-84
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:39:09 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgB1I-0003Sy-1I
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:39:08 -0400
Received: by mail-pl0-x244.google.com with SMTP id f6-v6so3830184plo.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:39:07 -0700 (PDT)
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004727-13778-7-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <647437b6-a538-73d5-2fe9-416f448c9dab@linaro.org>
Date: Thu, 19 Jul 2018 08:39:04 -0700
MIME-Version: 1.0
In-Reply-To: <1532004727-13778-7-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 06/11] target/mips: Don't update
 BadVAddr register in Debug Mode
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
> BadVAddr should not be updated if (env->hflags & MIPS_HFLAG_DM) is
> set.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/mips/helper.c    |  4 +++-
>  target/mips/op_helper.c | 12 +++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
