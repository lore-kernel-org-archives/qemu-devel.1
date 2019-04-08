Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E61C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356FE20879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pX4Wrzwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356FE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57679 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZfd-0006yX-HE
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 15:11:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDZes-0006W4-IZ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDZeq-0002Gr-QX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:10:18 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDZep-0002Fo-D5
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:10:16 -0400
Received: by mail-oi1-x241.google.com with SMTP id y84so11385101oia.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Bmrg/8jQOPhTkHtY73ubF19WQeon/KuaI7pHpRc0of8=;
	b=pX4WrzwvUsgMYzxQioFWi9SpwhlPdBoQwEaoN9z2EUEzAlaBRI7ppZgTB3hgw9165x
	NpvdMbb6D1Bf6PzBk0ccaCOGP9HuOAxXq3zG9hrCYjOEl59+pOO/1D0vB94TEiseOVQh
	pA/sbznWExkVkthfPaMrtUYM2QhBn1mi7FuKsIR//F0K1xE+e2HEOJRJ+mvlQtjKctqp
	YsbDQhIohnR/vvQXODmugiZAaTkW4H13S9DeFUu3+levHmXIbTJyrq7VXUatnDe4ZJAU
	RYCIa7JOBRpZiK0pgxlIb3DrXMRWz/vgcijQ8Ik+GPw1Byvd6n9uK4Plc2MvNxhhjqgG
	0iDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Bmrg/8jQOPhTkHtY73ubF19WQeon/KuaI7pHpRc0of8=;
	b=gYAQ1ur4ypi69vpfDFLA9u6cc+UTgQG9HkVXgnE9mRxzNvR7ZooJaDRR6Fn7h3VCK9
	ws2J/1rJAxWNHOMVCMGKfVGz3s6eToFPC+do3KHZc1MILYXV28UN6iGYhNnVkC6Lh7tI
	us3nGP6dWyZdIAKWNlzjp1weSeppZzwsxH4ZzTujw6ADGWYAA9PRdeFCQrSx52QCya9N
	77U751uPX/VqHQ1GleWaKaRSYoNQ4kei0W9oZV6MTQAOmIeWhpU2aVfQjvTfRDvSOmyp
	guEm9aJYumbP69fLF4qbO2YQR2XVkaPaxBzC+mw+9qJxg0odR8kPbt3SEhNIVczDxGV4
	HfvQ==
X-Gm-Message-State: APjAAAUmMyQatmbIHzCgJ9qyAg9iOmcUNgLbXvj4CkGFvYL83zLWyPhB
	L0DH4fRewZmB5Pei+U4pfBe5a04Ay8c0hFRs6rgo/A==
X-Google-Smtp-Source: APXvYqx44g5PeQtc+UcwW9o7th/FCsEh5fwotz5gOJhwjGPsc3AGNhe3cqZkx7lg/HFFRcMbfa8b7EOAw8jrtzpPIvg=
X-Received: by 2002:aca:c7d3:: with SMTP id x202mr16075790oif.48.1554750614093;
	Mon, 08 Apr 2019 12:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190408163439.18818-1-kwolf@redhat.com>
In-Reply-To: <20190408163439.18818-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2019 20:10:02 +0100
Message-ID:
 <CAFEAcA_MXn6LXD_P3iMka_1RvXctt+CmB=bZJPnf+-Pe1Dk_zw@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 0/2] Block layer patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408191002.tNZTv7thiQtZcmWGBt9W6nt_gltY-XG_Okgb4Pity_o@z>

On Mon, 8 Apr 2019 at 17:35, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit f55a585d1037e5de6088f25e75443c2776786e29:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-04-07 14:54:55 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to ab63817119b03b95f7dce6fae036e6d063ad63fb:
>
>   hmp: Fix drive_add ... format=help crash (2019-04-08 17:42:06 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - hmp: Fix drive_add ... format=help crash
> - block: Forward 'discard' to temporary overlay
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

