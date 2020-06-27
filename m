Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DC8C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B6E207FC
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APvqABuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B6E207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpF27-0007kR-Eq
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jpF1Y-0007I9-Rc
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:53:56 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:37398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jpF1X-0004RA-BC
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:53:56 -0400
Received: by mail-ej1-x642.google.com with SMTP id mb16so12327433ejb.4
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/uKoXbzRBdoC073oErPEhHasrtc3oYGlanETkmbsn5Y=;
 b=APvqABuLEjFKQsyf6NKSWgT+ep5jZF+Yl41691ibnrDW3sUv+XZe8H/NJqMvXnrJOf
 6gz6UCJWNpmSlxydHdHj5DWAxem2mC+jiKmwMHNIM6iQU/8ZgIymDozKlJI4KLIvWStI
 Sr5mdSMJdCsd4Fv4wCrjXKMlJIfT5+AS/RoYOo0ufkw6+e/qkJjGKOPrBE6kvolOg7/Y
 7wvWrWe/aBtg/C5nEAruT8ymcTAlkxaTKXHd7HcRCKrK2GI0tg6yFSdqWUvvaBTC3Bqf
 aabMJlBf7i0poy7sWfAkyGMWuUcoZaLuyHzZcHv2/SAKvnzz/Z1s/LI21ecwJEQ5hySe
 QPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/uKoXbzRBdoC073oErPEhHasrtc3oYGlanETkmbsn5Y=;
 b=rtPMmJ+6uPOatvS4OkYal7mky+/UkfXoWHx/78gBSEwoLKU7vFx4bCCRZH7rCCWnFV
 RwZzC3w4Hfl1WUUxPYFBwTfIkV5GxlW/2pwQ6ra3xdbFiZRZHeX3ZUQFoSApI/VhNP/l
 M3LTyN6ZacJQdyXbbTtvha6WXR1x3EVwi/BAu/BbeF4QHWqVT4mD6J2cZaEZDfbSQOHm
 fGFhBItc1Cu3Sa4V5CPTV0s/6lKDA0vcFN2gpFIlR6tLNG5GK92DzFNYmiuJccZ2ivcy
 lHlCaXqhChgmbLXrYZw30mNvCmC8e7ujeufQu7sGBJZWbUTO9MyjgHMloRx9u6Lw4nFs
 qRqw==
X-Gm-Message-State: AOAM5325ce35ilygZBHhErUWI36jRb1Q5K4m5KGujh8lpRqTrFGmiGBR
 XY10mHF8V3NREZLy2AIQmgkGK6BUFwfcefqg+tQ=
X-Google-Smtp-Source: ABdhPJxgDC6xzdE2nCA5+JFqJ6IatmVNBDCMrLhP42oB46P+jhfOt9PPgsBN91T8V69b+6fvFIqUH399/YreHhwnCo0=
X-Received: by 2002:a17:906:1c4b:: with SMTP id
 l11mr7243326ejg.307.1593280433941; 
 Sat, 27 Jun 2020 10:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <1592995531-32600-1-git-send-email-chenhc@lemote.com>
 <1592995531-32600-5-git-send-email-chenhc@lemote.com>
In-Reply-To: <1592995531-32600-5-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 27 Jun 2020 19:53:43 +0200
Message-ID: <CAL1e-=gAkvEx7PsV1BZmnejyvOJJvQMA4LUvPFW2msSa6Z141g@mail.gmail.com>
Subject: Re: [PATCH V6 4/4] MAINTAINERS: Add Loongson-3 maintainer and reviewer
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 12:46 PM Huacai Chen <zltjiangshi@gmail.com> wrote:
>
> Add myself as a maintainer of Loongson-3 virtual platform, and also add
> Jiaxun Yang as a reviewer.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Applied to MIPS queue, for now without one of two files mentioned in
the section "Loongson-3 Virtual Platform". Also, "Loongson-3 Virtual Platform"
is changed to "Loongson-3 virtual platforms" to allow future extensions.

>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51a4570..0226a74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1095,6 +1095,13 @@ F: hw/isa/vt82c686.c
>  F: hw/pci-host/bonito.c
>  F: include/hw/isa/vt82c686.h
>
> +Loongson-3 Virtual Platform
> +M: Huacai Chen <chenhc@lemote.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> +S: Maintained
> +F: hw/mips/loongson3_virt.c
> +F: hw/intc/loongson_liointc.c
> +
>  Boston
>  M: Paul Burton <pburton@wavecomp.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> --
> 2.7.0
>
>

