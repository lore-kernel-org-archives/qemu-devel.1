Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A16C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375C126D27
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5WB17Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375C126D27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlJn-0003wp-Hn
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:27:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlIr-0003Tx-Lc
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlIq-0002rL-Lh
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:26:53 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWlIq-0002qK-Fn
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:26:52 -0400
Received: by mail-ot1-x342.google.com with SMTP id g18so9921015otj.11
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=RoMf15a459pypNx5gmPuyDZLGCQHxpwWmiR2cQcJEq0=;
	b=B5WB17EbHf3lfyyT4IXPPvMyU7iUWfMmk6+b9tCWIJTKxs66aM0/L6+vnFa74qTcW0
	lUag2+xeiXfbG19M8hw0aHUdEJbhcOTwBgpnbbRl6PaLbr3jLEPqb39b/PODyVhq6p3U
	EvlraQg1eIuFS0yfqsg0haAtJ48gUoAsZ+e7PDVKbqrpGYQM3SyA5333KmRLEKiAy8io
	S8VkWQ+QpH8f+whmlB1NMlTcdLiyLNnpBWv3sFMAFzZlTCvOcK7Iday1EQ/e6RVvhodd
	KhZDh9Dr61memPsBRjLtf9PxaCjI2oXP39g4X3at4MrpIIVwvsF9mWcZ6uHt6D2Xf2xY
	vvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=RoMf15a459pypNx5gmPuyDZLGCQHxpwWmiR2cQcJEq0=;
	b=ZUs5e7/bKheLesmTenW21kDbQMcJYuB3+ubshpzn+sO8N5O0gweiAjVegLt6iKUNZz
	y3uGm2JJZIm8bttSJl3KEGPLZwrzLyLuLuxYidAdwX8elRVFQpVaPRiGDWk3s7uIbMod
	C6KvdC183vrL6mzGc2INptvSoe26SoxPtp7XlDdx7EV9pcJZXWzkxA8sbXx2pOEBXxcw
	SIYFTYaqN/aLrMTvaLrd2OR74QfzgPdeR5yI/o5IXvi5KZLPKjqZvwRxyb9W/NaDbGHV
	KPE92GVtufODS8i/XCkD7SkQI+DMJewDsefq8JpE0YFAmzVjgYxny1U03JlnaQvP9ssN
	UciA==
X-Gm-Message-State: APjAAAVTSaUYvh+2igQVkVCVG2CCA799e4HDPhDUxNL2L9sL0x2dJf0Q
	a5+wrgU8F9AymrkJqiQpesxUCg==
X-Google-Smtp-Source: APXvYqwhg4ORArbk8aOAAHnuQQOKLWtOeg7clNIMjcSbSBvlAngcUFDabPm5o6Qm6Yr4ljXy5YcsIg==
X-Received: by 2002:a9d:5d1a:: with SMTP id b26mr2846918oti.50.1559323611369; 
	Fri, 31 May 2019 10:26:51 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	c19sm2116480otl.70.2019.05.31.10.26.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:26:50 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-13-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <660ccd04-2a10-446c-704c-2e4358e2466e@linaro.org>
Date: Fri, 31 May 2019 12:26:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v1 12/23] s390x/tcg: Implement VECTOR LOAD
 FP INTEGER
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:44 AM, David Hildenbrand wrote:
> We can reuse most of the infrastructure introduced for
> VECTOR FP CONVERT FROM FIXED 64-BIT and friends.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c |  3 +++
>  target/s390x/vec_fpu_helper.c   | 23 +++++++++++++++++++++++
>  4 files changed, 30 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



