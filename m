Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB6C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C062020880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N94sDWbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C062020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho6FJ-00022t-1B
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 09:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57845)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1ho6F1-00017B-Ea
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ho6Ez-0007W8-VU
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:14:35 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:45686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ho6Ez-0007Vd-M5
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:14:33 -0400
Received: by mail-ot1-x32b.google.com with SMTP id x21so28911567otq.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s2M4q1miMVDXBz/MxmYzRapFJfzZRtVLjz/Y3n7hJiE=;
 b=N94sDWbjCBi9q8AJ5AM3E9mi76baJg1kHA9w1UmIm+xd1FTYaKaYcvAuHRYfNhDqVC
 gcesPLQrhnhrvB0p52s8QfDiHcrHJ5Dv5umHxu11S8KXyzWvQk+5F44a+bf3t40X/aUr
 smQlg/cHVBSg8RroYrOnNx7Y2tK6u8OcGkOxEh3Pngpwsj1RKrQzskhJxxkX0Ed/DLXi
 jCmbODhD1LHZWZ7LJbDaqfBxd9ILXRCQt2Rp/rOgQTpgpoh5QrbR3MT34uqamzE+bUlA
 gt8/5NUy3UlGNJ9zIx7ZJ6J3Zj9/H1Nw9jC55OoPz05SyiAI6rMxdUP5zHvk7A/fPLTD
 jEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s2M4q1miMVDXBz/MxmYzRapFJfzZRtVLjz/Y3n7hJiE=;
 b=oMW1R/u/r6baIlc6luTpYntwXM8KUV30M767ZVmaztyEC31Gq4z3QkM5vJTAREk40+
 LvSkjzqCgAVhCJd/W8O7gBNm+mYLo79I52B6joN6lCc6d8vcxYhY8tys7AnCPYhz1gbN
 zvpxU3WHcC4HP8o260X8NHKhqQlP548tjQTshZ/yoiQxzesKbZFRzSPYkE2TMTuzipOB
 eMMawzyeLa88PUdCakKDxXJCVVn5IquBUwBBb8P3hpVGvjN3/VMSz4w4rvZ6YHp89xlq
 Ni/tEuHgKzbwgoYLicqH/9x46ZiVxP81FSuFG0Tr2YA5zZwOuSu0IEptvR6FNyBCU7Vd
 ieow==
X-Gm-Message-State: APjAAAUIf11OxiQ1sKhb88K1TOXC97E+yYb87MDG1LoqBzwBXTSrURSO
 o3xYwvwHi3prbLS7Y9ZWuZwTfQ6DGYL5tQgTaqRCUQ==
X-Google-Smtp-Source: APXvYqyjBDkxuE7HKDlQ7L9p49/gVXWYIcKppBWMdvC/FF9jKdLpNIY5b7V+RKO6u6j0idDJY+jPCWBnZIARLx9/aRQ=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr13204563oti.91.1563455672642; 
 Thu, 18 Jul 2019 06:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <cb727b5d-683f-115d-f3c0-06f5a6761aea@redhat.com>
 <126a3ec4-f5e3-0590-011a-9c2a10d07b24@redhat.com>
 <bf5da6c7-74c1-8950-2869-2d94419f1820@redhat.com>
 <CAL1e-=iLLQfAdfFrKpAT9k48X0sEMevBXFWAmny7PRPwtBMiEQ@mail.gmail.com>
 <4367860f-5226-ec42-6407-f50dfd96270b@redhat.com>
 <120c0218-293e-b70a-0853-ea2907e72007@weilnetz.de>
In-Reply-To: <120c0218-293e-b70a-0853-ea2907e72007@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2019 14:14:21 +0100
Message-ID: <CAFEAcA_XMs1QcD-8FbvuzGEi7QrfK++p-aKoG6-45Pm1e_o6-g@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] No archives to download from www.qemu.org/download/
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jul 2019 at 12:50, Stefan Weil <sw@weilnetz.de> wrote:
>
> Am 18.07.2019 um 13:29 schrieb Thomas Huth:
> > I guess we should simply re-arrange the order of the tabs ... the
> > OS-agnostic source code tab should come first (since this is about what
> > we provide for download on our site), and then the others with
> > references to the distros etc.
> >
> > Does someone care to send a patch?
>
>
> Wouldn't changing the link to https://www.qemu.org/download/#source be
> even simpler?

This gets my vote -- I'll send a configure patch...

thanks
-- PMM

