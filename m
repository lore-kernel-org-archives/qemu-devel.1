Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57172C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CFA20674
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZgwNhWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CFA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGdq-00025v-U4
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZGaZ-0007cr-FO
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZGaY-0001SB-3O
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:47:47 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:42162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZGaX-0001RM-Qe
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:47:46 -0500
Received: by mail-ot1-x32f.google.com with SMTP id 66so6859113otd.9
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e0Antpu18es8uOSN2yjyqhIWvG6lJsh+Ei81WeFXyC0=;
 b=rZgwNhWunAOA+rEft/kfpX+sW24TZ9axq4HNI90hmE4nLlW/329/i+mVXq2H0BI1+t
 w1lNN6k3jbsGGXEejDh3XBwqMuQLFFFlMcB6m+KMh67e8dNfS1VBoCd6I1gPibQALW+3
 ZrAVtrgdixTPdRQzdTijpn4AlF6pzNxTugXFWKs0lSNja+fUbqtL+xJM/iXlfE+sMEzp
 uDdMedzzAn6288kH3aIKTwW+SEuqF9+7GKfUaDwwnOkRC6IifZhccmZM5x1oY2NPEcXA
 ipNMFRLGYwtzl/ImuCQehgHxKFn10/Rk3ucIoHV3QIArYEIdb00esh9a32TPiv5IBYCy
 7pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e0Antpu18es8uOSN2yjyqhIWvG6lJsh+Ei81WeFXyC0=;
 b=fnAQbHvSPsLHboeyvnOOGNK4CNC+8CNdkeJdluR1GZT0tziEttJ9mn+38ZZV+FVWZj
 62UYpbhOiRxZiah2mlDnlFI4m4Merx6mTUE5yFJ0dwqzmj6qC2p3TkNF5T+QRd7X19SK
 BOeXVwVYxf4soElzaWCxMZtbGEkCWReZvLZLZ7RtpXfoL+oUzjuzv9tYtdLNdmsLbh7E
 4zm5mQkyDq+aqeFMPa4wP7vzHELwiiLVLApJzNxFpE/62TGrKLq3nBkRF4bbEqhJRzil
 pW50WkedXiO6f9NRAW/WM29jTO1JjjOMA5cRt3n3nnC+oyLLAeY5cqqPni8WmydukAmD
 cSFw==
X-Gm-Message-State: APjAAAWpHDVg0XFvhjZi+bUi7JDsibZH6cRPuj/pFMgikRsDu0IMLQTo
 C0UK8+DZ+FMmovVanDHjhNp4vdUCzT3aWfkbnWZaPk60pnc=
X-Google-Smtp-Source: APXvYqxK9TS81gZJYPwCu8HstbfMCNAVZCK99F0v30XqHi5iEE7S1MEeK7GTjYN+dsyb8hjAzpwb49yD52h9cFVV2Po=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr21620210otg.232.1574696864554; 
 Mon, 25 Nov 2019 07:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20191125060434.22997-1-armbru@redhat.com>
In-Reply-To: <20191125060434.22997-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2019 15:47:33 +0000
Message-ID: <CAFEAcA8TQu3-Ut8-zgsxENN_PJc8bd9dYHmeO3aAHek6kDLMoQ@mail.gmail.com>
Subject: Re: [PULL 0/1] Miscellaneous patches for 2019-11-25
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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

On Mon, 25 Nov 2019 at 06:06, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 2061735ff09f9d5e67c501a96227b470e7de69b1:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-11-21 17:18:40 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-11-25
>
> for you to fetch changes up to 25f74087c695364dfaa87443b1040a3aa5c29008:
>
>   util/cutils: Fix incorrect integer->float conversion caught by clang (2019-11-25 06:00:05 +0100)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2019-11-25
>
> ----------------------------------------------------------------
> Fangrui Song (1):
>       util/cutils: Fix incorrect integer->float conversion caught by clang
>
>  util/cutils.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> --


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

