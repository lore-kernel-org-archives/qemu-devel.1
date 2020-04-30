Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D03C47253
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DD02073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0XHBv6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DD02073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEHA-0007x9-Q6
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDtl-0000kW-K0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDsV-0001hB-NP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:27:01 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:44320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDsV-0001h4-AB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:25:43 -0400
Received: by mail-ot1-x32c.google.com with SMTP id j4so337682otr.11
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/orQlfssKbQ1ui7bKofJaXpsj1uwPA8Cvv2XMAcBwhg=;
 b=C0XHBv6pHNJm3sS9OYzIBlAFRJ2KPJ/2pjuWVtjw3fz7AIvpgaG+prObXgEkn8gA6a
 a6ksU/WsFymP61WAB92m7joC/Yvmq9X0RwZWDaHzpDZShxFdpx7V2VMBQvqX8r+QQcmb
 P9udan1HiOVv6o+vpYw3XOydMFobi8KefTERPYt9YuuIaUWuR6Uv76YX7vzIIJsWeLSg
 UK3a2nnJS6lGVwj39hnCJmzfg+m/JaD3/DIigDQf35QbAB39N06niTN2/xheLWLuSOPH
 EMLeJY1loFwlbuM3P2pzepxhe/XH5YX+gRpcGT9X6sz/n91VtjmXmiu2QXepjyGXmv+O
 +Akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/orQlfssKbQ1ui7bKofJaXpsj1uwPA8Cvv2XMAcBwhg=;
 b=JdyB1jS7O4xZtUz/heZ3PzxV3T1jsIu/qfV2ECeGf68qvRdVNwvDmWpc+z1mvv51Zh
 kr1O9JJOYxrhzAOnDbGTNzWbd2YPu5ORTX/TnoEsTG9yjEBs2UMMBrHiA08fzGGlumLF
 UHd7Y2Vo5DemE0m04GQvyHn9eKqwWJekPdRCEWpMMshsl3Q9LvOJWnhXNqConbkMeqEv
 WIvTsvsSGH2mPz6ErZ8y7Ailri1jopzuGBQqh1GkBjPk6HiHvt4bKvxRO3yej1z3WKaC
 H2sCuMvELkx0LZi9xM207gLxdVbY9zg/P7If8+IgB4I13Vn6mHk8SdgqQ3yNw+KHXJHD
 ZQMA==
X-Gm-Message-State: AGi0PuaecMg0Lq/pZFeqRhKTdy1VmJhHJrfYryuUNjY6GO1UE9Pwe3DQ
 mMuzSkBlEISLXcfhatWcJlE7c3Bj3u2SWs2QqTBJssAm
X-Google-Smtp-Source: APiQypK4G7MM5hFhs88cm6xC7FZpTFpekY5CUzWjfhqReiev4YKNdwW7kzuHU2pHHtoODw/bsdBxNbERsUa5aZA1550=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr341117otj.91.1588271140496; 
 Thu, 30 Apr 2020 11:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200430101949.7754-1-edgar.iglesias@gmail.com>
In-Reply-To: <20200430101949.7754-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2020 19:25:29 +0100
Message-ID: <CAFEAcA9K80sEp+T4tZY4sY_bky7UyHON9g78NUPrpBB3MnF5Kw@mail.gmail.com>
Subject: Re: [PULL v1 0/6] Xilinx queue 2020-04-30
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 11:19, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> The following changes since commit 648db19685b7030aa558a4ddbd3a8e53d8c9a062:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2020-04-29' into staging (2020-04-29 15:07:33 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2020-04-30.for-upstream
>
> for you to fetch changes up to 3ed43b5031ed2d7ef501bb81b87caed960218461:
>
>   target/microblaze: Add the pvr-user2 property (2020-04-30 12:11:03 +0200)
>
> ----------------------------------------------------------------
> For upstream
>
> ----------------------------------------------------------------
> Edgar E. Iglesias (6):
>       target/microblaze: Add the opcode-0x0-illegal CPU property
>       target/microblaze: Add the ill-opcode-exception property
>       target/microblaze: Add the div-zero-exception property
>       target/microblaze: Add the unaligned-exceptions property
>       target/microblaze: Add the pvr-user1 property
>       target/microblaze: Add the pvr-user2 property


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

