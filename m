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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F2BC43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E18222C4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kjx64Qu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E18222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKZ2-0005bP-QH
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 22:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUKYC-0004vJ-QR; Sun, 18 Oct 2020 22:05:28 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:35897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUKYA-0002rR-Vv; Sun, 18 Oct 2020 22:05:28 -0400
Received: by mail-yb1-xb43.google.com with SMTP id f140so7542307ybg.3;
 Sun, 18 Oct 2020 19:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=23Cikbh05ukXkcHCv9z0Pt7LyTI4adA1SHYWMMMzxZI=;
 b=Kjx64Qu2H6zPmdz2XOuf6SKzTotcTH6thnJe/q5+iX7JBXMx7O7h1Ecj1Jz9cRfB+H
 5AX43YVGxdQwWSlLhYQjTqtaTh/qoCFrFNiwgPvouGifhwPAfGZOTE2nKY6kwL6XKXuD
 92098R9q+ks51yTuZcNv5gUZNqRknHJd9qzga3tD0KlIEe1+Mwx7Ll0hwm17qWf+eDTm
 bqRSbBa2YTEbGC5syWwOdKsS46GRid8SLIAAyWXKcIMyFMry4KSOrzXLntiJng5hjNbq
 cgyC5PVaoqAaKjDWewSgKOl0xkpVJrW85vA4s4HHn233Qf7IRFwsuNEflBIghlNSfRY7
 iN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=23Cikbh05ukXkcHCv9z0Pt7LyTI4adA1SHYWMMMzxZI=;
 b=qb8sir3xzb7/LNoQw4P/WMkwj/Be3mkkATuS8TPphg7MQ0KCVvc/LYZZMZf4pgOtg7
 Mrg/whU7ADtbsZhsGyb5Oze2Tz+qLIkMfYgkZFUomo1OTR0u0Xv9o0MLnwp9oYdX0GHH
 xmtZGj7m+0nzWuvVpGYozDohRM94r697wwjsvsLZc00HZ0R/OBDNIj2mnx1oP4gJotFq
 0Qrt9jeh08oXvpWEdm2VsHevungtnbtzaFqbgIBqDOukkQHBNwXOr1wSzVdMvQ318rfZ
 tLctMLZbPTFqySTMzTeYDB/yD7r2uDFsdFZzm41R3MxIcm3bOMO0+2OUxOVUeg/eNAD/
 DkXw==
X-Gm-Message-State: AOAM530poyoqfRi0IwSK0vmGxRoMh5v+PLo6RtipnrVgQKzNGkDlmPgZ
 MhVkXQzaZieYCnk9HVh9czAE70T0YkddqFW3Evs=
X-Google-Smtp-Source: ABdhPJzuP0crXM5Dtk7hdVDjD/YG4wC5QjvnoHN7tr8aRMrV2IsFbtvspfe/84I5TICv3PGocGqEJjjqUqkPv6gjtcw=
X-Received: by 2002:a25:705:: with SMTP id 5mr18975685ybh.239.1603073123878;
 Sun, 18 Oct 2020 19:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201016123737.8118-1-ivan.griffin@emdalo.com>
 <CAKmqyKNykruYK2AQ05KZyGCGD0rUsqQOVBbnccY+ELATBF=Ozg@mail.gmail.com>
 <DB7PR10MB191544AA04D0B3ECF82C57CDFE030@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB7PR10MB191544AA04D0B3ECF82C57CDFE030@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 19 Oct 2020 10:05:12 +0800
Message-ID: <CAEUhbmVPzOuP3kuMhZB2JgN47nnzL7p9+meyhyBK7kRAhu5BCw@mail.gmail.com>
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
 Alistair Francis <alistair23@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Ivan,

On Sat, Oct 17, 2020 at 12:31 AM Ivan Griffin <ivan.griffin@emdalo.com> wro=
te:
>
> I don't know why it isn't documented in that PDF (or in the register map)=
, but if you check https://github.com/polarfire-soc/polarfire-soc-bare-meta=
l-library/blob/master/src/platform/drivers/mss_sys_services/mss_sys_service=
s.h you'll see the following
>
> ```
> typedef struct
> {
>     volatile uint32_t SOFT_RESET;
>     volatile uint32_t VDETECTOR;
>     volatile uint32_t TVS_CONTROL;
>     volatile uint32_t TVS_TEMP_A;
>     volatile uint32_t TVS_TEMP_B;
>     volatile uint32_t TVS_TEMP_C;
>     volatile uint32_t TVS_VOLT_A;
>     volatile uint32_t TVS_VOLT_B;
>     volatile uint32_t TVS_VOLT_C;
>     volatile uint32_t TVS_OUTPUT0;
>     volatile uint32_t TVS_OUTPUT1;
>     volatile uint32_t TVS_TRIGGER;
>     volatile uint32_t TRIM_VDET1P05;
>     volatile uint32_t TRIM_VDET1P8;
>     volatile uint32_t TRIM_VDET2P5;
>     volatile uint32_t TRIM_TVS;
>     volatile uint32_t TRIM_GDET1P05;
>     volatile uint32_t RESERVED0;
>     volatile uint32_t RESERVED1;
>     volatile uint32_t RESERVED2;
>     volatile uint32_t SERVICES_CR;
>     volatile uint32_t SERVICES_SR;
>     volatile uint32_t USER_DETECTOR_SR;
>     volatile uint32_t USER_DETECTOR_CR;
>     volatile uint32_t MSS_SPI_CR;
>
> } SCBCTRL_TypeDef;
>
> #define MSS_SCBCTRL                    ((SCBCTRL_TypeDef*) (0x37020000UL)=
)
>
> /*2kB bytes long mailbox.*/
> #define MSS_SCBMAILBOX                 ((uint32_t*) (0x37020800UL))
> ```
>
> And in https://github.com/polarfire-soc/polarfire-soc-bare-metal-library/=
blob/master/src/platform/drivers/mss_sys_services/mss_sys_services.c you'll=
 see MSS_SCB and MSS_SCBMAILBOX used in many places to interact with the FP=
GA system controller to perform various services.

It's actually documented, but not in the PDF file. I also spent some
time locating the doc when I do the DDR controller modeling work.

See Register Map/PF_SoC_RegMap_V1_1/MPFS250T/pfsoc_control_scb.htm in
https://www.microsemi.com/document-portal/doc_download/1244581-polarfire-so=
c-register-map

Regards,
Bin

