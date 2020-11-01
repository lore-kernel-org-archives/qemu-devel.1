Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C233BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0934D2071E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXIfYeGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0934D2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZGCz-0003Am-4Z
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 11:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZGCQ-0002k6-4g
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 11:27:22 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:34907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZGCN-0005un-P9
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 11:27:21 -0500
Received: by mail-yb1-xb42.google.com with SMTP id m188so9642165ybf.2
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ZTueme90DJZ6ixQK0TtE5ZL4IJSkdKpu3U0UFjqoDE=;
 b=bXIfYeGnI0QVKH9O2vh7/Lj1odpnXcIbTya4HxDYYXoHY6cL0TH2/mF1bFHAlCt8x9
 PzMHxgwN21E8GUzGzBes7UD+JuIGZquhJWsk4VQRs8zedfYQ9hzBeVjOOVik1VwTfxTH
 q1P9PsvcJ4gLVouKfH3sba7raj3AV4nXvftSjNcPZstutIrnOvvJz40dkRg81lQteax0
 UGP9YH68E+FEet+4NLy7mxXg+t9F0j2fjcDnG0QIO02VfGKRV7+S6SrEFYhTLomO92tq
 VMFw9qXf7qNgq8TKALevAVi1SHzpy/C0UxpHf3xkRULFqkr32qJ93ESLIPdF0mCqIuLe
 p+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ZTueme90DJZ6ixQK0TtE5ZL4IJSkdKpu3U0UFjqoDE=;
 b=SkLe9EwfsaadeW8cElhFm/GlEj9ng88EzBA4vWEIKNLx13al14LVKUWFro9oQ4rp6S
 vlWKJdCcR1caPBe7IoVIzh8Q9USvHk1cc6xnLbNteBTe8Bxbogt1AeHz1ocNVXXc0eC/
 W8vtXDNc6+Gi3LwBpCkKZ5DxkxrXMO/UUPtsBIB8YyElqUxR/EDRU2+1jYwjpJ7R3dol
 fvtpcF88H6IZluCvRzK+45C0rSoqciWjHCAJtsANnld1JmvT/m5eon/DJeMS2sfBriSb
 s2hOnDjzJV0+uunzykdhUGYkSjrWQcxjOxOy8jNhJoh13Xkiha8TH1JGg/oY7OlqKQAf
 +IOg==
X-Gm-Message-State: AOAM5314LSr1oQTj1DBqToBwCWzk2wICGaKrfirR9ZqYsL39kwDuCTc8
 oXm1Pz4OP7eiIY0RW9DYVz8VUsLms0qlX8tR1EE=
X-Google-Smtp-Source: ABdhPJxG/RUFv+WyHkm0EEaKRR8sN4mpr60vpg+Yt7jw5WQp+CqYdDUo00TzUMFAQ46N3MqQ0rM5T14BrGoVMK0iMNM=
X-Received: by 2002:a25:f81e:: with SMTP id u30mr16523147ybd.332.1604248038319; 
 Sun, 01 Nov 2020 08:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20201029141358.3102636-1-alistair.francis@wdc.com>
 <CAFEAcA9cTDhKjcvOL_QaeeDjWKUPaLxh22iueE0s4i7+WtMtiw@mail.gmail.com>
In-Reply-To: <CAFEAcA9cTDhKjcvOL_QaeeDjWKUPaLxh22iueE0s4i7+WtMtiw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 2 Nov 2020 00:27:06 +0800
Message-ID: <CAEUhbmUn+YPk_n8HODCB21hdgeoPUHgmCc=c19h3QEk+cS9u=Q@mail.gmail.com>
Subject: Re: [PULL 00/18] riscv-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 1, 2020 at 10:02 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 29 Oct 2020 at 14:25, Alistair Francis <alistair.francis@wdc.com> wrote:
> >
> > The following changes since commit c0444009147aa935d52d5acfc6b70094bb42b0dd:
> >
> >   Merge remote-tracking branch 'remotes/armbru/tags/pull-qmp-2020-10-27' into staging (2020-10-29 10:03:32 +0000)
> >
> > are available in the Git repository at:
> >
> >   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20201029
> >
> > for you to fetch changes up to e041badcd4ac644a67f02f8765095a5ff7a24d47:
> >
> >   hw/riscv: microchip_pfsoc: Hook the I2C1 controller (2020-10-29 07:11:14 -0700)
> >
> > ----------------------------------------------------------------
> > This series adds support for migration to RISC-V QEMU and expands the
> > Microchip PFSoC to allow unmodified HSS and Linux boots.
> >
> > ----------------------------------------------------------------
>
> Hi; this fails 'make check' on 32-bit hosts:

Oops, I don't have 32-bit hosts to test :(

>
> qemu-system-riscv64: at most 2047 MB RAM can be simulated
> Broken pipe
> ../../tests/qtest/libqtest.c:167: kill_qemu() tried to terminate QEMU
> process but encountered exit status 1 (expected 0)
> ERROR qtest-riscv64/qom-test - too few tests run (expected 6, got 3)
>
> and
>
> qemu-system-riscv64: at most 2047 MB RAM can be simulated
> Broken pipe
> ../../tests/qtest/libqtest.c:167: kill_qemu() tried to terminate QEMU
> process but encountered exit status 1 (expected 0)
> ERROR qtest-riscv64/test-hmp - too few tests run (expected 7, got 3)
>

But I think this is caused by the following commit:
https://github.com/alistair23/qemu/commit/8c47c1e9df850a928b4b230240a950feabe6152f

I will send a new version of this patch soon.

Regards,
Bin

