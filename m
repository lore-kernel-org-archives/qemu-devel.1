Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D00C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C782B20850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcgXD0+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C782B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42998 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF3rN-0006To-5L
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 17:37:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF3qc-00069v-Tv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF3qY-0000El-O4
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:36:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF3qV-0000Ct-2a
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:36:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id j26so5781810pgl.5
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=mfX2gjA7uvSCKucjTre7Wu+sx1BLPz7Fu6+zq8OSIq4=;
	b=lcgXD0+wxQXWS4DuueTVDmKk0Uw1rbI1iHxeMH8AUP3NZ6JLJyxam+S9s7Wg4suyev
	+mau//ASXvTzYGZTu0oCSwq00dKUl9WIXi2sWdu1xaXokAIM3x3PE4kclPiKfg/HwcAH
	Fd1IAw1x3XLpcoRPZg0jjudAPyAaH1VeXWL+m+tGe9PeD8eiMBi8w1fOspfhvtOVuwDH
	7ILCX6E1+9Rq/QdDh6o199rbW987vHnl0F8wJVbIVoU1k1C4xxcE7R5XsszhseO2Rwl9
	/QtnSFqFbUbCuNxBzBx+qHjtMv23Bti2yudybdRYvbJKUUI6JuKAm0Dq5cm4XyMjMcpG
	aeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mfX2gjA7uvSCKucjTre7Wu+sx1BLPz7Fu6+zq8OSIq4=;
	b=rByqrJTg8D8CQPnCIArFp2V0i2hNL/DoprKFwlYlB3kjh11Qdj9uMFw8iFlmIJcFzj
	3puUGo784uo0jj9W9QfWuP4POAnuIqRR41qVM4esmCBvbcxvC0t7JA6cWXVD15IPOHq2
	5oTNAXoLBRsLxGrU7tOhDWXBZcngSvtNgTm91Z7RjU1aqvkoYNKBaZeFfQ8f8hjy3UZ0
	tH8FEGs2lA0uPuNsFZhC52LuY7kb/LEVesFzoJHBwSJVZQfM0eYH8jeY9xquB9jvIJq9
	UtNztAhRsJ1sbnr9GUxDMzGeuWNx6qDsijId2QVpdruGIBktaL69V/psH5cQg0eFYOo5
	3qgw==
X-Gm-Message-State: APjAAAWB+OArEPc6OtAMbG2fy9DekGF+aKOpJrhtLNvPV7r35YMl3aNA
	alRgYTWLRyiAXI1PHkUqEfr8HmcH9Tk=
X-Google-Smtp-Source: APXvYqzVLi5w+VfQdv0g9yberIevV4tWxS5/6qGEb6elsQLHI7JfHvFhN1RNUsoILvy7uNwpCjZuYA==
X-Received: by 2002:a63:e045:: with SMTP id n5mr56401102pgj.230.1555104984970; 
	Fri, 12 Apr 2019 14:36:24 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	b63sm116398947pfj.54.2019.04.12.14.36.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 14:36:24 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b3a0517f-2f5b-d56c-d3f6-627f479f58af@linaro.org>
Date: Fri, 12 Apr 2019 11:36:20 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-5-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v1 04/41] s390x/tcg: Implement VECTOR ADD
 WITH CARRY
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
Message-ID: <20190412213620.vfB4K2zWfWMLO9umaUoryl9jPjj8HjfKUijj0J1qpEw@z>

On 4/11/19 12:07 AM, David Hildenbrand wrote:
> Only slightly ugly, perform two additions. At least it is only supported
> for 128 bit elements.
> 
> Introduce gen_gvec128_4_i64() similar to gen_gvec128_3_i64().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 63 +++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


