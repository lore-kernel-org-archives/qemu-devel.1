Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B4DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6975622257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0/MDH4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6975622257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQhr-0007d6-8c
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUQgc-0006v0-B4; Mon, 19 Oct 2020 04:38:34 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:45096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUQgX-0007X5-8D; Mon, 19 Oct 2020 04:38:33 -0400
Received: by mail-yb1-xb43.google.com with SMTP id s89so8167298ybi.12;
 Mon, 19 Oct 2020 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=11kgloHNKw0f43ksa2bcRPfyCXY5kNefnKHxfj98KBg=;
 b=D0/MDH4HkURe0gvLFh/3r9UxvQTqcxKfMPE13/hmpQz3mlCOE7ZHmNXMUj0yFEIwod
 kJQqc7TPkRAdBhQnBeaW/xJe7nR2K4GjtXJvOSQV3v7L2/Ci2Bv7YYQbI+otLPzewczy
 JTO0QiZbBp3F/4DuRNfWQonGnS+qq0AbQcin2hUpJBxo5CA2xfeu4yqIEHPJl6Ma8tGv
 gDKSA38PYi1pvg7rlIEnvt/r76ntxIyFbDuWwXg1xa82Hx/P3tCIOmDWx4oRhKfKJ5aW
 /EeOAThz5ShHC+RCx36mBlhops9hDZzuN5g2aY6tv1QJw/nCRnmDljR/3j6Wds98i2EV
 fbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=11kgloHNKw0f43ksa2bcRPfyCXY5kNefnKHxfj98KBg=;
 b=NqQ8ZgkY7gLfaXJa8YitmqpISJiKMEy/W0SD8WPVUJZK5pgNZfybfV6eZ9xlUXcZYS
 ZhFIeWlIHLWfP2yty57E5pUB7tZiaG5qM7HYYsk9zJs+QLRvHPCfuV4Vxh1glzG0WN9N
 FRkc/iXJoblc0gKSg88vIqXvxSLI3f0Or7BZERSiVpEWA8NYdu88oBxgkT12Z05Zd/Gc
 JvaSAlTN4WVDeTarnUkSE4aXpk4y/gop4K2ez71Sq7DE4T5opcgEMqTN7ICQX1v0EnhZ
 e6vp9jn+kwNLCQky1lk6yi077LQJI+kpmvd5DAjtl2F7lVwqf0PEwEtnRO09v2iYFesG
 fB2w==
X-Gm-Message-State: AOAM530KLcdDV7iVmr+fIzUlgx3fVssrtIY7kZDBaZMb4Bz6w+ZsRfDB
 LIqubKr7LT2HzCZKwiHgSvgu6PmLPPg7b0eIuNQ=
X-Google-Smtp-Source: ABdhPJx6NsN0CbMLHOEo81QAdIjwCbTSAQOHJtrg4KRDbJMX2SU8TfmblgOS6mgj7h9F75b/4rVxzfGwjD2Z/aVLzhY=
X-Received: by 2002:a25:386:: with SMTP id 128mr9488230ybd.122.1603096704843; 
 Mon, 19 Oct 2020 01:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201016123737.8118-1-ivan.griffin@emdalo.com>
 <CAKmqyKNykruYK2AQ05KZyGCGD0rUsqQOVBbnccY+ELATBF=Ozg@mail.gmail.com>
 <DB7PR10MB191544AA04D0B3ECF82C57CDFE030@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
 <CAEUhbmVPzOuP3kuMhZB2JgN47nnzL7p9+meyhyBK7kRAhu5BCw@mail.gmail.com>
 <DB7PR10MB1915CB83F5FD388871B4D841FE1E0@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB7PR10MB1915CB83F5FD388871B4D841FE1E0@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 19 Oct 2020 16:38:13 +0800
Message-ID: <CAEUhbmXmmtpZx9WUFBLgdDMm31QVc+vUFNmizfph8DEiu9Cjuw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
To: Ivan Griffin <ivan.griffin@emdalo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Ivan,

On Mon, Oct 19, 2020 at 4:17 PM Ivan Griffin <ivan.griffin@emdalo.com> wrot=
e:
>
> Hi Bin,
>
> Well spotted with the register map. I grepped it for 0x37020000 and didn'=
t find it, but it seems the address (incorrectly) is 0x07020000 in the docu=
mentation.
>

I believe the documented offset 0x07020000 is the offset into the
IOSCB block, not the final one that is mapped into the system memory.

Regards,
Bin

> ________________________________
> From: Bin Meng <bmeng.cn@gmail.com>
> Sent: Monday 19 October 2020 03:05
> To: Ivan Griffin <ivan.griffin@emdalo.com>
> Cc: Alistair Francis <alistair23@gmail.com>; QEMU Trivial <qemu-trivial@n=
ongnu.org>; Bin Meng <bin.meng@windriver.com>; open list:RISC-V <qemu-riscv=
@nongnu.org>; qemu-devel@nongnu.org Developers <qemu-devel@nongnu.org>
> Subject: Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
>
> Hi Ivan,
>
> On Sat, Oct 17, 2020 at 12:31 AM Ivan Griffin <ivan.griffin@emdalo.com> w=
rote:
> >
> > I don't know why it isn't documented in that PDF (or in the register ma=
p), but if you check https://github.com/polarfire-soc/polarfire-soc-bare-me=
tal-library/blob/master/src/platform/drivers/mss_sys_services/mss_sys_servi=
ces.h you'll see the following
> >
> > ```
> > typedef struct
> > {
> >     volatile uint32_t SOFT_RESET;
> >     volatile uint32_t VDETECTOR;
> >     volatile uint32_t TVS_CONTROL;
> >     volatile uint32_t TVS_TEMP_A;
> >     volatile uint32_t TVS_TEMP_B;
> >     volatile uint32_t TVS_TEMP_C;
> >     volatile uint32_t TVS_VOLT_A;
> >     volatile uint32_t TVS_VOLT_B;
> >     volatile uint32_t TVS_VOLT_C;
> >     volatile uint32_t TVS_OUTPUT0;
> >     volatile uint32_t TVS_OUTPUT1;
> >     volatile uint32_t TVS_TRIGGER;
> >     volatile uint32_t TRIM_VDET1P05;
> >     volatile uint32_t TRIM_VDET1P8;
> >     volatile uint32_t TRIM_VDET2P5;
> >     volatile uint32_t TRIM_TVS;
> >     volatile uint32_t TRIM_GDET1P05;
> >     volatile uint32_t RESERVED0;
> >     volatile uint32_t RESERVED1;
> >     volatile uint32_t RESERVED2;
> >     volatile uint32_t SERVICES_CR;
> >     volatile uint32_t SERVICES_SR;
> >     volatile uint32_t USER_DETECTOR_SR;
> >     volatile uint32_t USER_DETECTOR_CR;
> >     volatile uint32_t MSS_SPI_CR;
> >
> > } SCBCTRL_TypeDef;
> >
> > #define MSS_SCBCTRL                    ((SCBCTRL_TypeDef*) (0x37020000U=
L))
> >
> > /*2kB bytes long mailbox.*/
> > #define MSS_SCBMAILBOX                 ((uint32_t*) (0x37020800UL))
> > ```
> >
> > And in https://github.com/polarfire-soc/polarfire-soc-bare-metal-librar=
y/blob/master/src/platform/drivers/mss_sys_services/mss_sys_services.c you'=
ll see MSS_SCB and MSS_SCBMAILBOX used in many places to interact with the =
FPGA system controller to perform various services.
>
> It's actually documented, but not in the PDF file. I also spent some
> time locating the doc when I do the DDR controller modeling work.
>
> See Register Map/PF_SoC_RegMap_V1_1/MPFS250T/pfsoc_control_scb.htm in
> https://www.microsemi.com/document-portal/doc_download/1244581-polarfire-=
soc-register-map

