Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114EDC10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68852084E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Slk+xeQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68852084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44575 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6Yo-0004e7-Ru
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:30:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Xy-0004KF-RA
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Xx-0000Cv-Jb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:29:30 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:36772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6Xx-0000C4-5i
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:29:29 -0400
Received: by mail-pg1-x534.google.com with SMTP id 85so5938350pgc.3
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Q7zpV0nQTTSKUPa6W+C0ZVH5WtvB4fTENBXO/9/28BM=;
	b=Slk+xeQA9t35ARtYF+lDK+qwNvfnrCt1YIE/fvSVDaTTb49zTSYjPhJiotzbO5RYDo
	PBDmOwJoeQZe15waxDKDe9Ikv3z7Lw0Iek3UPsK5Bgqx29ITD/cjSkzILzdj02HFSqZc
	I52hTzUc/1qVnO6t7fWjq4FMS09fz6snrhw+LYS/HJQadhWLKIWIrGBBpKYeAwctKyt3
	3B0sB9KHDdtwFSK5D191v1BfGc68rybkd6C2zR9HgFH9zVuDFoLACHBzA408fbzPyZ31
	ibMecRUUm+U/MMffY6i/NTRUpM6QNKEcJYah7mNeSlo80fx6rPmRIOoTic307HVvNucL
	67bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Q7zpV0nQTTSKUPa6W+C0ZVH5WtvB4fTENBXO/9/28BM=;
	b=cUk5HXSehWChFzFqZQ/t6ZQUmE6CLx13hgPwdrcRpO5vb+MxmivqnMOvRSCu0qIMZt
	3FISIp4HeCZrtaUjBFX6AzP6Up8pXR2W4UgDsovj+cDYlMfKlmmVqv/0ub1eEOCdhT2p
	PBa1Oj/Tz/UqtzbElTm9J9L+APa4hhUVGoMWVNFb9EsuhgCjyMM4QK+SXcnd6wtClIUV
	zZY5QEdlTQeSkFoJzOCoBI+3/WPLyD74m9fMqald6lGu9THeXrZG32jCGzh7XkE9hj6e
	pKsyc00hc7rBNHep/HJR4kLYwZ/hyBdjV91uxlCS3D7NKHlhWK7NFoEAj4P26mYY+YqE
	ROQQ==
X-Gm-Message-State: APjAAAU9R+Ltxv33f9RxeKgBWeRtmPo/paWSvmxYaRAZ78ahlXKJV2jV
	8CxnsQfiA0Kp3wl8YSmTGJn90Q==
X-Google-Smtp-Source: APXvYqxW56exfvCNfAlP1iwRLMiGv5JT0RoqNsUWtvV7ICDDIgGZFu5UvD2GAZKCz7ba0oMAVG9pkg==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr60809447pfe.163.1555115367382; 
	Fri, 12 Apr 2019 17:29:27 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	a10sm10831478pfc.21.2019.04.12.17.29.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:29:26 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-29-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <604e8d87-44dd-f27e-171d-d3de05b9d183@linaro.org>
Date: Fri, 12 Apr 2019 14:29:22 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-29-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::534
Subject: Re: [Qemu-devel] [PATCH v1 28/41] s390x/tcg: Implement VECTOR
 ELEMENT ROTATE AND INSERT UNDER MASK
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
Message-ID: <20190413002922.qqHhqlthZq7hJjswVm3_Td6rL241WZ3g3J2Cpg10ydM@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +static void gen_rim_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b, int32_t c)
> +{
> +    TCGv_i32 t0 = tcg_temp_new_i32();
> +    TCGv_i32 t1 = tcg_temp_new_i32();
> +
> +    tcg_gen_andc_i32(t0, a, b);
> +    tcg_gen_rotli_i32(t1, a, c & 31);
> +    tcg_gen_and_i32(t1, t1, b);
> +    tcg_gen_or_i32(d, t0, t1);

The ANDC and ROTL look to be in the wrong order.

"For each bit in the third operand (b) that is one,
the corresponding bit *of the rotated elements* in
the second operand replaces the corresponding bit in
the first operand".

I think you need

    tcg_gen_rotli_i32(a, a, c & 31);
    tcg_gen_and_i32(a, a, b);
    tcg_gen_andc_i32(d, d, b);
    tcg_gen_or_i32(d, d, a);

with

  { .fni4 = gen_rim_32, .load_dest = true },

> +     const uint##BITS##_t a = s390_vec_read_element##BITS(v2, i);           \
> +     const uint##BITS##_t mask = s390_vec_read_element##BITS(v3, i);        \
> +     const uint##BITS##_t d = (a & ~mask) | (rotl##BITS(a, count) & mask);  \

Again, this seems to be missing the insert into "the first operand", i.e.
loading from v1 as well.


r~

