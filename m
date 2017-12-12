Received: from eggs.gnu.org ([2001:4830:134:3::10]:57526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eOoWj-0003fQ-6x
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:39:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eOoWg-000051-4x
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:39:33 -0500
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:34413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eOoWg-0008WI-03
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:39:30 -0500
Received: by mail-ua0-x244.google.com with SMTP id d26so14952705uak.1
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 09:39:29 -0800 (PST)
References: <1513080506-17703-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <52515faf-f889-93ee-c0d0-4a895cfb6b13@linaro.org>
Date: Tue, 12 Dec 2017 09:39:23 -0800
MIME-Version: 1.0
In-Reply-To: <1513080506-17703-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Make disas_thumb2_insn()
 generate its own UNDEF exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 12/12/2017 04:08 AM, Peter Maydell wrote:
> Refactor disas_thumb2_insn() so that it generates the code for raising
> an UNDEF exception for invalid insns, rather than returning a flag
> which the caller must check to see if it needs to generate the UNDEF
> code. This brings the function in to line with the behaviour of
> disas_thumb_insn() and disas_arm_insn().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This fixes the odd asymmetry of API that caused the bug fixed
> in commit 7472e2efb...
> ---
>  target/arm/translate.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
