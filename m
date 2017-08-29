Received: from eggs.gnu.org ([2001:4830:134:3::10]:48932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiYu-0006VB-0r
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiYr-0006EH-OM
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:36:20 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:36365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmiYr-0006DB-IR
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:36:17 -0400
Received: by mail-pf0-x230.google.com with SMTP id z87so11224893pfi.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:36:17 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-6-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <472c8319-b1d3-c91c-c9eb-6e138d8ba82f@linaro.org>
Date: Tue, 29 Aug 2017 08:36:13 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/20] target/arm: Add MMU indexes for
 secure v8M
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
> Now that MPU lookups can return different results for v8M
> when the CPU is in secure vs non-secure state, we need to
> have separate MMU indexes; add the secure counterparts
> to the existing three M profile MMU indexes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h    | 19 +++++++++++++++++--
>  target/arm/helper.c |  9 ++++++++-
>  2 files changed, 25 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
