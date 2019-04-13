Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD037C10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4B62082E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIWcAwg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4B62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44384 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6EP-0006je-MK
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:09:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6CG-0005JF-SJ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6CG-0003ob-2i
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:07:04 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:43620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6CF-0003kt-OP
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:07:03 -0400
Received: by mail-pg1-x535.google.com with SMTP id z9so5902310pgu.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=QjUD/rzlszPp5MtDNRZhHjLQ1kyUip4jeIuoNm+ES/U=;
	b=oIWcAwg1US5u/SNV8/ZfkZv3p1vQ10yzc28Yd83QE/s/xXCPUs4ZISlmIUl/m8mGFu
	NbQlCjqMzYCcQN9ikcPnCOeDf2Izg93DfgDMWBbCVJrHErew3M1Hyfm4B8HX9X3aeY50
	wEogwcy2ExpaQEweSkRXTtEXLbZ0V0mAtc71yuzililXwIVkcvqtGh5OTcszREz7Fgio
	lXs4/pDGIty+NDzskPS5PsowXntEJg8To+o2v3LlD75nDBIqwo2lMzXjK907UOo2TqZ5
	xAg+kY9ZeUXgn2mD/a94i9dXJPRe+Rad5Zx8MjqERyBc4Yo00IWqL9x6e4LM1jxzwKIR
	iFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=QjUD/rzlszPp5MtDNRZhHjLQ1kyUip4jeIuoNm+ES/U=;
	b=XsIT4Nob78FSSBH1zH6FUr4a451JcycJ3T7Db3ekLgAUboYcQY5LfpWZ+8hSmYdTSI
	/mzRHm1dPKBYcOrES+ZDikrcfa0hWopJkSqrsPwdwnjCo/I+GzFc9iJhxbQXFik1iR5L
	yO2P+KNj2MeV+p3Q/nObFyGYosf761miwNN1LcwsQMeluxytkdRiIBzZb0anbPcWk1FL
	Ywsx1BpE63dhg4KgQwdRlMyZNgAZKYsAAqB5x8IbPJNrW5E+YlUW2KqIOUitANSljDJ6
	8+NczTxeSLpuA6cuLggGS9eabd+KDtk++Zm6uYwl1s9INYiDtHassY5BkB9mdWt2nEfd
	vvxA==
X-Gm-Message-State: APjAAAW9fgq8TQ2CD276/uZMMoDlEd7bapEzxgnroReqVCHfy6YtXGui
	TzpjSVagLUZV/TCXE1mvlRVldQ==
X-Google-Smtp-Source: APXvYqyJBJnmuICy5blgDeB8dIK/Odf12FwjH9NlGIop/W6p13Uq/NMyuP/xFG5k0PrHDKSglMbI8A==
X-Received: by 2002:a62:fb0a:: with SMTP id x10mr60546621pfm.179.1555114022591;
	Fri, 12 Apr 2019 17:07:02 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	g4sm61112599pfo.38.2019.04.12.17.07.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:07:01 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-25-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <73b20e0a-ffa8-552a-2345-8877fa2b9595@linaro.org>
Date: Fri, 12 Apr 2019 14:06:58 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-25-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::535
Subject: Re: [Qemu-devel] [PATCH v1 24/41] s390x/tcg: Implement VECTOR OR
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
Message-ID: <20190413000658.OaCwBC1u7msdpm4YkS0Kl-3j0NIyXms_tvzRVZDMBbU@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Reuse a gvec helper.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      | 2 ++
>  target/s390x/translate_vx.inc.c | 7 +++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

