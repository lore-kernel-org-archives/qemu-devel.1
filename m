Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93968C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B58620869
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2RGddpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B58620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47391 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFBxV-0006cb-EO
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 02:16:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBwW-000616-5g
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBwV-0000TY-Dg
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:15:12 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:44989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBwV-0000T9-4b
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:15:11 -0400
Received: by mail-pg1-x529.google.com with SMTP id i2so6168993pgj.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 23:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=UjHo7drkXmKdW5Qz40KFUHnz56lHkDF0ve92IhaY2NE=;
	b=m2RGddpkmbkXHcSg5j0ULw5J3X30BayZCqrBzJr6qBhTSG7ToaTLy4IkDT4tyKa7im
	sqUsrbWnF5N3WGTEkfl7OvRi+JGtxFeDxeopY03qyJ2H5u9dLvRHTpmb839iCJ2k0lum
	OKMv6gb/Ui2lOeS5mwKZSGYJhps75IYebvfigOl1Ahxx5dqZEY9oYIz0T8iBTV1kIQtq
	CP31xI0GLszZgxd+Ad/eYrSEzHe9ocIhAdAkJI3l+j+Vy7SiFEbzbwuWd3gSRUactJtW
	glOiICzmrZTeM0MpLc33JGRuqHUvzCyTRDDAWuHIU+7WpLnJc7wjT3yu4JwotrEt4DJx
	zZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UjHo7drkXmKdW5Qz40KFUHnz56lHkDF0ve92IhaY2NE=;
	b=bf244+fSCL3XGJpcNerYeEZhDFj82tEV3d2xB6QJgAv5KBmWlNi+dpmdDsmBMLwpBE
	byc9mrGoUCZPTGfGUz6mQile00bpYMCYS7TQBFrp1iak8j/RDkUYg95fsH8pVXQagSao
	9XR856empz3H3vp/Hw34PXaG0VMmu1atdLDuWZUeo+pbR8MwPLoG3X5ZUURrPLUmsqOY
	erAmkMgVFi2fERfPtHSHeumgpnt3xWss1lzJwv9ncssNXZYpu1LNGCXgx62FGM3aZZk/
	gOSTMVw4vN+7RODHqx49W3HQ6BxVATfLL1YVy0dxmX+U3UMsbnoZmn/ChAy/t480+QcL
	ODbA==
X-Gm-Message-State: APjAAAWuQm7CPPKQorP4eFbSg6wa8eOXjBCxuhPUgsTBaFmjbcP6XPRH
	BWS+fgL7PXXF2TifrInWsr6Fgw==
X-Google-Smtp-Source: APXvYqxubXUsz8ErLqjxt26tyo6oU9ZSwJd4ekiZLcsTzrC85Aq9a1eUArMoFzO7NJ2hkZy/Nc4FSA==
X-Received: by 2002:a62:6086:: with SMTP id
	u128mr61944008pfb.148.1555136109551; 
	Fri, 12 Apr 2019 23:15:09 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	n3sm76645661pfa.99.2019.04.12.23.15.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 23:15:08 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-39-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <372cdc7f-08b8-4856-cd6f-d6d67381ef29@linaro.org>
Date: Fri, 12 Apr 2019 20:15:05 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-39-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::529
Subject: Re: [Qemu-devel] [PATCH v1 38/41] s390x/tcg: Implement VECTOR SUM
 ACROSS DOUBLEWORD
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
Message-ID: <20190413061505.gznPCMC3v5fY-BuYbFY-WKnYm-CyMfHdyugOofL0AZo@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Perform the calculations without a helper. Only 16 bit or 32 bit values
> have to be added.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


