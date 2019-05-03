Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7296C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10F9206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c0Tu9DAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10F9206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35083 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRHU-0004jY-0R
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 02:02:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMRCr-0000m4-UR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMRCr-0005Oy-1W
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:58:01 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMRCq-0005Oo-QS
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:58:00 -0400
Received: by mail-pg1-x543.google.com with SMTP id i21so2184424pgi.12
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 22:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=W7r8JobTZB+LldUPKgEU8ZWssw9bAU5TxjjMtVMzfEc=;
	b=c0Tu9DARppiGVx6OWo8XhdigMVnLMcVRXgqNykEH26rTszJp1ty047uR82goReqNur
	a7lLAuc72eIypZjKZSyKgYVlOPqZeUwy5MDIU0N8J7al1xbsbh1vWHIRvegm/9vrqZ23
	E1btcTuKLW9IFNRHpoMm/AxCxClBKI1orDikqdx2+tmuaL1Zb7eAzzeaR7NP6XyGgHjt
	ZTdXML3ng4Cw6TOBUdyXMx0GtfNTYMAMag+KraX718HEG3PFlBmwMjXFVHLsr3KGe/Z7
	jG+q5x0GRW8/dsaXlm4YQ/evh5Mr5d4EBaW7RsQ9zhBVJRWkopKaIUJt4WD/Rn0myCFD
	fDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=W7r8JobTZB+LldUPKgEU8ZWssw9bAU5TxjjMtVMzfEc=;
	b=o9s9WJ9QEZwu9EcAdyCCBXf/SgkEx77p9deq96NY3qw6tT8atjr8sqxTCWWDMElZtv
	2JhOIpGOSRRJNHpJHYcmXkmoRscQGn1tgFNBxBDyd5dZoVIVdX2IvopQ5vp00gqfh2SO
	+5VgJyLqyp0oLVKWs+YQ5NFbF0LJ+5JSLLg3WDcc1Q1DLVugPWxohg33A4apcc1Ispf7
	PEQY/ILTMLT9MEw85XcmaEKahTtWD3OIyqff7Hx8AtE0sY2V/hAFK692n3rHt3Dc3WFK
	VZQXhlDLWs2LjeO5LSpWHwe3B0ytaK5CQWx/zIH07KRi+ThqmbZrHxHRpt7HPKRWNpsV
	geTw==
X-Gm-Message-State: APjAAAXXAhnZqv4tTx8PY9BKSq2GH+wg4fNqZJO4yPoykjbWKNgB83Cd
	bjvUhxm4FV3rtGX5nrueSL3uPw==
X-Google-Smtp-Source: APXvYqyMXXIxdkDESi8MWE3v+jTfhVb9M0kruPbwCjbtkkcxXLtJww52FKOabjelBlxTi16pXXOjVw==
X-Received: by 2002:a65:6541:: with SMTP id a1mr7862050pgw.233.1556863079646; 
	Thu, 02 May 2019 22:57:59 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id 9sm1727459pgv.5.2019.05.02.22.57.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 22:57:58 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-35-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a2d14b29-e162-54f2-a44f-09630212c63b@linaro.org>
Date: Thu, 2 May 2019 22:57:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-35-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v3 34/40] s390x/tcg: Implement VECTOR
 SUBTRACT COMPUTE BORROW INDICATION
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
Message-ID: <20190503055756.J3oLPSZt2Ele4EIhFJVq2oZ0cOsETbY3Kt0oAtdN3Tk@z>

On 5/2/19 7:10 AM, David Hildenbrand wrote:
> Let's keep it simple for now and handle 8/16 bit elements via helpers.
> Especially for 8/16, we could come up with some bit tricks.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 52 +++++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 16 ++++++++++
>  4 files changed, 72 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



