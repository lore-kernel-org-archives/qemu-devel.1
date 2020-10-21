Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC33C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09E7221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ygXngiOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09E7221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVB3h-0001kj-N3
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVB2w-00013x-Na
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:08:42 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:38456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVB2t-0002CM-67
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:08:42 -0400
Received: by mail-ej1-x643.google.com with SMTP id ce10so2357914ejc.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=61FqqMwxVkmnjHv48IxfK7T14oFK46P4hcmamWPEeSk=;
 b=ygXngiOerx2QCBpFCLVGeQafzqcNWQnRrwMjCiRIIpGFx9uBt8gBXd5CZzVyJBOgXZ
 Y/6Mxlc61anPx6PqvGj5QTS6nePML5i4fUgaWijBNChmZP43DUYTh5iPwSVdu4HdmFPc
 4TDagd8AchvoDmNxpwXB4GMSUUbXwv3VxXiuXp/g2OO121hwjg2j1pDljCPISJP+sw/F
 K+510Luv9HhJD3l2xYwO8McF5uW08Ny87gjpSm7t4jsK8l5PxKQhweLJfazFQGge+2BS
 hK+63k7xD8B2yK2XYLBhPoJoUCGYvzZGkCyytAyc7JqMXuAn95bXEI5OwJD+AdcScz22
 tNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=61FqqMwxVkmnjHv48IxfK7T14oFK46P4hcmamWPEeSk=;
 b=UCREJ+gPjg6/sYz18UBMkLiAZylP6nQ47P3F+mZbscbptnkrcwtoyAXO184NFCnztK
 618J6FlNON6jXv7z+MhE+wl5vhK0iYhz8cC54xRmT+EtBiaREgx4G3gNDN2zWlEyXNCY
 o9DughK7QxDxWh9Qd+fZIMq89T3a+mdaxX0NWVWs4mF5o9GlVUR0jLnQTW+3q9+j7Rse
 Mjhl/zR974/4otyakJoAWUqOyeCX0FiydnpMNa7lM4vYTtdj/MhmF+tMgx7kGWbkuNtN
 FblVjKAwxsmkbhZUC8KguSGdFVdJNKwUBaRaWg+Pk5JsALY6gee49kc206/6pzOxwGZG
 WMfA==
X-Gm-Message-State: AOAM53018m1dx1BStDi3uMjTalr7asXPisVgd7VCzeAsImU7rBbNuGNJ
 6XgXmtON17TuAfm77/6Q+vYfqU/vr5yMlDnlIB/UtSgtpKA=
X-Google-Smtp-Source: ABdhPJwjXSk/N6hhfW05eKC5BkbvmgXap4yA2QR/XfeD2QKnAK7MpjT+OeJia72c9OpR/XEk0CgEpYoTMXiPpQ9lmcY=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr2557586ejk.382.1603274917169; 
 Wed, 21 Oct 2020 03:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201020201119.9308-1-peter.maydell@linaro.org>
In-Reply-To: <20201020201119.9308-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Oct 2020 11:08:26 +0100
Message-ID: <CAFEAcA-OUF1rSjREJEFrc8f1JLR=XCsuOMg+V6TRYA-Xa=Ag1g@mail.gmail.com>
Subject: Re: [PULL v2 00/29] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 at 21:11, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v2: dropped linux-user bti series.
>
> The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f89:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020' into staging (2020-10-20 11:20:36 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201020-1
>
> for you to fetch changes up to 8128c8e8cc9489a8387c74075974f86dc0222e7f:
>
>   target/arm: Implement FPSCR.LTPSIZE for M-profile LOB extension (2020-10-20 16:12:01 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fix AArch32 SMLAD incorrect setting of Q bit
>  * AArch32 VCVT fixed-point to float is always round-to-nearest
>  * strongarm: Fix 'time to transmit a char' unit comment
>  * Restrict APEI tables generation to the 'virt' machine
>  * bcm2835: minor code cleanups
>  * bcm2835: connect all IRQs from SYS_timer device
>  * correctly flush TLBs when TBI is enabled
>  * tests/qtest: Add npcm7xx timer test
>  * loads-stores.rst: add footnote that clarifies GETPC usage
>  * Fix reported EL for mte_check_fail
>  * Ignore HCR_EL2.ATA when {E2H,TGE} != 11
>  * microbit_i2c: Fix coredump when dump-vmstate
>  * nseries: Fix loading kernel image on n8x0 machines
>  * Implement v8.1M low-overhead-loops


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

