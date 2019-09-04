Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2590AC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D5C2339D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFDQ0kWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D5C2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5V2x-0002Bm-4u
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5UsE-0000bb-AQ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5UsB-00076M-Nr
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:58:57 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5Us9-00074s-SF
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:58:55 -0400
Received: by mail-ot1-x342.google.com with SMTP id c10so9106534otd.9
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w67Y/hjv3SDUD8pc7dRKF/jV+ea1IS4S+jZMIoqrqW8=;
 b=OFDQ0kWo3AKYHk12fsuWeRKLGtoZyEGwTZTPuH2OSCGvFcjIJRp4A8Evq4uHdco822
 thwtjRznv4OEHRJNOituhtoWD90c3FSbPhMFKDXuyu2mEB2Wp5dBYbMd6cn3LEmEc7T1
 2ILJOol+Buyc0pJPsPlOU76SilP/tZ+FdRuXlVKA42MyoyRfY1Ul1wvFTqF1MqUWa1Sa
 bl6mvFERFmyu9YnBaQTpC18JnEdiWEruLTJMxww/jP3pXmHUvj+pZGPf+N/j/J2SsGl7
 fzDjUPdSleB5VPBGZPCGEywvCKMkDQ/eZOAlrI1resjZsdw8W+f3IO6gxmDeEGcBK2wR
 aPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w67Y/hjv3SDUD8pc7dRKF/jV+ea1IS4S+jZMIoqrqW8=;
 b=Wql8efpYN1CmLyo+vvnyNAhrSm2Wn4th3jJ9U26UvIQiNxCtmXz4o4RWBxBXDkq9Kt
 4sptwkRfUeaqTcGdophQjYM5/H5rbQqojR/Bfvpj129rJTDlygUjlhuOVF3dudL873vk
 7dOa+SoRE+stjuw1IUHmUTxvaP0YPgBNJyIrcfsN5ZlQWUm0K0lMmBSqsTKMKhLmDo9j
 Ihc3nBcuMcBgUxJF5ESeIdJkLImBA1fMiBPeQ9IYDJEBPN3CCwIR4Suvg2h+EqIpfwlE
 IFMaImbPTOs1xVAp0x7dmV6QkAyiBLDVJQH4VILhKflZWXaXio713UEmEyLVDqGSNv+7
 iguA==
X-Gm-Message-State: APjAAAWds0aGXxDjAgGlCUN9aFQW2eefUK/a4uA10fKfTFAnFSziyB+F
 2iOejYWbfZnu0dAARTwpqnjkYRKy0P9/4R7NaXFlfA==
X-Google-Smtp-Source: APXvYqzzHHRgnnc31FKeAGwjFcf/cEMv0iH7bXYjLOcn5pjT5GMe1CbreYr7Cxk2T1pMZQOsIW53bIuoC2YYDyAUKtU=
X-Received: by 2002:a05:6830:1bc3:: with SMTP id
 v3mr13397880ota.97.1567601932126; 
 Wed, 04 Sep 2019 05:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190903133553.6500-1-mreitz@redhat.com>
In-Reply-To: <20190903133553.6500-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 13:58:41 +0100
Message-ID: <CAFEAcA9zHZfid7peCvNhAqPe3Hbm9HynW5raQk5PkX9gArdX2A@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL v2 00/16] Block patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Sep 2019 at 14:35, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 54b89db5309d5fa8b5d3fe5fe56f81704e2f9706:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-09-03 09:43:26 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-09-03
>
> for you to fetch changes up to 755c5fe79d88717600356d3edf04835bba43dcb6:
>
>   iotests: Unify cache mode quoting (2019-09-03 14:56:06 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - qemu-io now accepts a file to read a write pattern from
> - Ensure that raw files have their first block allocated so we can probe
>   the O_DIRECT alignment if necessary
> - Various fixes
>
> ----------------------------------------------------------------
> v2:
> - Added a patch we already had on the list to keep the iotests passing
>   when $DISPLAY is not set
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

