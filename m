Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5C3C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C41206E2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkvD7cK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C41206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGP3-0007DW-B0
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGMw-0004m3-4h
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:02:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGMt-0000SQ-Iy
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:02:37 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:36327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAGMs-0000K6-AJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:02:34 -0500
Received: by mail-ot1-x32e.google.com with SMTP id j14so3104845otq.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PmAQ0dwA+6EVQT0XvT/7+kZzT5vGrEMbT8Pz295NI58=;
 b=WkvD7cK4QHy70Q11HqEVc8/4CPLZGOLwylk7kyxZOc9MGh1ltqvNM7GBfaOslk79sB
 Fan6wsG1dmEn+1OmWDjPlr8TqleKKQaCRCo2NP0sqjVHWAn/mRvVK1emO/pjrV8vJA/w
 yA+zmP35ppZvDCY7PEECdmRKhTy64H5sbgUvz32qMmcyImUR9XbCc6Q2zbX4DrSZjV4k
 FOxSdyJpEeB/oLCX8QsAhwwaaKPKtJvWM2l1Imi2V4WsgG6Gj7PWmf6VBUZULJxYZcNu
 yQ15RBQNrh/SMjVXRzVFSXZBRObg3TgzWvf+CuHWjxsCxWNhajRrhCO0T+GpP3kMbWuS
 Hr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PmAQ0dwA+6EVQT0XvT/7+kZzT5vGrEMbT8Pz295NI58=;
 b=cPcMnr79RiFxBM7/JekvHnh0GJxJB6kHGHtW2cYaqePtusNccwX1iN0iD7bgVpzP4r
 NtiW+naJo/Mgb+GxVVvhGw6k6DbOOmAaNd6APZ3ulB1kTrw6RxdTX5pLyjAehFfj5HEw
 G6O9lajz16nILId+ooWlv3HZQHonE7jckXPakQsx1EAQYHv0conkjde5/DK5fhQcGv3c
 vPLoe4GidyVXMvdZwi8o9h/LibD9E9fNiORSHqh+j7ez+0MCBmFDd7Uj5Leiyjx/tfQ7
 kYBLkn/gMdf/+GfjPsdt5uxS9i47CTbk6Pn69lSXaTEmGZ+7p6trXIh48j1r86Q0emQ9
 EShw==
X-Gm-Message-State: ANhLgQ2XbvXeWTVDE+lNfYtpMc5O2voVzuenSvA4IFwLt8bdWqtLL8AO
 ra/Y2KZEQ337JACoovBnTla+4COw8mIESe+9c2MBpQ==
X-Google-Smtp-Source: ADFU+vuV3UmIUZmsNr1+EMVX7PTFS4bKmdOJLOkxqad0TL7fXilTk5by2uD9GZvwIfQhtqokVos6sbBVsa+Q12eLFhQ=
X-Received: by 2002:a05:6830:30ac:: with SMTP id
 g12mr3191689ots.221.1583514153045; 
 Fri, 06 Mar 2020 09:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20200306142318.1435372-1-stefanha@redhat.com>
In-Reply-To: <20200306142318.1435372-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2020 17:02:21 +0000
Message-ID: <CAFEAcA9MiLj+5QiHufZVwoddoBN8arrKNSrS7v7h3KYOicEoLA@mail.gmail.com>
Subject: Re: [PULL 0/3] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Mar 2020 at 14:23, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit ef9f8fcbec6276414921dcd042575129a6331a2d:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2020-03-04-2' into staging (2020-03-05 19:39:47 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 1f40ace7b5634f93801c8474b9eb77fe2e00289c:
>
>   tests: Fix a bug with count variables (2020-03-06 10:35:15 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> These patches would have gone through Thomas Huth but he is away on leave.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

