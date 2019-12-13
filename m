Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A526C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1863E24671
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mV4egBaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1863E24671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifsDS-0006Iw-3b
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 16:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ifsCc-0005HS-4D
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 16:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ifsCa-0006Pu-NV
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 16:10:21 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:42997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ifsCa-0006OF-Fi
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 16:10:20 -0500
Received: by mail-oi1-x22b.google.com with SMTP id j22so1891021oij.9
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 13:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=et9DgHZv3cNUc21+xtHFjnkOwB9mRltLZxdxMnkrJyE=;
 b=mV4egBaZUgWXOeaw5Fk3ZNF2Fj8RnEBcZ3RaotIhPoLOo0lSpfJs04IgO3rOjoeqZw
 kKnFZN2fcDkNqcgst6ebZRmCTbVLveWtO2WNiV4qeNpepyjM2qMH32xl4GwZoWzXiffi
 UJlyInGeH3FEui2ubAeNwY/docIKZLuO0BWDsk6xK+EOTD3bWyRlHi96/a9YIXt9LkHP
 q6P3kZDCtJQF1GcBFB/hngSJLhbazBwDMmKf2POMqA9uOYQ1Vm63DqL/JzzhwHrFZBkC
 oq9psNuNh9Fuy22r/xMm+eaMvqImLOBlyMdXtHi4ryIkp1f1p5rDcVNEmWkOQ4PgwpsW
 HJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=et9DgHZv3cNUc21+xtHFjnkOwB9mRltLZxdxMnkrJyE=;
 b=qWW0P4DlGyLd1eMzycuYAtJyPrOHfdRC03flRezmTdnvCElthAZmjlKMGKRbhPzUGu
 rnGgPYD4VwgJ9ngg4gWF3uTt3yxkjPqpFuqrE9oVulMX0DqG9i9PW86rBtvRxpU4M81i
 lZouXKmb6LA/2okZWxRQq2d0695rQsGI6lIWVWzpGTQtMigQTQxgn14nleZFlsgJgxFO
 StmMDWZOMr41qZ/810z0+4v1fGU+pYYYPnu488Pikykzix/5oN0ft8im2pGLclz/Tbs/
 63sa3vIclzVsNJ9npzJFS2p8jp9jyNfs1LSFhGPtU+wS+VuFNfjwoBgdTJeWMB9qAgoa
 4JpA==
X-Gm-Message-State: APjAAAVOPwTXzFqQKQoHVjHsuN2xngjN0MUDd59CBarcPUqWQ5qnP7of
 f/Ubg0HVNplK/qeCCX0vu2gMNHqN1hqKyh0+/9soAg==
X-Google-Smtp-Source: APXvYqxbm+Doh+qHOK7ddKEGVd8GkbLrigEutUG8A7+aHvJy0EywpAy390aWXc/El3rG1otbvUM2ObGW9nOwZ7qRw70=
X-Received: by 2002:a05:6808:2d8:: with SMTP id
 a24mr8184541oid.88.1576271419028; 
 Fri, 13 Dec 2019 13:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20191213143314.1198821-1-stefanha@redhat.com>
In-Reply-To: <20191213143314.1198821-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Dec 2019 21:10:07 +0000
Message-ID: <CAFEAcA_8zAXcZ+e1KiTkJx19bg1gopWyh48EGacbZasBY3PKiA@mail.gmail.com>
Subject: Re: [PULL 0/2] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Dec 2019 at 14:33, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit b0ca999a43a22b38158a222233d3f5881648bb4f:
>
>   Update version for v4.2.0 release (2019-12-12 16:45:57 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 86d2a49b41832355ab50cf60cec0cd50680fc0e5:
>
>   iothread: document -object iothread on man page (2019-12-13 11:24:07 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

