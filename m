Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD162C47247
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 01:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2E220735
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 01:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj+3Zdw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2E220735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW8xu-0004jy-MO
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 21:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jW8xH-0004Jx-8Y; Tue, 05 May 2020 21:34:35 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:42619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jW8xF-0007UL-EJ; Tue, 05 May 2020 21:34:34 -0400
Received: by mail-yb1-xb43.google.com with SMTP id i16so131485ybq.9;
 Tue, 05 May 2020 18:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RTtQPvebiIKh8094jlNv5dRHdSZfAaWFVZ43LRjuN6Y=;
 b=Qj+3Zdw6ZvvpAslzJ5TFMx8cQQX8TPraIiCLBhYDmX2rVPN21IBKIuQeJthW7pd3nU
 4tY3bDXPJAHZaNk2qX/obb1aNAB12k1AB/6QOqbG/hI+ns0GdXnYNiyl1JC/0d2EQHuf
 smHXtdjf03hRFCC1I1JfxCDtEEGowtYhoHl8gRRKsWiimYX6uyVDr9WCdlmVFW3KwQYR
 lYUyEBPZ1p6YxGejrk8N35R/ryYHRijaSKfhmSL7OHVqzP7fEgXgJTtm2r2T0G78GDi+
 8OJjCkMOcaTdl/XwE5sjjiBG0ZOc3Gv2s+xLeO4TfuVSjPlcMuodyS/GgqzerFCJ9bRu
 r9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RTtQPvebiIKh8094jlNv5dRHdSZfAaWFVZ43LRjuN6Y=;
 b=onx+Nf3m0A3PxTRat2dMv5xC+mFO5LtDqVd5jzFQFCBFAA7hIBvoHI8P1xGUkV9Dso
 vUz/ejQyPJinsdD7wtvd+SCW2qatWfn2OBnxfjKW7rjuTBaLF+h3GIYlcVAYScNniuVh
 uGthzEGh42ov02eZHnB7y2KWX6/Q/c6s74wToPsDBe7vbuMB6sW10mwAUJjUho0c+XV5
 7O4nM9bfjdnqRE8duGxB96ha+WxAENZs8czr24sbPz8f8AIwlrpt7x1pri44PODFW7UJ
 DORwpwaQcEKgqqrPW/fH0dfqOpBClNRaQ5vg6KPX/lQnYeEORaI1+9KfzFmhnRy42inq
 XW0A==
X-Gm-Message-State: AGi0PuYQcnlDujZjYRs2rqSYTXSiKwvK/809/+UQxWQB+ibx0UKHjFVI
 D5oLQyIm7u3kAakE6ZxZHHhigBN+osJHLmWVjtE=
X-Google-Smtp-Source: APiQypJdTDUNj6ubUvT/OoAMEg2xjlLNJUTGclCKyylOTCiQlZQU0pErc18KaUZXkwPaQWVxecWUVNvUlsqGbP5S9nU=
X-Received: by 2002:a25:bdc8:: with SMTP id g8mr9470732ybk.122.1588728871802; 
 Tue, 05 May 2020 18:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <1588335545-649-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKMdmVrvYDNVtm6_iviDT_mofGZO9DC2vtZdZaHN31T07A@mail.gmail.com>
 <CAKmqyKO6HGQrMxsNovPkoB4TncEmeD=uFV_oXEpQ0t+=g20Wfw@mail.gmail.com>
In-Reply-To: <CAKmqyKO6HGQrMxsNovPkoB4TncEmeD=uFV_oXEpQ0t+=g20Wfw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 6 May 2020 09:34:21 +0800
Message-ID: <CAEUhbmVTg+521EHutukOod_PKx0RQ-s=EgnKu=JM-vduMn4mNA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Change the default behavior if no -bios option is
 specified
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Wed, May 6, 2020 at 6:37 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, May 5, 2020 at 1:34 PM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Fri, May 1, 2020 at 5:21 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > Per QEMU deprecated doc, QEMU 4.1 introduced support for the -bios
> > > option in QEMU for RISC-V for the virt machine and sifive_u machine.
> > > The default behavior has been that QEMU does not automatically load
> > > any firmware if no -bios option is included.
> > >
> > > Now 2 releases passed, it's time to change the default behavior to
> > > load the default OpenSBI firmware automatically. The firmware is
> > > included with the QEMU release and no user interaction is required.
> > > All a user needs to do is specify the kernel they want to boot with
> > > the -kernel option.
> > >
> > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> >
> > Thanks!
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >
> > Applied to the RISC-V tree.
>
> This fails `make check`
>
> qemu-system-riscv64: Unable to load the RISC-V firmware
> "opensbi-riscv64-spike-fw_jump.elf"
> Broken pipe
> /scratch/alistair/software/qemu/tests/qtest/libqtest.c:166:
> kill_qemu() tried to terminate QEMU process but encountered exit
> status 1 (expected 0)
> ERROR - too few tests run (expected 7, got 2)
> make: *** [/scratch/alistair/software/qemu/tests/Makefile.include:637:
> check-qtest-riscv64] Error 1
>

Please apply this patch to fix the "make check" as well.

[5/5] riscv: Suppress the error report for QEMU testing with
riscv_find_firmware()
http://patchwork.ozlabs.org/project/qemu-devel/patch/1588348254-7241-6-git-send-email-bmeng.cn@gmail.com/

Regards,
Bin

