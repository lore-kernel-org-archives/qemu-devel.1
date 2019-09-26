Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EFEC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B75222C0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljAVcXy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B75222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDTNF-0002QJ-FX
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDTLZ-0000jd-1c
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDTLW-0002FQ-TC
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:58:12 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:41585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDTLW-0002Du-P0
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:58:10 -0400
Received: by mail-oi1-f180.google.com with SMTP id w17so1956346oiw.8
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZPzOU3/dlg5ml8gIc5Broya418ia4e1wjRHopjcpvJc=;
 b=ljAVcXy8P4bOevCZGafQ8AZfD+ZYHQJFDLEEnxhbW6oiaW9l33BSpFzR8FhCLGFgiS
 izjC+wjNprqxOx4YZAaj4c20fzywyKyLzoPdHfHFwp6W0HHWV2qXhp/foEfZ7pL23uOQ
 JuoxdksjipnUCX4D9g8lKHQz4geWixbCg47VVJ78os/pckzZ7LYoL8LMRXv2AV5SGhOG
 Mk5xfE0KcSXln4dh54D2hKBshgbQ6PqBYn0/fHBWK9VGjYr5dNe/CE/7x94lxWZWs7P7
 t2YP2C+z0YoJRoEefqJOYMlynGlXWxRvVdWPWD2ktaUV7fgb0XH3knFL+/Brg8/k/C81
 k+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZPzOU3/dlg5ml8gIc5Broya418ia4e1wjRHopjcpvJc=;
 b=eq3z0foQWMD0c58XUixZL4GG7lkbt3uY8L9re1QugOGGAGQ6T9vNlLJg5h9a1V61Di
 AkXg9SIYrU3pH/bnUs9b38bIv+3aCvMzdOoDIZ3Y2GMKWyD68mMw/cJD2KfyDjfVPxH5
 7PuCrYhdw/5nvg6AOTjM0vALXdg27nn+Yrb59YGgFPbZS5J4F6jznGBPuWn2O0dwLGtR
 mzekGlD5nBDgjsEXYp2DJzLL79DnUnbosJJPJrEe0A3WIXUrtO6B1evwLQN9bfnEtDP3
 nxgDb3J0Z4kfdddQZ01arFaBgjbXmt4cgSaLBsaV8PAsJre8jqLWu0CXm/bRVtv5jh1P
 I1Pg==
X-Gm-Message-State: APjAAAUXAAh7B25xFvX3nhKcrFWoUyfh32HxOKzQQxu9vHWXi/Q2RXRf
 DIWNmfjX2YdZi2/0afhmy9DzZFCJi1BoT2OMGjhh2w==
X-Google-Smtp-Source: APXvYqze7ubamJP/6zCkgA5K1p1D/inXbVAOE64/ma4zKWTifah76I4PlZhhAlwve9OLWXNVIQoDs4JvhOBqurZr9F4=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr2573278oif.98.1569502629791; 
 Thu, 26 Sep 2019 05:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190925174400.8578-1-stefanha@redhat.com>
In-Reply-To: <20190925174400.8578-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Sep 2019 13:56:58 +0100
Message-ID: <CAFEAcA89HAsDS=of_sFbaSrHo8mTrN_Mzuqkt=eR8ye3bTGcTw@mail.gmail.com>
Subject: Re: [PULL 0/2] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.180
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 at 18:44, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 240ab11fb72049d6373cbbec8d788f8e411a00bc:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190924' into staging (2019-09-24 15:36:31 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to f9a7e3698a737ee75a7b0af34203303df982550f:
>
>   virtio-blk: schedule virtio_notify_config to run on main context (2019-09-25 18:06:36 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------

Hi; I'm dropping this pullreq as it makes one of the patchew build
configs fail to compile.

thanks
-- PMM

