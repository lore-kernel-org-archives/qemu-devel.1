Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BF9C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8669B20665
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ad6dXW01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8669B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAyB1-000674-Ja
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAy9d-0005Mk-CW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAy9b-0006yk-U0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:15:33 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAy9b-0006y6-Oq
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:15:31 -0400
Received: by mail-ot1-x344.google.com with SMTP id 21so3373618otj.11
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GQjKt1EZ33+I2Xo0cT4mxzq0yNnqBYUmxwEq/6rnNts=;
 b=ad6dXW01BKA2dR9ETwN3ZWdU3YhhOsF9FKmoelXa0yQ9xSvGEqKSW/btQnei6DPgJe
 Z61R8BZ6VZofr511oJITzTI95DBGmDGxqAsz0oU1PP1XvPig4ehzs70ADhm5+J8RnFlQ
 zniTKLan5ZZil7oEZj2R9l9qvQQbgvNfYfMsDxAp29fOByxDukxKfnmbR5ho9QxeOTQf
 HkSqRHZV1tNO1cuuxwF+MxyxY0HK4LNZplrkZ6EuIr3qrzAxWNG1aKBCee/+VI/pKaIs
 tup2yqKiBxdUBmqOZ8KieLT9NLyo8G6tD5amf1TM5m26oWzskSpmmjUJ47u8rCNk5yC6
 aRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GQjKt1EZ33+I2Xo0cT4mxzq0yNnqBYUmxwEq/6rnNts=;
 b=eBufB/QzCVF/+cjmP09gzUUaBX64BFYo2AId7bFgxUXl/r/QGtf/i2zrHGY4E5C8o9
 inZ8f9jZZA3XrLAQacDafSxydG0jAndX4snjqtU4i9pGSsP73ZYDqCipkTAMmPxmxrN2
 +KY7Y6cy0FRbH4rCckK01vlsdst32AbOIBSz3JdimtOZQ2t0+sfJFV1ez9p3FDeCc2yz
 0bMxlmVvqt6UVP+ewanktag3dfrlMfJoudnTxAAC8Hr1/mme94+EBOMo2tU/mgJUSb7a
 171wgOS28+cQc3EUDBRq7KFDtm7oDzlanossPnWW5//YbvVKX84taM33cIPaLrX4B8Sg
 yy4A==
X-Gm-Message-State: APjAAAUNt966w8M83PttFAM5NGZp5i2o43y0xz6fchl+4Dm7l7ebGL6N
 9AqHdTvQG0+/V6i/k9TSj8NReEXh2LE2ykJZCH1OJg==
X-Google-Smtp-Source: APXvYqwvAuZuVkWWNHR/DFV5ncSMOGi8Kgq8ZjJ0QPav/yxYPGmko2e5JRwVFtboXs64PxwYmsjvaZqQrubqnMr09RE=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr7364467oti.135.1568906130693; 
 Thu, 19 Sep 2019 08:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190919083629.29998-1-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 16:15:19 +0100
Message-ID: <CAFEAcA96outvEdRasZM-LdTSs7QCRZracTvWUZ3gG5x23kh+1w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/26] Audio 20190919 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 09:38, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c6194:
>
>   target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:00 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20190919-pull-request
>
> for you to fetch changes up to cf0c1c2aa32db5d658c3c797ad995a6d571bad96:
>
>   audio: fix ALSA period-length typo in documentation (2019-09-19 10:32:48 +0200)
>
> ----------------------------------------------------------------
> audio: make mixeng optional.
> audio: add surround sound support.
> audio: documentation fixes.
>

Hi; I'm afraid this fails to build on OSX/FreeBSD/OpenBSD/Windows,
with format string issues:

/Users/pm215/src/qemu-for-merges/audio/wavaudio.c:50:15: error: format
specifies type 'size_t' (aka 'unsigned long') but the argument has
type 'int64_t' (aka 'long long') [-Werror,-Wformat]
              bytes, strerror(errno));
              ^~~~~
/Users/pm215/src/qemu-for-merges/audio/audio_int.h:257:52: note:
expanded from macro 'dolog'
#define dolog(fmt, ...) AUD_log(AUDIO_CAP, fmt, ## __VA_ARGS__)
                                                   ^~~~~~~~~~~


thanks
-- PMM

