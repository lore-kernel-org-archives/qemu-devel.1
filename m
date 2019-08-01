Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A6C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F34206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBw7uFVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F34206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htCa6-0006KQ-W1
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60624)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1htCWr-0005Pl-TI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1htCWq-0004Zi-TA
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:58:05 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1htCWq-0004Wd-NR; Thu, 01 Aug 2019 10:58:04 -0400
Received: by mail-ed1-x541.google.com with SMTP id w13so69506975eds.4;
 Thu, 01 Aug 2019 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t+5VxFNDxAoeMM6TcmSoJp4VphqXgcASmhy++210tFM=;
 b=tBw7uFVIxlKFQLAgt42qNNVYyAGf/dNT1qr0GCILp5ZUYEbY14k6pFUnC1k5i4lnCC
 gQpZTDARA1McFSTGorCqXNIRmIVKQrWSkJz2C+DHF7wuetLCfKmaSrjrs/srda/6jZ5V
 vmKexsM3dKbT0pp2RSakt20lQl3RBzIAWmNv06XnY/B6kx/MIomUreETUZmlugVOgBVv
 QPAnyy021tJo2bYdd9JjHDSIhva2q+63OrXqRavXNWlNu9w5U75o8nQWNQIpM5plBIhP
 65bXeOyN+0Tg2GqEfVu8+ZHxR2Yt0RuF/C4jH4otUooqV8/iO2sFC1eISQLOyhvAp4MN
 soWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t+5VxFNDxAoeMM6TcmSoJp4VphqXgcASmhy++210tFM=;
 b=Nhlx/tIKHzxKV3CvpCNyHRG7tJ57EuxDDix9ooT6qfCoZE0OBXIFpTzZ+asnRP7gUk
 C285sAvCbWB+7QV2xbQJPZp71loII50B/A4O1mIr0/atsETJHSIfAClq93oHAclQrKXY
 VrDMprZDm2hE0xw68Dfdg5JTXv47GHt6FSC3JftX2fZNjYPCFw9eUro9kGyYQZxFKJeu
 Hy6gAy4x2bBucu0/xlS1SlKgDTfk55rdaNpf7ruf14xVTHouDJBZ5Jr5rygTwgL1U35q
 XHazGUWOSF2MfpO4J42FyrC9es/Y3EYc6eUqq/FnVlLAdg6yr5YnSQ7jaAiiheqM/FOO
 EopQ==
X-Gm-Message-State: APjAAAUc9lWJ7F2OYvDI2ldMPvkx//zrGw+VE6PitptoJKsC+Va14tdr
 ZBhRV52fq2DnlOUSTI9NSIvjJ64hgibDBjdRpXw=
X-Google-Smtp-Source: APXvYqz8uXBCThljYAbr7mltM25xP6DHf60CWgYMptOEb5L2UDGnIyZN4cYDpDL7Iu8T3lt3ytScEBbG2U23QrYmNHQ=
X-Received: by 2002:a17:906:340e:: with SMTP id
 c14mr102538823ejb.170.1564671483146; 
 Thu, 01 Aug 2019 07:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <1564577101-29020-1-git-send-email-bmeng.cn@gmail.com>
 <581a0284-c658-265f-1b0f-6f4be5406cee@linaro.org>
 <CAEUhbmVXC6GeHYFST514cLRJHQOo5ki=ZPG=OsLzV2YA0ChQgA@mail.gmail.com>
 <ac4453de-81cd-c32a-17f8-283fa3569ed0@linaro.org>
In-Reply-To: <ac4453de-81cd-c32a-17f8-283fa3569ed0@linaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 1 Aug 2019 22:57:52 +0800
Message-ID: <CAEUhbmX2C_FbW_m=Mri19hpz0c74SQTt3ogsatGgveH09t3_4g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] riscv: rv32: Root page table address can
 be larger than 32-bit
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
Cc: QEMU riscv <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>, QEMU devel <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 1, 2019 at 10:16 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/31/19 6:53 PM, Bin Meng wrote:
> > I am not sure how (idx * ptesize) could overflow. It represents the
> > offset by a page table which is [0, 4096).
>
> You're right, I mis-read what was going on there.
>
> However, lower down, "target_ulong ppn" needs to be promoted to hwaddr, so that
>
>     ppn = pte >> PTE_PPN_SHIFT;
>     ...
>     base = ppn << PGSHIFT;
>
> does not overflow.  (Which is the part of the page table walk that I thought I
> had gleaned from the patch without actually reading the entire function.)

Ah, yes. ppn should be promoted. Thanks for the review!

Regards,
Bin

