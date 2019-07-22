Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B14EC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1484B21926
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1484B21926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpVyF-0000th-7l
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40047)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpVy4-0000V0-CA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpVy2-0004Tl-Or
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:54:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpVy2-0004Qe-Ii
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:54:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so34653852wme.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 03:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fQqxjV+l1Pqp9zwnUYJQ4oSZxSq/X2V8mtZ17kFoJag=;
 b=QBpDpL2y9Oo5nIUe3YyM9Fc8F63nUur5/g8je6SZmgvtguSJlVw+bzgi1HhU0qNHFl
 Tr6Gr1/cirhUWd9V/vXNrdwtXRUMP+OdUIqr8ECT4ug/79i2hx1nlkyCJtMJgoRGcs7D
 7uWr5bGw1BqCj4vW+f3eHt5CNFApPm1eS0td31PKmrdyguWSg6OLrmGEPAmCYLlkUv2q
 3oNi82vQi6dFYg5LdfBsXVwTz3KIm0n7LmUMNSSTajsUuBLJi+r5W7HPE6nFhO97MGBx
 5e01bUEKOCmCTz7+PT6b/6cScoNF6vPZ2+70gULObjEubo4rAg9YpIg2y+OcIyUMf05k
 6vug==
X-Gm-Message-State: APjAAAXYNI5MT70VKoIcUz41kLZZg94FcKgh4B8E2ExdF//+lgpsCys+
 yivrsYL76pvpdQJXMAj457cIHA==
X-Google-Smtp-Source: APXvYqwABhgSx7UVruFGegCcrO+vAJp77lmhTxWpuWvy0lylxDE3iu54+vrZLXg4l3261MkfY9uEmw==
X-Received: by 2002:a05:600c:da:: with SMTP id
 u26mr61364556wmm.108.1563792893582; 
 Mon, 22 Jul 2019 03:54:53 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id c7sm31708437wro.70.2019.07.22.03.54.52
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 03:54:53 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <945056df7ff54ce6b272dce64721d916@tpw09926dag18e.domain1.systemhost.net>
 <1563766040903.29641@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dd8f07ab-82e8-e5fb-7f5a-dbce8b260964@redhat.com>
Date: Mon, 22 Jul 2019 12:54:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1563766040903.29641@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 1/2] configure: Define target access
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
Cc: ehabkost@redhat.com, arikalo@wavecomp.com, mark.cave-ayland@ilande.co.uk,
 jcmvbkbc@gmail.com, atar4qemu@gmail.com, amarkovic@wavecomp.com,
 aurelien@aurel32.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Tony,

On 7/22/19 5:27 AM, tony.nguyen@bt.com wrote:
> Move the define of target access alignment earlier from
> target/foo/cpu.h to configure.
> 

You missed:

Suggested-by: Richard Henderson <richard.henderson@linaro.org>

> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>

The single change from your v1 is:

-  target_bigendian=yes
+  target_bigendian="yes"

So you can keep the tag from the reviewers who already checked your
patch, so they don't have to look at it again:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Anyway this patch is already queued by Paolo.

Regards,

Phil.

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
> index eb635c3..8316a16 100755
> --- a/configure
> +++ b/configure
> @@ -7424,8 +7424,13 @@ for target in $target_list; do
>  target_dir="$target"
>  config_target_mak=$target_dir/config-target.mak
>  target_name=$(echo $target | cut -d '-' -f 1)
> +target_aligned_only="no"
> +case "$target_name" in
> +  alpha|hppa|mips64el|mips64|mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc|sparc64|sparc32plus|xtensa|xtensaeb)
> +  target_aligned_only="yes"
> +  ;;
> +esac
>  target_bigendian="no"
> -
>  case "$target_name" in
>    armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
>    target_bigendian=yes
> @@ -7710,6 +7715,9 @@ fi
>  if supported_whpx_target $target; then
>      echo "CONFIG_WHPX=y" >> $config_target_mak
>  fi
> +if test "$target_aligned_only" = "yes" ; then
> +  echo "TARGET_ALIGNED_ONLY=y" >> $config_target_mak
> +fi
>  if test "$target_bigendian" = "yes" ; then
>    echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
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
>   * (this is deprecated: new targets should use do_transaction_failed instead)
>   * @do_unaligned_access: Callback for unaligned access handling, if
> - * the target defines #ALIGNED_ONLY.
> + * the target defines #TARGET_ALIGNED_ONLY.
>   * @do_transaction_failed: Callback for handling failed memory transactions
>   * (ie bus faults or external aborts; not MMU faults)
>   * @virtio_is_big_endian: Callback to return %true if a CPU which supports
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
>     basis.  It's probably easier to fall back to a strong memory model.  */
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
> @@ -1926,7 +1926,7 @@ static const char * const ldst_name[] =
>  };
>  
>  static const char * const alignment_name[(MO_AMASK >> MO_ASHIFT) + 1] = {
> -#ifdef ALIGNED_ONLY
> +#ifdef TARGET_ALIGNED_ONLY
>      [MO_UNALN >> MO_ASHIFT]    = "un+",
>      [MO_ALIGN >> MO_ASHIFT]    = "",
>  #else
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index b411e17..529acb2 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -333,10 +333,12 @@ typedef enum TCGMemOp {
>      MO_TE    = MO_LE,
>  #endif
>  
> -    /* MO_UNALN accesses are never checked for alignment.
> +    /*
> +     * MO_UNALN accesses are never checked for alignment.
>       * MO_ALIGN accesses will result in a call to the CPU's
>       * do_unaligned_access hook if the guest address is not aligned.
> -     * The default depends on whether the target CPU defines ALIGNED_ONLY.
> +     * The default depends on whether the target CPU defines
> +     * TARGET_ALIGNED_ONLY.
>       *
>       * Some architectures (e.g. ARMv8) need the address which is aligned
>       * to a size more than the size of the memory access.
> @@ -353,7 +355,7 @@ typedef enum TCGMemOp {
>       */
>      MO_ASHIFT = 4,
>      MO_AMASK = 7 << MO_ASHIFT,
> -#ifdef ALIGNED_ONLY
> +#ifdef TARGET_ALIGNED_ONLY
>      MO_ALIGN = 0,
>      MO_UNALN = MO_AMASK,
>  #else
> 

