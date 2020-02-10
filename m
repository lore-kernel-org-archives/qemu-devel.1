Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6A9C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84F32082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRDoGS8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84F32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1DVi-0003CF-RM
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 13:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1DUl-0002gE-3e
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1DUi-0006yi-E4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:09:18 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1DUi-0006w7-5T
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:09:16 -0500
Received: by mail-ot1-x341.google.com with SMTP id 66so7262062otd.9
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 10:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=z4vi1RO6L2pZwC/JNY6BOweuUPcnUa1hKWdV5oxN7VM=;
 b=RRDoGS8qYs5VCpFf5rNfoZlqqrwCt9OvW9ZpfUjI3ZMa6qcrSrBWsl2q+U8OXT6p3v
 uXx5HUcsX+6I8vnlIJ4d9VJN6trX5loJAoWBscv0Uh0wQVjJpITzK3VL+5qSFS2hUcEN
 X7xkRvl6OBzUKcAO0wNMCgZLRTOpYoQeYqLg8Ox1m0J7Cg7xDQx7tr9+snDUvYOhNDVf
 emn3W9rk5UyFpGn9CBfkUjK1kd+48Wizi1NjQ4W8WffUhQZuh4nwkDxqo8LBDMAx7UCT
 D2SpedgSPTopH194IdqPlsmsBVGvy+l+zW2I1OxB9o+RIx/nOHEOcg8F1qfRvuWuRuc4
 HNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z4vi1RO6L2pZwC/JNY6BOweuUPcnUa1hKWdV5oxN7VM=;
 b=W707iOHchRjF89orwpRZeWDYGZkW3yIHLgeu/wMafCNh9qIaR0m+xCOC5Y8IHl9sRW
 bipgrE+Hfa3CMUdtj1BlN5WacZ6LtKhYsXABMM7H0qHnWB9p+x2qe9yw/57ivQvpqcSD
 RYQd74xEnhj6mkW7I4uZj23gBHWHf5rLVAc7quUt3PkgBMFQJhTaISe0LhSfXlvw9pIP
 SKTNMk0IIIdsaSyU7KKVEIwCYCEhdS9DMsNOL26UK3RMCQpYhZ+2BJTwudwyFYkP3EWH
 fpQp2aNrhjGplGe3bSKBgxlDo+PljQ6yFJwpYFLWKFSqdp52+QnoNIUI1+LhyiI36+nl
 WHeQ==
X-Gm-Message-State: APjAAAUgmZkxcY1n3sbqOqB3Jvhdy3+KrHUz5JWGLmg6VQLLOdVSuN2V
 Pf/J1jsiiMTC222/YPTGiN21wdra4uug4Ix7HoLWTQ==
X-Google-Smtp-Source: APXvYqzzACkc9g6T6+PstP96+T4Z8k288XxTvQQPnxyPypiQ8dhdCfGsxV46sWHx/ucdC3/gnzEOmIW7h0I/vgEKrGw=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr2014114otd.91.1581358155197; 
 Mon, 10 Feb 2020 10:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20200210092348.398611-1-stefanha@redhat.com>
In-Reply-To: <20200210092348.398611-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2020 18:09:04 +0000
Message-ID: <CAFEAcA9QzVVqRQmB3QS0Q_bn+-6itvH6HCJftU8DFdrjGAHgcw@mail.gmail.com>
Subject: Re: [PULL 0/2] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Feb 2020 at 09:23, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 346ed3151f1c43e72c40cb55b392a1d4cface6=
2c:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-2020020=
6.0' into staging (2020-02-07 11:52:15 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 11a18c84db4a71497d3d40769688a01b6f64b2ad:
>
>   hw/core: Allow setting 'virtio-blk-device.scsi' property on OSX host (2=
020-02-07 16:49:39 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   hw/core: Allow setting 'virtio-blk-device.scsi' property on OSX host
>
> Vladimir Sementsov-Ogievskiy (1):
>   block: fix crash on zero-length unaligned write and read


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

