Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B6C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAB520684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmN3ssUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAB520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Scu-0007Pr-5f
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 13:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8Sbf-0006gR-Mu
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8Sbe-0006XJ-Hi
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:10:07 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:43238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8Sbe-0006X8-BW
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:10:06 -0400
Received: by mail-ot1-x32f.google.com with SMTP id b2so26755687otq.10
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fKGLIgdjB9QfVFtgmgvuwylohlnra2FxbwS0MAoo1Ks=;
 b=FmN3ssUE7DsZ7+iDE4YRQcHKAixuPB7q41H/cadre0jKL0usEW4lefNKKpaBaxZBc0
 B8Oy/WQkS/wP3I4VqDT6gTrkgJJ2OoTxuVmwazFbL0bhG6mdAk8kxnfaMRtxOHdIkgmJ
 wuyDCUiWHtnRVMi5R3BD2k0/jeA9cqFEomgPbqzeuxj9UTOfRlX2o4Oe+NKx6vcyP9y1
 sxTP6xRlo3l4Y92h7jG5He3wYMQ/MDL2eeAfB8m5/ZCt3lBoZ/4C1BXlUYA3CwDRWIR1
 /KkW4uk4tsg036cfXhCwr1aap2Tanu3ODI7enjjDuzIEKKz3UIyIjptJdFiSCf6Q/dBF
 sa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fKGLIgdjB9QfVFtgmgvuwylohlnra2FxbwS0MAoo1Ks=;
 b=rhJLFV+cpUG10lcHEEpurdcOV7zQD/WsvFMQGEdBdeJTa8ypcddkaGzFwYza5DbfaN
 e5XGc00ziMD+ajNVPIcxdNhmlPUGmLQLxuVG6X/Q7HljlOd47I8u1WZOJSoTSuCAakwM
 YVbntSE4DUfnyKO0eUcxJK68mVuAN2E0fUmzD61ZrctTpdvPJM1fXYp7cnqJUVuNPkKo
 9fOHmrZtaGAyE+niXlkgdaNS9E2pn3kXk1giWJ2sF08KOgXDLRCPDy94xq4KsIqHnCxu
 KiNuQrjhOMSoGP4q1ZZwUVfGjkUlzGCCp8EXs6kXopknVoPd920tMqPDIWBXHQEsPH4z
 zWeg==
X-Gm-Message-State: APjAAAUiqKTXmNIrfJaH4apRZel5OryJkmNpDIaIzFV+wNFdsLRs2m5C
 OhvHq4S89EytRzQKxaYL0HNlERDNfb2xxYwq+m56Vg==
X-Google-Smtp-Source: APXvYqx05atBdnB9Ryatya5MacNMNf3MBV6hCXC/UBezfgAoXSgvGrfTddBg/2wsfkTVcZSDx0EkOalxSMZHSGlTuXY=
X-Received: by 2002:a9d:68d6:: with SMTP id i22mr28340296oto.232.1568308205075; 
 Thu, 12 Sep 2019 10:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190911064920.1718-1-laurent@vivier.eu>
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 18:09:53 +0100
Message-ID: <CAFEAcA8te6oemRMh+v12V=ni0NjeY2AU3UeQo8nvEAAMQ4nh-g@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Subject: Re: [Qemu-devel] [PULL v2 00/15] Linux user for 4.2 patches
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 at 07:53, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04b1:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-09-07' into staging (2019-09-09 09:48:34 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.2-pull-request
>
> for you to fetch changes up to 5eea942900536b76ad13bef35e1d8f276566ae9e:
>
>   linux-user: Add support for FDRESET, FDRAWCMD, FDTWADDLE, and FDEJECT ioctls (2019-09-11 08:47:06 +0200)
>
> ----------------------------------------------------------------
> Add several floppy drive ioctl,
> xtensa call0 ABI support, arm MAX_RESERVED_VA for M-profile,
> aarch64 AT_HWCAP2, qOffsets' query for ELF, memfd_create,
> and some code cleanup
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

