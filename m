Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0114AC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C180A26CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4FMMoFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C180A26CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46525 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWksg-0005y4-5S
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:59:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWkn3-0001ob-KU
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWkn2-0001Ms-MU
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:54:01 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWkn2-0001Lz-DH
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:54:00 -0400
Received: by mail-ot1-x343.google.com with SMTP id k24so4728594otn.6
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=viiIrUQHXCFTnkm12+2Y9XPqDxeXTtk6aBtYtKwz+Rw=;
	b=j4FMMoFW09t7fTN03a4dERxBL5RyWsMtlMXWO36I1YaI/J/zUwpycJko6Eax/IAMNs
	3ttmw0togFHCpsbu0XqHLMQaRNuCE5+7fPDjN/OnfkziCDLJFXTVhvosdD6ls3Hsc50u
	0vOu80vfUC423N5MPuHMkLbdS7bsNReYABUAjDmV0rdkCpnKrdTdhNYFvX4GYvLVqY31
	/ItnBqM2/6tx+2k8ivZmiGCkD0N4Oj4AJNYODrmajhRFrli76ALU7i4e/bmOSc2U7w/c
	TKfEl/XikWgoPvBPoBSu0/03yvPXmYofPeQl8p1+2dCizUFCSti4IQuJ1psc/S1qQ0u5
	0i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=viiIrUQHXCFTnkm12+2Y9XPqDxeXTtk6aBtYtKwz+Rw=;
	b=PHAqg/hrmlOEgWGf3wCrJl5buV2hgvPv14ujiugWUH7QGp0bSyMbLC0g3z3tXNQLz7
	mUm5ClMnJrR14HjqdAxmD2bkA4O8fj+fhDV0PlEBwmvVz5/5gq3OlDrwKwlmdIdrnUMy
	fmlXCAdqDvD8p2n96/reRv41SrVFvSEqyFdq3Vv0S/PjfI/bv235oBsPgW1JHW+d1E9m
	DbxHIsUWQ2YUM4vHb/1T0Br6+wmFXcHJDGQgtw4TkONImfxTGuyaSbRzLPX8SpFaGDu1
	3aDSzJqRT+qDPY+eI8eLjilhaOflvQz6EXQEhMZnwY6tuagx0QggjHqGiyMaxQUoxafr
	UrJg==
X-Gm-Message-State: APjAAAVDxKYnY1C5ZWuzr8psWFeVmca6BK1B1ybtyodj7tgcHPfcTXbX
	fljOP6Zv65preg+ZBjPPTvaPhA==
X-Google-Smtp-Source: APXvYqxsGzaTv/S5YMUK54h23jij0fBMFsp4lQyTZk/47Xm1qLjbxYHp+iZH0CP9D9Mxl/N3Zx90Aw==
X-Received: by 2002:a9d:d23:: with SMTP id 32mr2518252oti.174.1559321638633;
	Fri, 31 May 2019 09:53:58 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	b14sm2060565otl.32.2019.05.31.09.53.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 09:53:57 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <974e874b-bc19-d27d-ea8c-e64470da19cc@linaro.org>
Date: Fri, 31 May 2019 11:53:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v1 06/23] s390x/tcg: Implement VECTOR FP
 COMPARE (EQUAL|HIGH|HIGH OR EQUAL)
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:44 AM, David Hildenbrand wrote:
> +static int vfc64(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
> +                 CPUS390XState *env, bool s, bool test_equal, bool test_high,
> +                 uintptr_t retaddr)
> +{
> +    uint8_t vxc, vec_exc = 0;
> +    S390Vector tmp = {};
> +    int match = 0;
> +    int i;
> +
> +    for (i = 0; i < 2; i++) {
> +        const float64 a = make_float64(s390_vec_read_element64(v2, i));
> +        const float64 b = make_float64(s390_vec_read_element64(v3, i));
> +        const int cmp = float64_compare_quiet(a, b, &env->fpu_status);
> +
> +        if ((cmp == float_relation_equal && test_equal) ||
> +            (cmp == float_relation_greater && test_high)) {

It might be easier to pass in the comparison function instead of test_equal and
test_high (float64_eq_quiet, float64_lt_quiet) and swap the arguments to turn
lt into gt (not affecting eq).

This will let you pass float64_eq and float64_lt when it comes time to support
the SQ bit for the vector-enhancment-1 facility.

Otherwise you'll have 3 bools passed in and a bit of a mess here.


> +    if (match == i + 1) {
> +        return 0;

This doesn't look right.  How can match == 3,
with i == 2 when not exiting the loop early.

The vxc case is handled via longjmp, I think,
which leaves the S case to handle here.

Perhaps better as

	if (match) {
	    return s || match == 2 ? 0 : 1;
	}
	return 3;


r~

