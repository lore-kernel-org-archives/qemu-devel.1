Received: from eggs.gnu.org ([2001:4830:134:3::10]:56835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcXBr-0004F0-2O
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 10:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcXBn-0007Je-4S
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 10:30:59 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fcXBm-0007JL-TR
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 10:30:55 -0400
Received: by mail-pg1-x542.google.com with SMTP id n15-v6so1300098pgv.4
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 07:30:54 -0700 (PDT)
References: <20180709124535.1116-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7fafbf1c-9af1-cfb9-24c7-ee9a00ef9d4e@linaro.org>
Date: Mon, 9 Jul 2018 07:30:50 -0700
MIME-Version: 1.0
In-Reply-To: <20180709124535.1116-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] target/arm: Use correct mmu_idx
 for exception-return unstacking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Adithya Baglody <adithya.nagaraj.baglody@intel.com>, patches@linaro.org

On 07/09/2018 05:45 AM, Peter Maydell wrote:
> For M-profile exception returns, the mmu index to use for exception
> return unstacking is supposed to be that of wherever we are returning to:
>  * if returning to handler mode, privileged
>  * if returning to thread mode, privileged or unprivileged depending on
>    CONTROL.nPRIV for the destination security state
> 
> We were passing the wrong thing as the 'priv' argument to
> arm_v7m_mmu_idx_for_secstate_and_priv(). The effect was that guests
> which programmed the MPU to behave differently for privileged and
> unprivileged code could get spurious MemManage Unstack exceptions.
> 
> Reported-by: Adithya Baglody <adithya.nagaraj.baglody@intel.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
