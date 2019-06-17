Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005DEC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C655E208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmPnYfh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C655E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuaQ-0005Lp-1L
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcto3-00073F-HR
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcto1-0005Jb-J0
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:44:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcto1-0005HE-9o
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:44:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id v14so10516076wrr.4
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZuyWPwI9zsRq98f3yZ1hjodiotWK5DdnDD/mWU39P20=;
 b=nmPnYfh8OoM5hy944hTfzzKFPS7nXo+3MduPr4ey6dku5xS+jeACbwVv8ELaCyLsoQ
 AM7BNVxJ4tDRGq0xCZj7qwUb3Iy6vcVEKeXhNsYx0Xpo3nUJKscfdygocQuGLqDc3giM
 n1WShpcaC5eyzjBKoWtQmdgLbqvw28pDZrIBlHinWGjjyO7VfMYIFnDc+FWH8U/uRHTJ
 yBOKoeQtaZpQFATDL6AUNuAEoo8vrVF33z9qOxGk4kVtm3ksdlJSWvw/x6/fTEX2V1JY
 Xp01Mqst3NcerXUSTVLHKFIwgjgQHDx9jIzcHZPRuvCEcjXhZmeAGz4DYpl0aieNwNT1
 qBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZuyWPwI9zsRq98f3yZ1hjodiotWK5DdnDD/mWU39P20=;
 b=KPzGDVodVhgmgb5zyE3iEnnkUeCkbqxXaeAuoCcKc2qf8cIusB55TGNafe0FuKDtFz
 5Sh3pDI4vWFkrzjux9QzOl6iuYQGQvd1gru+waIs4df+sd5yyHF/c/2T0mF1sLTEJ23y
 9C7AmXA5moLwuNjur1LNhSmIc+E0ekUIritN4Zb2CmyrWjnyBgsfhjUEPYxjWvrYaom+
 iuzPrQIsvIpoMCnbwhB+3bYi1BZpiW613A2FRpzJDRBnu+hb2r0qto6zG+A5OxE119d6
 WFUq/mUWkEAMfGlDQOZXW2Vw6unrX6fLQLwI39I9KsUxo99Kgc3sh9qY/FaJUvCKQF4w
 O4ZA==
X-Gm-Message-State: APjAAAUj06ZY1lIW706nG5eOCG0I/7o7EAI/hgnCopypltcwLxPfsZWD
 4QViOqgAhhS5n+4Hi6Ft1abyzA==
X-Google-Smtp-Source: APXvYqw7FpZ2Yy7vUNiPaEnYnN/RSgeG72DggBxKSVmVXdqYREw5JIz9B5Gt80S6g9/YgjdzyzDvkg==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr7690856wrs.74.1560786262936; 
 Mon, 17 Jun 2019 08:44:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g71sm4125872wmg.7.2019.06.17.08.44.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 08:44:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 00E271FF87;
 Mon, 17 Jun 2019 16:44:21 +0100 (BST)
References: <20190617043858.8290-1-kraxel@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <20190617043858.8290-1-kraxel@redhat.com>
Date: Mon, 17 Jun 2019 16:44:21 +0100
Message-ID: <877e9k9pyi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v4 00/11] tests/vm: serial console
 autoinstall, misc fixes.
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> This patch series changes the way virtual machines for test builds are
> managed.  They are created locally on the developer machine now.  The
> installer is booted on the serial console and the scripts walks through
> the dialogs to install and configure the guest.

I've tested this on the previously failing box and it works fine.

Queued to testing/next, thanks.


>
> That takes the download.patchew.org server out of the loop and makes it
> alot easier to tweak the guest images (adding build dependencies for
> example).
>
> The install scripts take care to apply host proxy settings (from *_proxy
> environment variables) to the guest, so any package downloads will be
> routed through the proxy and can be cached that way.  This also makes
> them work behind strict firewalls.
>
> There are also a bunch of smaller tweaks for tests/vm to fix issues I
> was struggling with.  See commit messages of individual patches for
> details.
>
> v4:
>  - rebase, drop patches merged.
>  - use in-tree seabios binary, for serial console support.
>  - some minor tweaks.
> v3:
>  - python3 fixes.
>  - openbsd: configure memory limits.
>  - freebsd: configure autoboot delay.
>
> Gerd Hoffmann (11):
>   tests/vm: send proxy environment variables over ssh
>   tests/vm: use ssh with pty unconditionally
>   tests/vm: run test builds on snapshot
>   tests/vm: proper guest shutdown
>   tests/vm: add vm-boot-{ssh,serial}-<guest> targets
>   tests/vm: serial console support helpers
>   tests/vm: openbsd autoinstall, using serial console
>   tests/vm: freebsd autoinstall, using serial console
>   tests/vm: netbsd autoinstall, using serial console
>   tests/vm: fedora autoinstall, using serial console
>   tests/vm: ubuntu.i386: apt proxy setup
>
>  tests/vm/basevm.py        | 135 +++++++++++++++++++++++----
>  tests/vm/Makefile.include |  23 ++++-
>  tests/vm/fedora           | 189 ++++++++++++++++++++++++++++++++++++++
>  tests/vm/freebsd          | 180 ++++++++++++++++++++++++++++++++++--
>  tests/vm/netbsd           | 187 +++++++++++++++++++++++++++++++++++--
>  tests/vm/openbsd          | 159 +++++++++++++++++++++++++++++---
>  tests/vm/ubuntu.i386      |   4 +
>  7 files changed, 825 insertions(+), 52 deletions(-)
>  create mode 100755 tests/vm/fedora


--
Alex Benn=C3=A9e

