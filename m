Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D13C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6976C2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bT0UswWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6976C2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQ2A-0001wW-Ip
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGQ1Q-0001GY-0p
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGQ1O-0001S8-Lb
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:33:51 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:34211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGQ1O-0001RW-9W
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:33:50 -0400
Received: by mail-ot1-x32e.google.com with SMTP id j16so14041192otl.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5YK0//WvbzgkX6SCOX0YPT0E5BLnMoVfpyFFoC45tSE=;
 b=bT0UswWvwxHqTGM7w1D0L0P8kONnCdtxh7FQcG/KYMPTDW08JNFM8SGDitp1IflXyx
 VBAOzwKQ/HQUmSJUM3bNTComGvNnIfz5/G5ogXVEtk17gtQ2H8W6TCVBS4+FMtd03MGP
 5ruz4h2Is6nuHc5v3SsOVXG+wKU7G5jhqX7oEFKINXGYSylrwydDC91GWBeUnO4ZOPOz
 s36f9GlRWe64a5tXBzIa7kbs3ZGwfWRYymBezaYCExvYav5mJe805V2HPYgOXVnWbFdB
 rSqP88UFbHxxSpWGnWooACencRIKxO6QIUAcqIIcdh3T9GMN10cXaNMvv3vcHItjzpiZ
 4jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5YK0//WvbzgkX6SCOX0YPT0E5BLnMoVfpyFFoC45tSE=;
 b=V2N0jayALtjRLcBDlA1dYqcpAV6niOPYxd0iHuuFp+BDzUKRjIBDclFkj79P23HiFE
 5o1oExlNMMRRt2OgugHSs2RAJRhEaL+azw97UMj0g0lKG1NmepDfja5KafupnknxUDGs
 EaGyDeTBdU8dG8jmX1gGPlRzeQzsDq1+B29Aekpk3BYqHq6asVdyP5Mp3I7vmS+uEK91
 LzQwo8lk0jQTD7sYMYvwgiKkxKNFFjIKRqAe5h3SNvG8uqg66ai2xZFZA843XyAt5fwI
 DGskdFD4eMHHM83P4LgpEKb4ngzw5LqO/zinuYXgv0y+QHXXJ5iy5AxAmrjXlJh0wWlu
 TjsQ==
X-Gm-Message-State: ANhLgQ36FvOTYTJNxV1FEGrhQ4tZMDZYjl89xeA05bHuYAIqw/4xAHoe
 gDMJFLq5IaAu7S3pYNdf0nNXyut2CTWW/8K1yxDX3g==
X-Google-Smtp-Source: ADFU+vuOVGwnBHedUQIOmpO3o3BkTF3b9ahE8I3wZM8mXllFlQtBQUx+/oF6ZA+WRYgsaUxJK1Dyd11tSSsMcvae60o=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr3629407oth.135.1584981229194; 
 Mon, 23 Mar 2020 09:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200323124923.24014-1-cohuck@redhat.com>
In-Reply-To: <20200323124923.24014-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 16:33:37 +0000
Message-ID: <CAFEAcA_DKPVW-GGHuUf=Ai1OjLwr9yzeJ9hyPCymJuyFkeru5g@mail.gmail.com>
Subject: Re: [PULL for-5.0 0/2] s390x fixes and documentation
To: Cornelia Huck <cohuck@redhat.com>
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 12:49, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 29e0855c5af62bbb0b0b6fed792e004dad92ba95:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/slirp-pull-request' into staging (2020-03-22 21:00:38 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20200323
>
> for you to fetch changes up to 7722837369eb1c7e808021d79da68afa0c01c26f:
>
>   s390/ipl: fix off-by-one in update_machine_ipl_properties() (2020-03-23 12:36:27 +0100)
>
> ----------------------------------------------------------------
> - fix an off-by-one in the ipl code
> - s390x documentation reordering



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

