Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14655C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2540620637
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5NIEc4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2540620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTGK-0004lP-W2
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYTDy-0002xg-Tt
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:09:44 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:40058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYTDv-0004lT-NM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:09:42 -0400
Received: by mail-ej1-x643.google.com with SMTP id oq3so6410805ejb.7
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jGCl4PWS5uo6m2PFMVXPiLo1Y/4zUOWjNgXlPDjSGCk=;
 b=L5NIEc4jNgPmYPDiDcmvIRc4ZJcGRC9GjLifF1DxUtL2cBNsMzizK1g2HmLaEq9hYZ
 W6mF0kCkOjL1Q7DmLQXjJ1/XXY4e+YM8rpu4KOtJ/xSMRE8WZFVMzcOkbgiGOfAoy27v
 svVvPuqkUKo3BIJY3/TbssAjpFlCLo46Cc86Jh02D5yw5Fpf84eSaoZjWYKaYUoWuhyl
 sZyO+K7LX0IKllSwgsS1J+LpV1KydILsOA1zmdQJMc6T0/pMkjJCn6FBWMQzSqRwU4Vg
 65AwvSWLEJaI6GaO3apnyaVunThG9l+Ned1LoBF3XmgzFD2a6IQxQcRIeKLjznDP5jF4
 d8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jGCl4PWS5uo6m2PFMVXPiLo1Y/4zUOWjNgXlPDjSGCk=;
 b=LZ9b/BWarA1FO2wAlASwlHg4can6A59W8sqmKLotk/5I9yiH9vvKCEDIHoNn99YkXo
 LhM1SGfD25OVc4Gzk4VMJfHcWQAo/s0MAd1GfCbd0tQ8X8MsGYGtYud6wzVtQSnKhlX8
 BWhFdtBhlcMywHAT2Guq9jCEffqqmYkOe9ekTe+zn6AK9/PFYzU6xanSaqA2KRFTUclo
 sxsk7DLGCZZNSp7RmsIOxTIZIxR4t1LMDVxDvTyzcYkWJgO3cMv6Ri8qoHos9i+wk6ZQ
 4WhmAmjn7f+5D0dR8KKs5Y4TOvvCApIYH1OGVwk9iasGH0fel/oFDPUddlI6dUW88r5+
 UX9Q==
X-Gm-Message-State: AOAM533To30s6Jo5I7pM8xfZnUGybRUDJ3GYuC3VuSan/mg0iYga3c/z
 1EluAu7Ni8GSm4XSXZyi4gr4SHE4xfMuwt3Cm0cSRQ==
X-Google-Smtp-Source: ABdhPJwWokJH/LoBVng/tUJ7XLG4M1PwnESdbCND8ShlUwFxbB4XRkaZ6c37fq6MBDeV4fUItdkHyABfZX/y24zG8os=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr2117735ejd.250.1604059777949; 
 Fri, 30 Oct 2020 05:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1604046404.git.qemu_oss@crudebyte.com>
 <b111895492f8fb79bcca1c3e9586c0615f46cc97.1604046404.git.qemu_oss@crudebyte.com>
 <20201030124418.1a20fb9f@bahia.lan> <3565953.R2qxJ1zP7r@silver>
In-Reply-To: <3565953.R2qxJ1zP7r@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 12:09:26 +0000
Message-ID: <CAFEAcA8QW0T3e4gUAOWh0Jnfov09=rPnqXGQDvHs3sYAYn7O3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/9pfs: fix coverity error in
 create_local_test_dir()
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

On Fri, 30 Oct 2020 at 12:02, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
> On Freitag, 30. Oktober 2020 12:44:18 CET Greg Kurz wrote:
> It's not clear to me where this coverity report is accessible online. A quick
> search only brought me to statistics about its latest check, but not the
> details of the report you quoted.

https://scan.coverity.com/projects/qemu . To see the actual
defect reports you need to create an account and request
access to the QEMU project (we happily give access to developers,
but it is a manual-approval process).

> And more importantly: is there coverity CI support that one could enable on
> github, so that pending patches were checked before upstream merge?

No, unfortunately not. The Coverity free-for-open-source-projects
system has a very limited number of scans it allows (for a project
the size of ours just one a day) so we can't open it up to
submaintainer branches or even use it on pull requests pre merge;
the best we can do is running it on master daily.

thanks
-- PMM

