Received: from eggs.gnu.org ([2001:4830:134:3::10]:44521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKaw-0002c5-Jw
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKas-00074m-BP
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:53:54 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqKai-0006yN-Ci
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:53:43 -0400
Received: by mail-pg1-x544.google.com with SMTP id z8-v6so2250577pgu.8
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:53:34 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <28937a46-f989-6ff9-2cfa-d772e0726aab@linaro.org>
Date: Thu, 16 Aug 2018 08:53:31 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 03/84] target/mips: Avoid case
 statements formulated by ranges - part 2
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

On 08/16/2018 07:56 AM, Aleksandar Markovic wrote:
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Remove "range style" case statements to make code analysis easier.
> This patch handles cases when the values in the range in question
> were not properly defined.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 78 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 71 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
