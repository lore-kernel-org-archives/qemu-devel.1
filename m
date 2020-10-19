Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA920C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2073A2224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M03rW8Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2073A2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kURsN-00045c-Rv
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kURqb-0002pI-Be
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:52:57 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kURqV-0002rn-Dp
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:52:56 -0400
Received: by mail-ej1-x641.google.com with SMTP id ce10so13028197ejc.5
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jpxie+OfdG4FXWyidsq0ZisbiaH9hwo4zcUzyQm9nB8=;
 b=M03rW8ZkLecz6C7dPAKpDjIWMo6B/X/MKvSJTSGr3Sy3tphOm2yma6MtFnLJjm8vPD
 rr1MnzkjZOlp40bl1UBx6BMx1upkDIdd/PQDie5svVyaQt+IUbrXfBYbK2sgl72J7raH
 lY3DROKlUqK4MZd8xFCumU351oasBSqx4xhhkjIcoWqbBoVC8NVxJ6tax5xqAHzlgZtO
 R71//gNSn2Wr9jVcHPw49MWdum9momdpZQN4zzPtrkDFGS2nOh/n1YkycqNGbdZumq0c
 EHB1USEQKnWPUJmyFwTKd2pcbjTr/GaqXXLmVenjQDgCaDzgEiDhOLrDl3MndjaLyj74
 UfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jpxie+OfdG4FXWyidsq0ZisbiaH9hwo4zcUzyQm9nB8=;
 b=Gq58iev7Z9EIn2F3jcInWDsZESQKAiNIdkn2RtzN5wFenxIQf96ZwabETO4tUT4FA8
 rmxksSoHURSFalUa3+T4sMCN0Vq4VWMaFmI1iGIXZZ0vhmRkCNXDS3jgBw7Q+YCSo20Q
 2GTmRPyw4l45MQzW8F0520UvN/BLVEE6YpvIsH65TL2VxGLPs8t8kj6nkIZBkb9ONd5O
 Z6F4hDyK3uHdMEGFm/LQgWsG9wc9vufqWdR/G7NvWVgFGnS27u4AJW+Md+er2BcxOtg2
 B3BoNLCKjjP1KV2mIoRZEQJqMcjGX9TLQyHTK6HiinCfVrEpRZ3Bg7SyEG/xm0TNe0Ou
 rUPA==
X-Gm-Message-State: AOAM530HnLBEA2euIcaVWK09mJW8+6EwUMlrjBUIdzNwjSUjhZn6ceCl
 +UayMjujaghoYdIVkK4V50B68q0FvQhWfeZn/iK1COYpLbFL3Q==
X-Google-Smtp-Source: ABdhPJyA6thkUjHvnt+im6mVtW269zv1v8LdwKYQkV1/xurhIZL9sNczbWn9Lc5jmAHjyNsBNdpDH6DTcP0ibfTI/jc=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr16599247ejb.4.1603101169473; 
 Mon, 19 Oct 2020 02:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602943547.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1602943547.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 10:52:38 +0100
Message-ID: <CAFEAcA8M2n9X0a2bzcc-bZTvh8cMYrQ39mWLUzNAJzkgNe8UFw@mail.gmail.com>
Subject: Re: [PULL v2 0/5] 9p queue (previous 2020-10-15)
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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

On Sat, 17 Oct 2020 at 15:23, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit e12ce85b2c79d83a340953291912875c30b3af06:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-10-16 22:46:28 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201017
>
> for you to fetch changes up to fa4551e3f4416cc8c62086ac430b1ceb4f03eb6b:
>
>   tests/9pfs: add local Tmkdir test (2020-10-17 15:58:39 +0200)
>
> ----------------------------------------------------------------
> 9pfs: add tests using local fs driver
>
> The currently existing 9pfs test cases are all solely using the 9pfs 'synth'
> fileystem driver, which is a very simple and purely simulated (in RAM only)
> filesystem. There are issues though where the 'synth' fs driver is not
> sufficient. For example the following two bugs need test cases running the
> 9pfs 'local' fs driver:
>
> https://bugs.launchpad.net/qemu/+bug/1336794
> https://bugs.launchpad.net/qemu/+bug/1877384
>
> This patch set for that reason introduces 9pfs test cases using the 9pfs
> 'local' filesystem driver along to the already existing tests on 'synth'.

This emits a lot of new warnings during 'make check':

PASS 27 qtest-arm: qos-test
/arm/virt/virtio-mmio/virtio-bus/virtio-9p-device/virtio-9p/virtio-9p-tests/local/config
qemu-system-arm: warning: 9p: degraded performance: a reasonable high
msize should be chosen on client/guest side (chosen msize is <= 8192).
See https://wiki.qemu.org/Documentation/9psetup#msize for details.
PASS 28 qtest-arm: qos-test
/arm/virt/virtio-mmio/virtio-bus/virtio-9p-device/virtio-9p/virtio-9p-tests/local/create_dir

PASS 54 qtest-i386: qos-test
/i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/config
qemu-system-i386: warning: 9p: degraded performance: a reasonable high
msize should be chosen on client/guest side (chosen msize is <= 8192).
See https://wiki.qemu.org/Documentation/9psetup#msize for details.
PASS 55 qtest-i386: qos-test
/i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/create_dir

etc.

thanks
-- PMM

