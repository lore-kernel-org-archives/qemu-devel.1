Received: from eggs.gnu.org ([2001:4830:134:3::10]:55213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HQQ-0005Y8-QS
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HQQ-0008CA-04
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:57:06 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7HQP-0008Bs-Pq
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:57:05 -0400
Received: by mail-ot1-x343.google.com with SMTP id e18-v6so1272626oti.8
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 02:57:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180926112048.17778-4-alex.bennee@linaro.org>
References: <20180926112048.17778-1-alex.bennee@linaro.org>
	<20180926112048.17778-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 10:56:44 +0100
Message-ID: <CAFEAcA9DaiY-fu_P4FkswyxHgPO50W7XvkKWXpV5wLbLyCL2bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 3/4] target/arm64: kvm debug set
 target_el when passing exception to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Omair Javaid <omair.javaid@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 26 September 2018 at 12:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> When we are debugging the guest all exception come our way but might

"exceptions"

> be for the guests own debug exceptions. We use the ->do_interrupt()

"guest's"

> infrastructure to do this however we are missing a full setup of the

"to inject the exception into the guest. However, "

> exception structure causing an assert later down the line.

"structure, "

>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/kvm64.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 346e1f1a73..9ceff1884c 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -984,6 +984,7 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_de=
bug_exit_arch *debug_exit)
>      cs->exception_index =3D EXCP_BKPT;
>      env->exception.syndrome =3D debug_exit->hsr;
>      env->exception.vaddress =3D debug_exit->far;
> +    env->exception.target_el =3D 1;
>      qemu_mutex_lock_iothread();
>      cc->do_interrupt(cs);
>      qemu_mutex_unlock_iothread();
> --
> 2.17.1
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
