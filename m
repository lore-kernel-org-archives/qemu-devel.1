Received: from eggs.gnu.org ([2001:4830:134:3::10]:60876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX6p5-0003WO-QQ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX6p5-0003CO-0A
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:44:15 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX6p4-0003C7-Qd
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:44:14 -0500
Received: by mail-wm0-x22e.google.com with SMTP id c206so138402978wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:44:14 -0800 (PST)
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
	<1485285380-10565-7-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1485285380-10565-7-git-send-email-peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 13:44:12 +0000
Message-ID: <8760l0aa8j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/10] armv7m: set CFSR.UNDEFINSTR on
 undefined instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Liviu Ionescu <ilg@livius.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Michael Davidsaver <mdavidsaver@gmail.com>
>
> When we take an exception for an undefined instruction, set the
> appropriate CFSR bit.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> [PMM: tweaked commit message, comment]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7dc30f5..e6b1c36 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6072,6 +6072,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>      switch (cs->exception_index) {
>      case EXCP_UDEF:
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
> +        env->v7m.cfsr |= R_V7M_CFSR_UNDEFINSTR_MASK;
>          return;
>      case EXCP_SWI:
>          /* The PC already points to the next instruction.  */


--
Alex Bennée
