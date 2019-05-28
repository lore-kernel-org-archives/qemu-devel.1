Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FC2C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB972070D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pT3RAgh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB972070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60733 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVZj8-0008Eu-CX
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 06:53:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVZiE-0007vI-E5
	for qemu-devel@nongnu.org; Tue, 28 May 2019 06:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVZiC-0000Cd-Fb
	for qemu-devel@nongnu.org; Tue, 28 May 2019 06:52:10 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:37549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVZiA-0008WF-Fi
	for qemu-devel@nongnu.org; Tue, 28 May 2019 06:52:08 -0400
Received: by mail-ot1-x336.google.com with SMTP id r10so17310683otd.4
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 03:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=5pomw+VuqsdZp+2VIIKCswCyJjJ0S5l/pl6VYl5VuJc=;
	b=pT3RAgh9lXlaLjp5ssjVtVaJHfDRkCGef29iIzkpx+AXpifadkCPmELUJN+ShUV+9D
	Qdb0Lwvv/3jFyOMerxSElEOm5G2NrgI+ruB74U5awBmfZ26KxcU3cCNpgrXX1PmA2pAy
	tzPNVGky2yl23+TQhNApx3IeH9fBwmkcw7qQhZmxGQTytY5wPdfx7FOc/Tw739QePliI
	feN9dp5alw+C2jRA24de8bnPtqbC8FiU9z+fT1Scwtvn533VzsLsnPMtFipYvKbqYFhf
	hw5rRFfjPjp3vT0/JuZPsZ7Shu/87d+cHrUdmJMb4OjFEtjqtuRLsT14TWnuyvoANe97
	JA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=5pomw+VuqsdZp+2VIIKCswCyJjJ0S5l/pl6VYl5VuJc=;
	b=Wspx3fPqwDQ9yxtF0yIMuAZC75phvtgIA+txSxvURcYa/EALz8Gy5Ees7BYgB7iVFG
	Z/lNjH98O1vEykpcKgV3GljnDg3E2WIwvjkIq0LaI/CaxnutYpsB9ukbbp01RAG0fmii
	MAA5gGy3Uc6z1qeCQx3Miyolf/fsNonBrfUlTv1D//wR7v9MaTLiIKgxNk+sNx008Jb0
	mn/dOl3BJcGBtynGeQ0FFaug94XSy1BZ6PGIy8V+2bfyORZdPSzEXSo+y1AqBGYBPIgj
	tucWF5lX1FxjlwF+qN5iSm04jqnUNZIDwDUeb1bDUPoseeEeX2JIpxMSzSh8GZYrLk9o
	r7Kg==
X-Gm-Message-State: APjAAAUFX4AqDvENxJaFFNM+5M9Rk94xtq+RkGwo7563dhEBfGUcGku4
	giPbrpbRa/Uig+kbo80U5gGPr4Oo0mOJPaZvCbw4lw==
X-Google-Smtp-Source: APXvYqzjbnrXPxTgeuPvUBoJujbpThr+8F+B+crCQQf3PA3hwyq1y88Nxsq5klX5ovGahM4fh+tlrD998J2nb7/ku2Y=
X-Received: by 2002:a9d:5608:: with SMTP id e8mr18299776oti.135.1559040720458; 
	Tue, 28 May 2019 03:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190524184447.16678-1-ehabkost@redhat.com>
In-Reply-To: <20190524184447.16678-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2019 11:51:49 +0100
Message-ID: <CAFEAcA9KtJmikbKHxsazr+COOmto+Ox=z+Pt2Ho25xc5+DDwrw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::336
Subject: Re: [Qemu-devel] [PULL 00/17] Machine Core queue, 2019-05-24
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 May 2019 at 19:44, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit a7b21f6762a2d6ec08106d8a7ccb1182991452=
3f:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-p=
ull-request' into staging (2019-05-24 12:47:49 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 23d1f360f3de1d968d98ba605bd3b718f5309e6f:
>
>   hw/intc/nvic: Use object_initialize_child for correct reference countin=
g (2019-05-24 15:29:02 -0300)
>
> ----------------------------------------------------------------
> Machine Core queue, 2019-05-24
>
> * Display more helpful message when an object type is missing
>   (Philippe Mathieu-Daud=C3=A9)
> * Use object_initialize_child for correct reference counting
>   (Philippe Mathieu-Daud=C3=A9)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

