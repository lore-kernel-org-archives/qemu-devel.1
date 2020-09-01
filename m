Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05866C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96D22064B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2FoEqnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96D22064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8a3-00021u-Ut
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD8ZO-00014f-SC
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:51:38 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD8ZM-0002n7-5D
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:51:38 -0400
Received: by mail-ed1-x541.google.com with SMTP id q21so1954721edv.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/3r0V5XaWzpq03UXQxRhWPAEfoInKgh4VrLacrOfRHk=;
 b=y2FoEqnTpKJ8yZ6xQbESB03fyV4FpWOkpiXvUxfH9A2HnDGKr/Q9mrWG+TTBPWS9aK
 Tt5Q1ZVhKxYG7qqqgR3XMEU95d6rZxmzmf30M6BWVB7GJQA68SaG0qqbR+MYnxHAvAhb
 GbEgA2w/EMXKNZrNlHb+Qh/WkcQLXGBPJENxkPLlQ06IRsq7hHM4Os4YcfhjGNwfbcAI
 j/4O2UGeI86G45RqcHBb6i9ETm6eCjTEx0MJbqZeCPAJrJj7SIu49EeSZ3F+ilH3VpSE
 sjeXkd3zsXHtsMMGwGmUa/jhJ2/B65N39MoDZa2clraA9qthsZTVj3/Nv0NHSIOnWvGG
 cEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/3r0V5XaWzpq03UXQxRhWPAEfoInKgh4VrLacrOfRHk=;
 b=coHDmbNkvKkjJFcgekogOcUz9EZSI0XMYnzQeDv+RmpyKXI4FInGk5otJZzkPvgCrZ
 NSOaQbp6RNIH7gxg6vY469xbX7Iy4xgzwF6qtNcgoiRnH5W27ZEscX4pblkp1mwKt8ht
 eXJn7Wm9toIgaYrqihu0r4q344aTxphPvq8XjHSKww3riCrqxB2/ZvM1gN5Nx28I0nMP
 srkvNR2jL7uCCfj9WViqN5nXeCBzOVnoqahw1tAEOky1eVPbcMbHcvtmnFB9kPnlM6/x
 4qQbk63WwTkz/qrS6Wty0Fuv8ULhJ5gu8uMixzQ7wLnAvJ7DhgDscLr8/raWF4qICCuj
 XZLg==
X-Gm-Message-State: AOAM5301sUE8BAIUx56OyZsgEQQVR+NzooXGYiPWcLkkZpi2P+qAHKzO
 owYBM9NgIN53GSlm/MzMAfkn2lG0267WTk/gO3KzWg==
X-Google-Smtp-Source: ABdhPJwNfFpSHwO1xiJbcqKIqWq8tcKjeBQs9PJeYoxt7WHzXpjVw8/7yjcLcZedTErCJYNQogfmw1ctnMcsD5D97JA=
X-Received: by 2002:aa7:d596:: with SMTP id r22mr2344387edq.204.1598975494113; 
 Tue, 01 Sep 2020 08:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200901140803.888852-1-laurent@vivier.eu>
 <c63cde35-2959-f119-5c22-fccdf23a23d7@vivier.eu>
In-Reply-To: <c63cde35-2959-f119-5c22-fccdf23a23d7@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 16:51:20 +0100
Message-ID: <CAFEAcA-OMRhuZFZO3S4-g7BCX0BQVvqaivSN6E5WXCxeoo_eAg@mail.gmail.com>
Subject: Re: [PULL 00/44] Trivial branch for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 1 Sep 2020 at 15:42, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 01/09/2020 =C3=A0 16:07, Laurent Vivier a =C3=A9crit :
> > The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3=
a3e0:
> >
> >   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2=
-pull-=3D
> > request' into staging (2020-08-28 22:30:11 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-req=
uest
> >
> > for you to fetch changes up to 1eef4ba6be30f8b95c8cda1bcb50a176d680a34d=
:
> >
> >   docs/system: Fix grammar in documentation (2020-09-01 12:09:30 +0200)

> Please ignore this PR, it failed after the first patch.
>
> The second attempt is the one to take (same name, no versioning but
> completed).

The two are identical from my point of view because they refer
to the same tag (and even the same commit hash in this case).
The merge process doesn't care about the emails that go to the
list: those are just for others' information and the historical
record.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

