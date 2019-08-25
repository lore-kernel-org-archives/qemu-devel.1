Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CCFC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 15:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA342080C
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 15:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFoYy796"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA342080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1u8h-0004R4-D5
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 11:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1u7q-0003pJ-7K
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1u7n-0007nb-QP
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:08:13 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1u7l-0007iL-Oa
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:08:09 -0400
Received: by mail-ot1-x344.google.com with SMTP id m24so12926246otp.12
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lXaXIotgga07y7FZV9L5+iOFgu/3tQIR+KZjMpDYmfQ=;
 b=nFoYy796rf5w4GJmAlr08lQTFx9zY2IB3SZ3z6od98jPjLMZeDRKPdvIW12csgio1O
 QUA3ZFclNfuyYmcU5eHP4MIA+QgVVIU0FWD5lPkPUSB1spzz94UttGuSw5sS+2K8s1BQ
 6243vJT05G8d+M73nNEG5nnVohEDTfYREMQYfMtLdqRTnt7CNIuvNMC6IHCDDwqpU9Va
 6B3Mr5tYfZz3cNpXyCc6FPqasXwgciKmwYTE9M8L84gq8wQv6x7U9oXfbcFf9mBrzXXs
 WbpGaa5LlYw+whgbGNKzeglOdG48tWArJIA7d5lllt8OaO87+ihrz0PxMOfHr1EFhV0i
 Ctnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lXaXIotgga07y7FZV9L5+iOFgu/3tQIR+KZjMpDYmfQ=;
 b=Zjss3qjbY1qxYWuShki9fkMd6k4zyuKoDwcz+zfhT2dycG/3ZTzszW5/ms+uR2IcjL
 W0ezqg82j6ZL3ZktY8dgTenTOp6Mx0Ix1tMs5Ow8BPyobU2SVG49nMUs+ohOfNsitULR
 DDwGJlJUnJucQrK0FkxD4wrSjAg3kiR4kFccG4Bic9yMePCn7B6JsJCYwSK1YR69CKil
 IY2O1M5NolQStqZeIpxxuyOObJiQlbrv6cS+MCv/Os0hjgIacQ0sDKkBg6VTw0BUqdI9
 MYN3UWFwAGu5ilYuESiRKkc6jKIkdiCvEPJKRAnB144ZMld8aOM/h/O99xxY3kJXbkuV
 lm7Q==
X-Gm-Message-State: APjAAAWESxB8w+mxIcy7w1oZH8GSvDMlZqOWMuagpOybtRUauybN63bN
 S/z5ZgU3tJZkj1YZvXls20gmZjBjnXUbQJ/g7zCrhg==
X-Google-Smtp-Source: APXvYqylWgbBiA+arFmYmkvPQoro3MQAkNl5k5iFl1SRlBdu1HqSzGBaNH0Tx8oHTX/VprI+cgBO4jHgn0pOs90RnM4=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr1177751oti.91.1566745686498; 
 Sun, 25 Aug 2019 08:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190823215451.26276-1-crosa@redhat.com>
 <1566631944235.10945@bt.com>
In-Reply-To: <1566631944235.10945@bt.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2019 16:07:55 +0100
Message-ID: <CAFEAcA_ndWbDtRSUO1_=qTf+mdU8OiT=4NyUXt2+q7a9n5YGEg@mail.gmail.com>
To: tony.nguyen@bt.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] configure: more resilient Python version
 capture
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
Cc: Julio Montes <julio.montes@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 24 Aug 2019 at 08:32, <tony.nguyen@bt.com> wrote:
> > -echo "PYTHON_VERSION=$python_version" >> $config_host_mak
> > +echo "PYTHON2=$python2" >> $config_host_mak
> ...
> > -ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
> > +ifneq ($(PYTHON2),y)
>
> Succinctly, if Python 3.
>
> We can further ween the world off Python 2 by replacing python2="y" for
> python3="y" and PYTHON2 for PYTHON3.

I don't think it's a big deal which way round we do this, because
once we drop Python 2 support the if and the variable will just
be deleted entirely.

thanks
-- PMM

