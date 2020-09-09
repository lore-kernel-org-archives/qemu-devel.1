Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3831CC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A34F218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFuWk4t0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A34F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5UJ-0002OR-MA
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG5KR-0007gu-9C
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 15:00:23 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG5KO-0001VI-Mz
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 15:00:22 -0400
Received: by mail-ej1-x643.google.com with SMTP id z23so5054947ejr.13
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GYKtxsm1tUAtAz6PMSmwpL2uACQIT8bZcCYu+VH2lIc=;
 b=hFuWk4t0A3aTF9sYm14hmOBFnabmcsSeVJ8PpensFExc4GSDjxvjdx/huDK5/YUf+H
 hboFFnx7ugRcpe48hQrVb8xAIOq7TdWFKigBjkYMZFBsQP+7Deb+JhZKP+mzRRvJ3fBq
 1f65yUB9SEZvGKIT/sBEVK+q59cH5JvUH4snTC0mFU8NYszndTRtOIXNF4m6O1FHkXst
 uwsfaejmTsGw1Reib9DnYynBA4aAGfHUSgcseYIgceLWg5zZlHJxAIp04Q25wSzUc2q2
 h99sIpXRU7z/BTU2Cd3DE10YBVOG/scty9sJm8NAoj00IPtA+oesFKnu06E9iPk+MEY5
 3S2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GYKtxsm1tUAtAz6PMSmwpL2uACQIT8bZcCYu+VH2lIc=;
 b=f00UX0NPyDSmcylWNm3k43vdsOd59E8kvjfxVoTxv19V1cBYjAtmp49reBTj0Iaz7B
 Xfn+X5uT1184V32zS+p0FI6S+ElQmmyNdeya4+pNYDgOwUfbzgzscGMwqKBBZn0iiXeY
 gfNvqeM4GrP7atEE9e/iX1YX/AELS0TU8Qt61MLiHsBo7Z3n6Pt+TPeeHizZiVg1Y+Us
 E1xjpLwSAZ+zijX4iAW4RvB+cXoTK9sVcLCtBrxvbZ+qKgVsFGEzsIf3yZiinko45qA2
 IDDFjl2MPHElASPvfCJQf4sI7fYYj+O6b6rTFo508kIalXEwjjpLuIoz7XCG78i3DNwE
 hY7Q==
X-Gm-Message-State: AOAM533QMdF6GJtmKLwOLmm9J9+wMelk7ssuI3R+Qf6EXcMvFcSM7MRK
 +e4NyOqpIbZBGRyUgMctpAY3O3maAiTDtY4FECrIBQ==
X-Google-Smtp-Source: ABdhPJwpviQemSony77xNAOOGL1Jpjwd/Lb5urQfWp/dmPQy5RO88Zfn/2sph0vzxZ23f2EzAe1oYQ/NVJU4GY8hnCY=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr5141715ejb.4.1599678018448; 
 Wed, 09 Sep 2020 12:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590704015.git.alistair.francis@wdc.com>
 <0ab3cecbe801f9e14ad1a5447d02483b9008fdbb.1590704015.git.alistair.francis@wdc.com>
 <CAFEAcA83=4=EhtQLmGJn5Z_PVZaDyo7pMwdX-9fTVUkVKe7Acw@mail.gmail.com>
 <CAKmqyKPryJP5g4RXq1uCbYKQX3C+9yzjjqEH4i88L6Vf2gW7Zg@mail.gmail.com>
In-Reply-To: <CAKmqyKPryJP5g4RXq1uCbYKQX3C+9yzjjqEH4i88L6Vf2gW7Zg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Sep 2020 20:00:07 +0100
Message-ID: <CAFEAcA9RcbWeM=hhUNH=Exdp_QT4s0GcCJdrpcvWkv2ea+o7cQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] riscv: Initial commit of OpenTitan machine
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Sep 2020 at 19:00, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Sep 8, 2020 at 7:52 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > ...shouldn't the riscv64-softmmu config have CONFIG_OPENTITAN too?
> > The usual principle is that the 64-bit executable can run the
> > 32-bit boards too.
>
> I didn't know that was the general case. I'll send a patch to enable this.

Somebody on IRC suggested that the riscv code currently
assumes that #ifdef TARGET_RISCV64 implies a 64-bit CPU,
ie that the 32-bit CPUs don't actually behave correctly
if built into the qemu-system-riscv64 process, so you might
want to check that things seem to work when you enable it...

thanks
-- pMM

