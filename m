Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F8FC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0440C26CD1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijayc+kP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0440C26CD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46840 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlCr-0008U7-8c
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:20:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlAA-00078i-Be
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlA8-00028v-TA
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:17:54 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWlA5-0001zp-8O
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:17:49 -0400
Received: by mail-oi1-x241.google.com with SMTP id 203so8235649oid.13
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=FZRU5XvA/IdSKcjjKlqPIqG0nKdwaUs2Diump3KApP4=;
	b=ijayc+kPy0VlHq4MOKJhW9Pbv3ZUPf4/py/fCmh7U1dGJnoEIExPAvQAt21wMKyA/v
	35xzWCP+UyQ4cXTwaD4S7Os/zR6KfQdwTe4mVdcV8YZQf+AfEJ2PTWGYytIDXA/+tRVL
	pdOsYtPI04se2v2NTuXPFHCSqjuEI/4BV7Tq1Htidx/c7J0rKAqrkPZjDPrxVFlrGwUm
	WHhIYWm7guqgJOfS+9zZDDPtuvASELA8fw7WwxHF6er/VJHSQ+H0KlBSHmnJrXwFfUCJ
	CXDAFppBNmFFKOPv5UpwGLMacTTJ5fmwZ7/O+HJSdEpwmtweOL/8Qg9pRnWsP9Zsf2Zz
	Z/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FZRU5XvA/IdSKcjjKlqPIqG0nKdwaUs2Diump3KApP4=;
	b=pu+czbjcLPrcetK8eVsAMWUx+X/vYMbSxtNT6RiDPFPpgBaow/p5dGmA50gaL5VZDS
	SRB+Chyw8Ov1sQDIEdyhUBxUr0LbtsGzJ+rHwudyxH/Z1SJ2lbGHW+yV8/CmJOe0jqLn
	yN6na+u/lz2spPC2uhP2F4QOFM1CdNB43RUHgitj76f0LjClZJXbff53XfjQkqjwXH8F
	ndNIpzOlm72ca7ixDsHDN8gseg6ehvE6INZblFZqZdxUJOzPitdOCNbOLFC+hXDmvcZL
	nUacvLYcJ9Uz35a+au4AHEtYVPxKeshOzTLxzRDbOOi3mSNHVyS6uTzPfNNRsh1LmQqp
	PRQg==
X-Gm-Message-State: APjAAAVihBtmRQ39SDdciiIvdVtdvSGSyIyWKpO+T1P1+pMDbzsfidhf
	VqzX7oRThdPTKcZU2GuoJJn2CVQeV3/mLg==
X-Google-Smtp-Source: APXvYqxUzQDDhLV/doj1p2SudY1lZJvQAJCxo6DLVQwLs45D18un1s/W9fqNBv0I3OfxiF+ZDLNu5Q==
X-Received: by 2002:aca:4883:: with SMTP id v125mr6942858oia.76.1559323060855; 
	Fri, 31 May 2019 10:17:40 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id f4sm3017664oih.39.2019.05.31.10.17.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:17:40 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e6f87809-7473-9468-bfe1-fc397b92262f@linaro.org>
Date: Fri, 31 May 2019 12:17:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v1 09/23] s390x/tcg: Implement VECTOR FP
 CONVERT TO FIXED 64-BIT
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
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c |  3 +++
>  target/s390x/vec_fpu_helper.c   | 23 +++++++++++++++++++++++
>  4 files changed, 30 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



