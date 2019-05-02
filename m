Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF59C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5E9204EC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIPVEsSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5E9204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53286 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDoO-0003rH-5N
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:39:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDnd-0003SF-VO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDnd-00072Y-5j
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:39:05 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMDnc-00072L-UF
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:39:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id t87so738523pfa.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=sTboo5vhuwHXHA6LrRDUkdHzTBwCGifVjDxNd3dmbxQ=;
	b=OIPVEsStDFY7TAYq2rG5hXYP2H8Q5DXfFQLVQS4Lx3bS9mP9edWolws6vMqOgQSgvf
	9sXF22NLmhH2ZHvDDdb+APn5ysQgZZ3XX05Uu08Gec2eoxBE9Uu7jurKMtkLQ++3nSmX
	zjb7GBoot+Sxy70gblsbrnQ6Ve5KaaKcQqqnIrRmawTwvAPYzGT8Qbt9yFCb93CyVYvW
	w4vFoM/MVrwqtYpFbnWn7h6qrZvt/JsI04EiVaD8GvguKBvxVlfeuXV4wivvNvXRf4Pk
	NC6Vh0NqLu0/v2WmVmIQ6kSokfjzsLsDRp6G48XzgcGB0TDoYeBWVXCgVr5S5lPREmVX
	2VjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=sTboo5vhuwHXHA6LrRDUkdHzTBwCGifVjDxNd3dmbxQ=;
	b=jqaP6H+0yVYnsVFb0toPdoDpJJDFP/qCxePUvoG05fzWwlhES80lyNPDXcxgV+pbf/
	rNTkD2d2F8lp4BcgOoexZBlvQX/jow0cu61kwoLBjO9l/snWyGWHw/6pPq06dVfuObpc
	8IzQrI+8nicW9kNUlrQWliVvW45/inw4hCsezQLPHo9Nij9VaKNmpgOQPfw03a4bXjOR
	Vo7+9mdX43RkA3No6QUi+WN1haYUKEBUbWIoXzV517bCb9ArYjBE+8qxgw9BGxUdfn05
	Cbe8QmCI1t14yMryCNK2eJrj2SBhPnCrdno3K0nCPk1OKCrU7UUi2eyDEH//Ta5SSe/Y
	fcpQ==
X-Gm-Message-State: APjAAAUpJX2f8lDabZdiMKmrYUVYqWqYeZ66J01kDzl1LkHLeGOXcNY5
	XogOgEUclXw5hB+8JcofghNNoZbvYsM=
X-Google-Smtp-Source: APXvYqzIyCxiKE9MYu49t9R34KF4JEQ8z4hMiJ+GmuXZVpQzCguvuOCdwL/W+CVIwqLs6SguBCP3dQ==
X-Received: by 2002:a65:6091:: with SMTP id t17mr4625626pgu.328.1556811542685; 
	Thu, 02 May 2019 08:39:02 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	p81sm5644661pfa.26.2019.05.02.08.39.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 08:39:01 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-14-richard.henderson@linaro.org>
	<87d0l156hp.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9a308f32-83cf-c5d7-3025-7181ffcc944b@linaro.org>
Date: Thu, 2 May 2019 08:38:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87d0l156hp.fsf@zen.linaroharston>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 13/29] tcg: Add INDEX_op_dup_mem_vec
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
Message-ID: <20190502153859.7kTQMMU_FAzvNdHzp8ep54y2Xf3FXaVnrz1niVcH5-k@z>

On 5/2/19 6:30 AM, Alex Bennée wrote:
>> +static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
>> +                         uint32_t maxsz, TCGv_vec t_vec)
>> +{
>> +    uint32_t i = 0;
>> +
>> +    switch (type) {
>> +    case TCG_TYPE_V256:
>> +        /*
>> +         * Recall that ARM SVE allows vector sizes that are not a
>> +         * power of 2, but always a multiple of 16.  The intent is
>> +         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
>> +         */
> 
> The c&p comment explains the fall-through  although in this case we are
> only mxing and matching V256/V128?

Err.. that's all we ever do.  2x32 + 1x16 + 1x8 is not allowed, and is
validated by check_size_align.


r~

