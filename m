Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BEDC74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 23:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91ABF20844
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 23:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+uw66L2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91ABF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlMGG-0001bK-Jx
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 19:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37732)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hlMFI-00016m-Lk
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 19:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hlMFE-00071u-04
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 19:43:31 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hlMF8-0006ve-Tw; Wed, 10 Jul 2019 19:43:23 -0400
Received: by mail-lj1-x243.google.com with SMTP id m8so3819130lji.7;
 Wed, 10 Jul 2019 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DfhVHYSytc0MgA0TW7DwzRhmzhW67lpM3yCAcd655Kw=;
 b=D+uw66L22Ir1xjEZPyaQPa+POoAwPXMNKwGFH3WVHYTXP3/UH+MTViw1SUUzebqjNz
 uYv+pSJAfvNPvFcf6CTXAN2D9c5gahJyLV+0a+u6Mk4pYlTdXMTdA/F4/Pv6zkZSfUKH
 XlW5+/BFucu/WwNV3s2D0a9DMvXs9i82Fx+dNBFp2lPwmPaLJGnra8iyQPvt+o8iTRVe
 denI+ZTvdSQa9htnlBiLxr95tTJPxwgVe41QUR/foL3ygzUQ0aW67s/grwZcgiVAl58C
 kpOlEJ+T8CFxBch8m3Vy5gTFHPpOZ07RWBX2sNROuPaZ9oLmmS8cvknMp6BohF5s+YY+
 GfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DfhVHYSytc0MgA0TW7DwzRhmzhW67lpM3yCAcd655Kw=;
 b=q6HVJ9BX7YrTar8Iz25dfRfpufg3Lrt210uwT4S/WUCFmz0xcPF5er5UEr1ThaNWqx
 HobDJJTns9JrkAeBLU1E4qrqT4yQJQThV/0FQU7ak/imSD+N7xN8mXA3biC9HvGvCMO+
 3SnNI3vY14xGkrSHDDJpIfWvbMBSd0DOF280rrQ6weEnE2d7ZIkVTkZ4hRRQqslNjBdR
 1HbY2XsTiEk9/BR8pIF+V1EKyiNlGLSjdXZJrelyjOLZyWsGCA8uVWcAcTVqkfj3XIE7
 W7QOGsIAylLZ6UrYnJvePjlrIAceKdGOJAtnH7O9MjYBc9bs3Ta4pHiplobKZhtle5SM
 Abdw==
X-Gm-Message-State: APjAAAWOsksAvOvLewZuBPsIDA4VJ3dQJx3wyIQ5m7i3zzckuIlqS5Is
 i0Fz841yXJ95yKWJ3G80PFCS8ijLYJpdGId2zIc=
X-Google-Smtp-Source: APXvYqwTPk3DJ3xGzlJVRW8xEkJiq9/ROPnpePoY9j5lznmf+SW6ZwLD18ZcnELiqYC73okKWzvLPJ1gJCv0ciM3LLU=
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr467631ljj.146.1562802200656; 
 Wed, 10 Jul 2019 16:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <1558108285-19571-1-git-send-email-bmeng.cn@gmail.com>
 <1558108285-19571-2-git-send-email-bmeng.cn@gmail.com>
 <9338c7b4-6a05-2189-b93d-25cb2bd4dd54@adacore.com>
In-Reply-To: <9338c7b4-6a05-2189-b93d-25cb2bd4dd54@adacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jul 2019 16:40:07 -0700
Message-ID: <CAKmqyKPXVseNcpVBNOLONq2M6jzsSL_CDsX+1xhupvis3_8amA@mail.gmail.com>
To: Fabien Chouteau <chouteau@adacore.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH 2/2] riscv: sifive_u: Update
 the plic hart config to support multicore
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 8, 2019 at 9:32 AM Fabien Chouteau <chouteau@adacore.com> wrote:
>
> Hi Bin,
>
> Thanks for this patch.
>
> I know I am very late to the game but I have a comment here.
>
> On 17/05/2019 17:51, Bin Meng wrote:
> > +    /* create PLIC hart topology configuration string */
> > +    plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) * smp_cpus;
> > +    plic_hart_config = g_malloc0(plic_hart_config_len);
> > +    for (i = 0; i < smp_cpus; i++) {
> > +        if (i != 0) {
> > +            strncat(plic_hart_config, ",", plic_hart_config_len);
> > +        }
> > +        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
> > +                plic_hart_config_len);
> > +        plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
> > +    }
> > +
>
> This will create up to 4 MS PLIC devices. However on the Unleashed FU540 the PLICs are M,MS,MS,MS,MS because of the monitor hart #0.
>
> This means a different memory layout than the real hardware.
>
> For instance address 0x0C00_2080 will be hart #0 S-Mode interrupt enables in QEMU, instead of #1 M-Mode interrupt enables for the real hardware.
>
> To fix this I suggest to change this loop to:
>
>     for (i = 0; i < smp_cpus; i++) {
>         if (i != 0) {
>             strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
>                     plic_hart_config_len);
>         } else {
>             strncat(plic_hart_config, "M", plic_hart_config_len);
>         }
>         plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
>     }
>
> This will make hart #0 PLIC in M mode and the others in MS.
>
> What do you think?

I think I understand what you mean, in which case I also think you are
correct. Do you want to send a patch and we can discuss there?

Alistair

>
> Best regards,
>

