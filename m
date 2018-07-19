Received: from eggs.gnu.org ([2001:4830:134:3::10]:59709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgAzR-00019s-8n
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgAzM-0002kz-Vs
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:37:13 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgAzM-0002kn-OY
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:37:08 -0400
Received: by mail-pg1-x542.google.com with SMTP id r5-v6so4106965pgv.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:37:08 -0700 (PDT)
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004727-13778-5-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1803c97f-3ecb-1622-978c-9baf8ecdb627@linaro.org>
Date: Thu, 19 Jul 2018 08:37:05 -0700
MIME-Version: 1.0
In-Reply-To: <1532004727-13778-5-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 04/11] target/mips: Avoid case
 statements formulated by ranges
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
> Remove "range style" case statements to make code analysis easier.
> 
> This is needed also for some upcoming nanoMIPS-related refactorings.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/mips/translate.c | 249 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 200 insertions(+), 49 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
