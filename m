Received: from eggs.gnu.org ([2001:4830:134:3::10]:41886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHC4-0004ax-0c
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHBt-0000AD-9c
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:19:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gFHBt-00009F-2Y
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:19:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id q6-v6so5144874wrw.11
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 04:19:08 -0700 (PDT)
References: <20181024105733.18605-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <65fc69e8-b31c-8cc7-87e4-fb4105e58732@linaro.org>
Date: Wed, 24 Oct 2018 12:19:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181024105733.18605-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] disas/mips: Increase 'member of ISAs' flag
 holder size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Fredrik Noring <noring@nocrew.org>
Cc: qemu-devel@nongnu.org

On 10/24/18 11:57 AM, Philippe Mathieu-Daudé wrote:
> Increase the size of 'membership' holder size to 64 bits. This is
> needed for future extensions since existing bits are almost all used.
> (This change is related to f9c9cd63e3),
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  disas/mips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
