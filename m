Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6688CC10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B3520850
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yL6AO5kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B3520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFBXT-0006C8-7z
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 01:49:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBWY-0005qo-6X
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBWX-0006Ye-84
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:22 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBWW-0006Y6-KH
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:21 -0400
Received: by mail-pf1-x443.google.com with SMTP id i17so6119983pfo.6
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 22:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=yyATKadU96zCFjKP/OHQWmE6keq+o5g6pYAacztPLK8=;
	b=yL6AO5kQyuOaeZ9uLoctLBvWTZgRJzIkFPj/FdwoTvxeCaZ0w8RikMnX22tyN/vuO7
	Ml4K0dqFPTMOnJXkwsGUOPFfGavJ9sUMICvGZE89GLWtpUxYbSkPx+/ZD3RQdAZjnKE8
	xlUfE6SaFQnx4yhFCgHzo/jUydPKzRBuWVHZPtof/DLSBl/zGna1tqPDvO678EubFLtX
	fNPjk1HwakaH6UJjEu0HfdXGZfdb5/jIAO1lrCvBnnB6TYVZ2RWhfQjImqgAsW34GoVI
	MzX5k5oWrIdrLbNBj/2Yk5ANQ1XKIWLid7/YfE+MHy1jewudoV66Trak14C6RRO16ajM
	YsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=yyATKadU96zCFjKP/OHQWmE6keq+o5g6pYAacztPLK8=;
	b=baVvpq4ef8ayeKqiGg4kRnCwUpuodFeh3A72+YqgQqfKJjZk8mp2t6xounUAQqIuaj
	+/4soP8Z7lsEeVTsHtH2YM9asDRHNJN2PC86huk8B+/SBuHQ2TUOcZeyQCVjaWepSxIc
	qybTSM+ec/8tPGdx7pLXu4SqNhDvz3wykUmZyrpz43LDBhhZA0NFhnIxgTYCcIer6KnX
	bDGtX6WXBrCPc3YAGJ3znIJ8qq91+ZTsfqakiCIet0l5HANbFLNxj1IkvhlWUADTvRtX
	hzOJhQqda3ai+WqvX5Bix5q4ygzyt0byA7QAX+35XdM4zyiDAOX7LCyauAyZt1E1lw1m
	x34g==
X-Gm-Message-State: APjAAAUduLC1uBrFK23Uqa49dgZLFxihqU7ACfs+VMeNTwtdbmFGlcXy
	NYVzvcqr5gXrsp+HgfFzrd4MuA==
X-Google-Smtp-Source: APXvYqwgFnJMT65Wj4kvPzgtwfPeE/zHGapEfY3dUY9dwqjLoHgRBeXmJjbxDVQEYbdF7jG3oPaqtw==
X-Received: by 2002:a65:51c9:: with SMTP id i9mr57869748pgq.187.1555134498754; 
	Fri, 12 Apr 2019 22:48:18 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	18sm59111820pfp.18.2019.04.12.22.48.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 22:48:17 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-33-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a5addbcf-5e3d-7b27-1540-69f026726d86@linaro.org>
Date: Fri, 12 Apr 2019 19:48:13 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-33-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 32/41] s390x/tcg: Implement VECTOR SHIFT
 RIGHT ARITHMETIC
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
Message-ID: <20190413054813.trsQXbEk_Q7uPaV-5xo9Ui8LgqCtfCPwezcDYHXh4d4@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Similar to VECTOR SHIFT LEFT ARITHMETIC. Add s390_vec_sar() similar to
> s390_vec_shr().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  1 +
>  target/s390x/insn-data.def      |  4 ++++
>  target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
>  target/s390x/vec_int_helper.c   | 26 ++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


