Received: from eggs.gnu.org ([2001:4830:134:3::10]:59567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fka9F-0004NQ-Py
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fka9B-00076p-G5
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:17:33 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:42538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fka9B-00076U-9u
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:17:29 -0400
Received: by mail-vk0-x244.google.com with SMTP id t4-v6so8081042vke.9
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:17:29 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-48-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dd44897c-6b1b-663a-bd09-39ba4c1214d3@linaro.org>
Date: Tue, 31 Jul 2018 15:17:24 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-48-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 47/76] target/mips: Implement CP0
 Config0.WR bit functionality
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

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add testing Config0.WR bit into watch exception handling logic.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/helper.c    | 12 +++++++++++-
>  target/mips/translate.c | 22 ++++++++++++++++------
>  2 files changed, 27 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
