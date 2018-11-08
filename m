Received: from eggs.gnu.org ([2001:4830:134:3::10]:51605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKgTZ-0006EH-6t
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKgTX-0007Xr-2U
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:19:45 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKgTR-0007Kr-7P
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:19:38 -0500
Received: by mail-wr1-x441.google.com with SMTP id 74-v6so20368987wrb.13
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 01:19:31 -0800 (PST)
References: <20181106163801.14474-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <468adced-a5d3-d511-b865-bb0c602d3fe7@linaro.org>
Date: Thu, 8 Nov 2018 10:19:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181106163801.14474-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] target/arm: Remove workaround for
 small SAU regions
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

On 11/6/18 5:38 PM, Peter Maydell wrote:
> Before we supported direct execution from MMIO regions, we
> implemented workarounds in commit 720424359917887c926a33d2
> which let us avoid doing so, even if the SAU or MPU region
> was less than page-sized.
> 
> Once we implemented execute-from-MMIO, we removed part
> of those workarounds in commit d4b6275df320cee76; but
> we forgot the one in get_phys_addr_pmsav8() which
> suppressed use of small SAU regions in executable regions.
> Remove that workaround now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 12 ------------
>  1 file changed, 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
