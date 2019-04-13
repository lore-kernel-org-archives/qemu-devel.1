Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE819C10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A07218AF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlsMnk2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A07218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44307 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF67a-0002dF-RH
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:02:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF66d-00028a-Oe
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF66b-0000eP-Pi
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:01:15 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF66Z-0000ce-CW
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:01:12 -0400
Received: by mail-pl1-x641.google.com with SMTP id g12so5830616pll.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=8xJftVeN3fCfK2vlCLOCwIWQmPVStCyBBunGHvRvnJc=;
	b=xlsMnk2pa1UeT9DTLSCuf/gdWUT+xQfS+Q41oDxvDs8EvEzeyeEXPtfhb7ScuAw3/z
	AHm3Hlt2zcwKdz0Y0I3z2dfmrZBoNBp87WKVSOWmHnAeErt7k/ie1CmD6UM2Zn0DxQEd
	4t+5q7MuNU13yzRPs8OXCZrxQzRQ2sC959S9KzzNAhF46XPP847KetHTS7GcUk/u/haW
	OmHW1WHifBvnr9yKMgw6ERAsHmfWvNorRjOGmnpvwgtPYoFD7Z8GSrvLN3GgeqBidf1D
	fIGCBkPmPqJPa9d8bHx888W6/pwDEkdT5e3kaiWcCC8Lp6gcEzNbyDL9iTI/hyU7wnWX
	ictw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8xJftVeN3fCfK2vlCLOCwIWQmPVStCyBBunGHvRvnJc=;
	b=sVpXLluiQbvxUSi8nsEb9lIxEt7Qy3qT52aUvkKTAc06MiXcXsOjbJygfDfzQnc9Of
	H1VLXnxca2015XXYmjod0/9LEpDttqtw82plwGNfdEVc6ng5kmFZYY7b2ju7mN7D0KXM
	SzZwxAzodRHhmmYs+MaFWx9BeFVFJRX4yFzd2TVXOS3qzkug7BxASsIInsx3r52sMOLO
	pNuC8Pv6DlanIxmIl1qtSrHTnPFKHERvM3jYb4ogPQgYB7pDjmDIGU2xuZAw56PZ2yni
	wD8EdqOqRxnoLZ0pt41gfm7oA0tm5otVraZ6JC86F/dIcDoFwvlEV7tCaB/DmblW30Kq
	9Rzw==
X-Gm-Message-State: APjAAAWj8r2mWdQYSWtRMvSUE6x1SYZW3NXMVIoMY15BfCp3cBUITgdt
	DOhdzTJ8ZaTRo2tou2HBP0U4/w==
X-Google-Smtp-Source: APXvYqxeGq/qoU4yeqvOtF2f6o4cokY79qnzMjJJiqkpnNxqbFfczPkT+MeELhsex4f+evV+q3D17w==
X-Received: by 2002:a17:902:2a03:: with SMTP id
	i3mr60790205plb.229.1555113668919; 
	Fri, 12 Apr 2019 17:01:08 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	g73sm74112547pfd.185.2019.04.12.17.01.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:01:08 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-20-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <92929d01-7607-84ae-c316-3072035ec603@linaro.org>
Date: Fri, 12 Apr 2019 14:01:04 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-20-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v1 19/41] s390x/tcg: Implement VECTOR
 MULTIPLY AND ADD *
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
Message-ID: <20190413000104.2eWbitDUopAn39ANWB2HPPftJ07ms4BGWVupBTICqXw@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Quite some variants to handle. At least handle some 32-bit element
> variants via gvec expansion (we could also handle 16/32-bit variants
> for ODD and EVEN easily via gvec expansion, but let's keep it simple
> for now).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  18 +++++
>  target/s390x/insn-data.def      |  14 ++++
>  target/s390x/translate_vx.inc.c | 122 +++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 123 ++++++++++++++++++++++++++++++++
>  4 files changed, 277 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

