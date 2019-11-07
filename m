Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAFFC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BE5218AE
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3vVBeJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BE5218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkG8-0001ye-O6
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSkE6-0000PM-4O
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSkE3-0004Za-J5
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:01:37 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSkE0-0004WD-Tz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:01:34 -0500
Received: by mail-oi1-x242.google.com with SMTP id k2so2361363oij.12
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 08:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XF8HiDjqlxT3Z3TpSmJy4SxhUhmRE18Xsdo93PIUvGY=;
 b=Y3vVBeJi3VIuavphFURgnFuzs0JBej2wBzqixfWT055JGrOWUhiFprgYU/3GyoNCXN
 tnKYtIFv/5Xd1IjdmBTd7ovqKlxQxw0djKRZCq3w9G0SVUAJmYDBhdSLLeA4oelva2PG
 03jDBMZSOzQP/8IFykBeF3roKAc66Bj4yypqFrDbrrw19NVty61MGCELFLLFvwt/Ryes
 ewf27vaKbpgTOSdqpqSydQ9YnAARM5subR88Lid/KT6OpnO4ZlE+CE6MxWYllG8f/C0Z
 Xupa/w4+uyEQyJy0tEhB1Rr/x4jlEYrLalayqGzfkk2nMjlMLU8i1VbXm6k7HT8l7k1E
 SaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XF8HiDjqlxT3Z3TpSmJy4SxhUhmRE18Xsdo93PIUvGY=;
 b=Bh5al2A5X7LLcdXlvoxiZ7v3rtrzp5RVAM2JLl1IJpWqxcnT6sIsQKQ+M0V0px77+G
 tiTehPnwnPJuIroK7GzmZJjd+BYfURL/mwbeUOo3jSqOXT+KP3oDdnmKPzSVbPVirIzY
 tTH9AibPdbDvQdcDS1KghWEONALhfE20GZzZ3Ha3cxt7HybOxxknW1/ptL6rxBqT9cbZ
 +YEROgIbiIC+2lv36XkgFxnO+qWY01J4wapcwOB1/ssEH7eVA21BDKNF6yBIaHErk6sH
 hVsX5Wwc9vi/mGAR3EkfWx9Sn64rXZs+gjna6JQP77aVINsgmVkfpeYdE4qiK4H9V0rt
 4oSg==
X-Gm-Message-State: APjAAAU84RUyb/otmYBAiJDXCjqOsBYcuvzZHZHbVvMlOCNwgnDUx9FE
 1oSkmIe5sakKJhAXWy7Wl6MDNk2bj/MypOOJUrAt2A==
X-Google-Smtp-Source: APXvYqygRa93ofqeG+bPS5EVwUazFeS76+F7Dwh56jIzzBKElIe8O/9vd5bxJnC6FYF377DIQ5BHfzehfOIOFh+P4Po=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr3953528oig.48.1573142489810; 
 Thu, 07 Nov 2019 08:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20191106145127.23700-1-marcel.apfelbaum@gmail.com>
In-Reply-To: <20191106145127.23700-1-marcel.apfelbaum@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 16:01:18 +0000
Message-ID: <CAFEAcA8nfOA-68XLF4JYnw4iXnWRuxgXmAV31Zg4Z+6D2pmJNw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH PULL 0/2] RDMA queue
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 Nov 2019 at 14:51, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
> The following changes since commit 412fbef3d076c43e56451bacb28c4544858c66a3:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-next-pull-request' into staging (2019-11-05 20:17:11 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to 68b89aee710ab48b3dcaaa721bbc5d8aa5ea24d1:
>
>   hw/rdma: Utilize ibv_reg_mr_iova for memory registration (2019-11-06 12:49:04 +0200)
>
> ----------------------------------------------------------------
> RDMA queue
>
> * better memory registration performance
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

