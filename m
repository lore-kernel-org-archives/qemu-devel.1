Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5F1C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DE82133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JUmrbJFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DE82133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToA0-0000Ss-LF
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:53:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTo7C-00073r-Cd
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTo7B-0005rL-Gy
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:50:38 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:46498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTo7B-0005qb-7f
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:50:37 -0400
Received: by mail-ua1-x942.google.com with SMTP id a95so2176042uaa.13
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Jxeo/cLgGRrMmbDdAomuFQZIeaqkSU2ZLgDPVczQCio=;
	b=JUmrbJFBLAPMbUeLTiHhKD/0rpT/QpFxK8gcMwDAW7bvjDhW5C5iaK+SE6B3PAm7NW
	MeBlTKKOgLbZ8puVTICHJVlYfRD7QzmTKjnhhrOdUX+czlo7pG2mV4Zr6yuau7/R8WUw
	HpdyaWvl7Vvkq1rC02x6pazismdVrZqnIWdZGUU4P94I+CWL9F/J24nlgBHqN2fLioMe
	oeE1kbsCYI93xByMqt2c5c96tfq87GGyCVhDQxv6p8fvFEOq5HJOU8GPRsrhgNWQWJE3
	KadcqxyROcvkmy/MRTdV8FAqdOjrU4Qso/foQLZ+UY/WtsWe4/ix80OPZxKEkK/sgbAU
	PK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Jxeo/cLgGRrMmbDdAomuFQZIeaqkSU2ZLgDPVczQCio=;
	b=Bg+GGMOSWorDs5mxNwLy2PVVF+cGAn9dbiMl2Pa1NGUIhakL9Ob+j3Gh3Y+BIGYOBe
	YaJOEhcIHuq/Hc9H4kAo776UQoJuIwI/EGmrcZk7arjlXUBZ0ot4kh2B33PR0P5+z1S+
	W+9R6VD3HIsiKXr56lhXU46+zug2qdLv5IAY/g6N3jUACJDMsErDddwZk+uTu6/8pz0l
	W0fIfOrGKQ2XrcBr+ZvrEhACiGRNv/ctzF/PyNR2FxFVk38m7JfzYlsZM4xHMS2OgzvN
	vtoQ8VJXHByG87rE7oj7d81vX5GFOLY5SopGtPp8yUp9hi+WyVBI9/F1hwiqM5FUOKal
	3dkg==
X-Gm-Message-State: APjAAAVOJf3Em/YmyhrM1ju6OP7GtJ32mprwms5rxWpNytpRVmgbsq45
	b6eyJlSSIVm9zdeU4+TNTTzPaw==
X-Google-Smtp-Source: APXvYqxLjUPrK8VVDoLvcx9B2w9M7mmZ4rxNwFo8AVOkwSSYTb/4wQxaLhUMgY4azIcewZPQ+W3eKg==
X-Received: by 2002:ab0:7591:: with SMTP id q17mr29049177uap.135.1558619436118;
	Thu, 23 May 2019 06:50:36 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	s69sm7567367vsc.10.2019.05.23.06.50.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 06:50:35 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-2-david@redhat.com>
	<b3611279-15c4-f9b7-2a91-051ac6431b2c@linaro.org>
	<44d7ddb4-040f-6778-7439-043b94e354ec@redhat.com>
	<0935643f-941f-5883-c481-8ac18d57c98d@linaro.org>
	<1f6001a2-e1d3-2b6f-e84a-8b9963302a3c@redhat.com>
	<CAFXwXr=YzSuVa9wMKAczhojU+sK5zzPqpWOaJXDLovLNcmkYqg@mail.gmail.com>
	<db392f3c-2bb2-6e16-ebe8-3175ef7859f4@redhat.com>
	<9b00d53e-d676-7d19-cab6-7fb7a6715d1e@twiddle.net>
	<273c1e4f-3216-78aa-508e-b063c0612854@redhat.com>
	<1c3a49f8-56bd-1577-60a4-7c29ca1c0d83@twiddle.net>
	<8ea05b5e-9d8d-f514-7336-8d7637188009@redhat.com>
	<968a70bb-c025-235f-2914-ecb4142ae79b@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d3e4e0d1-c0e9-7969-8434-e8953fa2225a@linaro.org>
Date: Thu, 23 May 2019 09:50:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <968a70bb-c025-235f-2914-ecb4142ae79b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::942
Subject: Re: [Qemu-devel] [PATCH v1 1/5] s390x/tcg: Implement VECTOR FIND
 ANY ELEMENT EQUAL
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Cornelia Huck <cohuck@redhat.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 8:59 AM, David Hildenbrand wrote:
> I guess I can simplify to
> 
> t0 = rol64(b0, i);
> t1 = rol64(b1, i);

Yes.

> My approach: Compare all elements of B at a time
> Your approach: Compare a single element of B at a time

Ah, I get it now.  This makes total sense, and does make the broadcast unnecessary.


r~

