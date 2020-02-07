Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C4C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB6920720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghwUvTAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB6920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01YH-0007Mm-JP
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j01XN-00060j-0K
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j01XL-00038B-Ot
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:11:04 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j01XL-00037j-IX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:11:03 -0500
Received: by mail-ot1-x343.google.com with SMTP id 66so1772006otd.9
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4tADPLToz3nwt4F0rV1Zqig+n/0qc1f6bX1x0rn/46g=;
 b=ghwUvTAojvc/PFwXoL5ZclPpSMdK9g0geVJo2qJEeggD/wjzqTCfpnW7G2vEantSGO
 QIXxSe1R9Mx6/yyiIFl8QyXDY34MKHrYKt6nzdKE/29b0xz4/Swb6BYgje8ZbH09kI0/
 3r873rbSIY3QJ8NicQ9047cm/MyZWibLZ97bDKGhUlKBpwJrB3r4xVsEpPRepqV43gwT
 1LnYA2peAJzrJYZVbmFvvNkoIgC8f6Rdq58p4ftdoPA0bda4UvvJHZWuXlYiEQLd9tqZ
 EZHcbSL+K+e9N2GvvJRIodP6BWuIINrTrA8/X+8i//Lh4KUySEbP+TJp/uC/FLwutC1B
 PLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4tADPLToz3nwt4F0rV1Zqig+n/0qc1f6bX1x0rn/46g=;
 b=WEXUuB9YjjYok7AQfX+bP9NTRpjqSZVAi3d9mKebcyTIwUJV1kqToj55wHhlU9T4F2
 DJO6rzo31Uclw1WjRKKYR4GGWIdBVflBjlNTx9xK0bnbWCcfjJKLyqc6hapvP67IhzDM
 HvGxhb14Qp9mpQvaUNXHDpm2Rb2fD2+dwZADHtidonkWrMdIEmjeytTABnTcnvQjI1QX
 npk0KhWVaw0newOohHpHIhPwJo64IDQpl1MPr8gSSLuYTJ5cPyCrNtJqLFHZcJr5Jhe7
 5REccIYtmDzOiTq4lFFU0U6BUr9G2vuS9tCuXNf+molZguONSsivrEODM0bGSihYxib7
 2/iA==
X-Gm-Message-State: APjAAAVuFwdxvPtwqPpnk8oUu8PmUj0OWoB7g/bDcMa4o6gv7JCYXx77
 +Cf7bGuTwNX2LLG0AD4BZDlnddBBLEwNOoL5nVtqRw==
X-Google-Smtp-Source: APXvYqzgv6XKBAY57jZNdR7HjcY7Q787tFZUvZ/M3Dft4SiwtnhxO+BmUl7/DDxaE1fNKDUynMJFdxlyBDBcRab/fsM=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr2323595ota.232.1581073862740; 
 Fri, 07 Feb 2020 03:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20200206125224.3819972-1-eblake@redhat.com>
In-Reply-To: <20200206125224.3819972-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 11:10:52 +0000
Message-ID: <CAFEAcA-Bbat1qMpr=-zeYYacRVK-ODnn7AROgxA+PqkZP8kHmA@mail.gmail.com>
Subject: Re: [PULL 0/3] NBD patches through 2020-02-06
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Thu, 6 Feb 2020 at 13:06, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-02-04' into staging (2020-02-04 16:12:31 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-02-06
>
> for you to fetch changes up to 0bc16997f5404134637227e53b637d0825d46b5a:
>
>   qemu-nbd: Removed deprecated --partition option (2020-02-05 17:29:49 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2020-02-06
>
> - Allow setting NBD description from QMP for parity with qemu-nbd
> - Remove deprecated 'qemu-nbd --partition'
>
> ----------------------------------------------------------------
> Eric Blake (3):
>       nbd: Allow description when creating NBD blockdev
>       docs: Fix typo in qemu-nbd -P replacement
>       qemu-nbd: Removed deprecated --partition option

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

