Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9433C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84528206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYSX7kb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84528206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrA3-0003mp-Pj
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkr9I-0003Db-UM
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:35:48 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:38258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkr9H-0004Ni-6K
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:35:48 -0400
Received: by mail-oi1-x233.google.com with SMTP id c194so16268373oig.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J8cJt+tLNE0QBGdUQZgVo+JWHIAuOdVJmp/uij9nOMk=;
 b=OYSX7kb4hZQeEPDTdIx0sCJUbkijihr5QdKXErTswCVoJ6tNcoXlR5FD5czAqV7Q0v
 m332WEDcAOWMT2dS5o7MURRTsfXXwtRxDasVBA854HDt6EdwhhQ2If0VSkqY3Gslr8gP
 riVcfZUte8oG1r8tCELuPSu241FMf/s59PgjrxULIws7JJGfW7QSL6H4644VAVB1+ukU
 pSTKOMX7Q6RK4gKyQvq/tJYLmnFrhxEKs8RazrZ/ph7fgoztuYNczO23EkOlt7bY8o41
 lGxUqzpdhXKWuYJVCR1GCWEuBC9rCH0TtJHnTfJ8bfB11CsLKT1jVfH/EM8QsVyuw5SS
 Wksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J8cJt+tLNE0QBGdUQZgVo+JWHIAuOdVJmp/uij9nOMk=;
 b=VZRw4kuq6LACpzYGp9D7A3Z0vlqH5y9hUCC1iF2P/oEprjeziBIfin+v9pQ5onTG0L
 OmePiMQrkSY0idhAI2sj3zayRnlDaX1N/5AdJ9XPYFE+udTaFORZOo/+A+EWfRXV3itw
 dxx8jdtzsQxwIVv2t2QWUIvW7T2FU644Y0bLkFFAV2O8v1zeIemhLvIkOF8coZP6TP11
 gbmlAQHx0hmJtT5UdqDw/qfRL+tYEl8Yo/WvhyhMvHhsZ3uHgJgRT7OJmfUn5/EOT4Xz
 j3PDoyz+mF7/0x/Zo9iEV+LpubSnwyANMG27i7tf7BuXqt2TqDKT4PKyLswuCDkhhZcw
 iEVg==
X-Gm-Message-State: AOAM533Gr2JFgZtVOkURW7mek+RMWt7DGyzq6V+z+hVfg0IlxeoJUUqh
 XfRqx88C7bNGGxKMBWq5lXqz0ByKjjJfGVonyzo99Q==
X-Google-Smtp-Source: ABdhPJwhgNPQOLybYzYuzu1uRB85UpJ2mRjXM6ws5QZKVRJmuFvfGh2LJsRfnwh0q6z29I4dP+2ZkfCTif2EtKgxWBU=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr9325415oia.163.1592235345312; 
 Mon, 15 Jun 2020 08:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200615151449.19818-1-kraxel@redhat.com>
In-Reply-To: <20200615151449.19818-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 16:35:34 +0100
Message-ID: <CAFEAcA8NPYuvOG7km6NxeKUTW_8gCpQjg_Dt9sT3ti0omm9Wzg@mail.gmail.com>
Subject: Re: [PULL 0/4] Vga 20200615 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x233.google.com
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020 at 16:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20200615-pull-request
>
> for you to fetch changes up to fca0b885417497a973c56e6d4e0d88f9f7a0e71b:
>
>   sm501: Optimise 1 pixel 2d ops (2020-06-15 10:52:53 +0200)
>
> ----------------------------------------------------------------
> vga: sm501 fixes and optimizations.
>
> ----------------------------------------------------------------
>
> BALATON Zoltan (4):
>   sm501: Fix bounds checks
>   sm501: Drop unneded variable
>   sm501: Ignore no-op blits
>   sm501: Optimise 1 pixel 2d ops

I just sent reviewed-by tags for patches 1-3 which you haven't
picked up; and patch 4 hasn't been reviewed at all yet :-(

-- PMM

