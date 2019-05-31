Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25702C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6EA326CDD
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVNoY6lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EA326CDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlhU-0007F9-9E
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:52:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlgH-0006LL-Gc
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlgG-0008Bf-Jz
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:51:05 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWlgG-0008Ai-DJ
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:51:04 -0400
Received: by mail-ot1-x344.google.com with SMTP id c3so10047094otr.3
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Hx2rQDqUtAxR1L2sz3SKNDhiizgN84pGNLU5y4iHXmo=;
	b=GVNoY6lwd2O68g0RlHP94PXctgCwbz6mBeQpTpEV2GVVd/M8sD0XOeFcTl2Th5IPsd
	KpEzWRHyYA9GPAzy5hp5+PIQeh7+8xOoTgkoOimr3KatpZY3JOLasvHDraaaPTDjTIhy
	5FoZ388eFV7lYFpWuZJZDhpUqSJiG3L79MFeLONrIu7RKBqhJfaoR0xI4u5p6g6q3fvY
	cTaCuKLD9yAeZAmu9H8VCKtOfYCjo35Ytvn6Tsp6Ts5Vamw9SkoXjd2f2/N/MmsJcaDt
	Q7guYfy6GGXEdhxMVfgvqa4nVTXwZYz1vvnTK1ORLL3zdUUL2evphit3PsyMSfp6GZhn
	njqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Hx2rQDqUtAxR1L2sz3SKNDhiizgN84pGNLU5y4iHXmo=;
	b=Si0dp2GDAyidj/POKyH0qNkj+pEH19/Hiho0Z8G1NquG5920glN0QhNe/Xi2nZJ1Q2
	nNiTW3Z74FeawjcePGnOmati/idM/URKAZXeg97pHotEWmL45MqnVu9bIgg0mDoK3Q5P
	EwH+jhxw/q+lrOjOcmjpYUWGs2PGpY+bJwbr5wAX9NLyg3HP2e/6f5M9grVdzw9fq9GL
	JFpSrV4s1t18Br/6rPsmbGrmQj+H6joSeABi21ZytYBrqhAGgMhHCJ4qq3CSZW6tGvBt
	Nlyv4H6Tic5rPhdXoFxxsP9pN+hSsFDGg1LchbDqBOt9DjHyMwBzrzPTpgia3kSPWCcF
	K4Iw==
X-Gm-Message-State: APjAAAVfFxsoc9VKRoLEGP+KK7c6cbxqpeutBjdfyLQzllT/WGC7jiC6
	crP9xPPxMQbjUyR7pov66FS8DA==
X-Google-Smtp-Source: APXvYqxthH4eiO3UDMp2WYle6ADZWEuMRS0uzmTbom95wU3grAz+e7Qo3bkZUXN2R2as8B3Ehd2Epg==
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr2622995otn.247.1559325063536; 
	Fri, 31 May 2019 10:51:03 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	h67sm2064491otb.24.2019.05.31.10.51.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:51:01 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-19-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9f187f13-c8cd-5037-8202-87570ff0c9a7@linaro.org>
Date: Fri, 31 May 2019 12:50:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-19-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v1 18/23] s390x/tcg: Implement VECTOR FP
 SQUARE ROOT
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
> Simulate XxC=0 and ERM=0 (current mode), so we can use the existing
> helper function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 19 +++++++++++++++++++
>  target/s390x/vec_fpu_helper.c   | 17 +++++++++++++++++
>  4 files changed, 40 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



