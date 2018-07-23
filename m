Received: from eggs.gnu.org ([2001:4830:134:3::10]:59478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhcwC-0007IH-HE
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhcwB-00073u-LC
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:39:52 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhcwB-000735-Er
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:39:51 -0400
Received: by mail-pg1-x544.google.com with SMTP id e6-v6so657745pgv.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 08:39:51 -0700 (PDT)
References: <20180723123457.2038-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d7a3bca9-381b-abfc-38a2-78a7fe564c90@linaro.org>
Date: Mon, 23 Jul 2018 08:39:47 -0700
MIME-Version: 1.0
In-Reply-To: <20180723123457.2038-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Escalate to correct HardFault
 when AIRCR.BFHFNMINS is set
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

On 07/23/2018 05:34 AM, Peter Maydell wrote:
> When we escalate a v8M exception to HardFault, if AIRCR.BFHFNMINNS is
> set then we need to decide whether it should become a secure HardFault
> or a nonsecure HardFault. We should always escalate to the same
> target security state as the original exception. The current code
> tries to test this using the 'secure' bool, which is not right because
> that flag indicates whether the target security state only for
> banked exceptions; the effect was that we were incorrectly escalating
> always-secure exceptions like SecureFault to a nonsecure HardFault.
> 
> Fix this by defining, logging and using a new 'targets_secure' bool
> which tracks the condition we actually want.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 8 ++++++--
>  hw/intc/trace-events  | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
