Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45328C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1414326D2C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qgrr49Lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1414326D2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47021 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlUn-0000yQ-5A
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:39:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlT5-0008VQ-2h
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlT4-0003gH-4r
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:37:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWlT3-0003fn-VW
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:37:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id c3so10004229otr.3
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=CMdF27JPE+qIVOTvgcovgcC4TXQm2FPLisQjE3iEgHY=;
	b=Qgrr49LmjxAawk55AL6OQiB/NOBex4gkZ+g2zyf7RwoagTBfktLbBJHl7CFRd+cjQR
	+W1hISbNBQuYw81EfoQ+E7nUybo7oPYAwZXCAPb+CEGmEJVRLFMHMsiEAKtBAd8RFAVO
	UTvTEnFxlu/jw/C1accRc5cdJUqgIUJJdAAk1PP10/yZf9Gdy6Qfa+kIR8xJ+7CNNWmi
	OXqlqpGT1EkopIxNugHLfWAnGF+xlBojUsidLjFMSSwpQMKJP6ONpI/NY+CqIIVocSIT
	2Ou6Lmz0WD9yq8UOcXEnVivyIWK0qB2QfKVeKKnaPjdl654QdmhLKGON8kt+kza21++3
	Nt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=CMdF27JPE+qIVOTvgcovgcC4TXQm2FPLisQjE3iEgHY=;
	b=m9d407y1Phl5Zhjuy5L0uljmnyidYKhVRA8XXXArsST4/pqz2BfRjk/ICuDUmSbI6b
	tafo3AzIuxt2vJiObh94UMA7QopPu5WWtd4XuuG/yV5XFU7gNLC81Zd107o+58x7bB8h
	DG9A/8/UvYVfKr45K4koRqdt8s4jPMydr4a0JXVciiqNgBKHwTOjPlGkLPCaID+ggS9h
	UADJpUd0xNfe06lqGDVWR093EqLe6mn5Mp+YzIflHaYnoV7q8p+/+zXyfwDQEjJON4tY
	xdFGHv5QIjlw83eSBJulGtX24xl3ag4dJb7L2UoRpjXMUpFWY8IyQJFXkcUE754RLFQy
	8mdw==
X-Gm-Message-State: APjAAAW7YUqiAdNffmJBQjTRjZ6xoFr9wM6Z/n3hiKYwgIYbQFGJbc+X
	L+6Hw9wMQyND8yhgODgdobtDjg==
X-Google-Smtp-Source: APXvYqxY7PNJRzVQuhSZXQ8lYN3cM70w3XLrdtaFlDUkmKeCp4mIxGPiMhM9i58ZNl29lvm8I+gHWg==
X-Received: by 2002:a9d:2969:: with SMTP id d96mr2759147otb.85.1559324245094; 
	Fri, 31 May 2019 10:37:25 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id d18sm546448otq.56.2019.05.31.10.37.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:37:23 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-15-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e915a415-c5f1-8974-c3e1-1056cc251793@linaro.org>
Date: Fri, 31 May 2019 12:37:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-15-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 14/23] s390x/tcg: Implement VECTOR LOAD
 ROUNDED
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
> We can reuse some of the infrastructure introduced for
> VECTOR FP CONVERT FROM FIXED 64-BIT and friends.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c |  3 +++
>  target/s390x/vec_fpu_helper.c   | 43 +++++++++++++++++++++++++++++++++
>  4 files changed, 50 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



