Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59682C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25151206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Byhg+zOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25151206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY56r-0007Oq-Au
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY55u-0006BK-T2
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:51:31 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY55t-0004ht-KX
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:51:30 -0400
Received: by mail-oi1-x244.google.com with SMTP id t199so14603418oif.7
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fffYlOjj/vQkdA3oSh5IEdQf1eF2J+wkUp4CVQxNbFw=;
 b=Byhg+zOStRJdeK67AUq9rtM7LBZsc+Cvt8xAtgPQqeeWoUf7QZadT7Z3la8LcEhPlr
 r1AiFY03ejjkUWoaEQ3vjO9dmaGaamboIjLzKj7EMUD1spf0PLNE6BkwEn2ji8tshc9/
 tYfrrGQJ5BDyU1beelef2xk4ZwKkNTm69/cxj681/CXKiS9lJSCreS79hZjWQg5mKHuj
 MnQDjglBc62/GJxbHBBMTu2jd2uFLKH/zcTDiJ9wtDAlFv0Q6Iu+uTfFMjKkNzqf/NDL
 rTad87f+kQg4vMhrd5OOmxbG5/ljA9QatUo0RQP4VEkMk6AX6K+tnbRt25tAtOI9HStk
 lyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fffYlOjj/vQkdA3oSh5IEdQf1eF2J+wkUp4CVQxNbFw=;
 b=hpgW1VEjYp9UTg9HGXZXD8/PwAavOd21T8PoiNJWMMnN9ePz6MOsRkWNN7vflDfRMA
 wU4MbmUk5HWERI+0GCJppig0bHmWaK/zbBFq3n6HzB2shM5+Ts2QAdEi/91hj+v0Y+uH
 bkAzgVMPenjWnm+Gvl/XKDi+7wa1i3Gemu8zc3T7jehEu/e3HaNU1ZNZRYglgnR1815S
 MaGUxc5/dJSW88FMb4B4EjAFV0yGwPHSnpmt0CZZAI5IFsS9abr9RMBgHX2WzLUNnQgI
 kCp5Cqq/KccVUeWb9DQxKKKqMgDtZyMFbC7RTTSCyhZX9woxGawLOcgxc0mOSrWenJpQ
 mkdg==
X-Gm-Message-State: AGi0PuatIJWnb5sRKozSO4BC1R4F69iXYqnTSVOaVxe6Repv+HK4CiHy
 2jZymLbYUMAjB4Ngq62Mgb69KCxaE2whT6GIEUvpZA==
X-Google-Smtp-Source: APiQypKDK0uA4p7HbVz6OUzr4IA0ilj3sJy9IylHmtjvJykhwMB9TVZ9yrvBIjneV5TaEFqfuUEK0GOr9dxv+ZBhUaU=
X-Received: by 2002:aca:895:: with SMTP id 143mr19060802oii.163.1589190687722; 
 Mon, 11 May 2020 02:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200504081953.245912-1-joel@jms.id.au>
 <CACPK8XfTg1OucOEeiUE711_+-Pz4daYCrPmKFDTj25keeM8aMQ@mail.gmail.com>
 <3e8500ab-929b-a3f0-f8b6-fcf8ea5c1306@kaod.org>
In-Reply-To: <3e8500ab-929b-a3f0-f8b6-fcf8ea5c1306@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 10:51:16 +0100
Message-ID: <CAFEAcA-DksOUWgyi7AfnUjNNk40Zd1kzkgXtJVXfFSdM=outJQ@mail.gmail.com>
Subject: Re: [PATCH v3] aspeed: Add boot stub for smp booting
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 15:27, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Indeed, with OpenBMC kernel v5.4.32-260-g7dc9442bbe7d and wfi (patch v3),
>
>     [    0.045214] smp: Bringing up secondary CPUs ...
>     [    1.178127] CPU1: failed to come online
>     [    1.187309] smp: Brought up 1 node, 1 CPU
>     [    1.187590] SMP: Total of 1 processors activated (2250.00 BogoMIPS=
).
>     [    1.187786] CPU: All CPU(s) started in HYP mode.
>     [    1.187850] CPU: Virtualization extensions available.
>
> When using wfe (patch v2),
>
>     [    0.091092] smp: Bringing up secondary CPUs ...
>     [    0.096628] smp: Brought up 1 node, 2 CPUs
>     [    0.096718] SMP: Total of 2 processors activated (4500.00 BogoMIPS=
).
>     [    0.096768] CPU: All CPU(s) started in HYP mode.
>     [    0.096785] CPU: Virtualization extensions available.

OK, I've applied patch v2 to target-arm.next.

v3 looked a bit odd anyway -- a wfi-based secondary loop generally
needs to prod the GIC to enable interrupts for the core before
going into its loop (compare the 32-bit smpboot[] code in hw/arm/boot.c).
But looking at the code in the kernel's arch/arm/mach-aspeed/platsmp.c,
it uses dsb_sev() to prod the secondary core, so only wfe will
work here. If you find that you are often in situations where the
secondary cores are not started and so QEMU is wasting host CPU
in this busy-loop, you could look at implementing a non-noop
wfe/sev in QEMU, though it's not completely trivial because of
all the things other than sev that are 'wfe wake-up events'.

thanks
-- PMM

