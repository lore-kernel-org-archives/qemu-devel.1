Received: from eggs.gnu.org ([2001:4830:134:3::10]:33574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwAMt-0001vk-OJ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwAMp-00053I-2Y
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:34:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491486340-25988-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <30f2db0a-2132-4f6e-cd06-f5505f01db88@amsat.org>
Date: Thu, 6 Apr 2017 13:34:32 -0300
MIME-Version: 1.0
In-Reply-To: <1491486340-25988-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: Add missing entries
 to excnames[] for log strings
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

Hi Peter,

excnames[] is only used in arm_log_exception(), can we move it there?

anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

On 04/06/2017 10:45 AM, Peter Maydell wrote:
> Recent changes have added new EXCP_ values to ARM but forgot
> to update the excnames[] array which is used to provide
> human-readable strings when printing information about the
> exception for debug logging. Add the missing entries, and
> add a comment to the list of #defines to help avoid the mistake
> being repeated in future.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       | 1 +
>  target/arm/internals.h | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a8aabce..e6f05e2 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -58,6 +58,7 @@
>  #define EXCP_SEMIHOST       16   /* semihosting call */
>  #define EXCP_NOCP           17   /* v7M NOCP UsageFault */
>  #define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
> +/* NB: new EXCP_ defines should be added to the excnames[] array too */
>
>  #define ARMV7M_EXCP_RESET   1
>  #define ARMV7M_EXCP_NMI     2
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index f742a41..97ca034 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -70,6 +70,8 @@ static const char * const excnames[] = {
>      [EXCP_VIRQ] = "Virtual IRQ",
>      [EXCP_VFIQ] = "Virtual FIQ",
>      [EXCP_SEMIHOST] = "Semihosting call",
> +    [EXCP_NOCP] = "v7M NOCP UsageFault",
> +    [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
>  };
>
>  /* Scale factor for generic timers, ie number of ns per tick.
>
