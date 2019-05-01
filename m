Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A936C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1974220866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srM7ZBe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1974220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLpzs-0000tq-8R
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 10:14:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLpy6-0008Ht-Qm
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLpy3-0003xs-5T
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:12:18 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:35065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLpy3-0003x9-0C
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:12:15 -0400
Received: by mail-pl1-x62d.google.com with SMTP id w24so8266857plp.2
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=4kQDhN4NfcJBF1zjhcmoNb8ChmBiTpVGRwYChVDGMjI=;
	b=srM7ZBe8Zw0DfinvlSvYIhB4E7D1RwepaUfUtAsRpLBecIh65i1Hsb2qMIQzBLAdHh
	Yv8HfMJoGIiCXK+6HGLQs/fjmR55Zjf96kPytC7tO0OYCuF3m+RYwyKWX1pOPRK8yeHg
	ZYoZSuaDSEr/WN+6E1q0d7ZgO01fLjIWo63MT3Q7wyzR2wP5fLpIHXgNKZczRDqdPOav
	zwR42Ayj0qOcSsSX5y6j0DIlBpogO881CoeOKKa/qkdVPVkFAr0DjaavWKIzkhAbI2ks
	jue9ujCXAw/kfHrHE1EoKcavktWabqGuM9HPhKfVT5QR99MIgTenatc0o31Wce/r15R/
	buxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4kQDhN4NfcJBF1zjhcmoNb8ChmBiTpVGRwYChVDGMjI=;
	b=dmuD0mebU9+A40FVlIYb5EqUD/xGA2FlbiBUq4QlX7L861uG47mTRhLTg01riIUPz/
	0GgZ2SC11rl2TRAC6Rt4zD7jt1Qg7FYbP3b0x2jMdzFkgkmwTHUK8VfjP1eeBIhRZjX0
	QGwKYrW6tJhvIXt3N4SwP61TNmlRRJQZvpVaAg2vNUFyEva2o/HqaZMmLb6BUkv5v59T
	txZJ1dlk2B7hOECF3yrjssV0e+JRxRtJxiu/IvP9e6Mx+0yOK6WhxamaTw2uU754r/Nw
	SVjvHeydh4Kb+dFq1mDI5Uo7dpMME5eFZilRiZx9CSTEo3kWPTyihGe/x20ILRH0GFiX
	NUkg==
X-Gm-Message-State: APjAAAW2vPpvVke2PLF/XY/CHISbFX5P/Bnp02Qf1cB6DxE6EXdRUV3E
	bHLu/kdSbDLp6P/Px7GzxVElIg==
X-Google-Smtp-Source: APXvYqyZzZZIH4hhL8sXByYEejO6rlQMe98XGUZrIsnQu71RB1XTNt2IaqtPZmBRvLi+0jtzvftHng==
X-Received: by 2002:a17:902:28e9:: with SMTP id
	f96mr5708519plb.37.1556719933212; 
	Wed, 01 May 2019 07:12:13 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	e6sm41948353pfe.158.2019.05.01.07.12.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 07:12:12 -0700 (PDT)
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0d585793-20a8-8dc8-98fa-13789113f672@linaro.org>
Date: Wed, 1 May 2019 07:12:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: Re: [Qemu-devel] [PATCH v2 2/5] hw/usb/hcd-xhci: Fix GCC 9 build
 warning
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501141210.uo8soEtxxGiEAKsVywD7L2MJQI6TP59EizQ9H7YdGQQ@z>

On 4/30/19 4:28 PM, Alistair Francis wrote:
>      for (i = 0; i < usbports; i++) {
> +        g_assert(i < MAX(MAXPORTS_2, MAXPORTS_3));

I would hope that it works to move this out of the loop:

  g_assert(usbports <= MAX(MAXPORTS_2, MAXPORTS_3));


r~

