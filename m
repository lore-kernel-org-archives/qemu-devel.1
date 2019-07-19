Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B3C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6439E2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezt7Arvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6439E2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoOvg-0002pt-Nm
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34450)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hoOvW-0002Qf-7P
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hoOvS-0002js-Av
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:11:42 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hoOvO-0002eu-Da
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:11:36 -0400
Received: by mail-oi1-x243.google.com with SMTP id g7so23741210oia.8
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=guX5GlN6zhZuz/GTsUJgksSc4+Dm0ScJ2yBxxCOFkWU=;
 b=ezt7Arvp1hI5EIimgm629aIFtkK7WMrrdorPJQSjSX5AbTBneT1y9OHOLeWz7/UjDP
 MFpu73V1Y1g5RK7SOhfDq1hM6RhV1Gzhaz7QVfuKFV+inFr7jcZDPjEgIkv4Vw26QsDG
 YgG8ehWB39S/ZtavjmH8xL5+zDjHN4p7rmKqQnH0WjmlGU2QvLWD0x6R/cPBTm2b6I5H
 vbYfTwRjHed0cMh4HkiRjgBZCwcqdtA8hDQ4AvySNYLN7BLoSjtMVfh93VlybFpWwatF
 UXoEkNyh5HBnwWOLiiOkiCU6nz9kqhghW60Io0Mkq/R1yWXj4OoNT/YlXiTyeEKw7QWI
 +XZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=guX5GlN6zhZuz/GTsUJgksSc4+Dm0ScJ2yBxxCOFkWU=;
 b=PzqKb8zyW238eo8qjWA6d/cc3oFAH4xkzBEGo9B5oyDT6JKjSJMSDmHv47JmAuGSG6
 6/zP2tPc0hTmoVbolT84l//mTX5LIFaW3aZVAtL5q97BNEqtnZtdcRwLuCG2IzCoswBe
 WzG2dhHat/bRv8xqtXllIpGkrcoaZQYjo4mtjLXzjiMHvb+7n9QBFyP0n6cOHnk1Ea21
 vHniOhbqSb8NCyAm5nYJw9Lgq8oN+htMDnUzezZzrqlv7rg+8nddc6+PeoSaLuEzcnx6
 +Id+bbzcTFHSnV+trVvHJWjvNFqBQTPRn4tcsszHA9g2p5IDHbcxGYJe69RG7Zu6lQG2
 ARWw==
X-Gm-Message-State: APjAAAXdnYwx18M5kMRIf54EKz7R2HDwTAPbgyuFNFOgCu7UCu5Puz1u
 nvtaKTEn1cPIGvt80icwoMocOYYU01TZ3XaT4qA=
X-Google-Smtp-Source: APXvYqwGf6OqjoGFuKihaSbn0E1/rl+BYQ/+UJg6CMc2U6IgNJcsEYQJCIgA+20vvyGlLaGnvrinXiW/Jp4n55xXrVY=
X-Received: by 2002:aca:b254:: with SMTP id b81mr26422100oif.53.1563527491446; 
 Fri, 19 Jul 2019 02:11:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Fri, 19 Jul 2019 02:11:30
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Fri, 19 Jul 2019 02:11:30
 -0700 (PDT)
In-Reply-To: <11e818d38ebc40e986cfa62dd7d0afdc@tpw09926dag18e.domain1.systemhost.net>
References: <11e818d38ebc40e986cfa62dd7d0afdc@tpw09926dag18e.domain1.systemhost.net>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 19 Jul 2019 11:11:30 +0200
Message-ID: <CAL1e-=jW5M6CkS3Ag68NnABOFXB5ELsf7BObwZrx-qkcebq=kQ@mail.gmail.com>
To: tony.nguyen@bt.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] configure: Define target access alignment
 in configure
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 18, 2019 8:02 AM, <tony.nguyen@bt.com> wrote:
>
> This patch moves the define of target access alignment earlier from
> target/foo/cpu.h to configure.
>
> Suggested in Richard Henderson's reply to "[PATCH 1/4] tcg: TCGMemOp is
now
> accelerator independent MemOp"
>
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  configure             | 12 ++++++++++--
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
>  11 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/configure b/configure
> index eb635c3b9a..c07687c656 100755
> --- a/configure
> +++ b/configure
> @@ -7424,11 +7424,16 @@ for target in $target_list; do
>  target_dir=3D"$target"
>  config_target_mak=3D$target_dir/config-target.mak
>  target_name=3D$(echo $target | cut -d '-' -f 1)
> +target_aligned_only=3D"no"
> +case "$target_name" in
> +
alpha|hppa|mips64el|mips64|mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc|sp=
arc64|sparc32plus|xtensa|xtensaeb)
> +  target_aligned_only=3D"yes"
> +  ;;
> +esac
>  target_bigendian=3D"no"
> -
>  case "$target_name" in
>
 armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|=
ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
> -  target_bigendian=3Dyes
> +  target_bigendian=3D"yes"

This line should be in a separate patch. What is the difference between yes
and =E2=80=9Cyes=E2=80=9D? Does this fix a bug, or is just a cosmetic thing=
?

Thanks, Aleksandar

>    ;;
>  esac
>  target_softmmu=3D"no"
> @@ -7710,6 +7715,9 @@ fi
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
> index b862320fa6..955eb863ab 100644
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
> index 5ee0046b62..9b50b73339 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -89,7 +89,7 @@ struct TranslationBlock;
>   * @do_unassigned_access: Callback for unassigned access handling.
>   * (this is deprecated: new targets should use do_transaction_failed
instead)
>   * @do_unaligned_access: Callback for unaligned access handling, if
> - * the target defines #ALIGNED_ONLY.
> + * the target defines #TARGET_ALIGNED_ONLY.
>   * @do_transaction_failed: Callback for handling failed memory
transactions
>   * (ie bus faults or external aborts; not MMU faults)
>   * @virtio_is_big_endian: Callback to return %true if a CPU which
supports
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index b3e8a823e1..16eb8047cf 100644
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
> index aab251bc4b..2be67c289a 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -30,7 +30,6 @@
>     basis.  It's probably easier to fall back to a strong memory model.
*/
>  #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
>
> -#define ALIGNED_ONLY
>  #define MMU_KERNEL_IDX   0
>  #define MMU_USER_IDX     3
>  #define MMU_PHYS_IDX     4
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 21c0615e02..c13cd4eb31 100644
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
> index aee733eaaa..ecaa7a18a9 100644
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
> index 8ed2250cd0..1406f0ba2e 100644
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
> index 2c277134f1..0459243e6b 100644
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
> index be2c33c400..8d23fb0592 100644
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
> index b411e17a28..529acb2ed8 100644
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
> -     * The default depends on whether the target CPU defines
ALIGNED_ONLY.
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
> 2.17.2
>
>
