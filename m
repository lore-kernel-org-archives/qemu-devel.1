Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66522C43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79E6212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLG8UjTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79E6212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSb37-0005LJ-Pd
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSb2E-0004ay-AQ; Wed, 14 Oct 2020 03:17:18 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:43083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSb2A-0007vL-Mg; Wed, 14 Oct 2020 03:17:18 -0400
Received: by mail-yb1-xb43.google.com with SMTP id n65so1805721ybg.10;
 Wed, 14 Oct 2020 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gA29hb0tm8ZMMLazNEeo1g2xvNBk96X0AemPcKzZOfM=;
 b=sLG8UjTSP2l61u9VFTkgcLNVtcnAJ707MD1BJChi4zQUITxHb09JmGOnkjFdp+vtk5
 H2Jhg8Y86d9ap9wt6/0tZ5YXsZy4Xu4Eiw45Ww/yZZ+lLSUFGWFQJv6yaNMHkMLi8G1T
 79g/rE18RIBQ+/BnwCUb2GNODboeQ2UIcHxGFPQ8DavBudLuQfr3p8q9esNskGOn+SYy
 2yKQ359xPvAVNfxPJ9Y3EZm3lnMsjdequgdrxVh+VbY5EzfiQXCnof9ORiQUpHNtWgZ/
 5OEqWbJWWscsc/QrWzA71kfw/tilBJU5Q9ITn0AoHw7QRgghXZHyBOropAmCkmEsfuiM
 hbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gA29hb0tm8ZMMLazNEeo1g2xvNBk96X0AemPcKzZOfM=;
 b=BXHQNiwUZeA6KKySpVrShhWIcAcSRj15Ia6UbYK8Hm1jROr+mSbmD3sA+IjqdhVNri
 VEDh42RIIxXXaAznReMB+H8NxaH8WbwYWq0GO16z+1QQtxqnrc6I53P/8OfTV4kxoKrw
 JfKQ9c8OQ8nYGkCVJtddIQhoPkTNxPKUCVIYtc2DiRKHJ9NmGsiIDIhQk1tMaXdj6/9N
 3hAUlAiM3TVhyZC/NFnCKULr53I+AYE3Nwve5jUBzPWyUM9CbWtpJEuUMSQAbiGB2hv/
 x4Ssf6W3Aq9P1D3s5W6gUKQckh2e6ZKOyG/C3HeuOmutE6oDMXVvnit1AFB+W/TcmzUR
 8aWQ==
X-Gm-Message-State: AOAM530N4uM5AppYw3aPhn01/UlElanXETKNs9USazoStAlcD8GA0HBD
 NBWNjm0XJDIVzVfWiPu1Nwx2RhxPmZwQeKncA9o=
X-Google-Smtp-Source: ABdhPJx90l0tmGhomX2RhVj4pYwWfakRzHW1NNnS9wk8JBsSjCsDP8sqgeKfZukjKbRJFY9IVRjTIWWrmtzKqWk9fnk=
X-Received: by 2002:a25:bb01:: with SMTP id z1mr5661176ybg.387.1602659833149; 
 Wed, 14 Oct 2020 00:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101146.12786-1-green.wan@sifive.com>
 <20200928101146.12786-2-green.wan@sifive.com>
 <CAEUhbmWxPmhZhEFECXO5oLTbf+r1E-rBuFQrC_e+D6YbmMDmag@mail.gmail.com>
 <CAJivOr7mr_poapw5Okga1uLo7Zq+gs3oiJxuMPpbnAsQMNgzfg@mail.gmail.com>
In-Reply-To: <CAJivOr7mr_poapw5Okga1uLo7Zq+gs3oiJxuMPpbnAsQMNgzfg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 14 Oct 2020 15:17:01 +0800
Message-ID: <CAEUhbmVUSJd1E9r4O+ziVbbH3RgSqaLe7q0CtgCqbhD+mjCurQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/2] hw/misc/sifive_u_otp: Add write function and
 write-once protection
To: Green Wan <green.wan@sifive.com>
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Green,

On Wed, Oct 14, 2020 at 3:02 PM Green Wan <green.wan@sifive.com> wrote:
>
> On Wed, Oct 14, 2020 at 1:37 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Green,
> >
> > On Mon, Sep 28, 2020 at 6:12 PM Green Wan <green.wan@sifive.com> wrote:
> > >
> > >  - Add write operation to update fuse data bit when PWE bit is on.
> > >  - Add array, fuse_wo, to store the 'written' status for all bits
> > >    of OTP to block the write operation.
> > >
> > > Signed-off-by: Green Wan <green.wan@sifive.com>
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  hw/misc/sifive_u_otp.c         | 30 +++++++++++++++++++++++++++++-
> > >  include/hw/misc/sifive_u_otp.h |  3 +++
> > >  2 files changed, 32 insertions(+), 1 deletion(-)
> > >
> >
> > I am not sure how you tested this. I wrote a simple U-Boot command to
> > call U-Boot sifive-otp driver to test the write functionality, but it
> > failed.
> >
> > => misc write otp@10070000 0 80200000 10
>                                                       ^^^^^^^^^
> Quick ask, how about 'md 80200000'?
>
> I didn't use 'misc write' command. I can check afterward.

Note 'misc write' is a new U-Boot command I just added for testing
this QEMU functionality. Please use the U-Boot patch below:
http://patchwork.ozlabs.org/project/uboot/patch/1602657292-82815-1-git-send-email-bmeng.cn@gmail.com/

>
> > => misc read  otp@10070000 0 80400000 10
> > => md 80400000
> > 80400000: ffffffff ffffffff ffffffff ffffffff    ................
> > 80400010: 00000000 00000000 00000000 00000000    ................
> > 80400020: 00000000 00000000 00000000 00000000    ................
> > 80400030: 00000000 00000000 00000000 00000000    ................
> > 80400040: 00000000 00000000 00000000 00000000    ................
> > 80400050: 00000000 00000000 00000000 00000000    ................
> > 80400060: 00000000 00000000 00000000 00000000    ................
> > 80400070: 00000000 00000000 00000000 00000000    ................
> > 80400080: 00000000 00000000 00000000 00000000    ................
> > 80400090: 00000000 00000000 00000000 00000000    ................
> > 804000a0: 00000000 00000000 00000000 00000000    ................
> > 804000b0: 00000000 00000000 00000000 00000000    ................
> > 804000c0: 00000000 00000000 00000000 00000000    ................
> > 804000d0: 00000000 00000000 00000000 00000000    ................
> > 804000e0: 00000000 00000000 00000000 00000000    ................
> > 804000f0: 00000000 00000000 00000000 00000000    ................
> > => misc write otp@10070000 0 80200010 10
> > => misc read  otp@10070000 0 80400010 10
> > => md 80400000
> > 80400000: ffffffff ffffffff ffffffff ffffffff    ................
> > 80400010: ffffffff ffffffff ffffffff ffffffff    ................
> > 80400020: 00000000 00000000 00000000 00000000    ................
> > 80400030: 00000000 00000000 00000000 00000000    ................
> > 80400040: 00000000 00000000 00000000 00000000    ................
> > 80400050: 00000000 00000000 00000000 00000000    ................
> > 80400060: 00000000 00000000 00000000 00000000    ................
> > 80400070: 00000000 00000000 00000000 00000000    ................
> > 80400080: 00000000 00000000 00000000 00000000    ................
> > 80400090: 00000000 00000000 00000000 00000000    ................
> > 804000a0: 00000000 00000000 00000000 00000000    ................
> > 804000b0: 00000000 00000000 00000000 00000000    ................
> > 804000c0: 00000000 00000000 00000000 00000000    ................
> > 804000d0: 00000000 00000000 00000000 00000000    ................
> > 804000e0: 00000000 00000000 00000000 00000000    ................
> > 804000f0: 00000000 00000000 00000000 00000000    ................
> >
> > But it can read the serial number at offset 0x3f0
> >
> > => misc read  otp@10070000 3f0 80400010 10
> > => md 80400000
> > 80400000: ffffffff ffffffff ffffffff ffffffff    ................
> > 80400010: 00000001 fffffffe ffffffff ffffffff    ................
> > 80400020: 00000000 00000000 00000000 00000000    ................
> > 80400030: 00000000 00000000 00000000 00000000    ................
> > 80400040: 00000000 00000000 00000000 00000000    ................
> > 80400050: 00000000 00000000 00000000 00000000    ................
> > 80400060: 00000000 00000000 00000000 00000000    ................
> > 80400070: 00000000 00000000 00000000 00000000    ................
> > 80400080: 00000000 00000000 00000000 00000000    ................
> > 80400090: 00000000 00000000 00000000 00000000    ................
> > 804000a0: 00000000 00000000 00000000 00000000    ................
> > 804000b0: 00000000 00000000 00000000 00000000    ................
> > 804000c0: 00000000 00000000 00000000 00000000    ................
> > 804000d0: 00000000 00000000 00000000 00000000    ................
> > 804000e0: 00000000 00000000 00000000 00000000    ................
> > 804000f0: 00000000 00000000 00000000 00000000    ................

Regards,
Bin

