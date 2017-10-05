Received: from eggs.gnu.org ([2001:4830:134:3::10]:45970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0B63-0006EE-El
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0B61-00047q-Ll
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:42:11 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:56047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0B61-00047D-GY
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:42:09 -0400
Received: by mail-qt0-x22e.google.com with SMTP id x54so27144850qth.12
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 11:42:09 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-17-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d5580cc-eea2-280b-5a65-0462e7af7cbd@linaro.org>
Date: Thu, 5 Oct 2017 14:42:06 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-17-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/20] target/arm: Factor out "get mmuidx
 for specified security state"
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
> For the SG instruction and secure function return we are going
> to want to do memory accesses using the MMU index of the CPU
> in secure state, even though the CPU is currently in non-secure
> state. Write arm_v7m_mmu_idx_for_secstate() to do this job,
> and use it in cpu_mmu_index().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
