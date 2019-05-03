Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCCFC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 03:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F0F2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 03:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qa7FqsLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F0F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33817 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMPB5-0002nd-WA
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 23:48:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMP9m-0002Cx-Ns
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMP9l-0004Xl-PR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:46:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMP9l-0004Wv-JA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:46:41 -0400
Received: by mail-pf1-x442.google.com with SMTP id g3so2199193pfi.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 20:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=tqa+tot4BdBjLT+lDYk1RnTsSjMhmkbSR6avAYrlPP0=;
	b=qa7FqsLRRtoALGpoKUUjnAj68h5ZbmUnEAvDVT1rjR1T3abdRI2Dcgt5Ei8f71u+aK
	tHHxmBJWos7Q7q5HmrJdd68U330+7u/6cIo7lka+doFit+bNkiu54lj9mztmGfncUdE6
	MVYC/BBH4KA4O0AKs3vBP0WcGhedQf3l+CF2fzN7Z9fZKhHzTKTzkT+VH3jHwJaCk5BR
	B5FEK46m+vrgctXOib2glUDWRsUOG+9xWp9sBNeq3fmESonzqMFShgbQcJ87OJ+jQ34t
	cWPTmZRxwIxZFxYdlQQJ/Qm3ZYIJJwd/AONw3N0+fs0iAbdlLPS0CY5ALdo4NZ19xqxZ
	frtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tqa+tot4BdBjLT+lDYk1RnTsSjMhmkbSR6avAYrlPP0=;
	b=ONzQPSBYlvdusTiPE1T5+zIqKp6U4M/Ftyhw8vMUVIfmHTp2sigMPWTR1sixln9n+v
	h9fbgkZYq9gdOwjmw1Jq9Y3gk9N5I1TE1oCmsAe0X5/cNtReAsj0LgW+LBl69EZXwcih
	XA+3WUY2PCRYVziDnPQZ+8ZMvssggc6yumSUuU+qZna0V71rTFwtEFtcQwbTy8zjazPG
	k/DRYgYdqUjbxkkO1HU0CD3xPzcIlCCkA3BoJ2nJC/7OfGP1VLzrB0Qv1KZp2x+jv6wM
	P2/LnqRMBQcRSl3HFIvkNxx8P+MX8RnlSWZJUjBXfLpk8FvCwclOpNF1YQFb1GwQELQU
	nLvw==
X-Gm-Message-State: APjAAAWIG2uB77qbeFBwBFTl876a/r/kdJG2xZnOn87fiF82hB1Vtdvy
	8WLkgqolciXla5gIThbvmWABUQ==
X-Google-Smtp-Source: APXvYqzyk4DodYamSH0/EKbohf6AGDgn3yJYVIozWtsWiESt53Zn9Ky0Kb4swRUuWG1WAxyN0/lZJg==
X-Received: by 2002:a65:6546:: with SMTP id a6mr7645008pgw.5.1556855200575;
	Thu, 02 May 2019 20:46:40 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id e4sm732725pfn.185.2019.05.02.20.46.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 20:46:39 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bab51b97-8cec-ed85-594d-e63c9a5fe6c8@linaro.org>
Date: Thu, 2 May 2019 20:46:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-5-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 04/40] s390x/tcg: Implement VECTOR ADD
 WITH CARRY COMPUTE CARRY
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
Message-ID: <20190503034638.RGJ3dmzs9UNrcsgtAztLVcQu7OzQGC6-w04JEQCK4XM@z>

On 5/2/19 7:09 AM, David Hildenbrand wrote:
> Similar to VECTOR ADD COMPUTE CARRY, however 128-bit handling only.
> Courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


