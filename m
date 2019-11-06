Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B39FC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 22:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507692173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 22:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UB5lVWJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507692173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSTT7-0003Mu-Bv
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 17:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSTQF-0000D5-Q4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSTQE-0003n3-Bb
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:05:03 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:35073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSTQE-0003mV-5G
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:05:02 -0500
Received: by mail-ot1-x332.google.com with SMTP id z6so188453otb.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 14:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IyNqqP/oRJ/tvX96Oj9UHOsfnD2XhEjUF0iB8lJoJcY=;
 b=UB5lVWJjGNAnmhR9Bf2nUMHZVHCZMijoUmm0IGLgTam2WygTOXpUMU87jsmEfVIPLE
 YErx/b6I6mlD8AmKJTz50aYVVFUK8fiuZSLrzvP7CamRWbXoOHxdXa1KmyBBitbotH/N
 hu+o2vgxFh5Yctvswmo1xS7xqh00csPfA16SJYGC97uN6TQyaAY5t/SXxv4dIv1G3J8K
 mVW4w31PryakxEH2ioQ7O+7JJ+hKsdwGo1owqZeyNKh5kzQIf4XKJgkSonId3WDGSX4o
 6VRGQphMCm3b3DXy5445VSBWJC4tzVMCJj3ssvncnufVO6TT6NX8I5kyzTwo7o5rbrjT
 4JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IyNqqP/oRJ/tvX96Oj9UHOsfnD2XhEjUF0iB8lJoJcY=;
 b=ZdTfmKCI5JOyz3n3RFVSj8c7rED4hSGYKoBv4OOVw8MkPdoaso1YmPJ1lfJXjmYL0r
 4SsnpS5UlZeX2bRb0FMBcKAUnO1iGfcpayPkST9uj3U2UbqXEZSxy9CUIv/roRpvrvAB
 26S62d9YCHfcRODs68myVq86oeyQH7b+EpL36fdET1mRXbBAlhr5MYK1/5fJiurL0GNa
 eudC4NMrjkwQcqWD8NpanK8ZPzArGMa+O12ilhAuAZT7iIawT//SzkqRVMYoNSX0wHrX
 Fl3X1bGeWg5xJNouD38mItrcCdFIuKYo1YlmQnvzd9CUWlNBcs5pqagDbzj8GdlxMJ70
 fAdg==
X-Gm-Message-State: APjAAAXzzXY93k1ZI0qnzR/TcP+9TxhjlKQO96TLmEHq6FrTzeAE2OV2
 DEpBlsiGewx684jXPz06Cvjd+SEuRKL3Z5mqytP0Zg==
X-Google-Smtp-Source: APXvYqzwRXcQHonpRl6Xj2NOAQtj/wiP7UwFKFD1msmnmhr11BbQTrGOZTTK1bC2AHpqZeffk8xRxhZCiAhpW2G0ITg=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr18033otg.232.1573077901289;
 Wed, 06 Nov 2019 14:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20191106130456.6176-1-laurent@vivier.eu>
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2019 22:04:48 +0000
Message-ID: <CAFEAcA_gjo9GxTX4Gv_rabV7NU3Nf1MypR9EGqK3gs+VToMbaw@mail.gmail.com>
Subject: Re: [PULL v2 00/13] Linux user for 4.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 Nov 2019 at 13:09, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.2-pull-request
>
> for you to fetch changes up to 5849dfe410b3fefec7d54a536cda7ccbf809ebea:
>
>   linux-user/alpha: Set r20 secondary return value (2019-11-06 13:45:05 +0100)
>
> ----------------------------------------------------------------
> sparc/sparc64 fixes: this doesn't fix debian chroot for me
> but they are a step in the good direction.
> Fix Netlink support.
> Trivial fix for alpha
>
> PULL v2: fix checkpatch warnings
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

