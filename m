Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9CDC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE10206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYABB8ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE10206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOL94-0005Ez-34
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOL8B-0004oO-NX
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:29:51 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:40625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOL89-0004TD-Pi
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:29:51 -0400
Received: by mail-ed1-x534.google.com with SMTP id t16so1639045edw.7
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gICf0vo43goLH0iCtKMiQB7h8UDudj8pEdb9nE4u4LU=;
 b=IYABB8ye4Onbm8zQCNSOFayypKHqw+B3Ql4UGiqEwUQRmEoK58Qu/BRO4hTh4amXVC
 EsUE/CU1kET2CA9pFe8DQTc/rjaBuLeLV6AK17uYqZh89SL9tR+smoI0xMTGuMcWTm6k
 Toll6kBL+U6B2HssOdlam+5vCrkUbMT3Fvvhl3hfjAVzhAmvHAC/mnOvEVKiwQj7KuXf
 ND2TtNjW7SYswaBNdbmIurQbc31eoTSOd5Vs/9IvB3MPIoPA7mpw+Hnk3K/BaNDMV3UD
 OTUSAHSm4R6HOJjPCODkDqfuig185xe9NH/7VFE2JtDaO0BDTP2YXPWA1I+NGQBQjOe3
 QDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gICf0vo43goLH0iCtKMiQB7h8UDudj8pEdb9nE4u4LU=;
 b=PBJ6MCKrdMGMQSwJuy9yIau6cezeYqiLhyJI5eabX5QM2RKViKacd+mvSqwFJ65OZX
 NsW8w1gXG0Nba1/RF0MRYPbyw4sb26ssRJhY30O0nX2+HYFTRw9sPe1sUN95UOXGyE4C
 uqW4gO0vFKjFTuHiT2g6yBjSIVpv+TOjP5Y5xljQt4yRzYlrTLdZR9NyFuMaVWNQqbLd
 Q/ZNx+WKO5zdzhoupR7+/d20K9ryHRzfIWI3cpr0+jYTKyExy8ZKptsoPTTPVhmlvREF
 lShUb7bRqAEqxtgdMF47HJma+4S4LhEVE8aP8EkIFN7lY1/YkDVk2mcG+LxgXqoSfjr7
 XKEQ==
X-Gm-Message-State: AOAM5301NaX+QLun201neo67zBlLDiHo4WMzs/MSQSN9Jg/eKSF6f3Mt
 AIJ8R3YdRYLmgpf7f672Lq46+MtNw1nka7VmX9RtpA==
X-Google-Smtp-Source: ABdhPJzZDJQkgzJsY4cahWQ//G4b5rq1VkPC7MHhtmzqxQe7bBvQo1ns0M4X/T+8NFpAuUeBH2QjpZkly1NB5GCZVDk=
X-Received: by 2002:aa7:da94:: with SMTP id q20mr2413491eds.52.1601645387567; 
 Fri, 02 Oct 2020 06:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201002113645.17693-1-alex.bennee@linaro.org>
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 14:29:36 +0100
Message-ID: <CAFEAcA9DApaAdK21stVPab_8jYAUeHiR4AkVDzpnaTdx5xAuvQ@mail.gmail.com>
Subject: Re: [PULL 00/14] testing updates (python, plugins)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 12:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit b5ce42f5d138d7546f9faa2decbd6ee8702243=
a3:
>
>   Merge remote-tracking branch 'remotes/jsnow-gitlab/tags/ide-pull-reques=
t' into staging (2020-10-01 19:55:10 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-python-021020=
-1
>
> for you to fetch changes up to 2614670b7585ce4ec503546bc3023844d392f270:
>
>   gitlab: split deprecated job into build/check stages (2020-10-02 12:31:=
34 +0100)
>
> ----------------------------------------------------------------
> Python testing updates:
>
>   - drop python 3.5 test from travis
>   - replace Debian 9 containers with 10
>   - increase cross build timeout
>   - bump minimum python version in configure
>   - move user plugins tests to gitlab
>   - split deprecated builds into build and test


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

