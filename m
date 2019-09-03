Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB871217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXErh4N/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB871217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i54pl-0003BH-HJ
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i54oN-00024f-Hg
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i54oM-0005Lo-7Y
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:09:15 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i54oM-0005Kw-1U
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:09:14 -0400
Received: by mail-ot1-x344.google.com with SMTP id g16so4120718otp.12
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GinhXmUU9TXQVsUcajUaYcNNt5ZI5PaZZ1md5npj4Lo=;
 b=WXErh4N/+ZYdTvOH7CZqIWqs0zY2LJ9clq6wDVx2vSmG/T65S6CVS0WG5EHgiPogay
 daZd79cATRgRA0QPq86NH5Q3X5W5fWhpHaTMjkdW+7lZwxmCJBZ4WZN/IUiMcDy5XHMf
 q58ui27Zc/sJitVyREYEBqg/HYJxvPREwjfYh0oMaDeAdee7uTH2NYezVpmJLTADl2U4
 X0Y1dHJVV6ebVNCm8CF8kUGthnnkwiiLvTTETXfKU2X+u14CqekhfnK4lmgV7Odv04NQ
 9tQ4FTmhg8jXpqp4KEsT4XqWuw8mY6kU5kTIAuYifNoUoIcuPU4BR+6zptAuWu+1xtfb
 xT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GinhXmUU9TXQVsUcajUaYcNNt5ZI5PaZZ1md5npj4Lo=;
 b=EM+Sj1/VeO6yvFxsiQV1nZVGOKPCIiuJ8kqiMrZMtFBZylN5/be1Mh7XQceb5dqso0
 EwVnLZnUvXU7i4XGFLRGWJgbCDBnW+kl+3fJt/ry6tJWOjY0xSisr6vzE16zW6tlQUFa
 NAR8ILuTJ1Cl2u9oOfB84em2tJEIQoL/jDmAH+unMX/jhLQi8itLmCF7CsE4iYipwC9l
 qrv9TeeQNmDxueQSbOaSA9X2fM5VDS4k7rtCD9mXbn5OjOl1qTefK5Bs2RlUjchTERyR
 7mbH0JVrCbhkjeNMsqUccLVx/OnrKgMt63eHSqfFbtRA84dHcmAJhK1wYZt14byS6hqs
 eJ4Q==
X-Gm-Message-State: APjAAAVj//XfuOBvhb/mZKEoF0qGidqo+f69ZrntzzRFKesW1neNZJ6k
 0KVkbZLhu7mUgyte9Ljsg7YWxPtIW/jisZS7WcUCvg==
X-Google-Smtp-Source: APXvYqzdocJltUTj5JjjQWlAuNx538lbQS1NdQ43OuXYgDyTCOLWY6TABjrd71dX2NfoHGFekJOKnB+Twla1KRn8dqo=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr28087598oti.135.1567501753071; 
 Tue, 03 Sep 2019 02:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190827121931.26836-1-peter.maydell@linaro.org>
 <CAL1e-=j_uoOcyxqv7CZv3V6FWaarBnS1wEnU4k1cAoc1_b5mMg@mail.gmail.com>
 <87v9uf4t8h.fsf@linaro.org>
In-Reply-To: <87v9uf4t8h.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 10:09:02 +0100
Message-ID: <CAFEAcA-4KqGy-gg4dQu12XziuakO1Gs8SUC=z0Af22fUHn8kTg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] target/arm: Free TCG temps in
 trans_VMOV_64_sp()
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Aug 2019 at 21:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
> > I am just curious if you found this by manual code inspection, or perha=
ps
> > using a tool?
>
> I'm guessing that if you run code that exercises this while built with
> --enable-tcg-debug then TCG's sanity checking complains about unfreed
> temps.

Yes, exactly -- this was producing warnings for a random bit
of guest code I happened to be running. (I run most of
my testing with an --enable-debug build, which includes the
TCG debug).

thanks
-- PMM

