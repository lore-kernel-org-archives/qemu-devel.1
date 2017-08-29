Received: from eggs.gnu.org ([2001:4830:134:3::10]:59339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj08-0007B0-Ck
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj05-00026V-7y
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:04:28 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:32823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmj05-000269-38
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:04:25 -0400
Received: by mail-pg0-x236.google.com with SMTP id t3so12106746pgt.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:04:24 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-14-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0777d69a-88cf-4441-df0a-d7bb30571e80@linaro.org>
Date: Tue, 29 Aug 2017 09:04:21 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-14-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/20] target/arm: Make MPU_RBAR,
 MPU_RLAR banked for v8M
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

On 08/22/2017 08:08 AM, Peter Maydell wrote:
> Make the MPU registers MPU_MAIR0 and MPU_MAIR1 banked if v8M security
> extensions are enabled.
> 
> We can freely add more items to vmstate_m_security without
> breaking migration compatibility, because no CPU currently
> has the ARM_FEATURE_M_SECURITY bit enabled and so this
> subsection is not yet used by anything.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      |  4 ++--
>  hw/intc/armv7m_nvic.c |  8 ++++----
>  target/arm/cpu.c      | 26 ++++++++++++++++++++------
>  target/arm/helper.c   | 11 ++++++-----
>  target/arm/machine.c  | 12 ++++++++----
>  5 files changed, 40 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
