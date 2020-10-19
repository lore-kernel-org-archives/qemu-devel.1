Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A1AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5A320578
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABBeemgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5A320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUSLQ-0001Dz-N8
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUSJl-0000Vy-Aq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:23:05 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:41608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUSJg-0006Wa-QQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:23:04 -0400
Received: by mail-ej1-x643.google.com with SMTP id x7so13112568eje.8
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kZKHuv8BTQQ4tfrBI9XKh+O5b9VpR4VudSmi9PcFXmM=;
 b=ABBeemgi/AUNHPOHvbz4EPB42QC+ykjo1sHmt10oLV9j9rLuV0SGbTIr+rHHsUUs4o
 kM9pBb9gStetMoh9kMNkQq21J94BxoPKErbSFtT5fTwGTluxZTN5srh3rfEszf1EpBaG
 HX9wC231JcdYW0TERMCs6Y3ey8fsobBk2X2ojNa+Q8+orjoF3fykRuaAnY/1adiBKoQs
 BsoIy8mZtZbyvUSTlRd3MO7cd1MEzMpfou7EmFYotClSRTsqGFwdm/1Bt6++dR8Hr/Ko
 aqveNTmDlaYJSfGHoIfk+M6Ee5Ms1EXvV4q8Ex3mOpP/ElbldBq7p9sqSw9oqIfZIHBw
 3agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kZKHuv8BTQQ4tfrBI9XKh+O5b9VpR4VudSmi9PcFXmM=;
 b=hDwc6IDzxjhHcoTcoJsFDhe1VSHCc5PR3lSRQseUFXWzojWo1LMuekAcrb+US9VxNE
 KJJw0qnDljCpm4a5qsKTbXMrh6RUAR9T3yIEdtakovxL0W1LTUYukZZvsCyGtmh7MqIv
 KTI1JC6h6+Bce0JRdVlqlQTudk9gMrUPYTtt2cSmIJRJ9BZ1FVtPDlc8DhrnZnJwV6EP
 sBVrLO6+AjGVa3gxkYLFznAzHWmIH+ZGb/pPpi4/3gr/0H2qNe1l5BVphJ6JVFLzNkYv
 8ViDHsO4HJUjjOJnHRQLcVSOL/M2ZUAOhFXJF0N8fJF9ZkH4vtZf9R0Ytmby/Mmbzs3f
 LS5g==
X-Gm-Message-State: AOAM531c9nu78L9ue8HhY0KkR3sH7VdwLxHaSAwky3umItM7lHFJUuFy
 RNSLuMSE9OZWTOFrnday/5bKssqwwvDcz0MHShPAYw==
X-Google-Smtp-Source: ABdhPJwldQXkyR+P+tior8ghce/HgzEnXA4vLCHWREg/AJxd7dCrfZo8hkY+tIMauzdxxaGpaJXGbO2ARedky8YK1vg=
X-Received: by 2002:a17:907:4365:: with SMTP id
 nd5mr17444247ejb.56.1603102979233; 
 Mon, 19 Oct 2020 03:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602943547.git.qemu_oss@crudebyte.com>
 <CAFEAcA8M2n9X0a2bzcc-bZTvh8cMYrQ39mWLUzNAJzkgNe8UFw@mail.gmail.com>
 <3061113.rifjho4eKY@silver>
In-Reply-To: <3061113.rifjho4eKY@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 11:22:47 +0100
Message-ID: <CAFEAcA_1AcW9n949HXtX6QOmYvTRLcMb_PXLtKSG77s=zdzkwg@mail.gmail.com>
Subject: Re: [PULL v2 0/5] 9p queue (previous 2020-10-15)
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 at 11:19, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Montag, 19. Oktober 2020 11:52:38 CEST Peter Maydell wrote:
> > This emits a lot of new warnings during 'make check':
> >
> > PASS 27 qtest-arm: qos-test
> > /arm/virt/virtio-mmio/virtio-bus/virtio-9p-device/virtio-9p/virtio-9p-tests/
> > local/config qemu-system-arm: warning: 9p: degraded performance: a
> > reasonable high msize should be chosen on client/guest side (chosen msize
> > is <= 8192). See https://wiki.qemu.org/Documentation/9psetup#msize for
> > details. PASS 28 qtest-arm: qos-test
> > /arm/virt/virtio-mmio/virtio-bus/virtio-9p-device/virtio-9p/virtio-9p-tests/
> > local/create_dir
> >
> > PASS 54 qtest-i386: qos-test
> > /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p
> > -tests/local/config qemu-system-i386: warning: 9p: degraded performance: a
> > reasonable high msize should be chosen on client/guest side (chosen msize
> > is <= 8192). See https://wiki.qemu.org/Documentation/9psetup#msize for
> > details. PASS 55 qtest-i386: qos-test
> > /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p
> > -tests/local/create_dir

> One warning per test suite run (i.e. per architecture due to
> warn_report_once()), yes. That performance warning is meant for end user
> installations to remind them setting some (reasonable high) value for 9p
> client parameter 'msize' on guest OS side. The warning triggers here because
> the 9p test cases intentionally run with a small 'msize' to guard edge cases.
>
> Would it be Ok for you to merge it with this performance warning for now? I
> can take care of silencing it before 5.2 release. It probably requires to
> introduce a new CL option to suppress performance warnings like these, or by
> finding a way to detect that we're currently just running qtests.

The usual approach is to suppress this kind of warning by guarding
it with if (qtest_enabled()) { ... }.

I'm generally reluctant to allow new warnings in, because then they
never go away and my scripts build up a long list of "ignore this
particular warning" exceptions.

thanks
-- PMM

