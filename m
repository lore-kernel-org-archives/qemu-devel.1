Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB3BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A8B2192B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxS2qA1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A8B2192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWl6Q-0006nd-EN
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWl5B-0005lo-A0
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWl5A-0002n8-6x
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:45:01 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:33321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWl59-0002mq-V5
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:45:00 -0500
Received: by mail-ot1-x336.google.com with SMTP id u13so15289471ote.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hfM02Ak8r4N/gz+6GLSUTuLlksjfkTuTO3GhcrpRvxw=;
 b=pxS2qA1uuub9BKtXxsDFX7ttxoomSJNgw7xuahD2N/CeLRj5MJx+Csse05phNR0MUE
 yUfT1wlPSOklNfcYAuctkLypdGIaqNFBD2pIY+LBFdDaeynfe/gw8hLGeEvFJvI+tOyG
 N/K5AkNcYKvmjG+0HlJMJpSRgXsSCd7L/ulyeqMADVqkwXhFUlYF3+3QKYPLAZYQ9P71
 XWJ5HD25pIw81oPVBaZB8D9ypngNneNeviAvfHiXe+bmDpMfQZdKWnMicblZzUrauakc
 vdKxCvh+r1qlCdRAeeIH91WRGMG5LMlxpEwgVIhtxzYM470A9R0jPHcdQaftnqYltkYW
 BSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hfM02Ak8r4N/gz+6GLSUTuLlksjfkTuTO3GhcrpRvxw=;
 b=XUcE08c4lV/d8dwvDJPvHT2epOFIhDre0jwFFc/J+4vOD7Yt9jS0N4m7tlkxd1cnpQ
 +JKLx9SHrTOX3MqTf2L1AgZ01snxd57zWyErjhALpKRY3MVNM2xiC+iC65uSeo4TIde7
 4QnX86cn7v5reu6VGGinbOzM6Ub9o/XI9ZjKtuKJSND2kqTWncA5ogADgUZEKIcKxW3n
 1iIZcb+RH2DTlBTt0SsYvKMRzeWWzygBl22TXU+cOZZb09nzjFbS3CWhMm4ru8PboRkT
 AXP/GSGMptFlp/2Ddwwig6P9kZ0XfwNAUJlJ8MCL9VNI/4L5SjiSQ0dtkwnx2QLKKrKp
 tvbg==
X-Gm-Message-State: APjAAAV5unH7+pqdoMLAYVJaiOPDKqlLS9vb8qCujaiqQ0T/yrUtRtgd
 /YpjiLUgiiiKgC+U1G5+WJkb2xvSIGO89eMPL3QTtg==
X-Google-Smtp-Source: APXvYqwpFNkmv4K1IKcc38dXS7CJda1ik8NB3klpasZtgZSf3OdLcvyrTIw2mtFL8NDXmBP7ZasnmYKAyaO8k+bdaig=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr384805otg.232.1574099099292; 
 Mon, 18 Nov 2019 09:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20191118170256.31477-1-kwolf@redhat.com>
In-Reply-To: <20191118170256.31477-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 17:44:48 +0000
Message-ID: <CAFEAcA_YbFBWnHvSZDtpmQi57PV_qX9kek1_06U_DxMnGT4WvA@mail.gmail.com>
Subject: Re: [PULL 0/4] Block layer patches for 4.2.0-rc2
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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

On Mon, 18 Nov 2019 at 17:03, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit bbe165740a96f67f48ecd3029dc26bdd7fd5192c:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/ppc-for-4.2-pull-request' into staging (2019-11-18 11:09:06 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to b1f6a8e180367c945b67c6c9bbcec5c856be3779:
>
>   iotests: Test multiple blockdev-snapshot calls (2019-11-18 17:50:08 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Fix HMP savevm with -blockdev
> - Minor iotests improvements
>
> ----------------------------------------------------------------
> Kevin Wolf (3):
>       iotests: Fix "no qualified output" error path
>       block: Remove 'backing': null from bs->{explicit_,}options
>       iotests: Test multiple blockdev-snapshot calls
>
> Vladimir Sementsov-Ogievskiy (1):
>       qemu-iotests/iotests.py: improve assert_qmp message


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

