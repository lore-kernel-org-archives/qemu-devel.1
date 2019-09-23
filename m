Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C73C432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 22:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E34E206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 22:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgJuH4J4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E34E206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCWkU-0006CZ-DR
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 18:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCWjJ-0005iE-8N
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 18:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCWjH-0003oT-UU
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 18:22:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38793)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCWAA-0001ZY-EN
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 17:46:31 -0400
Received: by mail-ot1-x341.google.com with SMTP id e11so13539649otl.5
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1lwzpWN8tjukbbISDvbnJRJp7+j23v5G7tQvo2iviAw=;
 b=NgJuH4J4A33lyPD33YF15BNN5RpNHLbOuf5gm0qILbL/ica6Cuc9Zmb5BoeJC/Pp6M
 6eBAoOjf3wfumYLUsh4z4j3BGRNFyNGfwhsNopx8kE2yp8jIIumstlLJbrvhXBmOxqtc
 Ca7X5qxIHVtmUDwcJ3sfOVl/8fkjqa4TS0xNkgiuVI9tNeLGKrStTt6FOtiQFN4qTdBs
 dxklM/lynYEnNOJ+fUWdtxcCaPplYEfCRmw7Qj0c69MdtYhtXIO5cokxOxbD91dCTydE
 xB7iWiKfPU5y3D7ebnLAiHEFm6bkrG9Frp7P42C4CchQ4VYDheJ1acT6JGUkeTWHLkT8
 9THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1lwzpWN8tjukbbISDvbnJRJp7+j23v5G7tQvo2iviAw=;
 b=aa0BDMuzcHCb8r/czrXfVGrWfw+rVLlMkw7fsaqBosF2RvBCmQ7wZtdD1beL/JgW5C
 A0i2G47KkLnN6wZa7iGBdeKp5+izXMyzil75bbF6RYuPmNMfiYyDpe7aZw/yRGpnKT7d
 Bd9HqrStuXNxx2/DQ1FaSR1YMtF99wxM4++oXmh01trvZgovosRypi+27ZIbh0PkvK7e
 9/+OwLQeHAbk/mM7EKzYmD/MnxLJ8OFgNtRu7yQdVro13VLNGm2RNv5N7yq7WFYM1g4H
 luoCd+GjpHtCLrm/sFZZF2UGXvG4ede3WI3cPcJHwsvB2Jw7LKONZKsBQqT4kt7d4sAl
 nC/Q==
X-Gm-Message-State: APjAAAUccSEV5ySAltekhMcyu7WkaC7wyPJKY+nPkhjCSnw3iX7GN6Ex
 9egIQWqKiHmWpuZJ4a0tI6c7BmcNCcQ2yyF65QTN3g==
X-Google-Smtp-Source: APXvYqzlviW3HUvhH+fobID+Iesir2GZbVjn9P0OyQFYL8SkBo09OrV9KfQruiYNxghNEMxTA6uf1Kx1Rls0R+BwCc4=
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr304805otp.221.1569275188921; 
 Mon, 23 Sep 2019 14:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
 <CAEUhbmVvDKQqQYE-riq=cvSrCe_NMoW_KDsLjh8CVHRUhJvk9A@mail.gmail.com>
 <CAKmqyKOofA3U+8kjMkzQ0sNd1=uwJHq3c9eaLZdoNCb7=e-PAw@mail.gmail.com>
In-Reply-To: <CAKmqyKOofA3U+8kjMkzQ0sNd1=uwJHq3c9eaLZdoNCb7=e-PAw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 22:46:17 +0100
Message-ID: <CAFEAcA-uFPGf4BiDXH=Om3Df-xXrt7QwjzVF7E3kY4aMWMP4YQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] riscv/virt: Add the PFlash CFI01 device
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 23:23, Alistair Francis <alistair23@gmail.com> wrote:
> On Thu, Sep 19, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > I don't think we should mirror what is used on ARM virt board to
> > create 2 flash for sifive_u. For ARM virt, there are 2 flashes because
> > they need distinguish secure and non-secure. For sifive_u, only one is
> > enough.
>
> I went back and forward about 1 or 2. Two seems more usable as maybe
> someone wants to include two pflash files? The Xilinx machine also has
> two so I'm kind of used to 2, but I'm not really fussed.

One of the reasons for having 2 on the Arm board (we do this
even if we're not supporting secure vs non-secure) is that
then you can use one for a fixed read-only BIOS image (backed
by a file on the host filesystem shared between all VMs), and
one backed by a read-write per-VM file providing permanent
storage for BIOS environment variables. Notably UEFI likes to
work this way, but the idea applies in theory to other
boot loader or BIOSes I guess.

I would suggest also checking with Markus that your code
for instantiating the flash devices follows the current
recommendations so the backing storage can be configured
via -blockdev. (This is a fairly recent change from June or
so; current-in-master virt and sbsa boards provide an example
of doing the right thing, I think.)

thanks
-- PMM

