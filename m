Received: from eggs.gnu.org ([2001:4830:134:3::10]:45347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0B50-0005O5-MO
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0B4z-0002su-Ts
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:41:06 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:52431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0B4z-0002sW-Pm
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:41:05 -0400
Received: by mail-qt0-x232.google.com with SMTP id o52so27178239qtc.9
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 11:41:05 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-16-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <440f5fa0-9c35-63f7-400d-2504a6e63483@linaro.org>
Date: Thu, 5 Oct 2017 14:41:02 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-16-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/20] target/arm: Fix calculation of
 secure mm_idx values
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

On 09/22/2017 11:00 AM, Peter Maydell wrote:
> In cpu_mmu_index() we try to do this:
>         if (env->v7m.secure) {
>             mmu_idx += ARMMMUIdx_MSUser;
>         }
> but it will give the wrong answer, because ARMMMUIdx_MSUser
> includes the 0x40 ARM_MMU_IDX_M field, and so does the
> mmu_idx we're adding to, and we'll end up with 0x8n rather
> than 0x4n. This error is then nullified by the call to
> arm_to_core_mmu_idx() which masks out the high part, but
> we're about to factor out the code that calculates the
> ARMMMUIdx values so it can be used without passing it through
> arm_to_core_mmu_idx(), so fix this bug first.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
