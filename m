Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E22C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2611F20835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D++qCVuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2611F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46758 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGcId-00058R-DY
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 00:35:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcHp-0004dZ-Eu
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcHo-0000y8-Kx
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:35:05 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcHo-0000xw-8p
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:35:04 -0400
Received: by mail-pl1-x643.google.com with SMTP id n8so11381048plp.10
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=8ioZoRHGgxcke29rUZn5yk7U5UmI8nnmWlL/vqftbzw=;
	b=D++qCVuzkB0dwJ9mCQNkk3L3j+zT3oKEkgfLibJgZfVg8se5nQbgPtJ8K203M1MSEP
	8MQgh46IlV5m9mkw4DCJ4U1MsCLHZN/Ryx3z5u8WkpEH8Gk+SYvlczKY3nTOCjaHftO8
	lfrYYnatl6Y5bHYwnc8OpnDib8nwtqnGBDcjbE4BzTUO0X9jFcgzNmAZ90rWCW55jfzk
	fP7SneHl3zn3ypv/s4dbKufhgGH3fGDmrtBRfbRxPBTLuzdhFyy0QxATl1wFqKxKGosH
	eiFEBXC9eNEJsLTQkhkpuyxhcu4VYsVSQV0T95Of7NE7jfnFE8pCPoAA4ecA44kpAlY+
	vpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8ioZoRHGgxcke29rUZn5yk7U5UmI8nnmWlL/vqftbzw=;
	b=T1cMr8V1hGNIYMYkeF56Itz54x/KRQqAvFyvsuKnB4rsBuBAL3VydcTeGGXnMIA7rs
	8FKwuaqXCS8LkjMPMRjOj9/aoJX/kLLBV6Gkt0eM1FttjzuVPLT90qva6m9HfF7KuQ3y
	gJ48iNE5dB5o57jkf7m0SDmaaVO1w3NNh0KpdfU6eiBsNGCAT9EvB9oH8LZ70vMcBtU3
	/2ZWl8m6Ez6V/6BBNTV0J+m9vnrBiwjd18/XKrZ7vkWcwedUSJLm5Bq1YVLp4Xf3ceqn
	vw8ZiLq8pDu4UBa55Po5bgagVBK/kfEMWHmpfb+xTBM/+ZxRNhrNivDpNuMrsdG3UoZd
	HwWg==
X-Gm-Message-State: APjAAAXTC8Os/svzJraWbdeBB9PLV27wp6MXV3mA/sLZGR3rx8BA6Bea
	e60EZ+E5br8Vc5rMVAiyZT+3cA==
X-Google-Smtp-Source: APXvYqz/Pr4pf5LyHz6Mz7LZ9F8oVPjNdCN0UIlKj/wclVL39rT+uvyuiazSkdpou7bkvqMqapJ65Q==
X-Received: by 2002:a17:902:a607:: with SMTP id
	u7mr87936730plq.66.1555475702963; 
	Tue, 16 Apr 2019 21:35:02 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	r145sm131237752pgr.84.2019.04.16.21.35.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 21:35:01 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a721581d-ee23-8dfc-d618-48db9d1d38e2@linaro.org>
Date: Tue, 16 Apr 2019 18:34:58 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-4-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v2 03/41] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
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
Message-ID: <20190417043458.32tuZbxOo4OT-s-oSwHynv9jHw33BhOdMYU0P1BTl_M@z>

On 4/16/19 8:52 AM, David Hildenbrand wrote:
> 128-bit handling courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 +
>  target/s390x/translate_vx.inc.c | 94 +++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


