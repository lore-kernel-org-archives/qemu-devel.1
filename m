Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97970206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZd6KH/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97970206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsrkt-00069i-Ua
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsrkM-0005jQ-Q2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:51:10 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsrkK-0007Py-3B
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:51:10 -0400
Received: by mail-oi1-x243.google.com with SMTP id j11so32904361oiw.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NWlbCoZnqYGdfmKtiNBaJt2fa1fk0EPg7+EaCPHqiyo=;
 b=DZd6KH/GH8Hlh32O71st9p/qhJu5OXtUDAuwLjq1OB1Mjk3ZrpvIUVN39OTGn+/6EL
 V1NyMOjW15OTY+2wp/CpMcDKFq3iIH8wI5VPkzGJWBgMbhA5VT2Quk9A9PE6YjrIgyU5
 aTwJEEFB4H5f1F/5UhrMzi+kyGfRJY7Qnq11ZZr4QcLNtvyoiSn4yZXwC66fpx65Qs/W
 o87hwvOLS/+ajhszzdTBHWNaSxy8qv8VbL816v9shzaHo0Mwee8+cm2hyldOMYlzsAwQ
 fN6F5IPW71ilj1nNW6jGKeO/hRDEP35kZqDj5cpSgGWGMNaFInoXQjzqGX2XXA0j86wt
 jEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NWlbCoZnqYGdfmKtiNBaJt2fa1fk0EPg7+EaCPHqiyo=;
 b=NR7/QHbbolE+P72QKXisTy3/I/NeY4wivfEOAlPjqTwRrLiDq98675NmoLugGgjP6C
 VwVuNghmk0VZyrNxR19npMd7s92ESqpMTHoC1Oxbn0KpW6f7cbXWU9NJoBnx8tlxGv8Q
 0ACFihCXOIZD6Nk9TMyqXJD6JVquqztPvhqbeVK2uJMvPGUkPAMz8rexrV9VJcNZAEBS
 ucePopYOwa3CqgX47aeX5QLP+8apZmOL+JbbyW+SOqMjnBYKEZ5yq5FSZ892FBwXfBTv
 QRxf98CDRAcQ2DjwRBrMs9QFliyS/Qb7GlX3LpFyss1mh+pb4/v/PYVF9sVu8erXH3sQ
 a6Ig==
X-Gm-Message-State: AOAM532skJQ5LnPXfl0vTb8Khi3NWJLDo8ADC9J91dY+qtZBYsiwRLKG
 9iKzOxYVS6Yv0qmlZkF0RrO/uIN/Gq0M9tEKdAhukQ==
X-Google-Smtp-Source: ABdhPJxNcsG0+k+gXVBrLPDY97db6l/8/9Sxsfkq6zEYpCkTn0gu+6MjLB1WQ8C8wwR+kUHo+TPL/jknB95Xp3JPyYc=
X-Received: by 2002:aca:2819:: with SMTP id 25mr3971524oix.48.1594144266715;
 Tue, 07 Jul 2020 10:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200704182750.1088103-1-mst@redhat.com>
 <CAFEAcA_LrhvLmbwsSrhHUYZ+z9EZoDZwct+s3xfoaGLyLkOPfg@mail.gmail.com>
 <20200707080049-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200707080049-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2020 18:50:55 +0100
Message-ID: <CAFEAcA_th3hhXcnyt2qV+rQNV1PgF62B5+=sEWzJKfHYj2=ooQ@mail.gmail.com>
Subject: Re: [PULL v2 00/41] virtio,acpi: features, fixes, cleanups.
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 13:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jul 07, 2020 at 12:40:38PM +0100, Peter Maydell wrote:
> > On Sat, 4 Jul 2020 at 19:29, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > >
> > > v2 of the pull, fixing non-Linux builds.
> > >
> > >
> > > The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
> > >
> > >   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > >
> > > for you to fetch changes up to f7d98068bf7a0913744dd4ac0a28e8c841df2af5:
> > >
> > >   vhost-vdpa: introduce vhost-vdpa net client (2020-07-04 11:13:50 -0400)
> > >
> > > ----------------------------------------------------------------
> > > virtio,acpi: features, fixes, cleanups.
> > >
> > > vdpa support
> > > virtio-mem support
> > > a handy script for disassembling acpi tables
> > > misc fixes and cleanups
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > > ----------------------------------------------------------------
> >
> > Hi; I'm afraid this fails to build on 32-bit:
> >
> > /home/peter.maydell/qemu/hw/virtio/vhost-vdpa.c: In function
> > 'vhost_vdpa_dma_map':
> > /home/peter.maydell/qemu/hw/virtio/vhost-vdpa.c:48:23: error: cast
> > from pointer to integer of different size
> > [-Werror=pointer-to-int-cast]
> >      msg.iotlb.uaddr = (uint64_t)vaddr;
> >                        ^
> >
> > This should probably be "= (uintptr_t)vaddr".
> >
> > thanks
> > -- PMM
>
> Precisely. Sorry about missing this.
> I made this change and pushed to the same tag - don't want to spam
> the list for a small thing like this. Can you pick this up pls?
> Commit 849c48004df0e123b53fe9888770cb4f6eb5e8ab now

Sure. (You can always just resend a new v2 cover letter without
all the patches; that's what most people do for minor respins.)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

