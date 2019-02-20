Received: from eggs.gnu.org ([209.51.188.92]:34421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWVw-0007Xa-Pm
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWVw-0008OB-29
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:22:36 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:32797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwWVs-0008Jq-8s
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:22:32 -0500
Received: by mail-pf1-x444.google.com with SMTP id c123so12319794pfb.0
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:22:28 -0800 (PST)
References: <20190219125808.25174-1-peter.maydell@linaro.org>
	<20190219125808.25174-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <af9298f6-15ca-fb51-9618-9cf7e3cd3d6e@linaro.org>
Date: Wed, 20 Feb 2019 10:22:24 -0800
MIME-Version: 1.0
In-Reply-To: <20190219125808.25174-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/8] hw/misc/iotkit-sysctl: Correct typo in
 INITSVTOR0 register name
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

On 2/19/19 4:58 AM, Peter Maydell wrote:
> The iotkit-sysctl device has a register it names INITSVRTOR0.
> This is actually a typo present in the IoTKit documentation
> and also in part of the SSE-200 documentation:  it should be
> INITSVTOR0 because it is specifying the initial value of the
> Secure VTOR register in the CPU. Correct the typo.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/misc/iotkit-sysctl.h |  2 +-
>  hw/misc/iotkit-sysctl.c         | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
