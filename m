Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A81C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B09206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PQtXIKZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B09206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWM3-0003Bm-DN
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jVWJO-0000lC-GN; Mon, 04 May 2020 04:18:50 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jVWJN-0003IQ-Go; Mon, 04 May 2020 04:18:50 -0400
Received: by mail-ed1-x541.google.com with SMTP id g16so12774886eds.1;
 Mon, 04 May 2020 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bLCUp/I0QrPUhwA9bNV0OC52nLmF//cN0+lWiY3eQsc=;
 b=PQtXIKZ3fYBX+63MjabmtjR9XJaz8Q+RR78xFsplDTC9Bkpq3d3QokoE2sQudCMivN
 2T52ejGF48S/Bg6R/3t+qDm6b/hbobVePW7GvToCuEdiswDxSuxvZ/PX6lfBKbOMV+jy
 d2vuUBmMsFh7qgGp3Fan7niRHSbViq7/YJGdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bLCUp/I0QrPUhwA9bNV0OC52nLmF//cN0+lWiY3eQsc=;
 b=Qu/HeHNr3vzOlKoMiroQ6ev+WJKqunpeBsUc0paM35QEQjLW8HN1vALC+CTC9BHSdC
 x4S2pdIbEWGgDh5aDgQ5UiZEBG7IXg0+eop/gaCp66ya5YD1/sMhpNGsXpuDAYa5n5Dd
 WdX8T+h+sdwDxjq6VtF3PZxcI3sO68QiVF0GaymWKcrUuhSlvMu263A2TYC4GhBpOTO5
 +3dEMz6306q/+6TFD0CzlCZe66ZXRD+BFkastXRPZNmgNTYin/YyxdAis/+RIvSWOjWa
 TdDHdyy+V6ftfJHJdV5zawmWRGXBQfwSk6aOaIDbCcguBgj03BaIpvvkBs+ehakoetnz
 RRTg==
X-Gm-Message-State: AGi0PuZT/MmfTUQy/2NlVNkrdo47cpnlbOYozdhYdOfkTYjUGxbLOMNJ
 JC9bp/KW3Zweis1SYuqVQ9ZkizPSF5DDRc92DcVBjA==
X-Google-Smtp-Source: APiQypJPsNkuISyYdRGsdfQdtx0Q3u7IWv7V+v6gfzrpw2pALbyC+moySjcvLyth1SLL0Q8LnE2FXaxVvHbHIotdEbA=
X-Received: by 2002:a05:6402:688:: with SMTP id
 f8mr13477687edy.233.1588580327345; 
 Mon, 04 May 2020 01:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200409063137.803522-1-joel@jms.id.au>
 <CAFEAcA8M06TFD4d8jLe-w24PMUGDH_sRXhf8TV25JuTV1ig2jQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8M06TFD4d8jLe-w24PMUGDH_sRXhf8TV25JuTV1ig2jQ@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 4 May 2020 08:18:35 +0000
Message-ID: <CACPK8XceOO9G=4eDjGz4n0VR3T25Kv15rAKdV+__okciCA-CNQ@mail.gmail.com>
Subject: Re: [PATCH v2] aspeed: Add boot stub for smp booting
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Apr 2020 at 16:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 9 Apr 2020 at 07:31, Joel Stanley <joel@jms.id.au> wrote:
> >
> > This is a boot stub that is similar to the code u-boot runs, allowing
> > the kernel to boot the secondary CPU.
>
> > +static void aspeed_write_smpboot(ARMCPU *cpu,
> > +                                 const struct arm_boot_info *info)
> > +{
> > +    static const uint32_t poll_mailbox_ready[] = {
> > +        /*
> > +         * r2 = per-cpu go sign value
> > +         * r1 = AST_SMP_MBOX_FIELD_ENTRY
> > +         * r0 = AST_SMP_MBOX_FIELD_GOSIGN
> > +         */
> > +        0xee100fb0,  /* mrc     p15, 0, r0, c0, c0, 5 */
> > +        0xe21000ff,  /* ands    r0, r0, #255          */
> > +        0xe59f201c,  /* ldr     r2, [pc, #28]         */
> > +        0xe1822000,  /* orr     r2, r2, r0            */
> > +
> > +        0xe59f1018,  /* ldr     r1, [pc, #24]         */
> > +        0xe59f0018,  /* ldr     r0, [pc, #24]         */
> > +
> > +        0xe320f002,  /* wfe                           */
> > +        0xe5904000,  /* ldr     r4, [r0]              */
> > +        0xe1520004,  /* cmp     r2, r4                */
> > +        0x1afffffb,  /* bne     <wfe>                 */
>
> Note that unlike "wfi", QEMU's "wfe" implementation is merely
> a 'yield', so a secondary-CPU boot loop that has wfe in it
> will basically be a busy-loop of those vcpu threads.
> (This is why the smpboot code in hw/arm/boot.c uses wfi.)
>
> I don't suppose the secondary boot protocol on these boards
> is such that a wfi loop will work ? (Depends on what the
> primary code in the kernel does to prod the secondary after
> writing the magic value.)

Thanks for the review.

I chose wfe as it's what aspeed's u-boot has. I don't have a strong
understand of this area of ARM processors, nor do I have any insight
into why that choice was made.

I did some testing and wfi in the qemu stub works fine with Linux so I
will respin with that instead.

Cheers,

Joel

