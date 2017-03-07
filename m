Received: from eggs.gnu.org ([2001:4830:134:3::10]:58903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clJFT-0008Hk-4V
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clJFS-0003hF-9p
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:50:11 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<20170307155054.5833-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1bfd4dce-1be3-2176-8731-ea5b9a677d30@amsat.org>
Date: Tue, 7 Mar 2017 14:49:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170307155054.5833-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 10/11] target/arm/helper:
 make it clear the EC field is also in hex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: mttcg@listserver.greensocs.com, nikunj@linux.vnet.ibm.com, a.rigo@virtualopensystems.com, qemu-devel@nongnu.org, cota@braap.org, "open list:ARM" <qemu-arm@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com

On 03/07/2017 12:50 PM, Alex Bennée wrote:
> ..just like the rest of the displayed ESR register. Otherwise people
> might scratch their heads if a not obviously hex number is displayed
> for the EC field.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: KONRAD Frederic <fred.konrad@greensocs.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3f4211b572..76b608f0ba 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6857,7 +6857,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>                    new_el);
>      if (qemu_loglevel_mask(CPU_LOG_INT)
>          && !excp_is_internal(cs->exception_index)) {
> -        qemu_log_mask(CPU_LOG_INT, "...with ESR %x/0x%" PRIx32 "\n",
> +        qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx32 "\n",
>                        env->exception.syndrome >> ARM_EL_EC_SHIFT,
>                        env->exception.syndrome);
>      }
>
