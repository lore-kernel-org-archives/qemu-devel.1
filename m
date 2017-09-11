Received: from eggs.gnu.org ([2001:4830:134:3::10]:42474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drSXI-0008CI-Gk
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drSXH-0006ta-O3
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:30:16 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1drSXH-0006ss-HQ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:30:15 -0400
Received: by mail-wr0-x244.google.com with SMTP id b9so4747961wra.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 10:30:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505175459-27177-1-git-send-email-jincheng.miao@gmail.com>
References: <1505175459-27177-1-git-send-email-jincheng.miao@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 Sep 2017 10:29:43 -0700
Message-ID: <CAKmqyKNzpD3nUcQHCFjerJ3Dy-dfqBdAP8BWC7qAdcEU5g6PTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix tci build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jincheng.miao@gmail.com
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Sep 11, 2017 at 5:17 PM,  <jincheng.miao@gmail.com> wrote:
> From: Jincheng Miao <jincheng.miao@gmail.com>
>
> The previous commit 659ef5cbb8 enable LDST_LABELS in tci target,
> but which causes tci build error like:
> tcg/tcg.c:116:13: error: =E2=80=98tcg_out_ldst_finalize=E2=80=99 used but=
 never defined [-Werror]
>  static bool tcg_out_ldst_finalize(TCGContext *s);
>              ^
> cc1: all warnings being treated as errors
> make[1]: *** [tcg/tcg.o] Error 1
> make: *** [subdir-x86_64-softmmu] Error 2
>
> If this macro is not used in tci, we could just delete it.
>
> Signed-off-by: Jincheng Miao <jincheng.miao@gmail.com>

Thank you for the patch!

This looks good, unfortunately someone else had already sent the same
fix. You can review their patch and add your Reviewed by line to that
patch, that will help get the fix merged.

You can see their patch here: https://patchwork.kernel.org/patch/9946503/

Thanks,
Alistair

> ---
>  tcg/tci/tcg-target.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
> index 5d692e1..26140d7 100644
> --- a/tcg/tci/tcg-target.h
> +++ b/tcg/tci/tcg-target.h
> @@ -206,8 +206,4 @@ static inline void tb_target_set_jmp_target(uintptr_t=
 tc_ptr,
>      /* no need to flush icache explicitly */
>  }
>
> -#ifdef CONFIG_SOFTMMU
> -#define TCG_TARGET_NEED_LDST_LABELS
> -#endif
> -
>  #endif /* TCG_TARGET_H */
> --
> 1.8.3.1
>
>
