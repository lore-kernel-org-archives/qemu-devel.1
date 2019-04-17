Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9E7C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1400920835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHv0p8It"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1400920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46935 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGcdH-0002Ad-CJ
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 00:57:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcc6-0001Xy-JX
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcc5-000216-MU
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:56:02 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcc5-0001zm-BN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:56:01 -0400
Received: by mail-pg1-x541.google.com with SMTP id v12so11427123pgq.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=jFncWn+JKmPn/IlN6hVimtulJrQiL36hn+XScPPKmTs=;
	b=oHv0p8ItMReK8viR4mp1rr6nLAZ+w+LEBrwf49YWdeT6Ab9KdAjP+UOzRAOY66dP1X
	QpZu3t1vnKHIZw/qbOvm6umA4BOXeRg8PEG2pUUM9RfUhIAUfyBoK6LjgpRb0xrVJ++Z
	8bHOOz0Jfb+F23jLr2IaOQRFhZGXnbk7yO8t8IM15tS8n+s5xjs0NdNUF879PVw4IrQX
	wq+xm7YxBlKrQZorr3gK9Xc1rZ8fiELP4jaMzgtc2HhJJZzij7Gf2GmwvjhXH3s4JZjB
	ZC9nI4oKC1huILVJN6fINrEK/0EJ+4uE4PnAtnAWkGq0YHTL7pd3fLTV97BTsOWWBlys
	K+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=jFncWn+JKmPn/IlN6hVimtulJrQiL36hn+XScPPKmTs=;
	b=o7zfiwhMge+G7VKsnfXM0Fee0LXYiOLtCauaO8iq2fh7lKc9wE5u0prMJAxTlVvCl8
	nLn3bxa34e1iKQBin/wdPwqZvpzKnQWFIb764r8fV1SwWB2v19/NwsxFkxE2OjAefuEz
	cvZ7K4vsz20cwoE5F8MjqVldHZUCEjoiHsOipX8pkyzfITzBTX916mbQOcPZ9GBPlX3B
	5hOiQJaz9jTxhMFu3VMX4lXcBgLgShtm0ZoTUC9jygTFl7h8frUPRWOuttUtwHygV0OY
	s5asNGycDArj2hyKvgVV2X+v39ldOsDianLAh2Hc+BdjTUK/klGcFmI6wq/Z1VC+a2F6
	Tw2A==
X-Gm-Message-State: APjAAAWusZnGnET6imRw1xZsLFpNJESoJnMg7eHOCjaiz2ot+BVtuqDB
	nE/ecwUeu41vHv2L9iBb1RtKoQ==
X-Google-Smtp-Source: APXvYqxB3QUcSpdgtiaI7iSPsvVxDuqV786T/+6ev0ltrCkM/yddowfHHRVjC7d23ZxjsaM+LrHlPA==
X-Received: by 2002:a65:4342:: with SMTP id k2mr1006644pgq.178.1555476960438; 
	Tue, 16 Apr 2019 21:56:00 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	e23sm74237121pfd.11.2019.04.16.21.55.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 21:55:59 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-38-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <86abb048-1981-a72e-7741-948307c78396@linaro.org>
Date: Tue, 16 Apr 2019 18:55:56 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-38-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v2 37/41] s390x/tcg: Implement VECTOR
 SUBTRACT WITH BORROW COMPUTE BORROW INDICATION
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
Message-ID: <20190417045556.Yij3YPRPHQJCbW9JS6z_jzSgZvOwnM_XTtLPfn4f3BI@z>

On 4/16/19 8:52 AM, David Hildenbrand wrote:
> Mostly courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 34 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


