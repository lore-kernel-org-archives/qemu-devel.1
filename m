Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BAFC10F14
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4143F20850
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGMhGn73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4143F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFBZ3-0007Op-Cp
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 01:50:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBXu-0006aT-KX
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBXt-0007OZ-OY
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:49:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:33123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBXt-0007Nn-Ek
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:49:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id t16so6117232plo.0
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 22:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Z/aecCuM/K910qrbOvJzH+ocK5PDY96EVFjLTYU8w7E=;
	b=wGMhGn73ASCuHiJLt2OAKlY5gNg3AfvMw//cEfssgDzteLnfHkejOAZTbwHyUI/Ypk
	XHXF0A+vuiCFCGJL3Pg5T4ObxPem6Uv3lBLofGOQUT3G5iPQ3cHLdVIQq87PHcsrqGKj
	aIFqEWfDrf690AOc2BeE0wS40Lfz+kbKw+im3qhxE7q7pTSwHnL2Q8bpqCZWTKBxtFhb
	JH89F3UcB6YvE803zcVy7CjV/GGjI/Q89vWduPXFKEAQpYq08rblwk3QKkhPcrj+L+F5
	9PcAjQRmumqlDaGiMqN1W/5CbM2hs7hAKbJ80qdoDKHGvTPgUYkzmfVsEUWL73OAyhs+
	hggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Z/aecCuM/K910qrbOvJzH+ocK5PDY96EVFjLTYU8w7E=;
	b=SYAlz88F0iaeaypxMZyMmXMkdfCxvWwIP7qvHd3k1W+GHncUxsLvW1JY868C5ZCdft
	s1VAOKOduUN6t+i60/ffGLn1cd7If42LM2BxgNpMdZ/CDNNi3XW16sHYrPg7jXFlQBP2
	3yXsB9eZV86pqT0H6AQz49IXn44mQWRIZzq4NU3vr9XRWCmGTUPdAjOQwNReIXmh4/8L
	j7O+/sGgji2uwkfP9+EdH5tnbSK9VmKHx/NodKKNPg5EHHaLrIsvTu1kfEtcss+s4Wpj
	A5eabplRMY04tgaKY3bnQchwaeU2nbb6F1dlP8JBaJyE5Pp6s7UzC8yX2O1PE9EAx5QQ
	VLpQ==
X-Gm-Message-State: APjAAAXYSxKqG02IGoCMQj11UxA4kFe1PS8Wf4Rso2ugxnMbwalWqBuo
	gfzZeW8g2TqT3LMYFsgyGarwSg==
X-Google-Smtp-Source: APXvYqy1k9Se28iLTNSIeZnSwl3VReDNOvXPITh5KndyJmU6RIpVjC301svzPuGgBnxqg97WRnvSrg==
X-Received: by 2002:a17:902:b181:: with SMTP id
	s1mr53854695plr.9.1555134584410; 
	Fri, 12 Apr 2019 22:49:44 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	j12sm52783262pgg.79.2019.04.12.22.49.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 22:49:43 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-35-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <45b58bee-214e-2683-c9f5-3153c177ecd4@linaro.org>
Date: Fri, 12 Apr 2019 19:49:40 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-35-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: Re: [Qemu-devel] [PATCH v1 34/41] s390x/tcg: Implement VECTOR
 SUBTRACT
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
Message-ID: <20190413054940.coZKVJAmhR8k8x-zC62Mxgf9OtCqAO51qF8yaj-GCL4@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> We can use tcg_gen_sub2_i64() to do 128-bit subtraction and otherwise
> existing gvec helpers.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


