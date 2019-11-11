Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5077C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F64D21655
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ToER9FJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F64D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU7Kz-0000ER-NP
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iU7Jk-0007di-Nu
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iU7Jj-0000Ua-CX
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:53:08 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iU7Jj-0000UQ-7D
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:53:07 -0500
Received: by mail-oi1-x244.google.com with SMTP id i185so11075530oif.9
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 02:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TFP2CK/5AOWvVWockY9HOT59kabWlOIEWVvx853Znpg=;
 b=ToER9FJ1V8Fg2ibnvvczplvpu1UMpmnIBAWMcpxLZehTFMynB2hRodsTY8g7olAY/V
 Zts1U9SNLXweV/piXxFYIVzrYxjrbWBEcygtTl+1r8m7O0Cg306UsHoSR+9vDo6oQULH
 Xm+ABjmej9Fb/kmoYf2M5w1AkoQytaY5fUK416Bqb7QB9VEXDU0HgWuFp06rtMRjm730
 Ov3TNp/CxkRbbwDWJRCbIftQ0/Eik/vJkissKgQLghKh/N7eeQCnaQ4EpD/HnAC54AuC
 4Yhx+eppSScuvWnk59R75bPh02L7uyKTku1HScrDh0txxGiUTQQhBxR9uLZlE85IZvI5
 k36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TFP2CK/5AOWvVWockY9HOT59kabWlOIEWVvx853Znpg=;
 b=tc3mCLiSaEmoc2es0t0/qY2Yeu9VtGkvwrv0tVRWz4rLvFVK6KDw56Mpc12CaxDfQj
 oN3915E3wj7O8liqR7uoliDUwewt+80S/Gd7xvIJgguSxJMpa7XfwUtMEdAtKda7GNjL
 VXt3SiagBjmKnZy0Z5tDwJD1CNLEek4ZicLGjrs3ExxT9nWkDBDosdLExXIXGZrrkuWO
 H2vmD5IK5tAPt4ceVYMrw3PjdGY27O8dM5JZVgKgSegQyuEYkU8AJmJdh7hCeFJ4sdhM
 OpNtTrfC01MQi2HiBhRzZmKoIX0yF0uwmDD0Dt+k1ezLprbHXQam6aZ25f+y3tnrF6Q5
 8mXA==
X-Gm-Message-State: APjAAAWvEXy/qajETVXF/ONE5QZxuQ7vxC4p4Fy7URcgpzbmUcz0hPpU
 1bbTsRrDqSOYxkSdy/sFN8jNnS9yJnsRurilThBxkA==
X-Google-Smtp-Source: APXvYqzttr8YB6U2LeDQnEyQBQMIT48Y6AfA7iO5p94ZTbIdSD0zjL7K4X0q1maPwcmGZKfTclRmeogosNsqLLyb3pM=
X-Received: by 2002:aca:4945:: with SMTP id w66mr23725792oia.98.1573469585625; 
 Mon, 11 Nov 2019 02:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20191108203846.8837-1-laurent@vivier.eu>
In-Reply-To: <20191108203846.8837-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Nov 2019 10:52:54 +0000
Message-ID: <CAFEAcA8uZKkCkgp3Pi61eKvNjDzfBt=__C2RrZEeax26N+hmoA@mail.gmail.com>
Subject: Re: [PULL 0/2] Q800 branch patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 20:40, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 1cee80fa665d37411f8ad8a930b84840bbab62e5:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20191107-pull-request' into staging (2019-11-08 11:00:28 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/q800-branch-pull-request
>
> for you to fetch changes up to c744cf78791e7ddc903a46d6506f1a0cbcbb3387:
>
>   dp8393x: fix dp8393x_receive() (2019-11-08 21:32:31 +0100)
>
> ----------------------------------------------------------------
> Fix dp8393x when used in big-endian/double-word mode
> (fix DHCP address allocation for q800 machine)
>
> ----------------------------------------------------------------
>
> Laurent Vivier (2):
>   dp8393x: put the DMA buffer in the state structure
>   dp8393x: fix dp8393x_receive()
>
>  hw/net/dp8393x.c | 113 ++++++++++++++++++++++++-----------------------
>  1 file changed, 57 insertions(+), 56 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

