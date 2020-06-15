Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601F2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2612620739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYQjQVme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2612620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuYa-0001bJ-9O
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jkuXx-00019v-7W
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:13:29 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:42024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jkuXv-0002En-MO
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:13:28 -0400
Received: by mail-ej1-x644.google.com with SMTP id k11so18646623ejr.9
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6yZyp27Jf+QZZ9WYAZe5miV0mrgCL9fgBo9R9X03T7A=;
 b=CYQjQVmeW169P4ksjmTHDnJ2UCkVaekznLSNBrwjj5L1LchguPR2APAbvUER7bO++r
 XQoluKkXiNN+kQ9I+M8SKhhaL9Dyas/NzhB1veCeR3zj3jJxgw7WVpNGKj04rUIg/RM4
 dgG/6H7LMnhqwD4e7TdT71cRb7DaTeSWQ/UklG+EvkPnWb2F93tm4n9mbdtsFrkfeoNz
 llEdKgg8RsDNiX7HIwCOHnvK5Yex7hLW/9enbHppYDxKceCmJG44bV6j48Re/rSlb8t1
 ccJ9UBEPUcw6LRL3/IS8uLNWxBUW8XiZ+CUWduQ3o+hEFym349kKDvlykmNlAn0MVk0x
 3cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6yZyp27Jf+QZZ9WYAZe5miV0mrgCL9fgBo9R9X03T7A=;
 b=uEuZWs3a+7hP+teI4mENM9RYYzQqt6JEeNhBDyYQ8rNxXauFYvYILDO1pSRz0aLyc/
 WeOdB3zYqtP9UhHujvqZZxcBllddt3ASv/KpAOI2rf/bzj7Eq9GFtOpPfT0jLfoJOnaz
 fFPpYrn+lMHCUtRM//47O7NL8OSHps98qXW1pJcN4LAyg0XSa2rL1fwyEweFspR6o4bJ
 d5MJ/FOkxDEmE1AiBw/20gG8moExnM8dRCbKNNy+0KaL3YFVeB852g6xw9qIVJrHafvV
 YcVP/b1o+/nfbyoVKamHqGgBD2/JFpAHY1lGN9EZdAFm2ykQmXlkFvdE0r32jc53kI4X
 Omgw==
X-Gm-Message-State: AOAM530scrBoivsOdH54MyhFNg/r8aew8QObCVhXyF76Lq4Ki4Zmbw+i
 lpWEHnz609O7dTBS72w3tZzV2JzEYYViSnKCSSA=
X-Google-Smtp-Source: ABdhPJzrygFWkCgWS84URWMjE6nG1n9YILIFWavMvuDOuNWxdGJ9sMusVJURZA/wdVYu59Q8jHQ5Hf3ixUMPAi+hcvA=
X-Received: by 2002:a17:906:ae14:: with SMTP id
 le20mr26314129ejb.307.1592248406227; 
 Mon, 15 Jun 2020 12:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200611095316.10133-1-aleksandar.qemu.devel@gmail.com>
 <20200611095316.10133-2-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <20200611095316.10133-2-aleksandar.qemu.devel@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 15 Jun 2020 21:13:15 +0200
Message-ID: <CAL1e-=gBogvOSTKQHUxGXg36udA3PkduxoFEXj1+EzdrSPR8oA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] MAINTAINERS: Adjust sh4 maintainership
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 11:54 AM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> This patch transfers sh4 sections to Yoshinori Sato, who is
> best positioned in the community to assume sh4 maintainership.
> He is the maintainer of the related target rx as well, which
> means that some synergy between the two targets can be expected
> in future.
>
> Further adjustments, reorganizations, and improvements of sh4
> sections are left to the future maintainer to be devised and
> executed, as he deems suitable.
>
> Aurelien and Magnus are deleted as maintainers in some sections
> of the MAINTAINERS file with this patch. However, they will not
> be deleted from QEMU Hall of Fame, where their names will always
> remained carved in stone as QEMU pioneers and granddaddies.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> Acked-by: Magnus Damm <magnus.damm@gmail.com>
> Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---

Applied to MIPS+misc queue.

>  MAINTAINERS | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e7890ce82..5c78ff5672 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -296,7 +296,7 @@ F: tests/tcg/s390x/
>  L: qemu-s390x@nongnu.org
>
>  SH4 TCG CPUs
> -M: Aurelien Jarno <aurelien@aurel32.net>
> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
>  S: Odd Fixes
>  F: target/sh4/
>  F: hw/sh4/
> @@ -1251,14 +1251,16 @@ F: include/hw/riscv/opentitan.h
>  SH4 Machines
>  ------------
>  R2D
> -M: Magnus Damm <magnus.damm@gmail.com>
> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
> +R: Magnus Damm <magnus.damm@gmail.com>
>  S: Maintained
>  F: hw/sh4/r2d.c
>  F: hw/intc/sh_intc.c
>  F: hw/timer/sh_timer.c
>
>  Shix
> -M: Magnus Damm <magnus.damm@gmail.com>
> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
> +R: Magnus Damm <magnus.damm@gmail.com>
>  S: Odd Fixes
>  F: hw/sh4/shix.c
>
> --
> 2.20.1
>
>

