Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E846C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C062086D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZ2psMNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C062086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44159 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF5rn-0005fu-Th
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 19:45:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5qo-0005Ij-RF
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5qn-0006ON-UZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:44:54 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5qn-0006L2-AL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:44:53 -0400
Received: by mail-pf1-x441.google.com with SMTP id 9so5822420pfj.13
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=okLfsXjHe8ghjLvArdcSGTMh7myK9RrTm7Z9jO1dzZg=;
	b=WZ2psMNc/Vqc8en1UEmd2AGmt38AL/PqDqAjYhG1UMifvjDoKcsSsp/hcEqCc4+WJB
	vToe8OLLs5PVrbDzlDrIjnaotx9JDOrEJ3DBIoZJ1HIQ7chb/HUvpRGA8BAqNkSi3YfQ
	eCkyIETVg0V1tUXYdM4+DLIhxdOiYnJ7Qrsn4yZsqEeEWzTZHAwM1bTqgUEcXnW8CK+m
	VHp/1XURQD54QiXNDPlxNE0xeeL5VookW9pwkVWdM4eLzJUt+4Fn9nFjv0VI3TyLScws
	19Do/7RctXJrsSokFfsX2DCbP/BgC23fOZURvgmK8gYmZq0J4gWvPpM+I3ARLM/pP9cy
	qxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=okLfsXjHe8ghjLvArdcSGTMh7myK9RrTm7Z9jO1dzZg=;
	b=GqiU6tb6sJUo5/WG0qlgYzYVJlZ+g2Uo4+XIKpOzo9MsblqwisG53npyZsUJiViope
	pqFBOyjWTn2EUKUkFppeJY9Wc6uNVSGwgkEGiUWEmNUSrkjWh2REkpVxD1kLfuZVsguA
	0iqj5TROLVB1mTMvBdLMvGcavn7884JmmniSgr4eVUzUg5DtH3qOyHVBLoppFUgefmKt
	nbYpkUZdyqS5/hdkuWl5TUEk0RYuIfQB+5pkM0ql0JX7mcPv0ZdwK3p7e70SLKaw76yU
	Uh1MzswvJUzrBSJ/zUaKDDyDH5xXbx8oMIm/9CJkmen7Sl8fqq9OHWu4Wm/ghHXULWCT
	VkjA==
X-Gm-Message-State: APjAAAXM6x4BbheRt7CCq0w846wN2u3igh8TyY9ifu+z9j4ZkUKVMdpl
	HPUUCQIn77mEBH7/h7EHyZtY3Q==
X-Google-Smtp-Source: APXvYqxYnT7JL3WUUKdcoM54OFXtBEBvBlDdrgidSjWMHt/o5F0WRsPQlSBYqJfh4mZiXHePRshrqg==
X-Received: by 2002:a63:c046:: with SMTP id z6mr53007160pgi.81.1555112691878; 
	Fri, 12 Apr 2019 16:44:51 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123])
	by smtp.gmail.com with ESMTPSA id l1sm48150059pgp.9.2019.04.12.16.44.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 16:44:50 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-16-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1365cc84-fdb6-3a36-9b5f-6921f04423e0@linaro.org>
Date: Fri, 12 Apr 2019 13:44:46 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-16-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 15/41] s390x/tcg: Implement VECTOR
 GALOIS FIELD MULTIPLY SUM (AND ACCUMULATE)
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
Message-ID: <20190412234446.I8nKrbPo1-HJeRNMDYinh-a8oN9G0YONiiZ7IMyYZF8@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> A galois field multiplication in field 2 is like binary multiplication,
> however instead of doing ordinary binary additions, xor's are performed.
> So no carries are considered.
> 
> Implement all variants via helpers. s390_vec_sar() and s390_vec_shr()
> will be reused later on.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |   8 ++
>  target/s390x/insn-data.def      |   4 +
>  target/s390x/translate_vx.inc.c |  38 ++++++++
>  target/s390x/vec_int_helper.c   | 168 ++++++++++++++++++++++++++++++++
>  4 files changed, 218 insertions(+)

FYI, this is now the 4th copy of this operation.

  arm: pmull
  x86: pclmulqdq
  ppc: vpmsum[bhwd]

We really should promote this to generic.  But that can come later,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

