Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A447EC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 12:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9952175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 12:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHZd+WrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9952175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42625 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP4iD-0003wc-N0
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 08:33:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP4hK-0003dT-5u
	for qemu-devel@nongnu.org; Fri, 10 May 2019 08:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP4hJ-0004Pj-5Y
	for qemu-devel@nongnu.org; Fri, 10 May 2019 08:32:22 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:42870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP4hI-0004P7-QE
	for qemu-devel@nongnu.org; Fri, 10 May 2019 08:32:21 -0400
Received: by mail-oi1-x22f.google.com with SMTP id k9so4371417oig.9
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=v36ddZrZlPT7wCUcB10JWm7aAbtUVrwXrjFHd1W0s40=;
	b=cHZd+WrO6eiuqVqtdymRd7VK0qYFINtSkr08ame37/nhvdLGTgB5h12i7zTjxMWK9g
	GQRS7gJ1KkOuHDS8JmQrPZ+T1uLM1TBfiCi4f63LES27zgUIDUbz4elaqS6+8PmQy1+x
	B2ioQh00zktOcWH0hKEfcNOTRRNOfAWFJg6reRIKZwwkyJfLeLAf5fpA5nmT0vRngvZm
	V56PggKyMxC3iohurHrCbUTWacWZBhWv5vO4kUNC2BBgqayX9BO5Pqu2dQbMfaLZf9c3
	r0LjcjzT3CRjBAaL3lZPRB2J+rU3Ag3Vxf2kp2ryXGLpJNnnq5oCUITwHw+lI7A0kBWY
	3svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=v36ddZrZlPT7wCUcB10JWm7aAbtUVrwXrjFHd1W0s40=;
	b=gL+WLyVCIreS+V5RWwXf8QQbYDkaHjBLc9tXQGBFMw7cvmuCsDdIlaN67lGlkUr3N/
	jHKGFxYcQYgwLRqBEKQeC+g2JWGD1zuJRzro1+fa2KbT8qjVzJp5LvUTBFb9hKcBYKJx
	zn1hJGtnQXE7QwCrAN3GK4TsobeLJ4vwHyWykbuiO2/0fPONs0y0MxAq3l8a5z/3NmuI
	/HfXQuZ5HdbQkrx3baCeyUpYov6W/lKttF/Us+NWt5Jiefg4FvhLO7eU/eNMuh2GvAvt
	Fcznx2DVoHKeOBkXY+HbnkoIn+qBmwOoCYixpbt3Ah0isdxb5/MvdvEGRl4kzDNjWLAV
	bJoQ==
X-Gm-Message-State: APjAAAUGZ361g54I6ptWbVPrWu4Y6Rs8SHoT0731Oc7maoc8mLpIMHbg
	ly3FWQ/MEbvOMV/lsZrJe2ue6G6ls4juri/+lxCdgA==
X-Google-Smtp-Source: APXvYqyOEk9RGLgGk0LNDQoC5cqepY/8hTZ6VyohuMyWNixeZbAZwVsXE/NZVPNXCZGvfyrvWi61CAzPfZbGG4jkGiA=
X-Received: by 2002:aca:b783:: with SMTP id h125mr4961355oif.146.1557491539832;
	Fri, 10 May 2019 05:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190510104536.17483-1-laurent@vivier.eu>
In-Reply-To: <20190510104536.17483-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 13:32:09 +0100
Message-ID: <CAFEAcA_cTXV8a_G+uPiBOXT0XUYNeEDskeT6jH2eii9dNH5Wtg@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PULL v2 0/7] Linux user for 4.1 patches
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 11:47, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 68a7b9724fe80bedb85060bde605213ce3f9baec:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-05-09 13:36:10 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request
>
> for you to fetch changes up to 9b21a36cd333f3f9a1acb379f5f4f4928ad84a06:
>
>   linux-user: fix GPROF build failure (2019-05-10 12:44:23 +0200)
>
> ----------------------------------------------------------------
> GPROF fixes, GCC9 fixes, SIOCGIFNAME fix, new IPV6 sockopts, elf fix
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

