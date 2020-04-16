Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414CC2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2362223E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0sQuH2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2362223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP70Z-0003tL-Ai
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 12:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP6zg-00031j-Ay
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP6ze-0003gQ-K0
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:03:59 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:42583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP6ze-0003fc-5d
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:03:58 -0400
Received: by mail-ot1-x32c.google.com with SMTP id m18so3462548otq.9
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YZ7FZUCG6E/8A0qT5X6zwhcgww7/8KEms9BuoWt4UoU=;
 b=l0sQuH2KsuISlAoM+lEiQJnMOFjTZGwmMniS8PHbcgXB3HoxugzgpG6PPKLdsZGiT1
 Tu9LH5d4bkBSZIgnG4dicepBpnDkYLdjOLrHHNahT5cvNOP2uGYjpy9+agAKLCj0Hl47
 pY+/71Mgz6a7HfG9k5Aovx0Uh8OelgWAupy1p/Jwe8/f5LuEFBsTBP/sec1w5/G/vs/a
 FtI44UIyK1khEaFMhk9LCZgbDydP+Ov1kXIQrprg2/EPXjnsUZSXshYs4nsUl49y7BCB
 OAb2O75MD3GxdCFwouR37faDPFQecBFA13FDQhqqqp/ObJ4VYQihz8vh+/MK1zGXsV5P
 MM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YZ7FZUCG6E/8A0qT5X6zwhcgww7/8KEms9BuoWt4UoU=;
 b=EdEGRm1iXFVBUOMX9jzD7JewKaB3eBVRFdmrlknlvj+ZNZ0P7JvE5nLVDvcTtdEl1N
 BMc/NJSQ8nxKjxzQ0v27dXTb62LiuEun4k6ezgVo2bBUag67tSmzs6hiDlCJpDc66fDj
 Oca1CYnXOM9vmsd7pzApA3l5RIhnM2Kcm7WVO3YvG0q+Zu5IxYUZBVOGcqWioJcRuKXW
 tFR/8clAFSXqBBLFCMe7jg9+sKkWc15V0Zjm5UQycc2FAum44m2MuV9WB/V2pV/HITQv
 1XH04sBmzog1eM4HllqYUIQetLbAQUpc0qDhN/0dgXd7kxBht6f7/mGOVks03s/xfPhx
 tPZw==
X-Gm-Message-State: AGi0PuZzzgHcleDzhwIgo66qcBk/3ZcKJ4xxmq/mg7AANrTCdKkgl72l
 TublrE0lesiwF0tKv2U0XUQcwoepicQ0wSNng8f18A==
X-Google-Smtp-Source: APiQypJyEI/jEj1dDPZiQQhewHRV5Q+Jg8tg/et8AD1EobtwOw2EoQz38dZ2VGtV4fSE//h9ZNhxZ5uLMasvtDhqxYM=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr8705701otj.91.1587053036729; 
 Thu, 16 Apr 2020 09:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200416152829.790561-1-laurent@vivier.eu>
In-Reply-To: <20200416152829.790561-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 17:03:45 +0100
Message-ID: <CAFEAcA9J=H7RMEEY5BmL=2ObKJDzMQQeWvbUnYYJfxFsntbP6w@mail.gmail.com>
Subject: Re: [PULL 0/1] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Apr 2020 at 16:29, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 20038cd7a8412feeb49c01f6ede89e36c8995472:
>
>   Update version for v5.0.0-rc3 release (2020-04-15 20:51:54 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>
> for you to fetch changes up to 386d38656889a40d29b514ee6f34997ca18f741e:
>
>   linux-user/syscall.c: add target-to-host mapping for epoll_create1() (2020-04-16 09:24:22 +0200)
>
> ----------------------------------------------------------------
> Fix epoll_create1() for qemu-alpha
>
> ----------------------------------------------------------------

How critical is this bug fix? After rc3, I really don't want
to have to create an rc4 unless it's unavoidable...

thanks
-- PMM

