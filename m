Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CD5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2472098B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXsTSIxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2472098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEqA-0005jA-1c
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlEpQ-0004f6-UD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:52:52 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:46934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlEpP-0003y4-1I
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:52:52 -0400
Received: by mail-ot1-x32e.google.com with SMTP id g7so16445199oti.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KCEnOnTn9PHWWLxnPDZQOPBoTWQd1ud5/oeuYSCYn3o=;
 b=qXsTSIxKdpl9mOGgeuf7rQjHvLAf6iLfA/kh7ms0t2c67DPUh1KJV+mBp4Dv+l3xAI
 MaAyGbb3XvFuM3V4ZHRvHaNvoktJTVoXO4ILwLzPy+iGoeaIs58LikwNbfEYYnRUcdGe
 E95dJKPIZHJVrR+7UYz/WlNP1WCit7YQ/3VS2KfA3KYOpI/IvdEXSMFz/JT76xKFvNNq
 XhbDRMjCQY1MsCBxYOgQRfnbMtkQ+3q4xynd5jQy5LYEqDiCzJmOUFbfAND6mWhkLKHX
 SfdROo0WYCxaDQoMmMgMkiFm1siJjE6H3a0p7WgyZ+VLFe44OP9avAa5o331f1FRMZ70
 RcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KCEnOnTn9PHWWLxnPDZQOPBoTWQd1ud5/oeuYSCYn3o=;
 b=CpoKFPC4yiK8VPX7unAuNiHqvc4JrdGAL31+kY/mWf6e1XOaNS7Niyjm1apZtaxajy
 4Sb/In8lUOEMO6j0rtzJLzuqoF1O5T4Nd7084KhL9B9+VXl/9BbAHVZVfRGE+P0+TuNM
 u9jq+ma5S6C68QqHMaPp0reYxEt9krEOM4A0KMvabC8DXh7cdJrxhoBF+U6T+9L57BaL
 sVFnQJOkDk2aKVgdsstOf/LYOpiJKsKFzOtL9W3QyRRwmmAK6bX6AVvzUMGy+8cmHtSN
 3nGn5KwSi7hWdl8kPuEzkzUfHzfhTM0F1JHy+3+ahpfi181coHd7J6JDgzZqA81H8Wtc
 20kA==
X-Gm-Message-State: AOAM530HTAtgGSYOIpDNtWtXffNxEBavSEct9Tebbh2VX6LhxbPqtpYU
 VzBaJKrHn6FT8K8Xjr1zAnv6/uWNpef6RktJ7FFxRA==
X-Google-Smtp-Source: ABdhPJy7SGXrMwRmBarTdZshw4xbXVGoU3Lz/3sxr80++uPG27FnjLoevLogAJtmPjBIw/QwVj33vD1mqUYvJzDVPzY=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr3359262ote.135.1592326369868; 
 Tue, 16 Jun 2020 09:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200616135129.5786-1-alex.bennee@linaro.org>
In-Reply-To: <20200616135129.5786-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 17:52:38 +0100
Message-ID: <CAFEAcA8xfA+=vUGVLmeiv5o0or=J7kHHOqRkKaMP5JgBr1LKJw@mail.gmail.com>
Subject: Re: [PULL v2 00/21] testing and plugin updates (tsan,
 pluginsm cross-builds)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Tue, 16 Jun 2020 at 14:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit f5e34624f28f37ec3c8a93bdee348effee966a=
78:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-15-=
2020' into staging (2020-06-16 11:00:28 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-plugin-160620=
-2
>
> for you to fetch changes up to c81950a2f1923dec3f6b952ec6bb9b921be58a70:
>
>   plugins: new lockstep plugin for debugging TCG changes (2020-06-16 14:4=
9:05 +0100)
>
> ----------------------------------------------------------------
> Testing and plugin updates
>
>   - clear up dtc warnings
>   - add support for --enable-tsan builds
>   - re-enable shippable cross builds
>   - serialise cirrus check steps
>   - fix check-tcg plugin issues
>   - add lockstep plugin


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

