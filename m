Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6683C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB32120659
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVU2Whyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB32120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsYIi-0003NU-MA
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 16:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33521)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hsYHy-0002eF-QU
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hsYHw-0005LX-KF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:00:02 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hsYHw-0005LB-B6
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:00:00 -0400
Received: by mail-ot1-x341.google.com with SMTP id j11so10322905otp.10
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CLvIAPzS7jnNx/+76C0YuD92Fc6BphZ49r2xmkOjync=;
 b=qVU2WhypAyHrHL56Bz+s39d20zwgjE2Uj/YHDd655lLA/gVdCokRbbPhUuA0yF4MQx
 wTd7vJZ+ubMh25beOGxImFXQVOjo3RkgUwqNTLzWApS2pMSPGaVxfa+NW55rTPlYiNBT
 RVW/jB+w6BM6x0e4kr+otn7ITy+c3CJM72oitWrHCG/kFSJa4J6VTVSvAdkui407thmu
 ae4H7YErSgw95BCIGudOuS//lu+075n1LF+nCcHAhHLAcYIxTUA5D/quA2Biat1Nqyuf
 Rx1Gnud+o5uMlu4N8K7vzP1IaHA+pLswqZCOsn7y5+tR+u7nZPq0Ssmft42d7BZ6bZLt
 NRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CLvIAPzS7jnNx/+76C0YuD92Fc6BphZ49r2xmkOjync=;
 b=uUKnZ/xiK+sF8vAYKMBBpDk8JJQuciOzQmUCB5VQPdu4EEBx762EXoX5kTaoZsVXBO
 OSfGOyMGwVCcx1Ml2Z3rkPYVrztPtRkyS6VjyXP09U/8Gw2BKc1PrU6TAIeN4nC+zEnw
 Ghpb+9q3yPD0esGN2PN/WWMX5DoWp9EhkDDzCrPjTfHiA+4tS50vp08JOUUG3evpCTiG
 9IF5I3UXKehA31wgHYyGeLuV5shgLURun1pGlIGNGGwrZOUmyK3/q0bn+y12QvMyInj2
 SciEnWPMO0/rGktSGbRIZ304XBqQpQdZx+GBNbW7octZ0m0E2eYOGVAU10Wvo4BjvuDG
 6qkQ==
X-Gm-Message-State: APjAAAUYtshsUCYtHuYBWO6Og7LUEAHe4XXq9+Jw6Ok2BxEXdKDi2ktp
 kefCSeJjWtYWwhaeP6tp9ONLQ7jTtyHyK+VRJ38=
X-Google-Smtp-Source: APXvYqym7ok0RNT1CY5SPm3WGXbxnF/+Hu6fqgiZd75zIeTlWs9H1nWVoUGmLr4m7WvxvzSWAFBAgHRidGtXRBWpee4=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr65360014otr.295.1564516798158; 
 Tue, 30 Jul 2019 12:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <8a5c6ca782b64899b7d6fbf47e8e6869@tpw09926dag18e.domain1.systemhost.net>
 <1564017946033.57669@bt.com>
In-Reply-To: <1564017946033.57669@bt.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 30 Jul 2019 21:59:47 +0200
Message-ID: <CAL1e-=iGAiPdsbeVjs=LJWT7pMQCO-MgriS8DJDXtXXQd8xYiQ@mail.gmail.com>
To: tony.nguyen@bt.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v3 1/1] configure: Define target access
 alignment in configure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, jcmvbkbc@gmail.com,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 3:25 AM <tony.nguyen@bt.com> wrote:

> Rename ALIGNED_ONLY to TARGET_ALIGNED_ONLY for clarity and move
> defines out of target/foo/cpu.h into configure, as we do with
> TARGET_WORDS_BIGENDIAN, so that it is always defined early.
>
> Also, poison the symbol in include/exec/poison.h to prevent use in
> common code.
>
>
Hi, Tony.

Thanks for this new version.

When one mentions "also" in the commit message, this is a kind of strong
indication that the patch should be split into two patches.

So, could you please consider moving "poison" part into a separate patch?

Please don't misunderstand me that I am somehow preventing you from
integrating this change. I do it for the sake of you becoming a better
contributor, and everybody is welcoming you into QEMU community.

Try to follow out guidelines for contributing and also good examples of
existing commit messages.

Yours,
Aleksandar



> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  configure             | 10 +++++++++-
>  include/exec/poison.h |  1 +
>  include/qom/cpu.h     |  2 +-
>  target/alpha/cpu.h    |  2 --
>  target/hppa/cpu.h     |  1 -
>  target/mips/cpu.h     |  2 --
>  target/sh4/cpu.h      |  2 --
>  target/sparc/cpu.h    |  2 --
>  target/xtensa/cpu.h   |  2 --
>  tcg/tcg.c             |  2 +-
>  tcg/tcg.h             |  8 +++++---
>  11 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/configure b/configure
> index 714e7fb..482ba0b 100755
> --- a/configure
> +++ b/configure
> @@ -7431,8 +7431,13 @@ for target in $target_list; do
>  target_dir=3D"$target"
>  config_target_mak=3D$target_dir/config-target.mak
>  target_name=3D$(echo $target | cut -d '-' -f 1)
> +target_aligned_only=3D"no"
> +case "$target_name" in
> +
> alpha|hppa|mips64el|mips64|mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc|=
sparc64|sparc32plus|xtensa|xtensaeb)
> +  target_aligned_only=3D"yes"
> +  ;;
> +esac
>  target_bigendian=3D"no"
> -
>  case "$target_name" in
>
>  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1=
k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
>    target_bigendian=3Dyes
> @@ -7717,6 +7722,9 @@ fi
>  if supported_whpx_target $target; then
>      echo "CONFIG_WHPX=3Dy" >> $config_target_mak
>  fi
> +if test "$target_aligned_only" =3D "yes" ; then
> +  echo "TARGET_ALIGNED_ONLY=3Dy" >> $config_target_mak
> +fi
>  if test "$target_bigendian" =3D "yes" ; then
>    echo "TARGET_WORDS_BIGENDIAN=3Dy" >> $config_target_mak
>  fi
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index b862320..955eb86 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -35,6 +35,7 @@
>  #pragma GCC poison TARGET_UNICORE32
>  #pragma GCC poison TARGET_XTENSA
>
> +#pragma GCC poison TARGET_ALIGNED_ONLY
>  #pragma GCC poison TARGET_HAS_BFLT
>  #pragma GCC poison TARGET_NAME
>  #pragma GCC poison TARGET_SUPPORTS_MTTCG
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 5ee0046..9b50b73 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -89,7 +89,7 @@ struct TranslationBlock;
>   * @do_unassigned_access: Callback for unassigned access handling.
>   * (this is deprecated: new targets should use do_transaction_failed
> instead)
>   * @do_unaligned_access: Callback for unaligned access handling, if
> - * the target defines #ALIGNED_ONLY.
> + * the target defines #TARGET_ALIGNED_ONLY.
>   * @do_transaction_failed: Callback for handling failed memory
> transactions
>   * (ie bus faults or external aborts; not MMU faults)
>   * @virtio_is_big_endian: Callback to return %true if a CPU which suppor=
ts
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index b3e8a82..16eb804 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -23,8 +23,6 @@
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
>
> -#define ALIGNED_ONLY
> -
>  /* Alpha processors have a weak memory model */
>  #define TCG_GUEST_DEFAULT_MO      (0)
>
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index aab251b..2be67c2 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -30,7 +30,6 @@
>     basis.  It's probably easier to fall back to a strong memory model.  =
*/
>  #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
>
> -#define ALIGNED_ONLY
>  #define MMU_KERNEL_IDX   0
>  #define MMU_USER_IDX     3
>  #define MMU_PHYS_IDX     4
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 21c0615..c13cd4e 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1,8 +1,6 @@
>  #ifndef MIPS_CPU_H
>  #define MIPS_CPU_H
>
> -#define ALIGNED_ONLY
> -
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
>  #include "fpu/softfloat.h"
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index aee733e..ecaa7a1 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -23,8 +23,6 @@
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
>
> -#define ALIGNED_ONLY
> -
>  /* CPU Subtypes */
>  #define SH_CPU_SH7750  (1 << 0)
>  #define SH_CPU_SH7750S (1 << 1)
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 8ed2250..1406f0b 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -5,8 +5,6 @@
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
>
> -#define ALIGNED_ONLY
> -
>  #if !defined(TARGET_SPARC64)
>  #define TARGET_DPREGS 16
>  #else
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 2c27713..0459243 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -32,8 +32,6 @@
>  #include "exec/cpu-defs.h"
>  #include "xtensa-isa.h"
>
> -#define ALIGNED_ONLY
> -
>  /* Xtensa processors have a weak memory model */
>  #define TCG_GUEST_DEFAULT_MO      (0)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index be2c33c..8d23fb0 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1926,7 +1926,7 @@ static const char * const ldst_name[] =3D
>  };
>
>  static const char * const alignment_name[(MO_AMASK >> MO_ASHIFT) + 1] =
=3D {
> -#ifdef ALIGNED_ONLY
> +#ifdef TARGET_ALIGNED_ONLY
>      [MO_UNALN >> MO_ASHIFT]    =3D "un+",
>      [MO_ALIGN >> MO_ASHIFT]    =3D "",
>  #else
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index b411e17..529acb2 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -333,10 +333,12 @@ typedef enum TCGMemOp {
>      MO_TE    =3D MO_LE,
>  #endif
>
> -    /* MO_UNALN accesses are never checked for alignment.
> +    /*
> +     * MO_UNALN accesses are never checked for alignment.
>       * MO_ALIGN accesses will result in a call to the CPU's
>       * do_unaligned_access hook if the guest address is not aligned.
> -     * The default depends on whether the target CPU defines ALIGNED_ONL=
Y.
> +     * The default depends on whether the target CPU defines
> +     * TARGET_ALIGNED_ONLY.
>       *
>       * Some architectures (e.g. ARMv8) need the address which is aligned
>       * to a size more than the size of the memory access.
> @@ -353,7 +355,7 @@ typedef enum TCGMemOp {
>       */
>      MO_ASHIFT =3D 4,
>      MO_AMASK =3D 7 << MO_ASHIFT,
> -#ifdef ALIGNED_ONLY
> +#ifdef TARGET_ALIGNED_ONLY
>      MO_ALIGN =3D 0,
>      MO_UNALN =3D MO_AMASK,
>  #else
> --
> 1.8.3.1
>
>
