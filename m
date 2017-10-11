Received: from eggs.gnu.org ([2001:4830:134:3::10]:33162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e2MjM-0005MC-2q
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e2MjI-00078y-3z
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:31:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1507742676-9908-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7405d26e-f677-8995-737b-68ec74da5c8a@amsat.org>
Date: Wed, 11 Oct 2017 16:31:39 -0300
MIME-Version: 1.0
In-Reply-To: <1507742676-9908-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] nvic: Add missing 'break'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 10/11/2017 02:24 PM, Peter Maydell wrote:
> Coverity points out that we forgot the 'break' for
> the SAU_CTRL write case (CID1381683). This has
> no actual visible consequences because it happens
> that the following case is effectively a no-op.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/armv7m_nvic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 201e90f..be46639 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1447,6 +1447,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>              return;
>          }
>          cpu->env.sau.ctrl = value & 3;
> +        break;
>      case 0xdd4: /* SAU_TYPE */
>          if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
>              goto bad_offset;
> 
