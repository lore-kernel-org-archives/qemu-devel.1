Received: from eggs.gnu.org ([2001:4830:134:3::10]:58190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duiuX-00018U-0G
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duiuT-0006O3-Lp
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:35:44 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:53134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duiuT-0006NY-8a
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:35:41 -0400
Received: by mail-io0-x230.google.com with SMTP id i197so5236492ioe.9
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:35:41 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-17-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <25250048-7930-e084-9ab7-c899e4f9bdb8@linaro.org>
Date: Wed, 20 Sep 2017 12:35:36 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-17-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/19] target/arm: Handle banking in
 negative-execution-priority check in cpu_mmu_index()
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

On 09/12/2017 01:14 PM, Peter Maydell wrote:
> Now that we have a banked FAULTMASK register and banked exceptions,
> we can implement the correct check in cpu_mmu_index() for whether
> the MPU_CTRL.HFNMIENA bit's effect should apply. This bit causes
> handlers which have requested a negative execution priority to run
> with the MPU disabled. In v8M the test has to check this for the
> current security state and so takes account of banking.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 21 ++++++++++++++++-----
>  hw/intc/armv7m_nvic.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
