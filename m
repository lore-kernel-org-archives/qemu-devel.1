Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E798C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455E52082F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbOrRLSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455E52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNJAV-0003wE-GS
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:35:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNJ9c-0003co-4c
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNJ9b-0007BL-AI
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:34:16 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNJ9b-0007Ah-5o
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:34:15 -0400
Received: by mail-ot1-x343.google.com with SMTP id v17so1299696otp.13
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=CdQeSkh/iIz/fBvRxSb3cbzFfQPunOw73QRKDyNEApU=;
	b=WbOrRLSW6//Q6l7shx4vFMHEDwJjYj2hW9PHHwxC1I7yTQ3xfFS4bc5VyXbzM6fJ6h
	9HNmlq/h7ZHMtsVkJHeY/AG7Ob//ozdhAVicQ8PtMTQu8RAu9+y+UxmrDGgYTTReoH1u
	lUNpYpkrXFs99BMBeHaSjKtTbUSEMACjzXAepP31fhvHfGenHkmjqEIFxLXPCVjKWdVA
	yT2olqXYiIHY2nmzqkru+knRNfPcN7H5Mq3XsQ2A8FodfElsUIsZdo+0ljuBJZu/ptsK
	lGuyFo+opaRiv+6EKGuhhb3Vvn+Tu6Of2gQzJxulB9JjF0aUoN/HwITAMTkveAYrZ0xa
	4Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=CdQeSkh/iIz/fBvRxSb3cbzFfQPunOw73QRKDyNEApU=;
	b=QqIlXiF+urOw5NUKxubItalSr9Tia/sy7TZ7oJiNDMmNC/FOLqtyr/xa4QzE7zd4qp
	xN3275q+giMXF23jXHW3JvDOpJVXsmQHnM9wZVfsS+bnSVy1x6Yr7kgvj+nSvj0dlmfU
	wN/9G2FI8tWE7atKn1+Sx9oZhEohunjdNaUsM0MRh7LXEhmBFNSNqd62RW/PlNh30Sg1
	+P6owT5Iria+9mV6KEaFpNw4/ar6uZYLiNzcqTcS6vI9UIEcmvFebXPXpbxeAHRCiqy/
	hYa3NWe3+gnM+1O4ThXrg5GfdssSrCJz8O7lCvA9KWXpT16LRvyMzcmqDYptZbI/nhPk
	Dkjw==
X-Gm-Message-State: APjAAAWNEVH0PUb9FaiaHpDbL/IwU+SlmsP199cpEcbe4pW5dh14oFE/
	/4Y9hOZSRtJWja6K/NlX16yahAlo0F0/rbewD64ulA==
X-Google-Smtp-Source: APXvYqwg7/6sevHoLDzdBMV2E7pqSuRs3XDUFib1hnp3foCFJjsfFW6aGFptsid4DMKm969LAJ+hEMyz62khzlaDk+g=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr13679065otk.316.1557070454016; 
	Sun, 05 May 2019 08:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
	<CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
	<CAFEAcA-dZ5qdh58QCmX+t2RpJim8Fu9FY0UBY1tMpQOHkG06mA@mail.gmail.com>
	<97245929-a8b5-4b67-bfee-656db4438cd0@www.fastmail.com>
	<CAKmqyKOhfjwO+8UBj+-RiZiYUHM7LeDeJk+cmXfuKd5psowP3A@mail.gmail.com>
In-Reply-To: <CAKmqyKOhfjwO+8UBj+-RiZiYUHM7LeDeJk+cmXfuKd5psowP3A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 5 May 2019 16:34:03 +0100
Message-ID:
 <CAFEAcA_0NpQRJnMx-1vUCD_=e1GsfTBhO3z1rrz99CY+GNmGhA@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
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
Cc: Alistair <alistair@alistair23.me>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505153403.GeeZBNkkyS-CLENWf_kqy33rvVNC4RuAybSAN2Kar4w@z>

On Sat, 4 May 2019 at 06:26, Alistair Francis <alistair23@gmail.com> wrote:
> Ah, it seems like -device loader doesn't work, it looks like not
> setting the thumb register causes this core dump:
>
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
>
> R00=20000000 R01=00000574 R02=200015d0 R03=200015d0
> R04=00000000 R05=00000000 R06=00000000 R07=00000000
> R08=00000000 R09=00000000 R10=00000000 R11=00000000
> R12=00000000 R13=ffffffe0 R14=fffffff9 R15=0800cba4

Is the ELF file incorrectly setting the entry point address to not
be a Thumb one (ie low bit set), or is the loader device not honouring
that? (I thought that we'd fixed the latter of those recently...)

thanks
-- PMM

