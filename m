Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0187C10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A9320850
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWfHLiGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A9320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6G3-0007xX-Ea
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:10:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6DB-00064p-W1
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6D9-0004NZ-N6
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:08:01 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6D9-0004Mx-Cs
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:07:59 -0400
Received: by mail-pf1-x443.google.com with SMTP id 8so5872748pfr.4
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=wvOeSO+2P3Ii+Yyl+41rRYE4WUfuvKCp7szSFgnXQpo=;
	b=iWfHLiGO6HFfXpY4NMx+UqUkpsxwVAKqtwg/YUqBYIG4BsmcoMwHxTZg7Wch/6phpy
	1AKWbIzWYxf01HmUmgjDzb8Ymh2m2wGhBFPsA6DYHGmrZvriskgSVZjuS8mCUVSZGkop
	5+/pKZ6rndCEaRgo9ingJYOH20e5qCWRlw8aP4EGnUcHj86kblJG7KSA7Gg1gzqXcn3a
	rGVnSxSjasXL1+MOgmCXPZDkv2yPphM5X6NhxGMrPUAbGymh1D39GmZCaukxL2IyVJlr
	ga4s/VLl3PzjaL1/p4qxFzQ7ZIE3e1jaTcQUEVlmw9Soh5s0zfSto4Jj3RLXvz2jM56l
	VJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=wvOeSO+2P3Ii+Yyl+41rRYE4WUfuvKCp7szSFgnXQpo=;
	b=Dd35HkAgpjPrntzRboAzcfVo+nVfJpEiil9PYA59RTGScd4SMJBSFxMGp1MuZHFTt+
	mHknjf6odyxrZxBCIy66FWgWYDMgcXewzwt/GLJR7/MufMj8thVeyV+uKmM4ZVtIpIDF
	qvnaInT11RDx7TxPO1rqsaK/Cgevqi/gBZyvKemCp2ixtlLKHJxsGsK8vw3uNaro+7ke
	/g1KeJyvkuwc9QHxj6c+q+FChimnGtxQSuhZI1/RI+MaM2K2VYFZ8N3zE4/ktCvzMEgO
	S1L7A3VZ8Pa1xZ1acI1ZcSUjsju78WxN+XYmLNynPgOLJCmEDg3DZ4hU0Hdo1Zbtg5Zp
	zyiQ==
X-Gm-Message-State: APjAAAX6jCJ85DEu3oxB9miKOyFLdDs439zeXceotLrmVDvNv9RXVKI4
	ah7TSpk9AV5cAQrTTNovNWSS6g==
X-Google-Smtp-Source: APXvYqxQxek+9HSgm0y9aad+/tHN2/Xn8Ohv4sOegGE4UvjpLWvNb1S2K7L8XzOSp4ADL0YqIg2tPw==
X-Received: by 2002:a65:638f:: with SMTP id h15mr51295578pgv.147.1555114078412;
	Fri, 12 Apr 2019 17:07:58 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	g2sm63857795pfd.134.2019.04.12.17.07.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:07:57 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-26-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <473863bf-f871-1ac5-4082-02a0ee75f29a@linaro.org>
Date: Fri, 12 Apr 2019 14:07:54 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-26-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 25/41] s390x/tcg: Implement VECTOR OR
 WITH COMPLEMENT
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413000754.lu6cnz9PWp5hdWI6bJt-4xPjGH3zCkeWbAZBSW3njCs@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Again, vector enhancements facility 1 material.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      | 2 ++
>  target/s390x/translate_vx.inc.c | 7 +++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

