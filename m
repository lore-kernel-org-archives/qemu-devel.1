Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EEBC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7265D20651
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqC4eLEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7265D20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50547 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWPB-0006FZ-KL
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:18:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2S-00048d-56
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVr7-0004Y2-7x
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:43:46 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVr6-0004XW-3h
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:43:44 -0400
Received: by mail-pg1-x541.google.com with SMTP id d31so7093500pgl.7
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=H1S9FJjLfLnyUAEbpxl0S96fIHd4Mtz2cyX8UvQYilU=;
	b=aqC4eLEse7QscadaH2L3TiJ03nwVPqMBTm57ma27e+fnDX0yDSHCqZoij/4HYnYijP
	Qu+vrqFh4jIdwCuo9KwiDILs45uY6tXYebhgF5fZY5fR8MhZ1rQ5htXC0f+sqmK3gv/+
	lFxdgoBCENNswxl73nqRh6qjhfX015G2A/LSStz5gLnPxpdsECFP7FMNsEk5d3ZtQIE7
	KNDX5oEvMRLbhTp75toKdaedzCQszQTMmNM/61bTG3eOMX31nPoz9jviY4Bw6pcC7jmY
	WU+MxMo+TwBIwmxUIm3Z6tr/lKmIVKkcQZjLd6DLVJ7829v7Ap48dOV2iwEnx1ni6ZWE
	9AnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=H1S9FJjLfLnyUAEbpxl0S96fIHd4Mtz2cyX8UvQYilU=;
	b=P0MZg0g6e2SAiCgHWkrx1ykC2C8qI49nCcBXlnQho0U9sWkfZC5i4hoLEp1GzEYpsI
	Sf/O/ySeOZQ/0cIkq0L+ncuh1kEnmSzF1XBeZymGWaCqT1xjHie+sVxoCDBs5SWI1HMJ
	Bsbt/QvO0iP9re6EgNEgj99W3WUQ0kC/8u0h+yWtEEEWWaZrXCVEwE7S15wOh53U0uZK
	n+p7T6lwVJ6/YnHKwPjbVxSefOEK5XVmecOj0KvE3Lg8EIGX/aesOr/RN/L+IUIz6Orr
	5Ibhw4WxxhgSjVwb8SOZiF7mDoX95ih6AAGstQh8cG7OiqtZ2wrNnbjlfaiIaA7mGZ/d
	LIag==
X-Gm-Message-State: APjAAAX5xWl8dx88fivVKHoUlmes4huHW4zWVuzv5/BySUqCPJRgy+Zp
	uxGX5oz9qEEsHzogQ5M3vbWTsJmXths=
X-Google-Smtp-Source: APXvYqwySIESQcyHoyuMcL4If+mxEYMRqi2WIkxF4oIvEMpHhK9Li0VSRKLVFaV0jFDuidxCP7cPtg==
X-Received: by 2002:a62:415d:: with SMTP id o90mr71327547pfa.236.1556642622541;
	Tue, 30 Apr 2019 09:43:42 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	c62sm89741374pfg.33.2019.04.30.09.43.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:43:41 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-8-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cbd76a77-6545-73f0-53d8-57a119372568@linaro.org>
Date: Tue, 30 Apr 2019 09:43:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 07/14] target/ppc: introduce
 GEN_VSX_HELPER_X1 macro to fpu_helper.c
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
Message-ID: <20190430164337.xCemmgET1ADIIzrJX5UcY3xK6utE53mFLHJ-fizziMc@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> Rather than perform the VSR register decoding within the helper itself,
> introduce a new GEN_VSX_HELPER_X1 macro which performs the decode based
> upon xB at translation time.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             |  6 ++----
>  target/ppc/helper.h                 |  8 ++++----
>  target/ppc/translate/vsx-impl.inc.c | 24 ++++++++++++++++++++----
>  3 files changed, 26 insertions(+), 12 deletions(-)

Similarly wrt VSX_TSQRT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


