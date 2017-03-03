Received: from eggs.gnu.org ([2001:4830:134:3::10]:58539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrey-0003s5-2q
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrew-0006Vu-Ro
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:10:31 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjrew-0006TE-M6
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:10:30 -0500
Received: by mail-wm0-x236.google.com with SMTP id n11so21576032wma.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 10:10:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170302195337.31558-11-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-11-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 18:10:05 +0000
Message-ID: <CAFEAcA_BwXYnPfb36pXGd1u3dnyQce6Wm4M+1UqgJkpMFpDddw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/11] target/arm/helper: make it clear
 the EC field is also in hex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, MTTCG Devel <mttcg@listserver.greensocs.com>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "open list:ARM" <qemu-arm@nongnu.org>

On 2 March 2017 at 19:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> ..just like the rest of the displayed ESR register. Otherwise people
> might scratch their heads if a not obviously hex number is displayed
> for the EC field.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
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
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
