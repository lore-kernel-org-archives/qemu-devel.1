Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC85AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7C92081A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXBw7zry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7C92081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb18Q-0007AF-Pa
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jb17t-0006fU-D7
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:13:41 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:34201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jb17r-0000dx-0C
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:13:40 -0400
Received: by mail-ot1-x333.google.com with SMTP id b18so114617oti.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 05:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c56QSuQSfj5VH1CUWfVatr7HxzAPcNJhe9d9U3wNcfM=;
 b=xXBw7zryIDSpgc+G/IRLhEyG5mC3Fz1Z7ta5ctpM4JHdbI/EC7333ZdzA+hZkLDO1n
 Kh7ETC4d79SzbJ05s6G2uoEtFLuzfNHHOBXVtO+IaJ3xmY54rPspsPdygVTdsB0qzXpp
 A82EHqblDB0+77fnrcqh1NbCtYfMLXQ6aENHuHroCyEANJgapYgVrZke5sxTca+TGB2E
 iGMiOALVFyeVZE1P/5C4Okv6IHElWu058hRfML9zaCYmXLtTVzFoMzDflt6HAaMBhBDW
 upaa/IwYELMrrM3EZpVL3Ynxu4BpnsGhbrA3LTDY8zh5FfvOHAHG08bTNN9AhPt01H1W
 KJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c56QSuQSfj5VH1CUWfVatr7HxzAPcNJhe9d9U3wNcfM=;
 b=jAh7DdQ8HhZjMw3DzkHMtZB0oWJNwdSAI9wXJFSCl8edBBIlxEokNzwcW+ny/y0J1X
 Tk8J3Fjqlf5BSlgtxi17fOz5CjkMylIrBB709T5FvOG9QRBmfIqkETNxqYClThRAQ8Ea
 PYqOEhZBwQFJUDLW9qbfisEihlLL3zab48clXVdx92vfpDfn9aO/axW3zNlZ61Kw41G7
 V7ETCE2NLrnWnqhUQfYfyfDiejEunVoVOPywtupI6FFqbTKxhZsUIDsUvrGEmYDD+DtE
 8LYqMeR6+H87XetxywxJnThlBp/TODAQoy1xSGSGSCjDDEwDdfM6M3XXPTxq/hE/lgKm
 H3Uw==
X-Gm-Message-State: AOAM5302zlYD0m79N1VjP9ElGVOUTmILVAMmVEdq0U3AZrcfbcU8yis2
 lCbFjxda2dA152cLqo0LCf0Bk3DbU81173P7cmCTDw==
X-Google-Smtp-Source: ABdhPJyxRhiiSIKHx4E+VUkkqHG6McrQCsahb//YP74uGCYrUSfh8DXxm8zNuCsTdhpAmyFA4u/8X1mDrDaF50bBXEw=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr13944377otb.91.1589890417595; 
 Tue, 19 May 2020 05:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200518170659.36547-1-kwolf@redhat.com>
In-Reply-To: <20200518170659.36547-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2020 13:13:26 +0100
Message-ID: <CAFEAcA_HJkUQi16OhBnUR=2FEwJmocjr4sRE0LnpvRJt6hfG0Q@mail.gmail.com>
Subject: Re: [PULL v2 00/52] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 18:07, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit debe78ce14bf8f8940c2bdf3ef387505e9e035a9:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-fpu-20200515' into staging (2020-05-15 19:51:16 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 4cdd0a774dc35b2ffe6ddb634e0c431f17dfe07e:
>
>   hw: Use QEMU_IS_ALIGNED() on parallel flash block size (2020-05-18 19:05:25 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Introduce real BdrvChildRole
> - blk/bdrv_make_empty() functions instead of calling callbacks directly
> - mirror: Make sure that source and target size match
> - block-copy: Fix uninitialized variable
> - block/replication: Avoid cancelling the job twice
> - ahci: Log lost IRQs
> - iotests: Run pylint and mypy in a testcase
> - iotests: log messages from notrun()


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

