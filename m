Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6070EC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A66A21019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzACr5p5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A66A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVweW-00047p-Dp
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:21:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVwbP-0001Sd-CJ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVwbO-0000Q9-Iz
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:18:39 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hVwbO-0000PH-Ez
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:18:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id s19so1611241otq.5
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Xy51H6cWWG2bUUMmbF2SNKdgsiWnOQpIK08PtP4yCNU=;
	b=uzACr5p5HAnLZRdn9jxEak5jKjqwCAc7r/IjzelK/++5vMJaIobRmgee0AcSLmHghB
	g5FRvgCoguo/s9ENRZy1i30n2YjkHCrpdsztnJ8pk4hHKPWSLvHMRv3xuLN2cwd8LAGH
	EJIShx5rbIozhA4j4vnQrke9Xztcr0OFGwci3JtLW/s2GY5g9DiUkInwimOdaXZWeIJL
	NQWf9qKAde756veYYQA24mLMUMzI4ijLwZOn5q55adVDYwM5YLiR/oT/MMROQ++C6txE
	Fe/U5dGuUpVsJvCeaTmOUfdJ52g4Z4GKF0dtWEUlLnbJGzDF5bIX3KTVnFHYa77v140L
	Lkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Xy51H6cWWG2bUUMmbF2SNKdgsiWnOQpIK08PtP4yCNU=;
	b=WdxqKZZswCNcpmyO9TClD7dcveVVdXfisYHQoDdHgFHugElvPkehivMRhfKQqm2iEt
	Myk9AbYdN7215Hlgcft+iohLsw8LabX75z0dvrszjldcqtsPVT/JfrO7HE0xBuVGBVM7
	s/+law8sCdbxf7xD8cmJBkNOnzceLEDi2kVRUzKWbAQ/MYBUMLqZQfD3BqaweGnFx0vB
	gToIb3o+SQh3XqOB2YXc42ha6wUihoNX2fvPg3ptcFVKFxOlp/QANK5CQSxArVsDGoOt
	0JTjA8LQHKcI+BPppSB4tbZtSiQsRbhE+CWSshqKu2UBKHWnqc4g5XtpAh3rqQZayoN6
	+qmQ==
X-Gm-Message-State: APjAAAVVpF3OzQdAb9XXsu/2I8HAnU9PZFPjPFaBSu/9wTBaXiKskz7r
	zJeThD7PIzRdd/72BatF2dzgAA==
X-Google-Smtp-Source: APXvYqxPqJp+2ljtL+7KkDeUm6+X8iIKTpgBI29sjJisBwiqlWcVm15UGr75QwLYrWcy6mRvw0FRaA==
X-Received: by 2002:a9d:7457:: with SMTP id p23mr20475otk.5.1559128717452;
	Wed, 29 May 2019 04:18:37 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id x21sm5817426otk.4.2019.05.29.04.18.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 04:18:36 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190529072726.7875-1-david@redhat.com>
	<20190529072726.7875-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <77f56de4-ff41-f90e-5a1e-40f9b6f81c36@linaro.org>
Date: Wed, 29 May 2019 06:18:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529072726.7875-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x: Use uint64_t for vector
 registers
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/19 2:27 AM, David Hildenbrand wrote:
> CPU_DoubleU is primarily used to reinterpret between integer and floats.
> We don't really need this functionality. So let's just keep it simple
> and use an uint64_t.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  linux-user/s390x/signal.c  |   4 +-
>  target/s390x/arch_dump.c   |   8 +--
>  target/s390x/cpu.h         |   4 +-
>  target/s390x/excp_helper.c |   6 +-
>  target/s390x/gdbstub.c     |  16 ++---
>  target/s390x/helper.c      |  10 +--
>  target/s390x/kvm.c         |  16 ++---
>  target/s390x/machine.c     | 128 ++++++++++++++++++-------------------
>  target/s390x/translate.c   |   2 +-
>  9 files changed, 97 insertions(+), 97 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


