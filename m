Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB7BC2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A73620769
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAp9hSsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A73620769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMsqs-0004lS-IQ
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 08:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jMskK-00023B-R9
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jMskJ-00021E-ON
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:26:56 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jMskJ-00020v-Bn
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:26:55 -0400
Received: by mail-ot1-x342.google.com with SMTP id n25so1658270otr.10
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HWbxXjbLTnHyqvR2+v3t4KrM6IgxG7xZ8Tf8K6g6Qdc=;
 b=FAp9hSsKRuf4l7QRc7Wwag7Gxa2j/Ytp8KOJHgv3JkYtOXy3f0bsEz5jdEdRNsGgpr
 LPcIqHbyFpDOl6wyB4IzwHhJBsbzHIRqmhnVtTNRuJRtICoIoew4OgKBlBIa9NVHSJim
 T5gEBqnliahBHhSgpwoUNzj1L0I0AoYZ5nygCHD19BQaEmVhPmg5BIl5asYr0fU0sqQP
 RU6ULel76LF5lKo+VKvBtvHF6zb7J1ZRlcuhNCVOzKG5wVHmP8vYVN1sn297ZeXVjHoc
 roXjyXTkp1YXn5tpExxTsRdtEXTX26gF6Sw4M0qtTXwGoXdG6iPDSMqCILRq9UmEqWLv
 HZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HWbxXjbLTnHyqvR2+v3t4KrM6IgxG7xZ8Tf8K6g6Qdc=;
 b=QB6ytnmTiPiCMfrlZQTA1lfeV9Ymm7fZDaeEPvAc300W8QA5nw1SGDi4p+LhVp1Ujg
 YDhN43h4/ok6xDag4FmNlOBDdGN3RUEQ2Mr2LJY+iiMvYrQZF3bAjcNUlyNyRshPOwAJ
 dqHcC/6u5PvO8uZYsQVw7o3THQlEHHwCxGPhNHgT/Td8HTCRC38Ag6eCDcgtWvs6IKHj
 c2rtXVEMv1AURwjuJi3bzaJOkx/LWL2Q84O4p4uiaqsDw6aEWTBFELOPWzAtSVfyj5Y2
 ohm1C0/KXkwQihiE/KMxH+pdvxScpdFnMmYQ/GJOYh24RFq/JUt1HLfwe3al2M2BneIV
 ELXA==
X-Gm-Message-State: AGi0PuaV1LFwDYwQbMeprKjr3OAFXwFEYCHu9kZfXuqjjLLMXNfOU+ZT
 IGIvcOHFt/Z3DbVlGJY+TvmBGX4g+mJa4g4a+j/0yQ==
X-Google-Smtp-Source: APiQypIBdLWBirWD1XgBRrJwuZQ9GWPmRRP9OM24qMVQKtgUlOeTHET48m5yiqRkRmtcDemPHcBpseDUNFTFvWEW8b0=
X-Received: by 2002:a4a:a226:: with SMTP id m38mr3967620ool.94.1586521614446; 
 Fri, 10 Apr 2020 05:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
 <CAFEAcA9FSVzxwudyaDoCty8B+Up33caM20qytLNO7HAXWmcwtg@mail.gmail.com>
 <CACPK8Xc3mpoakAqq2_wccCH6_2i+V4NB61CmdxtMecJ4ejzgmQ@mail.gmail.com>
 <CAFEAcA9erXezwsn_UaXJz0SL5Zaj=UmjTO0LPg0LDM4P50tjHQ@mail.gmail.com>
 <9e8076d0-6704-4ff6-bcc7-90b71ac398db@www.fastmail.com>
In-Reply-To: <9e8076d0-6704-4ff6-bcc7-90b71ac398db@www.fastmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2020 13:26:43 +0100
Message-ID: <CAFEAcA-TrDeO2xKWYbxLfAuavGQkzsH-etQogv9LVQvF+j=U4w@mail.gmail.com>
Subject: Re: [PATCH v1] nrf51: Fix last GPIO CNF address
To: Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Joel Stanley <joel@jms.id.au>, Cameron Esfahani <dirty@apple.com>,
 Cameron Esfahani via <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Apr 2020 at 04:42, Andrew Jeffery <andrew@aj.id.au> wrote:
> IIRC Phil wanted to enable sub-word accesses to the sample value
> registers but I didn't want to spread logic dealing with different access
> widths through the model. We already had a mechanism to describe the
> model's  supported access sizes (as opposed to the valid access sizes
> allowed by hardware) in the `impl` member of the MemoryRegionOps, so
> I was trying to use that, but it didn't work as I needed.
>
> The accesses generated at the point of the guest MMIO need to be
> expanded to the access width supported by the model and then the
> resulting data trimmed again upon returning the data (in the case of a
> read) via the MMIO operation.
>
> So the intent was less about unaligned accesses than enabling models
> implementations that only have to handle certain-sized access widths.
> It happens to help the unaligned access case as well.

Yeah, we definitely could do with improving things here, it is annoying
to have to write code for handling some of the oddball cases when you
have just one register that allows byte accesses or whatever.
The thing I have in the back of my mind as a concern is that we have
had several "is this a buffer overrun" questions where the answer has
been "it can't be, because the core code doesn't allow a call to the
read/write function for a 4 byte access where the address is not 4-aligned,
so my_byte_array[addr] is always in-bounds".
So if we change the core code we need to make sure we don't
inadvertently remove a restriction that was protecting us from a guest
escape...

-- PMM

