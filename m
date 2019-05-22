Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4775CC282DD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1753A21479
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cm1IQkLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1753A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOyy-0006zn-B2
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 07:00:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTOxP-000633-RH
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTOxO-00019d-Uj
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:58:51 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:34991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTOxO-00019J-OU
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:58:50 -0400
Received: by mail-yb1-xb43.google.com with SMTP id s69so519824ybi.2
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 03:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=jhYSWAzwRB6Gn5cpA8J3IK/mNGVfnivH8jBnesMeby8=;
	b=Cm1IQkLaHp47u+I1HSMYRrtI0Rv957pQ8haAPn7ek8H0W6ikBVFE2oSJVt0ATvj2+L
	DzjsR6s9qdHuKy46lhmPmDOE+5GxOSfoYvpDZq6/NfjAFgCN+C1DvjfI9FWOMDjiAgT8
	rEYDLidU50F18pAJISHbHG27mylPShbgUAnUGOG3X8OKuTe5TJYl2griYgfRoKk8IEqn
	dzTbRVmWJDakKn/3SAdPzLYiS8QyT/rhbYcS9AhTB/uWQ5mYCQlM22l00WeMNaZ6cpma
	ujewRAtPw3tJaWh29t9VqJdkO2+GZfsOmCyAAom5PUEUOVz/5lqM2yS5upGz4SXXJ+Ej
	X91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=jhYSWAzwRB6Gn5cpA8J3IK/mNGVfnivH8jBnesMeby8=;
	b=mVwpuWGBRMq9mpWoCjpZRLBMES/8r6jUvk7VYXSiG1iXdA6ryAFT9JOmHdgdhrWW9L
	Hf61oFwv4QZWG5JaP5dv+IVfUIirvoLyYsX/lkqOsiUvTBibkVQSjMyTs6Qo805XwejR
	1Zhj2vUIJSrpM2pqr+4xqIMgI39352zihrGdHnK2Dcb/7YbYpJ9l3ythfQ93j1Rw3viW
	jn6n3w7JewjXaO1AuOoXYbUEPVeSCx9VVSmQp4HfMCnGwxnELuyYiZdkJ3S6I0zjNCcK
	U4b0RAx3Bk+8Wy/LvwrLDkdSZPRAhKw8VnYjvCL5X62rYgPeZmbbucUsu0Crr+wypM+u
	36vw==
X-Gm-Message-State: APjAAAVTiIElOU9ZcwzcJ02MvqTxqVfledk2NIhWkqoyg/BtCzQLPEd+
	P39bGkDQ7+nypkC9VDyoytcQvA==
X-Google-Smtp-Source: APXvYqw7TG5Lqt8lJd4epe94lj8Iu8FNEUnoJSqBumtPR//Wo8wgNcPXqAonJldjG2Vwyh13uiqbqA==
X-Received: by 2002:a5b:c01:: with SMTP id f1mr12972116ybq.518.1558522729921; 
	Wed, 22 May 2019 03:58:49 -0700 (PDT)
Received: from [10.243.202.139] ([71.46.56.72])
	by smtp.gmail.com with ESMTPSA id
	124sm6297222yws.102.2019.05.22.03.58.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 03:58:49 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
	<20190517023924.1686-3-richard.henderson@linaro.org>
	<20190521150402.GQ25835@redhat.com>
	<a928e588-63dc-ed4c-fcdc-9001941559fd@linaro.org>
	<20190522105614.GD32359@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <15223542-aef5-8a29-d5e6-b25ab5ee39b9@linaro.org>
Date: Wed, 22 May 2019 06:58:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522105614.GD32359@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: Re: [Qemu-devel] [PATCH v8 02/25] build: Link user-only with crypto
 random number objects
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/19 6:56 AM, Daniel P. Berrangé wrote:
>> I have a working configuration here in v8.  Can we please leave the bikeshed
>> unpainted for the moment and you can adjust the makefiles as you see fit afterward?
> 
> Yep, ok. I'll be away on holiday for a while so don't have time to look
> into it now. So lets get this merged as is & I'll investigate further
> when I come back.

Thanks.


r~


