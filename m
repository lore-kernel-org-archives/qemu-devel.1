Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57752C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E521820758
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWEByQHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E521820758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRrC-0001p1-2G
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kGRml-0004JT-Sg; Thu, 10 Sep 2020 14:59:07 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kGRmk-0000k6-58; Thu, 10 Sep 2020 14:59:07 -0400
Received: by mail-io1-xd41.google.com with SMTP id u126so8303692iod.12;
 Thu, 10 Sep 2020 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f3i9UdW14qknfifNwkoRYPMhlcCxUFd3MCQEswGN9eU=;
 b=IWEByQHHl6g+qkq7nKUfyL8XXtfN72Rxrsj7Ck1VrzqJxExu2834GyT7L1mW1ft4n2
 ZC/R+0xm7lHYvO76+wK/FHNfDpvaTaQMhcS1h+uAi1mrHfkcjePBgwx0WZLZGSi0fZzQ
 SWLDd08+aNo9lRDntiZd2SvQjW8+KWBrbkFPS5ZZH1VJW8CPmJgA3wMG9uxCjpaPUtet
 P1hNm8brVlU6mFXPWFv+UHM2Leao6fIlaRLs+PEXn/NzxMpTEskZkh6wiLX6+GruiM3C
 k9kqVbbDEUeqAsP6HGNzi2rpLfOGwNCBb9VSh6PenMmNAle6/FhVuswPoEkEscm/lfWS
 CuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f3i9UdW14qknfifNwkoRYPMhlcCxUFd3MCQEswGN9eU=;
 b=h7qxIRGbsk/aT0PGW5onnxCOpq7fmSAf9PvAFOAVksj1Slti8Dp5i6t/WVa+lU0nBR
 HVMVpp1YHckEKGRu3B+Zs3NESa0psT5saTKjKcVATmEDsn4qUlRA3OyacbJmfyf0fVEt
 81wjS429RYgZARCB9EoOWV2YaW7V3ZkjEnyO22vUF0F1N5eA1lkIkio3uF0hGvA12U75
 oIYF9X0miLyQOceX8T8PnyPeMQlXU7IHhSeAG9s7WAuaQ/sFAZDDoCfK5FL8d85wbEnH
 QKMl/Cb4kdU1O/hdmIDM5qKyDXXqfFxkCjoGJ04dp7MDJH236AjIwLpzZUi2N5SEjsfn
 W1bg==
X-Gm-Message-State: AOAM532PaVJdz/+cLivRJUdvNCyvgQvUQDkWBxnRl6NihiFz0YBLpAGs
 V+u33hkn75IaoAuQWbj/LVuDd1VDJEHhht1hd2w=
X-Google-Smtp-Source: ABdhPJwf+/i+E5pjDSoyPdR265wJ4juCUAdU6EsQPb6gK4ppON1Tau+aMX4uDO0oD9TRmWsCbkQfxAyvA1wF+zlSdUk=
X-Received: by 2002:a02:3213:: with SMTP id j19mr9725079jaa.135.1599764344597; 
 Thu, 10 Sep 2020 11:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA9RcbWeM=hhUNH=Exdp_QT4s0GcCJdrpcvWkv2ea+o7cQ@mail.gmail.com>
 <mhng-13d2ebf6-70bc-4130-9e11-6fa4391c64db@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-13d2ebf6-70bc-4130-9e11-6fa4391c64db@palmerdabbelt-glaptop1>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 10 Sep 2020 11:48:03 -0700
Message-ID: <CAKmqyKPmOCikT3OYr9Bq0OeBpm41jpNd_7EQrZ-91AokPDG4SQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] riscv: Initial commit of OpenTitan machine
To: Palmer Dabbelt <palmer@dabbelt.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 9, 2020 at 12:51 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 09 Sep 2020 12:00:07 PDT (-0700), Peter Maydell wrote:
> > On Wed, 9 Sep 2020 at 19:00, Alistair Francis <alistair23@gmail.com> wrote:
> >>
> >> On Tue, Sep 8, 2020 at 7:52 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> >> > ...shouldn't the riscv64-softmmu config have CONFIG_OPENTITAN too?
> >> > The usual principle is that the 64-bit executable can run the
> >> > 32-bit boards too.
> >>
> >> I didn't know that was the general case. I'll send a patch to enable this.
> >
> > Somebody on IRC suggested that the riscv code currently
> > assumes that #ifdef TARGET_RISCV64 implies a 64-bit CPU,
> > ie that the 32-bit CPUs don't actually behave correctly
> > if built into the qemu-system-riscv64 process, so you might
> > want to check that things seem to work when you enable it...

Yep, we don't even build the 32-bit CPUs for 64-bit.

I'm going to leave this config disabled and we can add a TODO of
fixing up riscv64-softmmu to support 32-bit and 64-bit.

>
> IIRC there's a whole bunch of that floating around the RISC-V port, so just
> tossing a 32-bit CPU into qemu-system-riscv64 is going to result in garbage.
> At the time we originally did the port we though we weren't goin to have
> mixed-XLEN systems, but the ISA now allows for it so in theory we should go fix
> all that.

Dynamically changing XLEN is then another can of worms. Although there
isn't much interest, it becomes more useful with the Hypervisor
extensions supporting 32-bit guests on 64-bit systems.

Alistair

>
> I don't think anyone has looked into doing it, though, as there isn't much
> interest in mixed-XLEN systems (though oddly enough there was a glibc post
> yesterday about them).

