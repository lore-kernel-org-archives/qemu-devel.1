Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74E2C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDD721537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rp2yhaph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDD721537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlVd8-00029u-Ic
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 05:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlVcf-0001gv-O2
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlVce-000214-Mk
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:44:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlVce-0001zz-FT
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:44:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id p13so5506854wru.10
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 02:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WS7ZX1gUM4Kv+O86nvFNaqgOEtk/PO+WXJ9kN9BnEeY=;
 b=rp2yhaphUqx+X5tIjpMFtd4oPdoJW6aiaxn32k+xNnCPuLPTZeez+xEFZ6ZHH25z/O
 yCSImE2B3/e0wr94jyfnhVEW5zUEuOKgGMepNPA4xx/Aq6LLtvsceiRZkpGV3QJvLYCs
 ImQNANglsz+LpVfu/NOUQTDALhbsTO/9fX/QNn6jjTrACC3r929p7DqRHcETcCHXk1Tg
 uYxA5/EjFJnTfHaWjrlGLOpMQCf1zUf0FDJ5si3R0mBgAi2Ka4KqXvXDN3khDEX1Ru5t
 /znQJk9nhorCtm995WUWaXgfBH8cXQPsbpeCyf5axLTU5PVCIqK1LltIGKvMr5U61nJT
 VdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WS7ZX1gUM4Kv+O86nvFNaqgOEtk/PO+WXJ9kN9BnEeY=;
 b=jld+ySqQGGdxYUzZ3pPo+E9WbISoA1++YSa3LVwNhvjU8DvfnySoLy0CaQjMshegSm
 JYyj0pYw2asPShaifmq1VFBAWxysOP7hMEN5HI6CV6eq3xpADkDfydrkclbTWjHvBvuZ
 xQLBYrHv9g76bkl8VigvK/KX5hKoj9phtL7HZCtuXCbb4lxzzIzZLdWKbwEgPkbA0YVC
 cJcbto8ReJi0Xy1H9Jsq5jGlrESNGBfZHOwtOupoLjVEQTy/Qww5sQYi/FTbUveE732k
 mffI3HAwH7e/+XgR42JQtr7Q4A4C4RtfwQhnrqrQ611dwbZLt+Wy+fqyJrY0oUFr9uFV
 5FUA==
X-Gm-Message-State: APjAAAWyOFZfy+iHbddvBxEj0+7MpTUS1h+Vwj5dVJjM8SQzES9Jt6UN
 5BCttYsxHCU+rd3BltrwhMS3wQ==
X-Google-Smtp-Source: APXvYqx8+UBCOdo/qp4qdCpWNXF9VEmKTJhFzj3P45O2aUj/I6LJkCoVnMBzbNwkNBMpRf0QS3X/xw==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr3953306wrw.96.1562838254541;
 Thu, 11 Jul 2019 02:44:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b15sm6497201wrt.77.2019.07.11.02.44.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 02:44:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6E84E1FF87;
 Thu, 11 Jul 2019 10:44:13 +0100 (BST)
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
 <f1b0ff64-0c62-f1b0-8362-539d9d37156c@linaro.org>
 <53d71ce2-54da-b118-c5b9-c49216d13d51@gmail.com>
 <e2947ad4-3668-0d23-1374-4101ebad6c9d@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <e2947ad4-3668-0d23-1374-4101ebad6c9d@linaro.org>
Date: Thu, 11 Jul 2019 10:44:13 +0100
Message-ID: <87ftncewia.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 06/14] x86.risu: add MMX
 instructions
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
Cc: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/10/19 8:32 PM, Jan Bobek wrote:
>> On 7/3/19 5:49 PM, Richard Henderson wrote:
>>> On 7/1/19 6:35 AM, Jan Bobek wrote:
>>>> +MOVQ            MMX     00001111 011 d 1110 !emit { rex(w =3D> 1); mo=
drm(mod =3D> MOD_DIRECT, rm =3D> ~REG_ESP); }
>>>> +MOVQ_mem        MMX     00001111 011 d 1110 !emit { rex(w =3D> 1); mo=
drm(mod =3D> ~MOD_DIRECT); mem(size =3D> 8); }
>>>
>>> Oh, note that there are only 8 mmx registers, so the respective rex.{r,=
b} bit
>>> can't be set.
>>
>> Actually, my CPU chewed it without choking even when the bits were
>> set, but it will taken care of in v3.
>
> That's interesting data.
>
> I wonder if it's worth retaining this as a feature in order to check qemu=
's
> implementation?

We could be some time, c.f. BlackHat 2017

  https://www.youtube.com/watch?v=3DKrksBdWcZgQ

I suspect if we set https://github.com/xoreaxeaxeax/sandsifter on QEMU
we might find a few breakages.

>
>
> r~


--
Alex Benn=C3=A9e

