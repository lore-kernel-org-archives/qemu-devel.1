Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FBDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62442075B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiHjoYvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62442075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsrTN-0006Lu-6W
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsrSq-0005vH-3h; Tue, 07 Jul 2020 13:33:04 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:38786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsrSo-0004eP-DX; Tue, 07 Jul 2020 13:33:03 -0400
Received: by mail-il1-x141.google.com with SMTP id s21so21560448ilk.5;
 Tue, 07 Jul 2020 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g9OwooJI0AmcpojJjAr6Vy6fVO8FPlaZL1UKue2QGKo=;
 b=hiHjoYvK/Ael3g6o94XmWkoTM6tXhC1Acj6z2JON77EyTv6jwJGtP+3jnpUpCHLTDO
 lAfN838nRJSHwXdkmRL2DdFgN3bn8+g5xW3HHdXh2tucIgwll5GAQJvU/GVJIm/3k22L
 yB9Z2CuO28Qczqw83GxFpUv2pJRcwS0GzciEYoUIEhELnLy5udtb4baVlVVJfkj4ro2p
 RU4/qeP2jlP0VzC5str9xmATvywbbKKM9ZdwGe+JdpQEkEpglWRWfpTE5tOnOQ4viS1E
 gqjbIZTXhiBpSO7tfH68CjvDBbm75u+DqZqoqJSEXHhKy9M0IKDjdTLuowJFb/SvKUSe
 PQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g9OwooJI0AmcpojJjAr6Vy6fVO8FPlaZL1UKue2QGKo=;
 b=qPgfVCdcG8gu3zw3CYoSuZoNI1F5QPPC/ZCoxuxE/gcz3Mal7+CQ/AUj+al1qViuKF
 Cx8EBPKP7RxGyBfjiJGuqOdPKcZoMVwe22BztL1Mx9UdF4Lukj/HeLvIq+0ISC6hcAt5
 NiphsLRxoqz3N0YtzOx2DN1o7P4m4zZ0BlzJqtNiD0Wmtejz13lWIlQJevoKYsgSVP8V
 fe3v4L1hro+otoisE0CQsgH9MEvV9GVMh9kh6GLbM+XKwCwC0NfiWFMd9JOKZSQ/Z3vA
 84BFmHUDUbekPn4gDUcsgBOx1AsNs++jzgZ7hzoLAjSP+mMv2rbsdQjJjzVeNZtdwyi7
 RGiw==
X-Gm-Message-State: AOAM530pvTgcSNGuDKtmhNE8GYU/YUxm6qV5XkugYAoKbATH5ukVnrRD
 uwKa6d/zpAKGPAoCzzGm7T2F1sqnoPDSzPOY6hg=
X-Google-Smtp-Source: ABdhPJzyGXuAQ+2VHVNSdz9SNVBY/rdkhlMGjookpzlGVnDLjHGHvfOXT7eojeFRyrxo55XPxTUcEOpIBSXYGnmhUPo=
X-Received: by 2002:a92:c213:: with SMTP id j19mr37607448ilo.40.1594143180983; 
 Tue, 07 Jul 2020 10:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593547870.git.alistair.francis@wdc.com>
 <ea4f280e6f77e734c8e555e3c98d10085ce9f5b6.1593547870.git.alistair.francis@wdc.com>
 <CAEUhbmVsQX+es-xw5Omj+-dsU1Km2kKNAZa_NJ6PipE4ZAEucA@mail.gmail.com>
In-Reply-To: <CAEUhbmVsQX+es-xw5Omj+-dsU1Km2kKNAZa_NJ6PipE4ZAEucA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jul 2020 10:23:12 -0700
Message-ID: <CAKmqyKPDUVCVcm8d8bAqr=M_atAgfsFSAMhv6DZ5hOC5aAUHXQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] target/riscv: Regen floating point rounding mode
 in dynamic mode
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 2, 2020 at 6:25 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Wed, Jul 1, 2020 at 4:23 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > When a guest specificies the the rounding mode should be dynamic 0b111
> > then we want to re-caclulate the rounding mode on each instruction. The
> > gen_helper_set_rounding_mode() function will correctly check the
> > rounding mode and handle a dynamic rounding, we just need to make sure
> > it's always called if dynamic rounding is selected.
> >
> > Fixes: 1885350 ("RISCV dynamic rounding mode is not behaving correctly")
>
> I can't find this commit id.

It's a launchpad bug case: https://bugs.launchpad.net/qemu/+bug/1885350

Alistair

>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/translate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Regards,
> Bin

