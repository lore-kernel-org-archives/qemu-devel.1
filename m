Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC0CC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8997320702
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bMspoWr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8997320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8IM-0005Q9-OL
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ix8Dy-0007yW-0x
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ix8Dw-000549-Sr
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:43:05 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ix8Dw-00052m-Nx
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:43:04 -0500
Received: by mail-oi1-x243.google.com with SMTP id p125so3150340oif.10
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hl+Nbeb/u0lzZbjMZh/WXxvOYL3bxb/9cXhNWvpCAFg=;
 b=bMspoWr6zOkAZ40kvFMA1rwHSXr7b/Ho6S/YW5JVqcmt44NfTfN5aS80xyj6ht5GxP
 EqlBLD0HvZtk6C9w4bhGg30xlYN476mSXY8m2DRAku7f8SAL8Y3X7tCRQiNxl8mUPwUW
 IQ6jg5NuJNGWeFNwWuaB+nnL1+9DoBJEgBWn+INXS+HK8dZMzn/4bkVBJ3pocBJamq4d
 WYavNWfqPCBb/OdqH/R9buR3Z+6ucSc6W/6clQ6XQIvFWfYuUhKIFTfzznMKGLIS+3O1
 6/rPlRyNbTQKHYPVdXnP8VMrvM+eHzkUERhJoVtXGoGdqfsZbEoRG6WQjOhmCgzNMVpl
 TEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hl+Nbeb/u0lzZbjMZh/WXxvOYL3bxb/9cXhNWvpCAFg=;
 b=VQRnZX++NaARG9GeycVQ0IcF0Mt6LTjUc3xngWeCwRCWgclw9xPibiII/QcBdEKgRA
 cmjTEYugYU9gcIGuFUP5D+jzWLoUZ1L+VfzQJipjYRagKbPm9FgpTYF1juV7kfXHrr6J
 J3WhRLAA2vvowClja+DA1RNMP6N8V6s9O0pWI0co4C9Pl9wOSOO+1zaKgNKJ35j1I6jo
 /s4BVfgupj68ocMe76wsTOqOi21udVLphAsVbgtPQNslTP8gxQFIQlkyjsCcU2FkWVDs
 BMEYhTw+0RZepnVZ1jV1MAIFvfgo5BVm04uIAoYxJ7T5qKs/Lnja2Jq9p0U7HaJSo3Ga
 5caQ==
X-Gm-Message-State: APjAAAUbhY5XuY9ZrrLOb+3PsodvRNC5SwsJjkVoOHqKa71TAYID0Gwl
 XNU19ZVWPu4SAktemfxn4RfABjVzthK/727Sa1Lq+g==
X-Google-Smtp-Source: APXvYqwsrBAdYaO+/3PpP+L0hwzHfdANwQDgNAcL5Yo8g+Lx7mShykMubo/ucHSeaoUEkqb1NdHztGg+JMboWhqT3ek=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2475112oie.146.1580384582183; 
 Thu, 30 Jan 2020 03:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20200128010707.19572-1-jsnow@redhat.com>
In-Reply-To: <20200128010707.19572-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 11:42:51 +0000
Message-ID: <CAFEAcA9LQ6pwfVGiypAGmuyQuNeaRxe0VhrGCkiWCg4NeFiN9w@mail.gmail.com>
Subject: Re: [PULL 0/2] Ide patches
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 at 01:07, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 105b07f1ba462ec48b27e5cb74ddf81c6a79364c:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200127' into staging (2020-01-27 13:02:36 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to 59805ae92dfe4f67105e36b539d567caec4f8304:
>
>   tests/ide-test: Create a single unit-test covering more PRDT cases (2020-01-27 17:07:31 -0500)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Alexander Popov (2):
>   ide: Fix incorrect handling of some PRDTs in ide_dma_cb()
>   tests/ide-test: Create a single unit-test covering more PRDT cases
>
>  hw/ide/core.c          |  30 +++++--
>  tests/qtest/ide-test.c | 176 ++++++++++++++++++-----------------------
>  2 files changed, 97 insertions(+), 109 deletions(-)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

