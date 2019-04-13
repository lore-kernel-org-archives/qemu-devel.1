Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6703AC10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F023218AF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nV7pBHlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F023218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44363 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6DI-0005yF-CD
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:08:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6At-0003sM-74
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6As-00033p-FB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:42585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6As-00033M-4e
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:38 -0400
Received: by mail-pl1-x629.google.com with SMTP id cv12so5859861plb.9
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=vqxC5iP+G4xlur7lJNAiXaZVlcbf6jJcEmQGRUXnDdM=;
	b=nV7pBHlgC+1EEfOe37FRj3lrZBWZ1TcQ4EN+OaUYxdrTqR6ir9TOxY7O89XVj8jl+c
	PsZHEjQi5TN4WdKS2ISMxSrI1UP7MgZphI+9a8Cz7ZPeIxDJ8NE5SfWt1RHSvlLN2Rd2
	Fti62I5YFjaqYKeWZpHFtuahzkYDBPSzvoPbZPkp/Tc5aJDEn4JfG0MSQ9ZGWZ19jpVl
	+8f3dis7aCT4WOZRR6ziwe4FZNYt4FYmwjiPZsr96XeyY8o8Xn9gwzjnW5KF5hqPciHU
	OAD0A1oswlK0PTARryV2Xs3vrnQSonxV1BUVWcv/ReNbxZ4y7FvtNjlaofNUtTfPODhC
	tuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vqxC5iP+G4xlur7lJNAiXaZVlcbf6jJcEmQGRUXnDdM=;
	b=nLm5EYlqsWnGrm+rGF7vMepBm5b7pOoAXD1judvexjWk49sFL52MKWFrggxuzz05u3
	Atf9v3O1ClLKy80K/9aPvAjVSYsafywTbQzc6L2sDKxOwPXcMW+RDQ36p595oDcKA9kZ
	qrw86y5siXTjZ0YG0leIhu/YthqthLp7rIA3PGJCKv2Ig0xVZmYvNh+YM8FBG7TMIoWg
	b9G7/utUDRR3TaW1cixb9X8amIttBhtdzvMQdnfM6175KvImEkAiJ/EXXhcerljSrFV2
	/4tvP8N1g6+aSGgz1jDw1D5W2/8gaRLMwBKE8rwMZbT2L7nXz6Vz35PslZk6LNtanPwH
	Ilhg==
X-Gm-Message-State: APjAAAWNfXa/MwGenkis3KlVbZA3L1K34IVL0SnJB8GVtIJclCtg66Q2
	mtlf5kg/fmc7QIAX2sQRon01Yov+V4Y=
X-Google-Smtp-Source: APXvYqzSjus1/kVGZ0vjhL4vZpEHTCYmj0z1OlsJvCCKLzWLM9sLTH5Nh3AEGv/Zm+J0vUAAspH5zA==
X-Received: by 2002:a17:902:2d01:: with SMTP id
	o1mr60921266plb.155.1555113937009; 
	Fri, 12 Apr 2019 17:05:37 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	a12sm48206132pgq.21.2019.04.12.17.05.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:05:36 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-23-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <156d4c66-a764-3a6f-9005-335922cfc327@linaro.org>
Date: Fri, 12 Apr 2019 14:05:32 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-23-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: Re: [Qemu-devel] [PATCH v1 22/41] s390x/tcg: Implement VECTOR NOR
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
Message-ID: <20190413000532.LN8E73hzBgqFCuMRv0mHzHYXhRcGSEW52VBCYw5cNFs@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      | 2 ++
>  target/s390x/translate_vx.inc.c | 7 +++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

