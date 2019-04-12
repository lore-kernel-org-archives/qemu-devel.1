Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA8C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1024F2086D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J94Q8xgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1024F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44227 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF5yT-0000Vj-Dj
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 19:52:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5wy-0008Ie-0p
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5wx-0002eb-5w
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:51:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5ww-0002dl-TX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:51:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id 85so5908794pgc.3
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=n6Jg9MepiCi0FWt4qDooc/fJVwFHXKWdgGsI5FaW4cM=;
	b=J94Q8xgNeHxT3N7Ujg4clBAgffuPAsQyPr1xfP80moJR/4fVFHi04G/xi0AiJ47q3z
	rd0K7DP9hEzBfHE0/ZFJXuv6bVa+g03koCl5TJJyMkwwdwtlE59M1qM3BGrUvbmyoPQ9
	qY8Ers+sgmu9GqJn6Nfdj1aHZUhgnWkS/wGJHkbS4zS6i0OcXvFXjZAuE9zspq1XCPaA
	a9y9wzTbhBbQJgw+IrdQK+V50r18XXj4qV0HRMNFi5vhcVNq662531ccR6Kpgv+rtFIT
	HFFYVT7N1fHIq8dGzDzsgH4jOVf8zzMjBbucgblJUT0SYZDuDwCPdUJA3XHm1Jk9xvDY
	KAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=n6Jg9MepiCi0FWt4qDooc/fJVwFHXKWdgGsI5FaW4cM=;
	b=iKs8PxIGe8z+DPYDg7VZF9EXaI5YQJi4ID7BqCuVauTHT/wxsSRsp4WqnLvb3EzqoO
	h53aFh8KDxhm87yMm6j5GL0oRdJJNlgKoaS4Gb4guV1ikh6FMY+d06EQwXOJdwG2zYTb
	+Cu+Re1nJWWUFydVc34QyMzrPC1GSrzxcshROW0YmgPtdDZ0JEKkAkqlooFW3bdUlz+4
	+tdQabASFYj9f9QgOOrvEvnqC7lh0NqAoGKtE4qvq6b/RmPObF6zoRIQh3TfnLi9hT96
	N8rLW2emCrmRtKgEXFxr40kMXyO4v9oyh93aC7wqssfA9cyGKLZgKXI4KkOghXvWEQ0o
	ywfg==
X-Gm-Message-State: APjAAAVUEdpH8lJ+hxKVMQJOt7bBiGPF6pc8BHpU/QPiAiMq/iFfAXFK
	BfS5qMrGwhUYMAQx5fjMHbeVBw==
X-Google-Smtp-Source: APXvYqy4Fb5YqgsaJ+1A10q/Rm7QKLyb+VOXJdSBLjQEcZeVspxX98aBRh7a85ywD42/FHRkNzTl7g==
X-Received: by 2002:aa7:91d5:: with SMTP id z21mr59812595pfa.222.1555113073991;
	Fri, 12 Apr 2019 16:51:13 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	s9sm30557601pfe.183.2019.04.12.16.51.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 16:51:13 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-19-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2c980718-0a9d-10a9-5c39-aa2b99d99b8e@linaro.org>
Date: Fri, 12 Apr 2019 13:51:09 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-19-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v1 18/41] s390x/tcg: Implement VECTOR
 (MAXIMUM|MINIMUM) (LOGICAL)
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
Message-ID: <20190412235109.t3bgHHi-NjvxcwawxKxPTbdfYywMvXbxP785J4zyUnE@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Luckily, we already have gvec helpers for all four cases.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  8 ++++++++
>  target/s390x/translate_vx.inc.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

