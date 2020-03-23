Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09669C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80ACD2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKKqXhsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ACD2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPrs-0004Vr-Ju
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sophian.yoma@gmail.com>) id 1jGPky-0003hc-E6
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sophian.yoma@gmail.com>) id 1jGPku-0002xM-HQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:16:50 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:40837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sophian.yoma@gmail.com>)
 id 1jGPks-0002wW-Lw
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:16:47 -0400
Received: by mail-pf1-x42e.google.com with SMTP id l184so7707351pfl.7
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ObpwbCPsmGPxY2YndmjlQTbJsSagd3XfNUjtzhI0/Ew=;
 b=WKKqXhsEIRHWZSdD7rnZ1oDRFAk5ow7un7Doj76b9DZGw384rlhu7xe9W5eejldJKr
 d3HOa+uOWlMjGGwyjX3DgKwsfrguoUG5YjBWXnZGUi5ZmkJ6GR6UQFgklcFQUJ7e3Xd/
 4wn77SjLrQ7eldluQg08sBVk/REzh7BC0mByAwawpeWSfzAz2U0cNeCtM6JrBPKHDZaq
 prcRrIXrJkQsm4n4oUnaLv9YytPSHP/HYJlSPGLr52ib82Jwz966/LGdSALbSpF6JYJu
 lQDmsq9jdkTEmXr2+UeO6+SE/anCbb/FXOzA+B8vBMKZnXEvuXz2NzZYQ5LTqEceTppR
 KFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ObpwbCPsmGPxY2YndmjlQTbJsSagd3XfNUjtzhI0/Ew=;
 b=L5Sbjk5nej4ZHLpuGjSih7Xc/uSD4IqN5fyMMO6WYO8yyFJd4LzUY38Zpgup0Sk5Sj
 3ABIkg0SMOSQMrhqJ/24PHQ7V6gzEM3YSghSV9uQHW3fjJuwrvLIPFRUUQvxmRGSrkKh
 NS5SYyzSE0rzqyh0TwJp2DjQMaenKN3ku6eIwHJDqjlb1G1R0ai4olCUdUVixmoPGwq3
 SM9cWUFEU0Br2lAYli7HsPVDFR000RrBhd3RYA64Zm1dQ5tRQYd6ACdxNc8vOiTJ7aRp
 XSdop72rliB+SQAvEsU+AWbDGgP3zkV433Z7izZdDL/qwXXbmAmn2qk16frbmbuOoGGm
 b/1A==
X-Gm-Message-State: ANhLgQ3pZCEqxyzZIW7bgcFEySyLopnvUotZ7hRONneSqPq3BjsmlxUt
 EsxTogVGFGl7JTSPEbzlJqefDXDHjChfkMcghpQ=
X-Google-Smtp-Source: ADFU+vt5ZeTnNFn6KvnhbQjoYYdyyLTj0UbhpNAApAeCM+2O9jLCipTQCjPrMsoxh83qIjuKpJ/f1DKUi9XbQ4wYCFo=
X-Received: by 2002:aa7:86ce:: with SMTP id h14mr24484206pfo.311.1584980204093; 
 Mon, 23 Mar 2020 09:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <CADUS3onjS+T-SSYC6ocKNm3oXsCpiQbDa0eJobhOnts3gZ_gEw@mail.gmail.com>
 <CAFEAcA8tU58_Bdpp7tmpF+X4D5zyxpV4pA-wz97EpP41SQ7sqA@mail.gmail.com>
In-Reply-To: <CAFEAcA8tU58_Bdpp7tmpF+X4D5zyxpV4pA-wz97EpP41SQ7sqA@mail.gmail.com>
From: yoma sophian <sophian.yoma@gmail.com>
Date: Tue, 24 Mar 2020 00:16:33 +0800
Message-ID: <CADUS3o=1XSzi-DdK2gNm4-WEwPsEWc8Tfn4j9Fxy92JAg9Lktw@mail.gmail.com>
Subject: Re: qemu-system-aarch64 windows binary run Arm64 defconfig kernel not
 working
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hi Peter:
> Is it possible for you to try with a newer version of QEMU? That one
> is a release candidate snapshot from before a release that we made
> a year ago.
With below qemu version, 4.2.0, the latest on the qemu windows download page,
Synchronous External Abort still happen with the problem still hape

Below is download page I tried and version number.
thanks for ur kind suggestion.

https://qemu.weilnetz.de/w64/2020/qemu-w64-setup-20200201.exe
$ qemu-system-aarch64 --version
QEMU emulator version 4.2.0 (v4.2.0-11797-g2890edc853-dirty)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

