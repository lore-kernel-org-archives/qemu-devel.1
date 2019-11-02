Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF8CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 19:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE2E21783
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 19:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eM8JsF6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE2E21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQyoi-0000AW-0n
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 15:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQyno-0007np-5e
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQynm-0000I6-M9
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:11:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQynm-0000HN-FR
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:11:10 -0400
Received: by mail-ot1-x342.google.com with SMTP id 94so11156186oty.8
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2019 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zPimsA8Gh9fQGgAO71ocUQL0iIVEb/d5agS+cm9E5Ig=;
 b=eM8JsF6+6rym0qK7vIPrJjQojYn4jdpqGvhGUPA8TGxuyLjFeBLIog66Dthj6K4YVe
 OLMkbvgDIhhSFJVShsNYIAhfs05EW2Bm2PhJtXsTv2/WYHspI30cuY2SqkyncL5yzuNz
 nS0zNjc2iktODNpcfeSGmyVn93Ii5nkTXE7xhtQPkXS/rEG9zTN5OthQbuwmVj7s3KTF
 yFAHkr9qh9gPah7Wh7vnTUU0GxIU30mOCmb822ihKuV7RphAdQbmSUi+1tvp1Y3GEIrQ
 c2tXcnq4VduEebTBovP5SwTSmLwfgGUgLwZc1vk9uUBpJP3s6Euqbw0yp6d9TowH8irQ
 g7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zPimsA8Gh9fQGgAO71ocUQL0iIVEb/d5agS+cm9E5Ig=;
 b=TXUzXSOIavka/zlu2QKBsnczlLiwLq39KtIbLYPF2IJ69M66ICo+U+Xwa7zSXvGiwA
 eIhe4jdjK20HxtaTSCit80x4S4+77Rs924Qx9e7IVMsICl36lpRdv/6PgeuZ9RVpELHy
 sQgtZfCznAcqrfDktUZpdDsoCZ8k5w1bQrM8jMYsEu3qlRx9G52ej/EKl0xRfiShV/lM
 Gc/ilAaHi+4Snpi7CUJaGYNTsgwQ9wNPCFn/xzgaUPJm0TqDN3M0VR26nv2RGTnib75D
 rM2j5PH+5ps7phTVsGHsNkkOjstp2nGPxSJh3RHfTUNZJwGimv9LRB2n5vr9QXpLGIZ5
 vmRA==
X-Gm-Message-State: APjAAAUCOYC3yWfIF8GYAOHwk8OGANuPWmzSZuqAIiR7fUbEhL08fMmo
 IfuPv/WYJFTXr0nXskwWbLoRT2uh/l2+rSYXNuT5KA==
X-Google-Smtp-Source: APXvYqzREGGHeYJrOgoM5qlZrvt6Dv514oAFYm6HlGkgQn/1b8ew3zQgsaxHCk7Y01NiX55cCrzuFwyZxRNoX4XmUdU=
X-Received: by 2002:a05:6830:c3:: with SMTP id
 x3mr10354275oto.91.1572721869296; 
 Sat, 02 Nov 2019 12:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191101161654.2871-1-palmer@sifive.com>
In-Reply-To: <20191101161654.2871-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Nov 2019 19:10:57 +0000
Message-ID: <CAFEAcA9hPWTguDeM=BxbgVBq5yFpRfToMUJV86Rp0siCJUCOSQ@mail.gmail.com>
Subject: Re: [PULL] Update my MAINTAINERS file entry
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 1 Nov 2019 at 16:17, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The following changes since commit b7c9a7f353c0e260519bf735ff0d4aa01e72784b:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2019-10-31 15:57:30 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/palmer-dabbelt/qemu.git tags/palmer-for-master-4.2-sf1
>
> for you to fetch changes up to c1677bcc395eb977cc7279a1af0a1d23ad23fdd4:
>
>   MAINTAINERS: Change to my personal email address (2019-11-01 09:13:30 -0700)
>
> ----------------------------------------------------------------
> Update my MAINTAINERS file entry
>
> This contains a single patch to change my email address.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

