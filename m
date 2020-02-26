Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C09C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 23:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04508206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 23:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeBztnJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04508206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j76W8-0001hg-4x
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 18:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j76VX-0001E2-5H
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j76VW-0004Lf-25
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:54:27 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:46755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j76VS-00045t-O3; Wed, 26 Feb 2020 18:54:22 -0500
Received: by mail-lf1-x143.google.com with SMTP id v6so618423lfo.13;
 Wed, 26 Feb 2020 15:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tygxNCoM38EfVRKUBOfwHkEzNwitoEsggLJYj0Hqk50=;
 b=YeBztnJy3fUPSazLC9cbVaf2PCtpwVqXWf5iGlBB53Eo3q8UTuxm5uQgpYj2nwurmL
 QliPIthSYqKa/XUUGcTFureKlZ0jiqOWzeOZs7qTtcnPrjWuh/2yoQThibMSBTg5RjVW
 4gtycAQ9STco/F1EKiJ3YUkhAgeMxvPDyoq67CMtlcHRFkCD2DuTSh6Zqn7bMwc8z19q
 KPxXFEaxbJxtLNRdZ21p/+nlGRv9/S3hIbCLM2kHOwf1NglHUo4YYQvMOpy8u9AZGk9t
 GLV8HVlg4dCm6h0Dn1qDjGPsTxZ60Lw7elVpppBZ8GSw1KfXBcmhwmN49nQ81Ge3/5pC
 zaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tygxNCoM38EfVRKUBOfwHkEzNwitoEsggLJYj0Hqk50=;
 b=fbJJryh3D5P3oxLJtuXIwMaq0OANqdiFC7n92koPaCNn8HLy42936JUtuKLo+uZsO0
 8MgooKc8SN7axJ7HWbReHYMEfRX1fNyigf/RpTqREBO4gyckuomkylbDrBo1nhYmZ1aI
 9wI+a+vcmCzQQB95qJ9vBOo+TOWwCPRNTmMhwKlT1iyUb3X3HrZlDeZ7bf9tjKkFVx5o
 0ANTVFjmbShbtCyfOlXHSeL1MwWJ0oVuz/GKcWJ+YFjk9TIl5/Gjk3GNfHtO5owllgsK
 rWLgpFmWrAcUrKjBYBxNaAV0ol4XPJh5yb86tGgll/ty6lncEM6ozJnCHUXG1c7sOQae
 wdNw==
X-Gm-Message-State: ANhLgQ0LPaKoQJRPP7/2laozicDohExb8i9uV9068EQX1UyHn4aHDd+N
 r40LAD/bPtOjQro2QZ1XFRzT0hAuvwZ3LZaEVdA=
X-Google-Smtp-Source: ADFU+vsJkrFNFQefz1XDNyaI8hJk4sTTdyzqVWFi1ug/CIzkwp3QgVEZyfVb2S4adg0kQDA0/FnBGaLyoQpu5xyVV0c=
X-Received: by 2002:a05:6512:31d3:: with SMTP id
 j19mr557323lfe.178.1582761260352; 
 Wed, 26 Feb 2020 15:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
 <ac290e38-bb39-6551-0758-95d087fa568c@sifive.com>
 <CAKmqyKOedrW3HZFfep4ErJ8H86V=KXeBL8LN2Cy_+669a6c9gQ@mail.gmail.com>
 <CAFyWVabLp78M2RGe0TDF5TyW4sJpa6Rm0sJLnc3-CPv8pW+TzA@mail.gmail.com>
In-Reply-To: <CAFyWVabLp78M2RGe0TDF5TyW4sJpa6Rm0sJLnc3-CPv8pW+TzA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 15:46:43 -0800
Message-ID: <CAKmqyKMx6pPDaeJmGXCa+cKUHphD+dzwPLDtZ4R_yXiN8t2KBQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] target-riscv: support vector extension part 1
To: Jim Wilson <jimw@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 3:40 PM Jim Wilson <jimw@sifive.com> wrote:
>
> On Wed, Feb 26, 2020 at 2:36 PM Alistair Francis <alistair23@gmail.com> wrote:
> > On Wed, Feb 26, 2020 at 12:09 PM Jim Wilson <jimw@sifive.com> wrote:
> > > If this rvv 0.7.1 implementation is considered a temporary solution,
> > > maybe we can just remove all of this work when the official rvv spec if
> > > available?  But presumably it is better if we can have both this
> >
> > That is generally the plan. When the final spec comes out this will be
> > updated and we will only support that.
>
> This solves my problem, but maybe creates one for Alibaba.  They have
> apparently fabbed a chip using the 0.7.1 draft of the vector spec
> proposal.  So for qemu to properly support their asic, the 0.7.1 draft
> support will have to be retained.  But I think SiFive and everyone
> else is waiting for the official spec before building asics with
> vector support.  If Alibaba will update their processor as the spec
> evolves, then maybe this isn't a problem for them.

That does seem unfortunate. I don't see a way for us to be able to
support previous draft spec versions though. That seems like a huge
amount of maintenance.

It shouldn't actually be that bad. Here is kind of what I'm imagining.

 - Vector extensions v0.7.1 are merged to QEMU
 - QEMU 5.x ships with v0.7.1 vector extensions (it seems unlikely
someone will upstream v0.8.0 before the 5.x release)

At some point in the future someone will update the experimental
support in QEMU from v0.7.1 to a fully released v1.0. In which case
there is still a release with the older experimental support which can
be used for the v0.7.1 if required.

Alistair

>
> Jim

