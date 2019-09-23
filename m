Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008EBC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 10:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C074C20835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 10:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+TO2MKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C074C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCLnd-0002ZX-G3
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 06:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCLml-00029Q-AQ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 06:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCLmj-0001ZS-My
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 06:41:38 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:44658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCLmj-0001Yz-Hu
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 06:41:37 -0400
Received: by mail-oi1-x234.google.com with SMTP id w6so7110874oie.11
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 03:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oAGv/i5xEt9gQ+bbJSSbdy2V/W8MBIEIoSR1WC+3pPQ=;
 b=k+TO2MKDM46m5rRlKgcmUZy/f0MQuOaeuAydFc/VGTMGcCFUYHrq/09qFleOndXPAT
 +TIhFWkgQFEzNw+5SLomYqOtmyqld68XrtuXuhVqReHloMzFgWS7JPCe7y+pMdveiBic
 6nIGm99xdVRFGsiLRPrh5DA6vYX0Tow9OPaeP1gyikQ8VLqshNMoxb337AneBIiRQL+g
 j7Sl1iJBCCxc1/ZHtCqSpi4HiizqeV7JIsIjBIe9JK/xPW894pJup/uQ+M7EER1zVy94
 X0wSnHMxvnVw6Ivk85g3St5GDU+SJpm+lP4tpIiFvT75eDlpw1NjgLFGUhx1WAEVxb3m
 ffWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oAGv/i5xEt9gQ+bbJSSbdy2V/W8MBIEIoSR1WC+3pPQ=;
 b=EjeybP5/ZFf4JdmGdtziy/xWNLJj12XXIOjpHX262Q+35Pe4eK2TW0bJkp2FtINE8s
 bYxyVcAdbH5y/y9s8vt4DwNZ/Vk9vHjxjKXbuxZMpNcS6+LScEr8f3KHwk1Wx3/1lG1n
 pgfjcoE3FYxrj/SqD+YQq0H0zRyRRP0DJqyxIzJZHxOdnbVPC5ESDd2GPhusaJxHz60S
 W87b/Q6JaKZgxvLiETJmODJXYhaumAdtr8mGUjCKFcXDgPdLSf69xpmrr23he4/air44
 +HNmWHJCAIjP/7TksUb3Dd6mQGZJdoSCcPzyrYPLfZ4LIR16IrYFwzdnA/N3DaTZaRNA
 1XQA==
X-Gm-Message-State: APjAAAUzIwyYPhRQfrp3gyh4N9X43uKV3bqbLh7wwmaVY+rAWyyvTC4j
 LSlOxSo5EKckT0UE2Bk50jr/06509bVHh+TzyOK8EA==
X-Google-Smtp-Source: APXvYqxMq6fVjro/swEuugezGfSAEL+i4KsQsa/hZLpgb080Lg8ye7baPcx1HKDgEIOspmZV+3Wd2xIzlXVj1cu0n/A=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr12190684oib.48.1569235296411; 
 Mon, 23 Sep 2019 03:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190920191616.GF31565@t560>
In-Reply-To: <20190920191616.GF31565@t560>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 11:41:24 +0100
Message-ID: <CAFEAcA9A=X_B1FEvo0xv-wmP50m4YLKbH4noXcBG_Sj7MhbLVA@mail.gmail.com>
Subject: Re: [PULL] Request pull for IPMI changes
To: Corey Minyard <minyard@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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

On Fri, 20 Sep 2019 at 20:16, Corey Minyard <minyard@acm.org> wrote:
>
> The following changes since commit a77d20bafcd4cb7684168a9b4c6dc2a321aaeb50:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190919-pull-request' into staging (2019-09-19 17:16:07 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cminyard/qemu.git tags/ipmi-for-release-2019-09-20
>
> for you to fetch changes up to ebe15582cafeb944a1c6e99aa526e81a1551c567:
>
>   pc: Add an SMB0 ACPI device to q35 (2019-09-20 14:09:24 -0500)
>
> ----------------------------------------------------------------
> ipmi: Some bug fixes and new interfaces
>
> Some bug fixes for the watchdog and hopefully the BT tests.
>
> Change the IPMI UUID handling to give the user the ability to set it or
> not have it.
>
> Add a PCI interface.
>
> Add an SMBus interfaces.
>
> -corey
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

