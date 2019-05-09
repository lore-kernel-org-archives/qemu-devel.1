Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBBBC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 23:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEF120989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 23:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7qmJifl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEF120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33933 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOs5E-0008At-Si
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 19:04:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOs4J-0007j5-2s
	for qemu-devel@nongnu.org; Thu, 09 May 2019 19:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOs4H-00070v-2f
	for qemu-devel@nongnu.org; Thu, 09 May 2019 19:03:14 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOs4F-0006zQ-41
	for qemu-devel@nongnu.org; Thu, 09 May 2019 19:03:12 -0400
Received: by mail-pf1-x441.google.com with SMTP id 13so2083586pfw.9
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=rlKpaJVBQlL0XT3HeqplK3PXLTGkK3kpZu2GVkTAO5I=;
	b=w7qmJiflHf4oAmri55f8tQW3Yuyx3OZ9lklI2lh02Jp4DxtSY+vT2DAYOxiOcYyLuF
	sKp7d6hGrh81AXH4drsmP69ufGYM+ulyymNPGEr58BHOMaRoUgt+8HWGLy3YICKNg3Gz
	byfao88jVhmfuoH55pExRUIMiaY8KakWc/aHixlMbY7dNrFjLHlXsQCY8hJ0jZ4CRAaJ
	nPXU4/g02n7aYk6MZg6hJyfQ7dmWgnBj86v8r9gTcnvFZbLy4kkzQYiiWBlSADM+4Fnr
	dHRgrq4IPTC5d91ZNhdF0aTvY9Cyu/OkF1NGGRTE+EiBT+tLBFia7fKA9uelWOiMkKYH
	I2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=rlKpaJVBQlL0XT3HeqplK3PXLTGkK3kpZu2GVkTAO5I=;
	b=M47r3BzJW+bDxFeSEwboZr7a0CeTd/ufHeoQpwMLMeuo9DMgHOGbS5VNty7w8mE5HF
	xWmse2LRgogsY1VjcG457y/AZxi4igX9rGUmILdW1qGZ8dTnjYWwBwE7D11gGJpaKpS6
	esuSqBAGLBLmYNxgydjUUFlbmKKQyVmGqCCcqU+1mRQBjWmlbBCHKmJC7OtmTNDEOMz7
	SowpDhOnx886sQLgfCq1BA4/tQmpONoeipbiPYN2pJ2+aWmTRxJlZSj9bzllwxnlKbul
	ddbpG2WG1jxZsR11av9IxQW6bIq8swUxFJ52Gyb8vLmyKGJVz0V2D+qkmF8BO9iHanZG
	+eOA==
X-Gm-Message-State: APjAAAWD7w8uU0w8g0v08WGpHp8eIVi3/IYN11+JEqNk5Lqap1gfKw1r
	5rbUT33X5ct2ivj8LGsoMWun2g==
X-Google-Smtp-Source: APXvYqx2bKmMtzt7l1BTH+r/eTy8GU9/S9LNYXc0Bmh5BV1BrkheITf5rBPjCgdMO7GHxA6uJpAjdA==
X-Received: by 2002:a63:5110:: with SMTP id f16mr9277223pgb.107.1557442988894; 
	Thu, 09 May 2019 16:03:08 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	n188sm4478627pfn.64.2019.05.09.16.03.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 16:03:08 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <512bc327-c8de-6df3-72d6-0548b9258f09@linaro.org>
Date: Thu, 9 May 2019 16:03:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509165912.10512-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 16/23] tests/qemu-iotests/005: Add a
 sanity check for large sparse file support
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-arm@nongnu.org, "open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 9:59 AM, Alex Bennée wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> "check -raw 005" fails when running on certain filesystems - these do not
> support such large sparse files. Use the same check as in test 220 to
> skip the test in this case.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190502084506.8009-2-thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/qemu-iotests/005 | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


