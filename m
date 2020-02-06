Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7A7C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FC220838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1i6ayeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FC220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izmNV-00072F-KL
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izmMn-0006Uq-91
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izmMl-0000kA-No
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:59:09 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izmMl-0000dR-GF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:59:07 -0500
Received: by mail-ot1-x32e.google.com with SMTP id 66so6525144otd.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5Hx+wnaWAhznZBATjM7/sJ/CaMShHBa8pFQt2pSC2Uo=;
 b=X1i6ayeQ5mDg6Nyufqel01b1AlBfgeNiEC/gFI1jYP+FxqmPzGBdVRVXRhEx/6IyvO
 W4P1sx1CQgcXoM+goz+Vg3mJYx91hJplWO8z41qpU5aVVv0L85TlPu4BalDAG93qEDiN
 9/ANNK/NLHieh7XQPAu2Bxlo8n2oLTKggVCZxUsmlVGpVDF4zwlCfOE9Gy2G/+Y+kQJu
 C4S9yO4QDmAsYH8X/8f0petuBw6yMQudYlj/xoB8AwCY9KDgorfqI/QYLb38I4961NI8
 BF2r4BkyC83xnB51CtakmJXnCk9PChYOiPyg/zGfssuF3ERniZmUAKVEyPu8mI/q0lHv
 2Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Hx+wnaWAhznZBATjM7/sJ/CaMShHBa8pFQt2pSC2Uo=;
 b=Dr/fPLkb7CMyA1s/HcFAPXuScOf5Kg2SxOeH68+s3mahjtC5aUzCEqr9QWIUTPu29C
 im9/zwex7CrNj1VlDr0zPKctY6KKukHrA9UpUyzrRmCGXKiJqAqUSWBB6/nF1PWSNWb+
 wAJGVan8pTFRh5ZPpLBkGxzv00Re9lCHk9uTEwrKYYvoFvA4OWzjhtNxtULTxsR0eqxh
 /ij0Tn8ftu1Ndw1nEtu8ZHyLML4Bs1C1HK+tE9dJOslDTNz+NGQ5g7d4D+gFcS9iLjwV
 vJ/rDKeREBLRUydgu1lmAcx1OWinug+J5VKaYFedAjqT4dxSm5gr22catAEnThw+Dhyn
 5AEw==
X-Gm-Message-State: APjAAAX0Je3SDwl73xSU0XyDky7/CX2wPZTJtLlRi1AAilZbDz/AyYYo
 yLLXgW+Rndvl1T9VKWWrx+Abu1pSutsZ9q1rlD0k7Q==
X-Google-Smtp-Source: APXvYqxKMXhkmOyoEUHu9k8nw3O1/bulKHGzi+A38WKfT0Y4+UUPbh4y05QKML4sgI3B7yGxKU5OhjO7BLDLxb9Wyd0=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr31925998otd.91.1581015546219; 
 Thu, 06 Feb 2020 10:59:06 -0800 (PST)
MIME-Version: 1.0
References: <20200206125132.594625-1-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2020 18:58:55 +0000
Message-ID: <CAFEAcA9nih8pU9mGsMmx3nqkAQor0x0LE8Kz1DmPgSZGGU_iDA@mail.gmail.com>
Subject: Re: [PULL 00/17] Block patches
To: Max Reitz <mreitz@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Feb 2020 at 12:51, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 418fa86dd465b4fd8394373cf83db8fa65d7611c:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-040220-1' into staging (2020-02-04 18:55:06 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-02-06
>
> for you to fetch changes up to a541fcc27c98b96da187c7d4573f3270f3ddd283:
>
>   iotests: add test for backup-top failure on permission activation (2020-02-06 13:47:45 +0100)
>
> ----------------------------------------------------------------
> Block patches:
> - Drop BDRV_SECTOR_SIZE from qcow2
> - Allow Python iotests to be added to the auto group
>   (and add some)
> - Fix for the backup job
> - Fix memleak in bdrv_refresh_filename()
> - Use GStrings in two places for greater efficiency (than manually
>   handling string allocation)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

