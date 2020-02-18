Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0AFC34033
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D48621D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9siwg1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D48621D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zlU-00065h-Pn
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3zkh-0004sK-HZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3zkg-0000ZX-Ct
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:05:15 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46317)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3zkg-0000YA-6M
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:05:14 -0500
Received: by mail-ot1-x341.google.com with SMTP id g64so18936393otb.13
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 02:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vMxX+nDorhKqu10/D7ZYUU5lAla6+z9TBRxzHMwoESE=;
 b=m9siwg1xRQPyQvh9D43Lgx3k9iJHpXfaViyYzH27RFStlHOKlFbJmG4N4s5TmdgI6A
 cb8kkvnStmoFoPXyYndIPQF/Ib3BmEkXIKJ7uxOA/iBk1NsMePUkF3al9+l6FoKOCCvq
 SLWE8jOOk8UUYPUk5/SXNIBU9jOps4yEfuBqFD5OrCAl2wrY1CH+D5C/qjgixHF1zXyp
 3Fph159DaSDVDWjO0f6ZsMeUBM+OY50L2jNIcKY1tIw0cq8oxuVtnJ4//iqP/L6HSMgC
 6DOjg7Os0o2f08UG6JceEEZdETWj+tcMhzg1Xr5rVQH6ZsUnlvuaGYdcVwkHwhB+Zp1A
 a1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vMxX+nDorhKqu10/D7ZYUU5lAla6+z9TBRxzHMwoESE=;
 b=t9h1HS9ToYkhU0uQPEzmfpn9hU1P2o3ypXk80kKhgQRi8NE+RDcvuhGxZCERe1Kk0j
 iHeYqecswNaY+EFi1urWzDm0BN1F1b/oXp9qSk825CXZtjNC8gaihdIhD6rbZJn1RN56
 i3rYbe5rAj+7zHVtjx9mIpk5g5MisC/UaN0TAWMWK0ifm/6uxZffC1MXGvjNB7M5S3yl
 4UC4NizOAE9m4jkooYlOF2QVG7ey/JtHHJM8594Rzmklpk0O3lBZiLYMRrqt9Tp7q1Tu
 jNV77+rh5G0Vwzaptb2PVvjfAix+PK6vlJlgTIVWgN4hO0S3vSmNRr1GIfiKd69MzAEz
 8n2A==
X-Gm-Message-State: APjAAAURqOfvcWMAqCOLvaEgF4vT4Z5XlhStzqOr2cQgksP5XuDd6e8a
 Wa8xlDd5pAkNPty4xIyuhqCd66xZBbMrorq2xNs2Zg==
X-Google-Smtp-Source: APXvYqxj/zkU5gCFJstOibaBQqHoBML3D4jF5nT0TTyiwfdmvMcmlT4D8O0KJBhtIomLHeUv2NESIGt2N8wIOkPkZr8=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr15411534ota.232.1582020312884; 
 Tue, 18 Feb 2020 02:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <CAPan3WpV2m9HXLXZDopKUb2EfX2KE9y530m2pJG4-D96==ggCg@mail.gmail.com>
 <ee95179f-c15f-9615-e241-80199e6948b7@redhat.com>
 <CAPan3WpG0yPu5sbS=mpHk=xNVGaqwWFrBcDBcovLLRit==5dwg@mail.gmail.com>
 <3aa04b23-80a8-21d1-7481-d52b6d8f88c1@redhat.com>
In-Reply-To: <3aa04b23-80a8-21d1-7481-d52b6d8f88c1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 10:05:01 +0000
Message-ID: <CAFEAcA-kNNWgLc8NxWgVJQk29BVr28j-A_d4M+8=7nfpTzhzcQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] Add Allwinner H3 SoC and Orange Pi PC Machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 06:46, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> IIRC from the specs, cards are block devices and the only alignment
> required is the size of a block (512KiB for your 4GiB card).

Isn't there something related to erase blocks too, which impose
a larger granularity than just a single block?

Anyway, in general the backing image for an SD card device
needs to be exactly the size of the SD card you're emulating,
because QEMU needs somewhere it can write back the data
if the guest decides to write to the last block on the card.
So short-length images generally don't work (true for all
block devices, not just SD cards, I think). This often bites users
if they're using some distro "here's a disk/sd card image file"
where the expected use with real hardware is "dd the image
file onto the SD card".

thanks
-- PMM

