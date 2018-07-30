Received: from eggs.gnu.org ([2001:4830:134:3::10]:60918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkEvC-0002iy-JL
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkEv8-0002cV-L0
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:37:38 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:37070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkEv8-0002cC-D9
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:37:34 -0400
Received: by mail-vk0-x244.google.com with SMTP id v72-v6so6403990vkd.4
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 13:37:34 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-17-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cc98131f-617a-9a11-3d96-d588cf54d036@linaro.org>
Date: Mon, 30 Jul 2018 16:37:29 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-17-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 16/76] target/mips: Mark switch
 fallthroughs with interpretable comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:11 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Mark switch fallthroughs with comments, in cases fallthroughs
> are intentional.
> 
> The comments "/* fall through */" are interpreted by compilers and
> other tools, and they will not issue warnings in such cases. For gcc,
> the warning is turnend on by -Wimplicit-fallthrough. With this patch,
> there will be no such warnings in target/mips directory. If such
> warning appears in future, it should be checked if it is intentional,
> and, if yes, marked with a comment similar to those from this patch.
> 
> The comment must be just before next "case", otherwise gcc won't
> understand it.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
