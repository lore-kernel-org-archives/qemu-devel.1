Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C695C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E7820693
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHwu0qKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E7820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGcOi-0006sM-6Y
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 00:42:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcNx-0006ZQ-Oe
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcNw-0003La-Uj
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:41:25 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcNw-0003Jw-Jh
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:41:24 -0400
Received: by mail-pl1-x644.google.com with SMTP id y6so11432815plt.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=UJ28g7MBRcpk1Uv1X5gLiBpEUoupibiY5eaxoB+nzTc=;
	b=nHwu0qKy5dIYFXF6tbnwK2lnxKcn9j5lOlhUYldPtpRxOnP5hZwwe7nSmk/Dl5LfL2
	nMJ1Vu3xmwK62B3GGCC7GKHwaDo6cmbUrzdyKC426ISJYEmo4dnuL3vUFzbWG1NHLt3Y
	AXtdSAoaA5UpST1+fDyjtD2qdu17LmrLl9yg3oAAp2UH1e7SFYRAJKJM8F9ESPO895H+
	whhNKyV0vIKlFAzXlLO+MUCU38w5gx1fb33nn2Qp2Ag6r/OBX1R4iAVDWSCKxfcwQbwe
	2z4TBitREuWAAjK0CY+l8dVgNWFyh9RcLAR47sU0dcgKaHccrPnko76iRIhD0Y+V+Nzc
	yt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UJ28g7MBRcpk1Uv1X5gLiBpEUoupibiY5eaxoB+nzTc=;
	b=NUav4pfA2nLJeQbeluyHQSRZTyBpxwJ/7prTj88A39X6su72fCkcvqFYshl6yw7c+N
	u/32tGv95K/Pxo3RcOY4+3T2lg9px4TczNfm5YaHfBi4b3L6NXDQU/E1e9btFaEC3Kn/
	+HyxDu32hia/0SXeNgVkGPBd8A8kHqjPcGaf07mygLV8G7q9MaS6MWhKJ7YNgi0Xf4Wh
	kjlsxrhV8gU0zXAP5218wEoSFiNl8Wanxq4eoDrQx+Jnq4qNu6DiJr/+Ftf/6vACyg1C
	dbhiKZ7zlG/NmTkodpVi4ajSJya7wlVwd6kdXRKSliZh3t2BJqsW5rSKY81We0KCr2h1
	2LbA==
X-Gm-Message-State: APjAAAUF5ZTuaIMOlSTC+fRQORAN3J4dVn3yIv4rSHmpPJiDBkGNVmz9
	MzZvvEnNZMc4NEGwqsJuQUgHTA==
X-Google-Smtp-Source: APXvYqzWTcbwrEoTVamP/AySku/jdLYn5boslSzuV1Kel2ooK/RSjGGBzVnogEhqYNVWBUZuqx1CxA==
X-Received: by 2002:a17:902:e287:: with SMTP id
	cf7mr59015189plb.217.1555476082379; 
	Tue, 16 Apr 2019 21:41:22 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	m25sm71947720pfa.175.2019.04.16.21.41.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 21:41:21 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-14-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <237a33aa-1c94-cd42-a10c-2059d09f3166@linaro.org>
Date: Tue, 16 Apr 2019 18:41:18 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-14-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v2 13/41] s390x/tcg: Implement VECTOR COUNT
 TRAILING ZEROS
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
Message-ID: <20190417044118.hIfUZB1q4GPkB9gbPBX5L8tBHCZ5YPW_8v_3ThCX3OU@z>

On 4/16/19 8:52 AM, David Hildenbrand wrote:
> Implement it similar to VECTOR COUNT LEADING ZEROS.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 28 ++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 14 ++++++++++++++
>  4 files changed, 46 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


