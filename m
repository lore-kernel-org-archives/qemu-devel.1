Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA32C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C97620663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZoWz07k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C97620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0QXW-0006Rp-Dd
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0QWk-0005bG-JD
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:24:22 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:42655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0QWi-0000ep-SH
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:24:22 -0400
Received: by mail-ot1-x334.google.com with SMTP id v21so7725275otj.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3OQ6jVrw7zQ6gyFk/7e3khyoijomitBo4MSyvy9u4Tc=;
 b=aZoWz07khFMZ53iWSUmn6Ju9zeneFJuI7Xw9VADJbDw9wUIfMZ9wpyn59j1bVf06m2
 SgcnK79IqNZOzUijTc3MbTiIN2BJpuWHXFTkEg0w1If+wW91HlDS0x0R5IE8pWTsOSet
 j1dk88XwjZ3/OIDw9HcAh5EXIAoeAg0jJVYNh/1X4FPaS1xqkawhtGXE/mTkzKQMWjZV
 b/zAnbi3nZFDbSQehAS2sW6amGdGGWzZXkI6J1asaZw1w3g7mhjRMriSFT7yoHH6kTLo
 Zs4h1BYyAHOYiCqDUKy6O9aXNOkvFX6eIYkAYTecwaWfZWzBYNLpWhKXgeBDm2ToS01v
 qT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3OQ6jVrw7zQ6gyFk/7e3khyoijomitBo4MSyvy9u4Tc=;
 b=RNDP0fIDjGTeUCo1NVhRZItxW92rdzLOXjd0XgKT8DjjGzOENXJ8rfTan6tT80rkR4
 ImHPO1CFpj500X5Uw77ke5Wre2L8WVXfqUmcd0qKzEmzd/pjyIDJh5FdzlIauEyR6PpQ
 DGXn9sIdvT/6zuDxidAAo7wtuvW9n7NZmvFSTT5tc8oy/8P2wIL/S2JxL28ulwjgAeIv
 1APuNMy74S98o5rmlHK74RsSoqJ08n+8B48B9XOr5YE3XPANPLJtllNoetVMVatYTsdS
 nyY2iXfI2L+0s9OO0/8G8YYl2jfNizOtc+Lo7iA2XVNNfjKBj/8AJxmPd3WZ3oSL6DdR
 Zjtw==
X-Gm-Message-State: AOAM533U1DcyDWDlGrrm+zvWO5RCv8lCTHberlpixPJV2xhChf5sWGpg
 0Utw61rjQgCc4gDkEPi0EvookerFZyEFzxhrD9qGQj6y
X-Google-Smtp-Source: ABdhPJw4rqBCrGh2QYlkCTigNN7Fr/DwjsRjHxECfg1bn3bVRpf7X/K5wWtnYcHlqEpwz9F5tP7W+ZtaaB1PYnaDMUw=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr23458182otk.221.1595946259535; 
 Tue, 28 Jul 2020 07:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200727205543.206624-1-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 15:24:08 +0100
Message-ID: <CAFEAcA_G6pd1QuSUpLimcxFUJK7X6YCiQLpOLn3kQgmefK91DA@mail.gmail.com>
Subject: Re: [PULL 00/24] bitmaps patches for -rc2, 2020-07-27
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Mon, 27 Jul 2020 at 21:58, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 9303ecb658a0194560d1eecde165a1511223c2d8:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200727' into staging (2020-07-27 17:25:06 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-07-27
>
> for you to fetch changes up to 37931e006f05cb768b78dcc47453b13f76ea43c5:
>
>   migration: Fix typos in bitmap migration comments (2020-07-27 15:42:21 -0500)
>
> ----------------------------------------------------------------
> bitmaps patches for 2020-07-27
>
> - Improve handling of various post-copy bitmap migration scenarios. A lost
> bitmap should merely mean that the next backup must be full rather than
> incremental, rather than abruptly breaking the entire guest migration.
> - Associated iotest improvements


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

