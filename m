Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3594EC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 10:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DFC208C3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 10:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvr2mzYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DFC208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwOF1-0005C9-2B
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 06:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hwOE9-0004BM-N3
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 06:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hwOE8-0007dT-P4
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 06:03:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34199)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hwOE8-0007dD-Hu
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 06:03:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id 31so100417142wrm.1
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2019 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=U26LjiS6gH6xEykeaGGw9vuksUsb6QI8PjTJcJC0mo4=;
 b=xvr2mzYBXW+tN6NldgY98jFBBQnFHhqknjW9o8sIQ/ICSeheyQV3G5lwTBu7RX8HMd
 9lUL1wj2gVBQfVSlktgUyeWHTQAVVG2VyUU5rd+E0r0cNIWtjJj/zUh0dOAZ9qPiCX8K
 F1ApYbtxFfpr5msPmuoWUqti2i+ULExpzw2ya14prOtyNd1QqvyUNW68zyoegNecGK79
 zHElh7XaL0KPn5Von3WQfPiyLxzMopOEE/JHmbyvp8gGoiU/Hhx35a1C83UTs6H0+dta
 Ktm0PV+V75IZkJIOqwdQMIL3D3TKFSYEN3SjCLie06qBrLJlS8buHntejPtI/D5KWcIi
 dlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=U26LjiS6gH6xEykeaGGw9vuksUsb6QI8PjTJcJC0mo4=;
 b=FocsX4zYPZSD/AFRBRCTvn5I/Aqno+qJGUMjyLN+wbIgAsNhKWUCK70P5pRGLhBx/W
 jgvaVbVOggieILK18zmsLjPaZvNNfQEX6U1kSlBBvot4JeJV/wLwPpmkGKV0X8iSNhgs
 WQ6A6Tjuheg8ayExH3oybIcxRmbKixet0aXxg6HsFE8KD59Gt43f7Q/48Q2KXGvcLhd6
 ZwOZ6JJjFVhYsrdfCktsUEmW7IOg7p7XcOaYq3AVffa6JZx/pRMzxbWrvg+naRFatPER
 xh2SFOdskd1RLVHBRivUWVz5z/D0MpMixjsS2raHuJWtRl0wyf21Etyqw6f4D9lBZT6o
 yeKQ==
X-Gm-Message-State: APjAAAUCzANilFz0/+ovyrhW3PUf6QQ0DVnjSkCmyDP8PwA7/Pw70hw8
 HgjAVUO7uIQmIqJLHt28z2ebNQ==
X-Google-Smtp-Source: APXvYqxltXedsOAKvZerlYpx2e7Yb/DrCK36npZu7YuwIP7XTcswflyG160PHiKGIN8T34N23Pa69w==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr28684266wrv.247.1565431434814; 
 Sat, 10 Aug 2019 03:03:54 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s64sm11181152wmf.16.2019.08.10.03.03.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 10 Aug 2019 03:03:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 99DD91FF87;
 Sat, 10 Aug 2019 11:03:53 +0100 (BST)
References: <20190808164117.23348-1-alex.bennee@linaro.org>
 <20190808164117.23348-2-alex.bennee@linaro.org>
 <CAFEAcA9i4igz8+DrmfcfDbBJEoR4pyvqCvKEuB=Vrt6_6y4onA@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA9i4igz8+DrmfcfDbBJEoR4pyvqCvKEuB=Vrt6_6y4onA@mail.gmail.com>
Date: Sat, 10 Aug 2019 11:03:53 +0100
Message-ID: <87k1bluyk6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 1/7] fpu: move LIT64 helper to
 softfloat-types
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
 Aurelien Jarno <aurelien@aurel32.net>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 8 Aug 2019 at 17:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> This simple pasting helper can be used by those who don't need the
>> entire softfloat api. Move it to the smaller types header.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  include/fpu/softfloat-types.h | 2 ++
>>  include/fpu/softfloat.h       | 2 --
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> I think we should be trying to get rid of uses of this
> macro, not making it easier to use in more places...

True - that is a more invasive (but mechanical) patch.

--
Alex Benn=C3=A9e

