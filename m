Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8DAC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AFF20863
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qv3iwLO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AFF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8mUK-0007O6-2m
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 09:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8mTh-0006q1-Ll
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8mTg-000770-Bt
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:55:29 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:44043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8mTg-00074G-6J
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:55:28 -0500
Received: by mail-ot1-x32d.google.com with SMTP id v22so5422079otq.11
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 06:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eGGq82rBD9XqOxltigPJ5g5kMU1Zjw3nV6fJAWTrx5Q=;
 b=qv3iwLO0xEk01uq23NecosWnp1iLdu1TZ0DjkFYkiL55X0dcDqP2T93mYPrZL6UJIp
 V6A14a6+XSZkMd7O4ypblEDXicZgqrN9MW3t1VGJ6zwRUZKsLUG3TY1eOrzYgyNDpzTA
 xtDxtbPQNKogkKxA+sNP2F9N08OUbOOmc//lQ3WmT+D0MsMWdua1WdhV/1WLVDVH5fBS
 OrzMx/xAjI9leSm7+RkLDZjmrQDCiQFpChxV84bCldUeayM3suSgSEuGOjVgRtdYoFAU
 +eoRwAjEUSieVAiBcuIHGQ6RenBe0lPjE+600YC7Lb0CbJ4hT3H2HNhIBUFJWRvvhNx7
 jIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eGGq82rBD9XqOxltigPJ5g5kMU1Zjw3nV6fJAWTrx5Q=;
 b=ZOp2f41VfrAcpoPyNiQm0zScvEEqL1k1abR5hzmmLXhc/GbLRk15zZa1Qjldhf6PbE
 CxUlB5G6+hO8Wh1iMxJuzXiSBCAfVdjaYYo7KvfcMNQ+Hd9mkGFP6eEunw0p75SKcEWa
 2EybA4ytbWY6OzEwJDev/82IXlG5cgSqOXodNqa/fNbMAnhabn+I3DuqHbODevJ/1HW5
 M6sWEx+3UVEX2P4HkUJO73MjQAJHMKRmgLqAV4twa5E9ksSdsf/wcA6wUSWEU5wKUmRI
 +qctTCuPBtoOR7v2I4JOP1QrgmFq3ebSxeMYHYGr1nKvlMgMTpAPqYTtUjj2PixBQp/s
 EF8A==
X-Gm-Message-State: ANhLgQ12NRs0RmG+Jjfw0k9z35OfGQk0mG36swPqNOJO8YiOm46Dl4oV
 oXbL5vK8QJ4yZP3CUjT/PGmGLP79694nzNOhSaAzfA==
X-Google-Smtp-Source: ADFU+vvX84MW1EbR8jPfAuxmo7TdadrQ4hfQ84JjSqvSJJPspKT1ypvL9SzCAF/ntCHcLYLhuF5QT+B4ssHT/Whnhss=
X-Received: by 2002:a9d:75ca:: with SMTP id c10mr2341815otl.97.1583160926990; 
 Mon, 02 Mar 2020 06:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20200302091836.29012-1-kraxel@redhat.com>
In-Reply-To: <20200302091836.29012-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 14:55:15 +0000
Message-ID: <CAFEAcA83k4ZargGVfRh0s_41yvcHShuxtno3G9RvD1e-KEmnBA@mail.gmail.com>
Subject: Re: [PULL 0/2] Vga 20200302 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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

On Mon, 2 Mar 2020 at 09:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e0175b71638cf4398903c0d25f93fe62e0606389:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200228' into staging (2020-02-28 16:39:27 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20200302-pull-request
>
> for you to fetch changes up to 44b5c1ebfa5db337714180e9d4a8d525da5595d6:
>
>   qxl: map rom r/o (2020-03-02 08:24:36 +0100)
>
> ----------------------------------------------------------------
> vga: bugfixes for qxl and edid generator.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

