Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C0C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE3F206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ol6aQQbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE3F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39609 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmRV-0006hv-R6
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:51:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSm7q-0007Kn-2n
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSm7o-0000Nc-N2
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:31:01 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSm7o-0000M5-GH
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:31:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id l25so5377326otp.8
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=upzeKs69iuDfmu9GfUKqLaEkv6m2wZsZqpcg5PjDTMg=;
	b=Ol6aQQbZysEyYvH38GHWuDQ6aLsvn6itJn8eGIlmoC1b7oG0RXP0gS+tCNh5dhHSpH
	mGYmdRz5D6jm1szMgH3x9VIiP+uYF8lPjf5uJlX9aoaOfOiEYb2zG6IElOCOr+XP2Apq
	yQBf3yS/OwZ/9XF2tSgeP5ee0wKHQhu0k5Bj0v+MGVidVxrc6yFNVRDk2OD04ETGq8qt
	JKC8tOPWFyc9Gr37luYo0jqae5fZwVWl1m4xJkoXBmvzY4mtzM+dvCGNvOOUXbbr6p1j
	FQTVsKTUvmWVGd8igEYpZww0jYqaKSk7otNaJc+ioIZip2s4Du7qguKJ7IofIws9E1tH
	qyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=upzeKs69iuDfmu9GfUKqLaEkv6m2wZsZqpcg5PjDTMg=;
	b=uB3ryyilJRmjsdN+/oXhJ0WyypLcZT1+beibvlwHPh1KQKuY0GW383NH6+Xzw6bf8I
	tnxiFgbVvihFMcYPmO3kyJomh5NE8PBaS1upCoMi+aNNB6nnuuqCwDPRthj9nLxn/BxR
	TGZezllQVxcJ6nArg9Eb894C1B+BY6dKql6u20eYUeyLxWjnVXB/Hler3nMpcRPyW6CH
	guHxbjdKI5cjY8efqlEtrERoVL6yXEviyqjowIP2YhjG/L14TQg/SyfxkTkS7JuUcRpo
	b2yAd5UMcYhUIY/fIBgy2M+Xt47HqSqdsttHkcKEfCZ8kxi9aRP1lSD7/A3dr/qrP2+W
	W8rA==
X-Gm-Message-State: APjAAAU+zgum5CucDhYKvQ/nH+PsL8BruIb4Xzawjtw88UWJ4CSJ0edV
	mx4PG5NODRjkTh7HLl4NA4YxyJ2ptyzoS5i3NJ1YDw==
X-Google-Smtp-Source: APXvYqxgEsPdvQPvbNrDgtS0daANgMM6g941hiCS+KD4WbpZWdZy9ESM/PZCogBlfug27XSIN43PH9gO5z/fiEgBi/k=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr9137781otp.91.1558373457035; 
	Mon, 20 May 2019 10:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190520170302.13643-1-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 18:30:46 +0100
Message-ID: <CAFEAcA9Da213mDF9kBOhfV_m_K7X=MEGcNkfZ-2whDmDQYrABw@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 00/54] s390x update
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 at 18:03, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit d8276573da58e8ce78dab8c46dd660efd664bcb7:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190510' into staging (2019-05-16 13:15:08 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190520
>
> for you to fetch changes up to f9de88d07258b7288b59ebca77ff1da75b0e8e9f:
>
>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines (2019-05-20 08:35:42 +0200)
>
> ----------------------------------------------------------------
> s390x update:
> - have the bios tolerate bootmap signature entries
> - next chunk of vector instruction support in tcg
> - a headers update against Linux 5.2-rc1
> - add more facilities and gen15 machines to the cpu model
>
> ----------------------------------------------------------------

Hi -- this fails to build on aarch64:

In file included from /home/pm215/qemu/linux-headers/linux/kvm.h:14:0,
                 from /home/pm215/qemu/target/arm/kvm-consts.h:18,
                 from /home/pm215/qemu/target/arm/cpu.h:23,
                 from /home/pm215/qemu/disas.c:8:
/home/pm215/qemu/build/all/linux-headers/asm/kvm.h:38:29: fatal error:
asm/sve_context.h: No such file or directory
 #include <asm/sve_context.h>
                             ^
compilation terminated.

Looks like we need to fix update-linux-headers.sh to account for
that new header file before we can do the header sync.

thanks
-- PMM

