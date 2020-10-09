Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC65C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9695C204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXLbRqK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9695C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR0mg-0000V3-HB
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 18:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kR0lc-0008Se-8l; Fri, 09 Oct 2020 18:21:37 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:38579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kR0la-0006LR-Lb; Fri, 09 Oct 2020 18:21:35 -0400
Received: by mail-il1-x143.google.com with SMTP id p16so2253577ilq.5;
 Fri, 09 Oct 2020 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=49HIxQMnU38CrwINBKj2LIfXMy+X4YMJfTBPCxVae+w=;
 b=pXLbRqK/bLr5srHglr2FrZzyGyaFAz1Gur9YddGv02pzzVxvLiWpA5virkOmz6A+t4
 ishL385FKpI8WyIoKFC2wNJODvauxFJoUfyiclU1IMpDYV8l1muDES50L37RDHYZRtQS
 fQBSkF9mUYJ+b5ANx+FPdtj3P6TFRievrD25U0Fw/7PwESnl9bAcaDpcPnPZoAiJ/Hn0
 Qkh64jnvmClXDVbIMlqRmoLBEt5HfzPZQhDjCMOrTAkKfQzNRqdDosISMKD8oDYasSs1
 Zuux2z3H/tmYkAElYirByNc2rGji8Th9bpcFO1Sl9YUq33H45B0i39Y5eBGr/p9RR6y7
 PLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=49HIxQMnU38CrwINBKj2LIfXMy+X4YMJfTBPCxVae+w=;
 b=FTsn18LTl2hgZOoFDDGfUT6X8ibaxx+tp0bBPMOa4Hr6Kt+F0FGkR+QIXsbl0KM1KT
 xiXxvamq9CVF92RY1pkDtpHicac4zJcxBRx4hQrSaCdZhpd5ojA9suKWY6RWd68WII3F
 Vb1fHS6W/beL2kJuSao+XbUMEgGQ3rjeXK1B8JTX8bkhasUjC8cHbU0/8vT/RcFDbEHu
 Nh/5xx/dZyErWfGP5ymZc3EqYTnlH4rBh6FJQY1yKyh7lkAZ7Zb/KOVI2tdMrJEAzH/P
 jzM9QEUloW04a/bbsIpK6KYjU4LGPd9XHa0S3dFCcTH/y3+baqlQA7CV1eN/tWzecO7e
 37MA==
X-Gm-Message-State: AOAM533rG7PnN0iiN4FWXVDvLgJHhqgtlH0njFOmjhrQCIp2OrkTe8X6
 A0cOzwQ/nZ4lYTWy9RvAlOxF5RKV6lNEV3gucBQ=
X-Google-Smtp-Source: ABdhPJxdEmGKLWZng2/TZk5w/WMTFkZbMnQLIeo2gfyCSp+K5klOvWi1YfR6MiFqFmPRwSAmPFO5zzy8FPUZY3D6tyA=
X-Received: by 2002:a92:c5c2:: with SMTP id s2mr12369127ilt.177.1602282093174; 
 Fri, 09 Oct 2020 15:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601652616.git.alistair.francis@wdc.com>
 <dc18ce8e762658aa80337a97e6e9c978ab9e1696.1601652616.git.alistair.francis@wdc.com>
 <CAEUhbmVdv_7onVjDes6_Tw0h2F4FqVnuiofFkRm5tHLO4GE6Kg@mail.gmail.com>
In-Reply-To: <CAEUhbmVdv_7onVjDes6_Tw0h2F4FqVnuiofFkRm5tHLO4GE6Kg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 9 Oct 2020 15:09:58 -0700
Message-ID: <CAKmqyKPzzpCNXfU9Q4HRpZc694vHP2Ayy4Otx4VD0sTYFWKVkA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] hw/riscv: Return the end address of the loaded
 firmware
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 9, 2020 at 3:14 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Fri, Oct 2, 2020 at 11:42 PM Alistair Francis
> <alistair.francis@wdc.com> wrote:
>
> It merits some commit message to explain why the return value of
> riscv_load_firmware() was changed from firmware entry address to
> firmware end address.

Done.

Alistair

>
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  include/hw/riscv/boot.h |  8 ++++----
> >  hw/riscv/boot.c         | 28 +++++++++++++++++-----------
> >  2 files changed, 21 insertions(+), 15 deletions(-)
> >
>
> Regards,
> Bin

