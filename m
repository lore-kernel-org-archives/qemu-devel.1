Received: from eggs.gnu.org ([209.51.188.92]:56050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvR0D-0005Xt-Ch
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvR0C-0005TH-M8
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:17:21 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvR0C-0005Sk-DU
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:17:20 -0500
Received: by mail-pf1-x441.google.com with SMTP id u6so7346550pfh.11
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 10:17:20 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e3271ea-9f3f-bfa0-4170-6f75255737c0@linaro.org>
Date: Sun, 17 Feb 2019 10:17:16 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/14] hw/arm/musca: Add MPCs
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

On 2/14/19 4:51 AM, Peter Maydell wrote:
> The Musca board puts its SRAM and flash behind TrustZone
> Memory Protection Controllers (MPCs). Each MPC sits between
> the CPU and the RAM/flash, and also has a set of memory mapped
> control registers. Wire up the MPCs, and the memory behind them.
> For the moment we implement the flash as simple ROM, which
> cannot be reprogrammed by the guest.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/musca.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 147 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
