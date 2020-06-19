Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4442FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14028207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBxHuZRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14028207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGJH-0008DT-A5
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmGH4-0004ol-Nt
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:37:38 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:44484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmGH2-0004wR-VV
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:37:38 -0400
Received: by mail-oo1-xc44.google.com with SMTP id e8so1855881ooi.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fyeDXqEBNyAx9Xib1lWpJKC+Xr8ELu0s/0geieAm8ig=;
 b=uBxHuZReYPXbdWF6Y2HnaSAmWkxZ8D/eS6HqxXU16+X1Y7y2QKLm9bUK08r72OHdse
 rtzjyWQ3xyKibsFvrOR8N3rGO2SqJUGIFlMDEi2JLgBrUlYaIAoVrgyKxPGMzn1KnJrX
 04Qutu84Qmf3odvy9ml/XIDKZbYxukPiVAOmBYKJeV9XV86yFLevgjZp/86VPjviSsvV
 bfXIc6qY1a0QYkhAlfuVoPMydkQ+FqglHdny2gOT1KUhPWoDsU0ChqDK9uHYfCnypbcq
 BYvH1Hv1/9IoawqDuFqQ7IDd9L5mNvr88qtit6ndq3P/qzZNrSlfaVGjkKt1nsrm7CHN
 16qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fyeDXqEBNyAx9Xib1lWpJKC+Xr8ELu0s/0geieAm8ig=;
 b=AGaw/VhhN/OOK8Oyn8wgD5Y0/v2aGfdgA/Ln48Bh/4E20N01JmVymL32RY+kxmbHIV
 5jeUj0X4pY4FuaaxUwxfwOgnK1UEliGADgqTTJ6ZfYHGlnrZieoG8DBBpOoopDg6eNUL
 vmqw1NbdkWe0s8zGdhBqkJoyd9wQO0ZL6etUMVsipIyegx6lWS6Sk2itQtdhCQ659Plv
 jkkIq+Mjf2Y+qVrvcDm6D4Fe9vkwmws2QVfJHyIWi4ubizVdgmiOryHSYw+JOOTOOJ9n
 /+RXXNVtZK0ipeNyAv6FbUbagFjWT/8gPlnSK4RNQ8QDLv7sSc/5BlsV9QuOxjbnm4xn
 JXnQ==
X-Gm-Message-State: AOAM530E3ShjLe8vrC3lLXnuUlL6j5EHc52iwJLTNQevCUtMj1oD9BBv
 cHb6eZWgcd2wZ5++Obc3iLpmvrnJnKURVeqCJABAQQ==
X-Google-Smtp-Source: ABdhPJyEv6SN0nERgx7k6MdKz6TDhHJxp9vioZGJ0cSRQigWJfaNUTllrYnjhp0VT6fMaiz1OZUvru4/1XUStmw5U5s=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr3049170ooi.85.1592570255656; 
 Fri, 19 Jun 2020 05:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 13:37:24 +0100
Message-ID: <CAFEAcA9VKbE89N3YkpN4VhcEHD92=fGb3W_-mgqd+yY0rc0=6g@mail.gmail.com>
Subject: Re: [PULL 00/32] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 at 07:34, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit eefe34ea4b82c2b47abe28af4cc7247d51553626:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20200617a' into staging (2020-06-18 15:30:13 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200618-1
>
> for you to fetch changes up to fad6a8463510ff5e0fb31bb451a6c3218a45d179:
>
>   hw/riscv: sifive_u: Add a dummy DDR memory controller device (2020-06-18 23:09:16 -0700)
>
> ----------------------------------------------------------------
> This is a range of patches for RISC-V.
>
> Some key points are:
>  - Generalise the CPU init functions
>  - Support the SiFive revB machine
>  - Improvements to the Hypervisor implementation and error checking
>  - Connect some OpenTitan devices
>  - Changes to the sifive_u machine to support U-boot
>
> ----------------------------------------------------------------

Hi; I'm afraid this fails "make check":

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=riscv32-softmmu/qemu-system-riscv32 QTEST_QEM
U_IMG=qemu-img tests/qtest/qom-test -m=quick -k --tap < /dev/null |
./scripts/tap-driver.pl --test-name="qom-test"
PASS 1 qom-test /riscv32/qom/opentitan
PASS 2 qom-test /riscv32/qom/spike
PASS 3 qom-test /riscv32/qom/virt
PASS 4 qom-test /riscv32/qom/none
qemu-system-riscv32:
/home/petmay01/linaro/qemu-for-merges/hw/core/qdev.c:438:
qdev_assert_realized_properly: Assertion `dev->parent_bus ||
!dc->bus_type' failed.
Broken pipe
/home/petmay01/linaro/qemu-for-merges/tests/qtest/libqtest.c:175:
kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)

This is a recently introduced check that all devices created
get realized; probably somebody's added a new device in this
pullreq but forgot a realize call.

thanks
-- PMM

