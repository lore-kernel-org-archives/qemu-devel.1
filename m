Received: from eggs.gnu.org ([2001:4830:134:3::10]:47423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMAjU-00079X-Kd
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMAjP-0006Dv-8C
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:50:19 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMAjN-0006DE-VK
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:50:14 -0500
Received: by mail-wm1-x341.google.com with SMTP id t15-v6so7875688wmt.0
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 03:50:13 -0800 (PST)
References: <20181106164118.16184-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181106164118.16184-1-peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 11:50:11 +0000
Message-ID: <87k1liecr0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-3.1] target/arm: Remove
 antique TODO comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Remove a TODO comment about implementing the vectored interrupt
> controller. We have had an implementation of that for a decade;
> it's in hw/intc/pl190.c.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ec56becc394..851ea9aa977 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8378,7 +8378,6 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *=
cs)
>          return;
>      }
>
> -    /* TODO: Vectored interrupt controller.  */
>      switch (cs->exception_index) {
>      case EXCP_UDEF:
>          new_mode =3D ARM_CPU_MODE_UND;


--
Alex Benn=C3=A9e
