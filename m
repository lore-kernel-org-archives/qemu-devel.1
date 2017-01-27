Received: from eggs.gnu.org ([2001:4830:134:3::10]:35721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX72X-0008QH-JN
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX72S-0001To-NJ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:58:09 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX72S-0001T9-H1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:58:04 -0500
Received: by mail-wm0-x234.google.com with SMTP id c85so117933726wmi.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:58:04 -0800 (PST)
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
	<1485285380-10565-11-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1485285380-10565-11-git-send-email-peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 13:58:01 +0000
Message-ID: <87ziic8v12.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/10] armv7m: R14 should reset to
 0xffffffff
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

> For M profile (unlike A profile) the reset value of R14 is specified
> as 0xffffffff.  (The rationale is that this is an illegal exception
> return value, so if guest code tries to return to it it will result
> in a helpful exception.)
>
> Registers r0 to r12 and the flags are architecturally UNKNOWN on
> reset, so we leave those at zero.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 0814f73..e9f10f7 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -196,6 +196,9 @@ static void arm_cpu_reset(CPUState *s)
>           */
>          env->v7m.ccr = R_V7M_CCR_STKALIGN_MASK;
>
> +        /* Unlike A/R profile, M profile defines the reset LR value */
> +        env->regs[14] = 0xffffffff;
> +
>          /* Load the initial SP and PC from the vector table at address 0 */
>          rom = rom_ptr(0);
>          if (rom) {


--
Alex Bennée
