Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE51BC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9392086D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MaY4Rq1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9392086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44179 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF5uX-0006wd-Qu
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 19:48:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5tg-0006ex-7z
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5te-00010I-Ff
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:47:52 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5tb-0000tS-Hw
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:47:49 -0400
Received: by mail-pf1-x442.google.com with SMTP id 188so5840845pfd.8
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=0l8K+A6DTGztGyOn/WKuPioDAiBtGyhSVMqA8nkBFvU=;
	b=MaY4Rq1cWB4elPqbvrtITM1LPVvjtNloUBIW0MZ4qAdTpWGvrchog/UJe7zv6Sd2we
	XteWgVT2roJnoFOP5BuGNtykOkdB8MV/FztPS+qtAIPj4QVNEyWtQhklTu6I63yqlaXB
	wYHwNtDf1Ns0Qaw+hwU2cPSX5ehwKhXDB3TIJON5UTZCY3/U8Kvb3OHsyRMHsW7G+bit
	WLCYZixhvg741CaoQrozWVUZg1w07bKPFpOSrC6OmEwSnFIbvmiCl71YUtaZ4JHedomB
	oRf1o2QPakX10nolxu1CLLXKlFyUDAlqGLIEnda0/7Btcf/GqtvacbSJoXT+YgVKhBe2
	3AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=0l8K+A6DTGztGyOn/WKuPioDAiBtGyhSVMqA8nkBFvU=;
	b=Hvi1XbogIwxWgIZqzZm42ZtT3b1Msk5BzlrXuxQoCeNg43F7SXyywdHqKGj0ykwrzg
	vZo8a72ALXSqwdeaAtuFYNQAPni8YNUeZJomcCWGGwQSjKwdeCkCFFO032VzBeG2f6wT
	IXqs/L37BJ2d4pSn3BwLnRJIrm+NxiKA91br+mk+86lAKcs6ZEJ8qG1h1WjVGh5WEKqG
	K9TtvnZkwouetUJDIRDRntrLIiKwWGWFXsH9Xb3POCnfJtjkDKFciBjiyrSUaGX2E/Ld
	GOrBjviVFNRoWRmVjVZDT735vhWymY4ui7xUNYhTF32C+zi/CCF7zSK+GI1VFUPqwdzn
	GKqw==
X-Gm-Message-State: APjAAAXFhgBYDsVWWzWAVJXt/fXQynLxa0btJM25Cf54APRRFJQ6COsa
	N+GO8+a5Yfjzfm4TKkXdSF+H+w==
X-Google-Smtp-Source: APXvYqywbR1fSwMdr2cWruLrvudeaLJMQqcL4XFRLoN492yGOUMBi6rPeL1hAeCTosj62YRKIzGuvA==
X-Received: by 2002:a63:90c3:: with SMTP id
	a186mr48696577pge.306.1555112857943; 
	Fri, 12 Apr 2019 16:47:37 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	p81sm70109960pfi.186.2019.04.12.16.47.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 16:47:37 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-17-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c8a27981-380c-cbe0-7a55-fd45b412e8e4@linaro.org>
Date: Fri, 12 Apr 2019 13:47:33 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-17-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 16/41] s390x/tcg: Implement VECTOR LOAD
 COMPLEMENT
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
Message-ID: <20190412234733.Ty8IpBunzck996AG6UQu8xN_SEhRnmk-aBFTjy56HrE@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> We can reuse an existing gvec helper for negating the values.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

