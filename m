Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CEDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE65206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtabE0Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE65206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix9cx-0001ls-JZ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ix9cL-0001KE-Rj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ix9cK-0004iL-Je
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:12:21 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ix9cK-0004fx-Ci
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:12:20 -0500
Received: by mail-ot1-x32e.google.com with SMTP id 66so3013468otd.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 05:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LXTwNq53EI3y2ZVBQYBZh8Gxa6lbOvk/HQh0pW5GU7s=;
 b=GtabE0AhHWxutSoeVUXfdySgzNkHvFsmqrGyYIfN0dty8dbyrhXgJS0id2SLJesa2p
 fksNDAv6zTjyDrPgWRLmnCYNN5tejlPPxyzsyLN0gtPP6fz0DeNNkC7sbMaFUgPIn5kj
 LR01zEdj/nxh8+MIvupPb012rP7kRoEt/3l930WaPGGrVcYahEsU1cVkoxhmO0AZ4Qjj
 vE7473DQJo/WxThL7n0SPTpuvViWimLnj+DpxNtHWkG6MW6Lv6IJ92PrWB4ew/wvyIOE
 VyzD91UjOMuXeiu1ZfDH9BjmKZc6qfHBXGAxzv7gy4rb09RWLasen14d2v60kuRg8UQ8
 3Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LXTwNq53EI3y2ZVBQYBZh8Gxa6lbOvk/HQh0pW5GU7s=;
 b=lEyBZMt/f9LhBDp+LM/jQLZ1892un17pvnOpTRXqkbnUf7fWZiZZ0iHyPtqt+aThQe
 KhX+EFxmColjZatoEh83od7YjxZpf+8IES0vJtW9aVQWFfCZduQtwtfpjidXM2cWHKi9
 rHeRxHl5jQCiMyYRs2NTLG84Tf2cvXOfx+7iFpWdhz8jJ5+aJCX01smwqUbjwqzadHg3
 a7PoX1ljm9mwSgqe10lr0PCTj13h48ZMN7fwzxKxZdb3MLKaM4SRTTFdUPYiTU5GOVF0
 ffxokeScPWnaggtN/cTlCTIp9C6POkZvlpNZSVyOXGVKrgvI4nDqAybSGjKKwosQjFce
 PxfA==
X-Gm-Message-State: APjAAAVyaKhP5gXE+t4/qS6qidEuSWUXO+G5DCjQgs3/4OiNv3Qjipyk
 sbkAakUST1k0u53KvH1eonPjuy2q3IGYNYtzz0apIg==
X-Google-Smtp-Source: APXvYqznO59q+wKzbb0vKt0LSHoOb8QI+gFXkxmj5pt+3kxCB6jOxvDtgfNlzlVJxtCir2a9xBWYmWnwAuEsbaCOfyI=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr3427931otd.91.1580389939070; 
 Thu, 30 Jan 2020 05:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20200129111536.9497-1-quintela@redhat.com>
In-Reply-To: <20200129111536.9497-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 13:12:08 +0000
Message-ID: <CAFEAcA9L1yNvVVK6LpuA2-Fiif6FGaf+U7-2sUvCQKV9qyFsng@mail.gmail.com>
Subject: Re: [PULL 00/18] Pull migration patches
To: Juan Quintela <quintela@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 at 11:16, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 4c60e3289875ae6c516a37523bcecb87f68ce67c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-pa-20200127' into staging (2020-01-28 15:11:04 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/pull-migration-pull-request
>
> for you to fetch changes up to 42d24611afc7610808ecb8770cf40e84714dd28e:
>
>   migration/compress: compress QEMUFile is not writable (2020-01-29 11:28:59 +0100)
>
> ----------------------------------------------------------------
> Migration pull request
>
> (this is a rerun of the previous pull request without the --- bits and
> rebased to latest)
>
> This pull request include:                                                            |
> - simplify get_qlist (eric)                                                           |
> - fix null in multifd_send_terminate_threads (zhimin)                                 |
> - small fix for compress (wei)                                                        |
> - migrate multifd + cancel fixes (juan)                                               |
> - migrate compression: the bits that are reviewed (juan)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

