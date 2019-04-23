Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D12C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 23:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20711206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 23:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byhPlIJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20711206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ4Qv-0004T6-9Z
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 19:02:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4PH-00037I-Jg
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4If-0003g2-NV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:54:08 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ4Ie-0003ck-D8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:54:05 -0400
Received: by mail-pl1-x641.google.com with SMTP id o5so3899271pls.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=WXCJzPgVeAe9TyQlEMYaqagY5Si3E8fpWo2HZF7UKEY=;
	b=byhPlIJkpG7shGWC7B7QV6BUL4MtW+0+EHqoWVuuqYsTk6h0Sx1Sk2T2QLLWVvQSgc
	kjyLN02dLr1CmSZ448LikgvFqTsoR7eNXT2KYqAFBarsLdhO3636Rdp42i5Ay0thUSSV
	SCozvalznw8n2+bz3G/g8dXu0Bjg1/+WqzkqnffYFCcgrTXCABU1W3HtvunuWGZn0D1I
	aIcjdv+POYoULj7g3tqZhVvm9tVnxWDPtxidGzkgbe/DYp5mvxn0tT4E1LkWNB/NEyHB
	/PTiw/qTaWDvlCUSaNEhchZv/djkLED4HrEbky7ulkgi9VxugXUjpVXQvQHaSi9Nfq68
	IXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=WXCJzPgVeAe9TyQlEMYaqagY5Si3E8fpWo2HZF7UKEY=;
	b=Xt/l8mCsDNnS66gSFTHPWl8oaHLmnSUxwukC68S6IQbH2OKkMiZj8YvxRQSPK4tS0Y
	kjHVR+jSrNAz3WC3CVj+j1EL3Uvz3aeg6CFGH7Qdz3KTbkQ3vW+TBXAes5bm2toRD5qU
	/NhyDk/gVBc0QZjDI1H6iBUdrsE8mxGDdzj14EDSPBPoXpGAL/UhnKWu/Y8wz/yZXYa7
	npn6+ksGmntZ4qgMDcccdKjefcY94i8dBEtcSjGqILstdX2nUtpPnd+3XIYIc8naQWMo
	nk6YELbgH+mpwnx1J+AFaiL0M0XMAOHg2oyxSFYvlIXGQ0Pd9N0P9CjrsT686a6+fIv+
	qwPg==
X-Gm-Message-State: APjAAAVmW+gkcBvBql0pDml0jN6988V4uLB8MO5sgn9M/2QqVeXy+B+0
	p5TKJNLj6Vn9B2w4P+l/cLIaRBnmoYQ=
X-Google-Smtp-Source: APXvYqzF6ZtZWCkinrD8sI79pI/5/Eajw7r180AMUij1Jdl+NQW25CAnGjQCHJ+i5rS7COvpdJxJ5A==
X-Received: by 2002:a17:902:9a07:: with SMTP id
	v7mr20581049plp.291.1556060042794; 
	Tue, 23 Apr 2019 15:54:02 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	o66sm4964531pfb.184.2019.04.23.15.54.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 15:54:02 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d106ef4a-848a-2543-faba-7a5613788820@linaro.org>
Date: Tue, 23 Apr 2019 15:54:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH 13/26] target/arm: Clean excReturn bits
 when tail chaining
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423225400.1ul3OB3_SEB6xPMY5uSQwm7K0qoGDFzJLIYMCB7DrE4@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> The TailChain() pseudocode specifies that a tail chaining
> exception should sanitize the excReturn all-ones bits and
> (if there is no FPU) the excReturn FType bits; we weren't
> doing this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


