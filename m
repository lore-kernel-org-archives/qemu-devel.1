Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86D2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 03:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A058E207D4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 03:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPrLvpHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A058E207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqq8p-0002XU-Tc
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 23:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqq7n-0001YX-Uv; Wed, 01 Jul 2020 23:42:59 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:44805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqq7m-0007aZ-Fz; Wed, 01 Jul 2020 23:42:59 -0400
Received: by mail-io1-xd41.google.com with SMTP id i4so27351782iov.11;
 Wed, 01 Jul 2020 20:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fjPiYAl6iZNctEarQe1aKyfmzpozE2QgZiRT6+efCNE=;
 b=KPrLvpHtXH80sPKu6uqrQk1p21IE9a/zsB2pWkR1tFAHvimw077JCaC2kTn63RuBJj
 RCMovt6Juhuoh1rJCtsE10Glf+xZl9SBlVXQEpYoXt+Ta6U2loFFyZ9N/K4jxpGvB/KG
 BjhtphVRcaTwKWwKMlweGDKzQ80BZ9mrIK4Mef16iZlK5o+tYsrXbU823457mDGRMLkh
 l7b+ui6tq6F4j1A6xTsUJT+sxgC2XkmHX8pXUZOhshnBsehRvvZie/FfSfl5gdbhKb1e
 /IRv2K9q6sdoD58mLEh87FpfKy6jmqJJ2iNJqfNItCOhjsU0I6cfD2op9JLfksD2d8wV
 f7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fjPiYAl6iZNctEarQe1aKyfmzpozE2QgZiRT6+efCNE=;
 b=YLdHgbPcYNUxAf4yXG536lGkSabZ5iESgByHA01pg4TWlCHHETqZ9LEd2s2eZPPOb+
 duqaVfSnyMlMdDjJj9fU1RL0EHzecYMFFcwIlLpd3fpQiaBHCsuwTXUuf/1CUEaZURuY
 g/ygNHuI2N3H4c/jgVm75U6CBCbO6hyqIhKSQ+VrCF3Hvl480icS9dzZB6rLin4IEWke
 1qscPjGTs6VjPC5WVBrD+ciLDrngURqW4/UprojlkTkOSM1nxFRZh5H4DbEkBMQKJRpr
 B/GbvO/pcQ/k/M5KHDqWQ19iu+x4Lbt1TV1QJAKheTccFxMi92+Qi78/vvTMmZIL30qP
 A8vQ==
X-Gm-Message-State: AOAM5305FQ/0I+/Bib2GiHUVOb8gKc4LPU+ILeXiB5pW4tb8msN2s6YD
 xO8dYLWlXBmizunxCI559TQ4HJCHCSHmtIADejQ=
X-Google-Smtp-Source: ABdhPJzSyZE13ENMZCZmQC9wb42c2+jfBT0xkRyBhG7aUDxuSOpM1i4lxtKV/gXIAQ2IB3/z86OdtASITafWT3RxO6I=
X-Received: by 2002:a5d:9306:: with SMTP id l6mr5598148ion.105.1593661377156; 
 Wed, 01 Jul 2020 20:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593547870.git.alistair.francis@wdc.com>
 <122b78825b077e4dfd39b444d3a46fe894a7804c.1593547870.git.alistair.francis@wdc.com>
 <619512b4-9252-5a32-0ed1-994d69b1b6ba@c-sky.com>
In-Reply-To: <619512b4-9252-5a32-0ed1-994d69b1b6ba@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Jul 2020 20:33:11 -0700
Message-ID: <CAKmqyKPkxbZ8eE7Z76ofgNKDs4NaJV+ENwOPYtTU9S4uDbuhMg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] hw/riscv: Allow 64 bit access to SiFive CLINT
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
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

On Tue, Jun 30, 2020 at 5:19 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
>
> On 2020/7/1 4:12, Alistair Francis wrote:
> > Commit 5d971f9e672507210e77d020d89e0e89165c8fc9
> > "memory: Revert "memory: accept mismatching sizes in
> > memory_region_access_valid"" broke most RISC-V boards as they do 64 bit
> > accesses to the CLINT and QEMU would trigger a fault. Fix this failure
> > by allowing 8 byte accesses.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   hw/riscv/sifive_clint.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
> > index b11ffa0edc..669c21adc2 100644
> > --- a/hw/riscv/sifive_clint.c
> > +++ b/hw/riscv/sifive_clint.c
> > @@ -181,7 +181,7 @@ static const MemoryRegionOps sifive_clint_ops = {
> >       .endianness = DEVICE_LITTLE_ENDIAN,
> >       .valid = {
> >           .min_access_size = 4,
> > -        .max_access_size = 4
> > +        .max_access_size = 8
> >       }
> >   };
> >
>
> Reviewed-by: LIU Zhiwei<zhiwei_liu@c-sky.com>

Thanks for the review. As most RISC-V machines are broken without this
patch I have applied it to my next PR.

Alistair

>
>

