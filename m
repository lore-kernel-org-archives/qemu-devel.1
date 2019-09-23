Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E54C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2215020867
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRQF1ylt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2215020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOOr-00063g-A7
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCOM2-00044D-O0
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCOM1-0000IM-MA
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:26:14 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCOM1-0000Hq-Ds
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:26:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id m19so10231999otp.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=F+tr8JAkIln9crXUwZeQvtxtEKb7O7vjGbgEId9s0W0=;
 b=GRQF1yltQKO/GgSZlvQCsJyvUTVxQ8aUMGbpjQ2sS6c6oZq5AMibDjS/Q3iwMGIMqj
 +WOVROMH4dvLurE1uGW4UJEmVq9e+0JiMywzVL7RYm0K9Q5GG/zGgX7MTpmp9alcVUOg
 EGWkmi0ficsqU0nC52SabiRESA4Xv0zrV4MVi3mBNvCssKXP44A+aFbQjsylnA7HmFoc
 xNHe8XZkVqYhmYWyKx1l8nYaMmMKZmlsD3WgUsJckz6HA4V/jmbanTusJ9dgeIj3yelR
 l22JIkid9L5bmLzBLhuaDnxl2iLdGsg+SZK2+hnGlznWlTuOcVqJazwPweXs+hl+16Rz
 /zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=F+tr8JAkIln9crXUwZeQvtxtEKb7O7vjGbgEId9s0W0=;
 b=iWnB3Hs8lW6sdoFg1W8iceCHcFHzQiD9hlTm+6VcSZHxKOUyxgXM+3iANxg4tr6tTD
 rzq45VNy8rEr5vpt2lM2b6soAYDt9oZ/xeE+xIBhUcPVL/Nncyni2Vpxyw7uwu1NIZuB
 CDOGr5QXFnJ987ex6ur3JrjH1XAYOasHSiGq9mKOJffJk/do+pH31x4DOfuDECm4eIoW
 PFppw3jCd3LTzJDmH4F2menYf7k78rcsd8Kj+VF2PPRVa/RKjRzNzvUMGxsQsJ/KuSk1
 xiuXVo6yWN04f+uD15ZdnKEnhc2vKzlS/5QM2M3ep1AcLwH0iWc6YVuQF7Vx3YRE1GD+
 glqQ==
X-Gm-Message-State: APjAAAX3L0RUA8eTOPrx5NLxw4OB/ptPLsMxptmkbYCO3wGUNaEGuF/s
 L7kAGo8qaeRmMu6z4ClqSbuB1bikPqSlHVL/LMzRIQ==
X-Google-Smtp-Source: APXvYqyeegPyq2BGOLoMECSe1plZzHEpFLlZPqU3fYm27EAqX/xqNU55EW8kYSDK67dK7LBkyMAklTX6YXCKB823XJ4=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr4007137otq.91.1569245172069; 
 Mon, 23 Sep 2019 06:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190820123417.27930-1-philmd@redhat.com>
In-Reply-To: <20190820123417.27930-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 14:26:01 +0100
Message-ID: <CAFEAcA_6uBtREzj2UaSwDp_VWd=oPsD-dARcOPeJdcMpO5kaHw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] hw/char/bcm2835_aux: Provide full 16550 UART
 support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Aug 2019 at 13:34, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Since there has been some activity on the list asking about
> Rasberry PI USB support, I had a look a some previous unfinished
> work and rebased it to share, in case it helps hobbyist interested
> in improving these machines.
>
> This series is some proof-of-concept on improving the AUX UART
> support. See the commit description for various TODO/questions.

Apologies for not having got round to looking at this
RFC patchset sooner...

I think my question here would be -- is using the 16650 emulation
really the right thing? The BCM2835 documentation says
"The implemented UART is *not* a 16650 compatible UART. However
as far as possible the first 8 control and status registers are
laid out *like* a 16550 UART." That suggests to me that it would
be better to just improve our model of this hardware rather than
to replace it with a 16550 model which isn't what the hardware
really is.

thanks
-- PMM

