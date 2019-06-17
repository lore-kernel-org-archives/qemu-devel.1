Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18EEC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC53C20652
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFFGmunR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC53C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49936 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcv7W-0005UV-05
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcuDm-00045v-M8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcuDh-0005Af-HC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:11:02 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:42355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcuDd-00056k-Cx
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:10:56 -0400
Received: by mail-oi1-x22c.google.com with SMTP id s184so7397204oie.9
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=zhVdBGwkEgCGSCEABkbGoGJC5V1QS+v9IpkM7WsdPBM=;
 b=GFFGmunRYdmEDr2ddzIa4aLlpflfx11hV6XRf0ITLT4OuTRU7lg49NQqKooYx1M9Dx
 WOGJBPx9ZChoA620OtANdPZHB9vRjzEXD3p4BTjXt8QDLyIadjNvGM6C+ljlxURGHS8J
 nuzwbnMtiTgODLSx0xWqP12S6AePPutWb31XuvqyKK1NeITKZf9hvUihmG10BxL6aH1C
 5K5rro4aWmEK7yRS0TZ+E+OSwydWvRwy3DQtGO5KrTv657ZyaospRFASWlkUqTSWe2vZ
 pt3la4hpAZHf3vKzqX8YQUFmpTnMTRyIMtVCAue7AREEwqpqdYlPVwU+VcuLlntXYtPv
 XrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=zhVdBGwkEgCGSCEABkbGoGJC5V1QS+v9IpkM7WsdPBM=;
 b=UuoSJfCpB5MGIZ+w8/5AcspXryOReVENXUpIo6J3bQnB2AlhJpMRE7F4m+hNE/WTjS
 Z4/zGeyKqh8WgmwXxYuhcLyJ4vbGKnqojhy6O1ExQ/6ItGDslandBkHzJkf2gMxBJ8rY
 6t9BAJJ02OOtoG6fS4NW1PixomKhTAjXqMoqWOflgkPYjw5v58CTx7C6q7WX+tYenxvN
 nxZLobct4njmLYEJ/nSxGPhSm9VapDeA6SqzjWp2bW6zi61kXv8dvMj70oUgDhHScbFy
 gBFOrLHkKc7vvwVfor+X1Vm52nn4GL34fQiku6/DbkJgBMedOKJDQzqYiR2eEjzfnyGq
 1FfQ==
X-Gm-Message-State: APjAAAUfKGf38K4Cbhe/rAFUdqVWR3f5TqcBm7C3ubexulx9SdlEJt1I
 RKyz8wCUGo9hEzRdmdy4Po35z36Tjc6f1fxqKLLJzDc3SkU=
X-Google-Smtp-Source: APXvYqzYr/e5+SxhKspDp0mQYBvJIkx/ybtnejYhWilrmKddxpi29mhoRYnLqcxm26pwV7EqYv5qL2rvcfRdFuIs/1M=
X-Received: by 2002:aca:6185:: with SMTP id v127mr1960670oib.163.1560787851897; 
 Mon, 17 Jun 2019 09:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190617145740.9881-1-peter.maydell@linaro.org>
In-Reply-To: <20190617145740.9881-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jun 2019 17:10:40 +0100
Message-ID: <CAFEAcA861J9fcV-kXB7SO_X1W2UMJSBJTu+DDk=M2krxiBcf4A@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Subject: Re: [Qemu-devel] [PULL 0/4] docs queue
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jun 2019 at 15:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> I thought I'd put together a pullreq with some of the sphinx docs
> patches I've sent out recently, since they don't really have an
> obvious more sensible route to go through.
>
> thanks
> -- PMM
>
> The following changes since commit 5d0e5694470d2952b4f257bc985cac8c89b4fd92:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-06-17 11:55:14 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-docs-20190617
>
> for you to fetch changes up to 0783a732f9ee2de28dc722d6cd87f04b2f264a48:
>
>   docs: Build and install specs manual (2019-06-17 15:35:31 +0100)
>
> ----------------------------------------------------------------
> docs infrastructure queue:
>  * fix some minor syntax issues in docs/specs/index.rst
>  * build and install the 'specs' manual, since it now has some content
>  * delete the "QEMU compared to other emulators" section of the docs
>  * Convert "translator internals" docs to RST, move to devel manual
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

