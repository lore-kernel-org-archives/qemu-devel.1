Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F7BC10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED09E2084E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PP9w87Qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED09E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44637 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6fq-0007Pl-7y
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:37:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6f0-00075z-LO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6ez-0003lt-N3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:36:46 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6ez-0003in-Ay
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:36:45 -0400
Received: by mail-pg1-x542.google.com with SMTP id y3so5919406pgk.12
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=kWztpWGYpJapxqamMewwb8YJzppWWiKXwkpdOui+uEc=;
	b=PP9w87QdfkVLIMnuC7oCtkAYsEQcFOwv9eti3QAD4eTkKeTRbJpZJQrcvyROMEFpwt
	PXhhZZpuJXkncNxkjY3suHKjH3otzhwWBRR6gqIhiwh4/YZXHP+nbvzjqxR2vzZg4PYr
	s8BZKzXGQf99m8KYHLBzMfDb5RsYJrYDBSCWkUeg9+YvhYKs9WfWdPl98+8NI8RZWtdE
	X6AQc44Kqq8ATpBPb5Ljkcxky+Pjmy6hErxEuJLLKO5VUinLuHyCvDJBtUinjATBe4qg
	kDVfWXZgrU76hzaXW0cqWWNrq0qFUWl4TqXrCLfla4yo4T8GABVqlwxkrVTehVhqY5E3
	f4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kWztpWGYpJapxqamMewwb8YJzppWWiKXwkpdOui+uEc=;
	b=fvLYQ2JR3B9GbVicu8+CYBkbGQNWwXeTKtJXxS4ATk9eedp4Q2SBbVxCjYZyMXPbZZ
	emzIVHOiehJyDs0sYVKRmqlUmSVqkAdyElajYPgFt+zFpmBluGsSzAednj9jl5lvx4X5
	/SIKtH8b7TNrhW5LcqLtEsVn4F8PD+GoZvVELPow9jIZitopLIoU4G9QDMHp44Zm08Tz
	SytIsi6zhiForW2b04UErzA3yyVNgSpbUg/5DM6hkf4hfcqsxeAbbe9EPxxuzB0/xCng
	x2EsRznJsrN6qjOW1eixGJe60An9JtLST31+EQub6BixlIukFMgeCDVVfMMoip0rYDG8
	za0g==
X-Gm-Message-State: APjAAAXt9WhZZB2AVSykrVddKFBLMyMyzFfG5LDA4zkAUPDhB8CZh1dg
	ElrLPHKEuyeAE/Lm2vCO231bqA==
X-Google-Smtp-Source: APXvYqyIZXr+KNqggM0pzUe8IBhDtMamFZSkQoa9x6dablkpWHnCJkFeGvfyQYERAcvMQSErenl2/w==
X-Received: by 2002:a63:d444:: with SMTP id i4mr57727269pgj.149.1555115804262; 
	Fri, 12 Apr 2019 17:36:44 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	j19sm51920218pfh.41.2019.04.12.17.36.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:36:43 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-31-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0fabfadd-5e7b-9b7d-2512-f81ba95f1cb6@linaro.org>
Date: Fri, 12 Apr 2019 14:36:39 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-31-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v1 30/41] s390x/tcg: Implement VECTOR SHIFT
 LEFT (BY BYTE)
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
Message-ID: <20190413003639.UMw85DlEC5dNt0acwPEjX7G4s32Bv2sCixP18Af9_k0@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> We can reuse the existing 128-bit shift utility function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  1 +
>  target/s390x/insn-data.def      |  4 ++++
>  target/s390x/translate_vx.inc.c | 20 ++++++++++++++++++++
>  target/s390x/vec_int_helper.c   |  6 ++++++
>  4 files changed, 31 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


