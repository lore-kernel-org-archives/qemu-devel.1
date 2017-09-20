Received: from eggs.gnu.org ([2001:4830:134:3::10]:46535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dum7F-0008QW-3u
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dum7B-0008L6-Bn
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:01:05 -0400
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:55782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dum7B-0008Kc-5m
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:01:01 -0400
Received: by mail-io0-x22d.google.com with SMTP id z187so6513565ioz.12
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 14:01:00 -0700 (PDT)
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
	<1505580378-9044-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d5885ea-8152-4779-3eda-e18aca00cf3f@linaro.org>
Date: Wed, 20 Sep 2017 16:00:56 -0500
MIME-Version: 1.0
In-Reply-To: <1505580378-9044-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] hw/gpio/omap_gpio.c: Don't use old_mmio
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

On 09/16/2017 11:46 AM, Peter Maydell wrote:
> Drop the use of old_mmio in the omap2_gpio memory ops.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/gpio/omap_gpio.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
