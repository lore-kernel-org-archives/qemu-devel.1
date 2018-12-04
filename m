Received: from eggs.gnu.org ([2001:4830:134:3::10]:40052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUBE4-0008N4-Ci
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUBE2-0001ER-8Z
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:59:00 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gUBE2-0001E1-2z
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:58:58 -0500
Received: by mail-ot1-x344.google.com with SMTP id 32so15183354ota.12
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 05:58:58 -0800 (PST)
References: <20181204132952.2601-1-peter.maydell@linaro.org>
	<20181204132952.2601-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <36d844d4-7382-3eef-b88b-9accdde7727c@linaro.org>
Date: Tue, 4 Dec 2018 07:58:54 -0600
MIME-Version: 1.0
In-Reply-To: <20181204132952.2601-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] hw/sd/sdhci: Don't leak memory region
 in sdhci_sysbus_realize()
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

On 12/4/18 7:29 AM, Peter Maydell wrote:
> In sdhci_sysbus_realize() we override the initialization of
> s->iomem that sdhci_common_realize() performs. However we
> don't destroy the old memory region before reinitializing
> it, which means that the memory allocated for mr->name in
> memory_region_do_init() is leaked.
> 
> Since sdhci_initfn() already initializes s->io_ops to
> &sdhci_mmio_ops, always use that in sdhci_common_realize()
> and remove the now-unnecessary reinitialization of the
> MMIO region from sdhci_sysbus_realize().
> 
> Spotted by clang's leak sanitizer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/sd/sdhci.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
