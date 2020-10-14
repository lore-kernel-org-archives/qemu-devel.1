Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0E3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3E62072C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HUjR8aNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3E62072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSap2-0008DB-9a
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kSaoO-0007jh-TN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:03:02 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:36485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kSaoJ-0002rl-Ie
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:02:59 -0400
Received: by mail-qt1-x844.google.com with SMTP id c5so1639337qtw.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 00:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lCzZBTERigzD6C3YVhh2zUlgXKFNK3Cq5qY5aymwUVw=;
 b=HUjR8aNb2dOiKNkkjknuwq9QZRtZJSWulJDsPfvgAslFL2YlZ8jEgL7pRxbjb93PyK
 RsVOdJoNVvGtMlrBz5Ij4z5EG0+E+zkvrzuoeN+78bay5MonDeq5gMpnw7NA6daJtcSj
 p2xUR8YaVvwwEvb6i0ZIJeBkrRBpjM3j+7Qhds6nKRpiTSUlpxMQeykol23Ryfw8F1p4
 M5QV+JZkHB+zUXVQhHZ3OSiUZISjubgvnkd3rwZLkHhWKIWxgWwe3jwvNDjq2g+RNqpS
 ToFBElNYLma3IVKhDmsizgzzG07z2IZCk1BrwcHOP8kd+yAGMBFrh5ApfmjsXFoUHtbX
 hMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lCzZBTERigzD6C3YVhh2zUlgXKFNK3Cq5qY5aymwUVw=;
 b=Dtzzvd5c0UIhorEl+W0PJBPzYXhSCOrgCBBW0ORU+SoeyMThY40WE2EEbPc9pGTDR7
 2rQEUdfQa7WxbIIQG2tF0pR1DImPxtmBrxt8K90fMDAUKx9560HDuQrCQRqFJZLuZnOP
 eRGIDZFtCiZJoJ17I4leLCfqwS/p2Mi1Ix6pzoJcr2ebUWsP2KSE8NUC9j5kXNxPPAle
 zOT0aYZ3eq72NcycB8y01ftZzP7dmeZUCR6TaTAZrCGCXCGMCFaozEIuG3lA9KRAxVhD
 oXhi2cUqxqKUExWTENlhzzEdRhFZX4c/wb4M5KjguL3VbjE75e29o8KnB4IT/9uCRrzw
 3L2A==
X-Gm-Message-State: AOAM530MlBLUuSFuQINaVUL3pKcJYJbYr9I5Wu9+ITwgwoL2rPsR5zyX
 2g3m1T4Yz2bvXUf77ewQvAaPsq1lsjcKwVZcsyzAMw==
X-Google-Smtp-Source: ABdhPJxa//0jBAL+coY0m3aJZ2DgksG+QgTJqYUEQjS+2W9z46h0RxWUgelR4AwrFz1qXkUAhzF5v/HMACkLWBazruo=
X-Received: by 2002:ac8:5a08:: with SMTP id n8mr3206219qta.97.1602658973986;
 Wed, 14 Oct 2020 00:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101146.12786-1-green.wan@sifive.com>
 <20200928101146.12786-2-green.wan@sifive.com>
 <CAEUhbmWxPmhZhEFECXO5oLTbf+r1E-rBuFQrC_e+D6YbmMDmag@mail.gmail.com>
In-Reply-To: <CAEUhbmWxPmhZhEFECXO5oLTbf+r1E-rBuFQrC_e+D6YbmMDmag@mail.gmail.com>
From: Green Wan <green.wan@sifive.com>
Date: Wed, 14 Oct 2020 15:02:42 +0800
Message-ID: <CAJivOr7mr_poapw5Okga1uLo7Zq+gs3oiJxuMPpbnAsQMNgzfg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/2] hw/misc/sifive_u_otp: Add write function and
 write-once protection
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=green.wan@sifive.com; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Oct 14, 2020 at 1:37 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Green,
>
> On Mon, Sep 28, 2020 at 6:12 PM Green Wan <green.wan@sifive.com> wrote:
> >
> >  - Add write operation to update fuse data bit when PWE bit is on.
> >  - Add array, fuse_wo, to store the 'written' status for all bits
> >    of OTP to block the write operation.
> >
> > Signed-off-by: Green Wan <green.wan@sifive.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/misc/sifive_u_otp.c         | 30 +++++++++++++++++++++++++++++-
> >  include/hw/misc/sifive_u_otp.h |  3 +++
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> >
>
> I am not sure how you tested this. I wrote a simple U-Boot command to
> call U-Boot sifive-otp driver to test the write functionality, but it
> failed.
>
> => misc write otp@10070000 0 80200000 10
                                                      ^^^^^^^^^
Quick ask, how about 'md 80200000'?

I didn't use 'misc write' command. I can check afterward.

> => misc read  otp@10070000 0 80400000 10
> => md 80400000
> 80400000: ffffffff ffffffff ffffffff ffffffff    ................
> 80400010: 00000000 00000000 00000000 00000000    ................
> 80400020: 00000000 00000000 00000000 00000000    ................
> 80400030: 00000000 00000000 00000000 00000000    ................
> 80400040: 00000000 00000000 00000000 00000000    ................
> 80400050: 00000000 00000000 00000000 00000000    ................
> 80400060: 00000000 00000000 00000000 00000000    ................
> 80400070: 00000000 00000000 00000000 00000000    ................
> 80400080: 00000000 00000000 00000000 00000000    ................
> 80400090: 00000000 00000000 00000000 00000000    ................
> 804000a0: 00000000 00000000 00000000 00000000    ................
> 804000b0: 00000000 00000000 00000000 00000000    ................
> 804000c0: 00000000 00000000 00000000 00000000    ................
> 804000d0: 00000000 00000000 00000000 00000000    ................
> 804000e0: 00000000 00000000 00000000 00000000    ................
> 804000f0: 00000000 00000000 00000000 00000000    ................
> => misc write otp@10070000 0 80200010 10
> => misc read  otp@10070000 0 80400010 10
> => md 80400000
> 80400000: ffffffff ffffffff ffffffff ffffffff    ................
> 80400010: ffffffff ffffffff ffffffff ffffffff    ................
> 80400020: 00000000 00000000 00000000 00000000    ................
> 80400030: 00000000 00000000 00000000 00000000    ................
> 80400040: 00000000 00000000 00000000 00000000    ................
> 80400050: 00000000 00000000 00000000 00000000    ................
> 80400060: 00000000 00000000 00000000 00000000    ................
> 80400070: 00000000 00000000 00000000 00000000    ................
> 80400080: 00000000 00000000 00000000 00000000    ................
> 80400090: 00000000 00000000 00000000 00000000    ................
> 804000a0: 00000000 00000000 00000000 00000000    ................
> 804000b0: 00000000 00000000 00000000 00000000    ................
> 804000c0: 00000000 00000000 00000000 00000000    ................
> 804000d0: 00000000 00000000 00000000 00000000    ................
> 804000e0: 00000000 00000000 00000000 00000000    ................
> 804000f0: 00000000 00000000 00000000 00000000    ................
>
> But it can read the serial number at offset 0x3f0
>
> => misc read  otp@10070000 3f0 80400010 10
> => md 80400000
> 80400000: ffffffff ffffffff ffffffff ffffffff    ................
> 80400010: 00000001 fffffffe ffffffff ffffffff    ................
> 80400020: 00000000 00000000 00000000 00000000    ................
> 80400030: 00000000 00000000 00000000 00000000    ................
> 80400040: 00000000 00000000 00000000 00000000    ................
> 80400050: 00000000 00000000 00000000 00000000    ................
> 80400060: 00000000 00000000 00000000 00000000    ................
> 80400070: 00000000 00000000 00000000 00000000    ................
> 80400080: 00000000 00000000 00000000 00000000    ................
> 80400090: 00000000 00000000 00000000 00000000    ................
> 804000a0: 00000000 00000000 00000000 00000000    ................
> 804000b0: 00000000 00000000 00000000 00000000    ................
> 804000c0: 00000000 00000000 00000000 00000000    ................
> 804000d0: 00000000 00000000 00000000 00000000    ................
> 804000e0: 00000000 00000000 00000000 00000000    ................
> 804000f0: 00000000 00000000 00000000 00000000    ................
>
> Regards,
> Bin

