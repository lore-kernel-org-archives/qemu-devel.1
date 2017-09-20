Received: from eggs.gnu.org ([2001:4830:134:3::10]:47543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dum93-0000we-Ps
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dum90-0001Sf-N2
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:02:57 -0400
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:55807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dum90-0001SD-Ib
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:02:54 -0400
Received: by mail-io0-x232.google.com with SMTP id z187so6524914ioz.12
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 14:02:54 -0700 (PDT)
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
	<1505580378-9044-5-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1f07b039-a844-1df3-a07b-20578b08b659@linaro.org>
Date: Wed, 20 Sep 2017 16:02:50 -0500
MIME-Version: 1.0
In-Reply-To: <1505580378-9044-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] hw/timer/omap_gptimer: Don't use
 old_mmio
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
> Don't use the old_mmio struct in memory region ops.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/omap_gptimer.c | 49 +++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
