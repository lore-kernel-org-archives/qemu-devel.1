Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9CEC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2951A20874
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7NnVUbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2951A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCvfM-0001BS-Ae
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 21:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iCveR-0000l0-06
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iCveP-0001f8-U0
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:59:26 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iCveN-0001dw-Cv; Tue, 24 Sep 2019 20:59:23 -0400
Received: by mail-lj1-x244.google.com with SMTP id b20so3788011ljj.5;
 Tue, 24 Sep 2019 17:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jb2Lqjsxv6Gso+EKst3C5mPas0pf5Rwsyo0+phyvWq4=;
 b=O7NnVUbnXL12A2R5IhEYqcvn7EQgAhywzSm+Jo34uP9e/O3mz8d7Xdf0WCw93By9kT
 WSZqeKWEwHY3YGhRXET4e3XuuRVy6R/u23InU8+fw1DTVSCRC7SQXe9EcgAwwIshyBXD
 +lZK8QtNV1Q6EBsUBnCzRxE9+ZnPK45jafZ5n2jtoQe/WLOVW/p4WbgIZWEF2m+99CyF
 MCUI6SDGkfp1NjbbWZelDnLHRY4pzpwCiki55AcRnumz99jr70gM94E9eM8xgmeXXZcf
 D2SbAv5v6Sa1cAYkzqHIwVGOQxdCZ3FqwqpZ/qAwoBFqaLk6137IxAK/qSaf6EEt1LX3
 Jh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jb2Lqjsxv6Gso+EKst3C5mPas0pf5Rwsyo0+phyvWq4=;
 b=Sy8dai4rZiZhukP09R0ZqGwdLqbtvQGE8RtMd8SzcrIEnPfC/6I11ijm+a39vR69FZ
 nOwGxREh4fdlSw5s6UQJRYU8v27v3W1jqYOywLb8kGdVuTsyS3BgIzLsOTj6/3boy/Vy
 /cB+hBQi62bwuDByJbibcY1ahpnisTKwlrUnsfjNiLJub7bBm/2zX1Fvqb8LDrlZhcIX
 XPW7oNbfbE1T/Pq7+kjibY9AOcP0Dafoh78Bq6729h6YiZsDrEIVvoQwZw4kxdYbNPgb
 cL/cVtzcPBNN8Zbg9XVTg5ZnQVQOXRluFMldQeuOC3Q3nHU3eIO0dmiHJ8/Vu+JoR2z4
 p3eQ==
X-Gm-Message-State: APjAAAVINVCsAXLPwRJlsArkrJOtPiLQPY9naSP8IJL7RO7ZUxqUh8Sz
 o2uk9c0Yt54UttwVd0luCLJIrj3E9l3pV7ZSoDo=
X-Google-Smtp-Source: APXvYqxMf/VIzWRKWIZBUjpPWFwNt/wsHQU7KtsSB95xSMuSWVMX2vJerZYtYnZbFxBLnQ3Ur3AEd6Kgijkc60iY5vs=
X-Received: by 2002:a2e:90d9:: with SMTP id o25mr3731285ljg.94.1569373161940; 
 Tue, 24 Sep 2019 17:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
 <CAEUhbmVvDKQqQYE-riq=cvSrCe_NMoW_KDsLjh8CVHRUhJvk9A@mail.gmail.com>
 <CAKmqyKOofA3U+8kjMkzQ0sNd1=uwJHq3c9eaLZdoNCb7=e-PAw@mail.gmail.com>
 <CAFEAcA-uFPGf4BiDXH=Om3Df-xXrt7QwjzVF7E3kY4aMWMP4YQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-uFPGf4BiDXH=Om3Df-xXrt7QwjzVF7E3kY4aMWMP4YQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 24 Sep 2019 17:54:39 -0700
Message-ID: <CAKmqyKP3T79qVUXftO=0hmhYbD9MKccdvsAcs=_4CQFoNmfucw@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] riscv/virt: Add the PFlash CFI01 device
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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

On Mon, Sep 23, 2019 at 2:46 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 20 Sep 2019 at 23:23, Alistair Francis <alistair23@gmail.com> wrote:
> > On Thu, Sep 19, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > I don't think we should mirror what is used on ARM virt board to
> > > create 2 flash for sifive_u. For ARM virt, there are 2 flashes because
> > > they need distinguish secure and non-secure. For sifive_u, only one is
> > > enough.
> >
> > I went back and forward about 1 or 2. Two seems more usable as maybe
> > someone wants to include two pflash files? The Xilinx machine also has
> > two so I'm kind of used to 2, but I'm not really fussed.
>
> One of the reasons for having 2 on the Arm board (we do this
> even if we're not supporting secure vs non-secure) is that
> then you can use one for a fixed read-only BIOS image (backed
> by a file on the host filesystem shared between all VMs), and
> one backed by a read-write per-VM file providing permanent
> storage for BIOS environment variables. Notably UEFI likes to
> work this way, but the idea applies in theory to other
> boot loader or BIOSes I guess.

This seems like a good reason to have two and there isn't really a
disadvantage so I have kept it with two.

>
> I would suggest also checking with Markus that your code
> for instantiating the flash devices follows the current
> recommendations so the backing storage can be configured
> via -blockdev. (This is a fairly recent change from June or
> so; current-in-master virt and sbsa boards provide an example
> of doing the right thing, I think.)

I have updated the code to more closely match the ARM virt machine, so
I think I'm doing it correctly.

Alistair

>
> thanks
> -- PMM

