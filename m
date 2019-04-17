Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC73C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2589B204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edsP53w5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2589B204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46933 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGccY-0001eY-Ev
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 00:56:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcbd-0001DJ-5g
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcbb-0001kF-Tj
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:55:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcbb-0001jr-Ic
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:55:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id z9so11401898pgu.10
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=qKPhG/kvkZHMo9+Hq0YPcQ4eH9GVKSiJ9EBvDGCoHnw=;
	b=edsP53w57lamZGLm6VulC1eaLNvsUa0ISKC+fCZs1FA5EPKyAl64za7tKQ8TktpCfS
	LtkZRFcKZSGb3ps1tWiTydUn7SgoU8PSWzjaSnvO8Irc8y4+tkhboWJVUDEA86FZHX4V
	sLfcKtB5SvBtw5/mZKtI2zqSFJpUR/M062FZQ/YkikcjMITunWwYZryTE469FLl3HlBG
	tvN4pIQ0R/CAFx6qhgho8R1JZH5xq6nTcUyhAO1mmPOnA5LjAk50lC4UBrDSvrnqZFvE
	u45XQ+ZdQ3mlr8SazmgDYmBvXDSDmF6uGMMxXsXJ7ICo8b0HCIiUvsbeHGNIIVvFdmd7
	JhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qKPhG/kvkZHMo9+Hq0YPcQ4eH9GVKSiJ9EBvDGCoHnw=;
	b=jn39NAY2YGVGinMeDcouzCflpL+b+IE/98e7xFZMKd0jVl8lv2IhkHhYX1xMzy5XkI
	mAdRy37naJ6qkJhCEThDm0/0xcyEUVX6I1AcKeRvWOQ+2KEakIOYeLlwoe5XkU65mMhe
	Qz6ZVEMcJC8JcNaL+t8QhTVIpAgOVWn+pidjjAuz+yMH93hL2NeQbI+7yR3qweGB574a
	9QoQeDNyXS6b+Yq5vrmZY69Q+PXrHOl95vTAjAFBiqYy4FgNFgf1fn5xdBPThuqPJHgL
	sHtj2C/jiOd9xF/XlHointeEveDbgZcDqaoRbmZSiDaSGmIoFN9vAM+iTU6gpVBzM/5q
	DdSA==
X-Gm-Message-State: APjAAAX8w3ssgdk5pnluYslJClEtQysvi5LBQUsGffmCSSjbC2N9m120
	XxxvK9Bx+765kM4bfSo2OT4DIw==
X-Google-Smtp-Source: APXvYqyIBiBobuoqihvlT+p8BuQwhKFYLPMjgB74lZENZniWyNfCAW2RFJyVA2kWuIhQotDUjrjZJQ==
X-Received: by 2002:a65:6210:: with SMTP id d16mr78334669pgv.110.1555476930548;
	Tue, 16 Apr 2019 21:55:30 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	s85sm79059629pfa.23.2019.04.16.21.55.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 21:55:29 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-36-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7f36f35f-c816-9920-728c-93ff23162d34@linaro.org>
Date: Tue, 16 Apr 2019 18:55:26 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-36-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v2 35/41] s390x/tcg: Implement VECTOR
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
Message-ID: <20190417045526.YIUbSTU018D8f48PQVP-sIZNEroyMXBBMSNXDkgnIiA@z>

On 4/16/19 8:52 AM, David Hildenbrand wrote:
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


