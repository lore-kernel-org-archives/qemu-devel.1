Received: from eggs.gnu.org ([2001:4830:134:3::10]:40247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Axb-0002Lq-Oz
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Axb-00011t-2U
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:33:27 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:49378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0Axa-00011U-U5
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:33:26 -0400
Received: by mail-qt0-x22a.google.com with SMTP id o3so27169969qte.6
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 11:33:26 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-14-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0c54401b-10b5-9d2b-4a7e-51e9a40f2408@linaro.org>
Date: Thu, 5 Oct 2017 14:33:23 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-14-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/20] nvic: Implement Security Attribution
 Unit registers
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

On 09/22/2017 11:00 AM, Peter Maydell wrote:
> Implement the register interface for the SAU: SAU_CTRL,
> SAU_TYPE, SAU_RNR, SAU_RBAR and SAU_RLAR. None of the
> actual behaviour is implemented here; registers just
> read back as written.
> 
> When the CPU definition for Cortex-M33 is eventually
> added, its initfn will set cpu->sau_sregion, in the same
> way that we currently set cpu->pmsav7_dregion for the
> M3 and M4.
> 
> Number of SAU regions is typically a configurable
> CPU parameter, but this patch doesn't provide a
> QEMU CPU property for it. We can easily add one when
> we have a board that requires it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      |  10 +++++
>  hw/intc/armv7m_nvic.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu.c      |  27 ++++++++++++
>  target/arm/machine.c  |  14 ++++++
>  4 files changed, 167 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
