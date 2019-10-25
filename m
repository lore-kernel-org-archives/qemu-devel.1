Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36338CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE5121929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xv/S7XCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE5121929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNyNV-0004EW-30
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNyMa-0003WB-QM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNyMZ-0002JV-D3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:06:40 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNyMZ-0002JH-6t
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:06:39 -0400
Received: by mail-oi1-x241.google.com with SMTP id s71so1457256oih.11
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 05:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XrJZ5Upat20NnQrE3c+6xlKbmz6+F99IqJyeX/iGlpo=;
 b=Xv/S7XCp5IYCu/bj1oeYZFcWfOfCr2u6tZEL0S3sojegoQ2vZi4EJWaqdS6v2akBRu
 qMkE1LNVQduee8FIF7frI7B1u8YeWayEFyy/mrUNhEKOsfuqgQ2yBCat0jIkTqYOBjF3
 yvXrLtIOAYp5oYZyOLn4g87Z9ePgydxofGgfg2dPyEc6lsaNoFhoxiH88lwPGpUYgBcL
 i0NJDzPDA/JNCDAcR3bO2pAUU4u5141vKLTl9am7G0r9tqNRk7kyCqGv2AU4D5hVzBdQ
 V6ji+jktEhUXVjzh9lx3l+Je+Fx6u1EpZgB20aX5pbF7Kq0UyrWgAbJk4Il18flPuzHS
 JXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XrJZ5Upat20NnQrE3c+6xlKbmz6+F99IqJyeX/iGlpo=;
 b=nAil2zqv9M2M7HVjVUOrJBlkR2usDn29MLPbkloTv6NjOiYJI391mm1C+SrxOfVPUg
 e+QfQNh2nCJMuDfw56A7NBKgPIhou4VxZ3XnskuAYgxpGrcgEP+0VuZ2KzJcA1tvMIqr
 OCgAHw5MnboO42OgfLQvoLtNbh5RDv97KbAib90NCdmaOeEN/hvBxArwTEd9poMmHx3g
 KT6glJE5X6Dq22gaiF8XNbqusOThnsC4Wt4aQzimVL8Kdg0YfWMW2YB9xIYAht6XamAU
 z3fkuRUHPgzML6JNr+xB6aA2Ph5HmE1sCCvV5HG8nZMvNONqeahrgioEgRSgbCUJN0pb
 0TLQ==
X-Gm-Message-State: APjAAAWpbRhmg3fgp7XQeFWT/Gru/TnXGAbbXG69uKlagQqIg8UNmibN
 rSuL/xrb7UudgulZMu51Pon5k2DVpXXbIPs8uXE8Fw==
X-Google-Smtp-Source: APXvYqx14+9iGIOuDNbFI0CEcx1ayIbAwq43UODovKcay0aj8tmI+9BvMGRcYtry7TvYCQDPd1XZeuHc0iBCKoId8R0=
X-Received: by 2002:aca:451:: with SMTP id 78mr2771712oie.170.1572005198127;
 Fri, 25 Oct 2019 05:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191024121808.9612-1-drjones@redhat.com>
 <CAFEAcA9ehcuktCTGR0xpTvZegUkr99H62F_fiT7RY_L_dqgN4g@mail.gmail.com>
In-Reply-To: <CAFEAcA9ehcuktCTGR0xpTvZegUkr99H62F_fiT7RY_L_dqgN4g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 13:06:26 +0100
Message-ID: <CAFEAcA981jAU6F9RRWBuzg+_5JDrd-ip-L_awtzdZFqKmewMvA@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] target/arm/kvm: enable SVE in guests
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: m.mizuma@jp.fujitsu.com, Beata Michalska <beata.michalska@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 at 14:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 24 Oct 2019 at 13:18, Andrew Jones <drjones@redhat.com> wrote:
> >
> > Since Linux kernel v5.2-rc1 KVM has support for enabling SVE in guests.
> > This series provides the QEMU bits for that enablement. First, we
> > select existing CPU properties representing features we want to
> > advertise in addition to the SVE vector lengths and prepare
> > them for a qmp query. Then we introduce the qmp query, applying
> > it immediately to those selected features. We also document ARM CPU
> > features at this time. We next add a qtest for the selected CPU
> > features that uses the qmp query for its tests - and we continue to
> > add tests as we add CPU features with the following patches. So then,
> > once we have the support we need for CPU feature querying and testing,
> > we add our first SVE CPU feature property, 'sve', which just allows
> > SVE to be completely enabled/disabled. Following that feature property,
> > we add all 16 vector length properties along with the input validation
> > they need and tests to prove the validation works. At this point the
> > SVE features are still only for TCG, so we provide some patches to
> > prepare for KVM and then a patch that allows the 'max' CPU type to
> > enable SVE with KVM, but at first without vector length properties.
> > After a bit more preparation we add the SVE vector length properties
> > to the KVM-enabled 'max' CPU type along with the additional input
> > validation and tests that that needs.  Finally we allow the 'host'
> > CPU type to also enjoy these properties by simply sharing them with it.
> >
>
>
>
> Applied to target-arm.next, thanks.

Fails 'make check' on my aarch32-compile-in-chroot-on-aarch64
machine:

(armhf)pmaydell@mustang-maydell:~/qemu/build/all-a32$
QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm tests/arm-cpu-features
/arm/arm/query-cpu-model-expansion: OK
/arm/arm/kvm/query-cpu-model-expansion: qemu-system-arm: Failed to
retrieve host CPU features
Broken pipe
/home/peter.maydell/qemu/tests/libqtest.c:140: kill_qemu() tried to
terminate QEMU process but encountered exit status 1 (expected 0)
Aborted

Dropping again :-(

thanks
-- PMM

