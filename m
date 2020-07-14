Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55472C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB232255F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsV7v8gJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB232255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOGZ-0001W2-Ed
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvOFg-0000p6-RG
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:57:56 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvOFe-0000r7-JY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:57:56 -0400
Received: by mail-oi1-x243.google.com with SMTP id k4so14460548oik.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eogyBrNyrFk+sNvIYMWEqqDp71rY2NH5vB6KoQ40634=;
 b=WsV7v8gJfbcO/2ZnO+YrkfWjfPTb9ovZlmxuzV1Yd/zTkQMWfCxjeoEGfwUXS/Spk9
 ysmh7W27WjNq2ETeMNuf6jkfYIL25zPuNyd9hSak3/c6XB4K90xske7GxsdgkWn8w6ER
 6PO8DuJQI1tvkDS76ZfjDXf6lI3HIszzDVRErwNpNddN+EgiIbgWDq+Cn7vxilS7NYc4
 wiAse2E9GatBTWghvq/vlr7SLvvehF/4hFP11mMDYerkZq58RGrkdRw1NccPHyJcoLVM
 GP1envWtA1Xkp+tFEjxDK3j02FUnibt9XrfBPtFRwEK9wo9a9gVsoQSTijLaO1J4bkgo
 QGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eogyBrNyrFk+sNvIYMWEqqDp71rY2NH5vB6KoQ40634=;
 b=VwhjIKVzvydAlBsSsJiNmBbpjMP2r7cyBhRDQ4PuXmge8aWV0PsjdcZgDjvyl2ZTLP
 MnRonxCXTxrRP8H6YbBbx+z065rErrD7dfORT/f9+UtDdTG+lV8WjwBpGKmo9ce6oE/e
 Pl8kmjwJrL6JFuGhcuCcuVL0/hPMbDpgtm3+Gc+zCvOTLdrKAXoJiHGpjYPsUMw7CRZL
 KN3ou5NdZb+AKgbFfQDn79WMprQMdTyU9ceEXkBeD3EeL0xQWBpCMfUvvq3s7PYIT+W3
 6BuAoOj9KDRuv1V5QOJKfR2h6Ua0cp0pjpFGJrlh4RUdNg/EzZIkBocIGLd58EUyB99J
 rwMg==
X-Gm-Message-State: AOAM532sDbTgqKeLO5ZCS8fqZ3ddNIjWTswzH+31hgoI/C1/UXjI2NPF
 3nGjhP7uUTXtAUZp5rs9oH+Et6TUjjVyYTtR5CqMEg==
X-Google-Smtp-Source: ABdhPJzs1K9gnxxcLIwB+Xfz4rX11IcsMAZ5ZdNxqhqk9eN5wZS9+d0HBeWvFqE3/3MBGozuSulhMU2sNcYE61kiLJE=
X-Received: by 2002:aca:1706:: with SMTP id j6mr4270586oii.146.1594745873129; 
 Tue, 14 Jul 2020 09:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200713175206.13659-1-quintela@redhat.com>
In-Reply-To: <20200713175206.13659-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 17:57:42 +0100
Message-ID: <CAFEAcA8i=XU=7OODbpAZZ5pK-dEpTvaBTqQy--EyKV_LfH1Z0Q@mail.gmail.com>
Subject: Re: [PULL 0/3] Migration patches
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: Juan Quintela <quintela@trasno.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 18:55, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 9f526fce49c6ac48114ed04914b5a76e4db75785:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-misc-110720-2' into staging (2020-07-12 15:32:05 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-request
>
> for you to fetch changes up to eb9bd46ff658e05e2c0c71fc308f3b811afa87e1:
>
>   migration/migration.c: Remove superfluous breaks (2020-07-13 18:15:36 +0200)
>
> ----------------------------------------------------------------
> Migration Pull request
>
> It includes several fixes:
>
> - fix qemu_fclose(denis)
> - remove superfluous breaks (liao)
> - fix memory leak (zheng)
>
> Please apply
>
> [v1 & v2]
>
> There was one error on the huawei address of the 1st patch and mail
> was bouncing.  Fixed.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

