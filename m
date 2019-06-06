Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D351C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41A920872
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAB7qUSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41A920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54066 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYxpY-0006sc-4S
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 15:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hYxlC-0004Qx-JD
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 15:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hYxOw-0004mK-N6
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:46:15 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hYxOv-0004Xf-Aj; Thu, 06 Jun 2019 14:46:13 -0400
Received: by mail-lj1-x243.google.com with SMTP id h11so3043269ljb.2;
 Thu, 06 Jun 2019 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Bhga0YIOBroMMDM2FCjwRLT+/LALmkhEyJF3XLvlVZI=;
 b=QAB7qUStfUGTNDJcRITAzVovVVgHT3ROcGg6dD3xG8pWoinzmx5kwipNNobbCEoGFd
 Sg700a/L19QzP8oMRpQwgZosQGYnnT5tdk2IFh5yo6vBdrPYkdn6O9/V981L0QlnKY9H
 hLQFZLTFFzhW5izxQO3JGEgL3Sp97rLBafB/Au6MokCpZlV1aoR0sIxuiPbJyHMMg2SS
 e6HeC3qoG8XXuCf0HgWMC5DKft8XYbteCQnycCY5MzqLWyyOzC42jD1e/ZAHlYu3JEO5
 Q5SAYeni9M5LybXa+p4SKmebpjaMS6VcWDXj72YtMYrG9BibKZbGappcEx9wIsd/xFgY
 XsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bhga0YIOBroMMDM2FCjwRLT+/LALmkhEyJF3XLvlVZI=;
 b=lyHUlN9F0uoX9K24SDAgBBTglsR4sYKN03GNxWifIj+uR8N5OkIBa/0U8nBP+zvNlz
 O3CdNFlNn15N6p5zsJp8XpN1Cz3euqP1rKUiL/3hI0gDa1jlQYapFHHaz3gNs5xqodPD
 g8iTlRTKWWIoyAphDqy7opMk0tWK4KF2OJeC4XD+RdhgqH+oJUYyJWshqeYnZDoub7Vn
 jXbibwnRV/AFe5N+K1yU8NqtBpsRBX9X7IqWKxbWtMaNmJok9vjZkyItrNu2vUPTAI2Z
 X1XAv8EhhHN9gTsaqcSEvbmW4VYq2+74w7ZeyUV/jw/dKCERj7nvYO/cmQiEkKcudo14
 20Ew==
X-Gm-Message-State: APjAAAXbYGKsc43sEcoV41dFrFZ+ZlsUXO5q/8tUNaaHhl+3bw3WhtYS
 QETb5KhE4QlqUTpcv6xNf8dBTDSeApmgkZ3+MY4=
X-Google-Smtp-Source: APXvYqwFWG4JjF8LIj9f9+z2Mr8jvQYD8U49gb+ZGBh3uL6MdBRJqkXJ1Mw5e20P01067vJJq2xIjeNCHsRCUnrT0QE=
X-Received: by 2002:a2e:6313:: with SMTP id x19mr16503011ljb.25.1559846771796; 
 Thu, 06 Jun 2019 11:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <1559119921-6098-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKNAL8KtVgfCx6yhaNYEL=_wnZ5Vf1eSjxwtg0x6_q+UHw@mail.gmail.com>
 <CAEUhbmXLr3zXhbphXRvqfyW1FH9qo3yoPwnFoRoYNtbwkrBBKw@mail.gmail.com>
 <CAEUhbmUAKoFPqBLVW4FHmiESaF8fqEtjqDb1LKf4ivG3g2z0ZQ@mail.gmail.com>
In-Reply-To: <CAEUhbmUAKoFPqBLVW4FHmiESaF8fqEtjqDb1LKf4ivG3g2z0ZQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Jun 2019 11:43:36 -0700
Message-ID: <CAKmqyKPO8CERWMZQEfEM1Q7HBTysB8cG5LsR1wdc334YX5tmgg@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] riscv: virt: Correct pci "bus-range"
 encoding
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 6, 2019 at 5:55 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Thu, May 30, 2019 at 11:36 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Alistair,
> >
> > On Thu, May 30, 2019 at 11:14 AM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Wed, May 29, 2019 at 1:52 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > The largest pci bus number should be calculated from ECAM size,
> > > > instead of its base address.
> > > >
> > > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > >
> > > This seems ok, can you maybe explain what this fixes?
> > >
> >
> > The logic is wrong, as the commit message said. With current wrong
> > logic, the largest pci bus number encoded in "bus-ranges" property was
> > wrongly set to 0x2ff in this case. Per pci spec, the bus number should
> > not exceed 0xff.
> >
>
> Ping?

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

