Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E587FC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE095206D9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2lySuXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE095206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1junfx-0008Uj-TH
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 21:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1junfR-000848-AE; Sun, 12 Jul 2020 21:54:05 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:41944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1junfP-00062x-ND; Sun, 12 Jul 2020 21:54:05 -0400
Received: by mail-yb1-xb42.google.com with SMTP id a15so5658557ybs.8;
 Sun, 12 Jul 2020 18:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xNyNspxOZnByj7xwKvb/k3qqCO/MEqSXjc6QfhWqYPI=;
 b=Y2lySuXT+WqArjR4qZHuEaHP6HRWk0gzRY/ntEOLf+sI0A/TuJ+mveuNJhA+JK10kc
 DtJA1uo8AVxYeksAQKkUybGNGRVs5TH+MENLZChsstoblvU+ZGbv1s+jflvF5XFNDGZj
 vfnzHLcVb7g+rxAA53/28FBb+9hFL5H2D/C69K5AbmxF3MSTyhMBOxYw9fOOl3EuuhNL
 9vyLGcK50pUMuUjfEFPRD6balTdCpQKg1gZFDazI+XYNq0Sp/7D1WyFLl/xNakmRCwW2
 kxwBS2svg9H5v9qe+ovHaltZEAj4NUvL3HEg415kNYByddRWkeKYfQ9I+5pjWvZJC/K5
 +TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xNyNspxOZnByj7xwKvb/k3qqCO/MEqSXjc6QfhWqYPI=;
 b=tZvk1A0ixGfRbjJopTEjZSf6ElBDNTI+5J2N2G4rv536fW2xUmYO51Q/4HUtNFe35t
 uH9tu8VMlVL1Z7OcBFspnnjz4UkAtOrWzQqupSV2G1ZNe82Y3PH2NLGg10pv012IQ/st
 Wx9QKPkswV3N8rmImK5bXgTCMoZJkg+FTij7cib1tMZakU5B2ku3PyEWNTUZ/HTp/3fx
 lg005W4Hz7bXc6zvyUutgPENCx6+NGzFeAyGvbkdPED1m7mVqcxtwxn6fZXmia4NaqpA
 q9VsYZCCDSum2iNFTQewe2lExqvNMEZQIWlPNsrqLzzFyHMQGD+pn/oaMSHiaiozzRF/
 KmFQ==
X-Gm-Message-State: AOAM532vfPV/36zWHjAhPrHMyS6ykqPKjk4rKfLZyg58WMVQyhU+QxRX
 vcfD22N4ysZlvuNlrFIpE5zLgb7AthqkBFRJXkg=
X-Google-Smtp-Source: ABdhPJyPP6H+kxy5QoBbQObbkZNNPOVG6YG1cnl/Akt0v21uP/ZpQhNxEs5rQWawFpnnjYr9AGwvzgzgWGSOyC9sbu4=
X-Received: by 2002:a25:c342:: with SMTP id
 t63mr128539035ybf.122.1594605242187; 
 Sun, 12 Jul 2020 18:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
 <1594357499-29068-5-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKM1m2j15ncbcW0rp5fk6FmbJ20uWOYUC40+v9PG=Hu7yQ@mail.gmail.com>
In-Reply-To: <CAKmqyKM1m2j15ncbcW0rp5fk6FmbJ20uWOYUC40+v9PG=Hu7yQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 13 Jul 2020 09:53:50 +0800
Message-ID: <CAEUhbmWxCMZG+kdyqeSBrJPRf0Jvb7a4AcADuFXpRwQ7fb8zDA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] hw/riscv: Use pre-built bios image of generic
 platform for virt & sifive_u
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 12, 2020 at 1:34 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Jul 9, 2020 at 10:07 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > Update virt and sifive_u machines to use the opensbi fw_dynamic bios
> > image built for the generic FDT platform.
> >
> > Remove the out-of-date no longer used bios images.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> This patch seems to break 32-bit Linux boots on the sifive_u and virt machines.
>

It looks only Linux boot on sifive_u is broken. On our side, we have
been using VxWorks to test 32-bit OpenSBI on sifive_u so this issue
gets unnoticed. I will take a look.

Regards,
Bin

