Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E624EC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 22:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2532084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 22:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGLoIAoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2532084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF4EW-0004t9-SX
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 18:01:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4D2-0003LY-33
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4D1-00054S-3h
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:59:44 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:44352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF4D0-00053k-Mr
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:59:43 -0400
Received: by mail-pg1-x533.google.com with SMTP id i2so5794243pgj.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=r+iOE9+j7y7XucIl2HcEyHqm4kLlN3Y/ixi+x8lAf3E=;
	b=RGLoIAoE6TDwVAPW0+15gZ7CTcYya+8si1kYFXBX+lQgntbgDVbiB3715VIrapzMFA
	OAOx2Epavm3lJLdzzZgFc6K5PqDmGBBRB0NzIpdT1Q2rAr0API/nrW71tM3G+VcSnlhs
	aL+Xq7AAzyvb5Pcw2+Ve9kdzQgfyxDgzhZSICCQ8LlgHNE/SCRErjAu45y/TZGD9QViI
	n3lAwySOWdpMDziukbhD1r801XLjHaRO4sYVSxUx25J8jkDzbdgGU00O1C1VAjARuEFO
	GU7XC6UdrWBItIGLl3LgCAHE3Sbgy551nflb7XiWlXUEC/Wrnyg0VYlckjZDsKleyWVb
	uGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=r+iOE9+j7y7XucIl2HcEyHqm4kLlN3Y/ixi+x8lAf3E=;
	b=miEaZS7NYfUjedHGmeF6Qz74t85VwjHBnuCZ1b+iW3KPiOJTH6do9XUqN3G4nOf4N6
	DMU9uGZ07TVdlNtIP0ZDBmx9e5Kn5RaplsxQdaFCWXtMcs13ebRJQMEoOAX6s/ZNIAgM
	aHu/7DLh3u2Ll355JU5Qu627E0SuGr22jLxU7hbReVuJiZKW9EsZqThiGMUa1X3XcENE
	DEjMfTRKbQC+1OHGLi9I2HNNIibIiyBeYYxn2KBhFirkp0X4RczteWJZ+VrIMipoPGSc
	w3f5C4f6t+UdJ7Hujk1usbvKQ/idAQYczv1AR237JcLWXMfWdudeKZh6fdk/VlkZng2Z
	hf/Q==
X-Gm-Message-State: APjAAAW6IHY2jyKVPbAORy2UmGggjVEyAxq7dBt+GJZpRkY991gGUZdz
	myW1HcKdKlItdP2DDlAKh/uLnA==
X-Google-Smtp-Source: APXvYqxRRlIkwWxtGUIhmNE/uAQpxV7FL5D6l7mnJSRgwZzgMXd2V9DU0tEeg4/M5qUxcufK/Z/KHA==
X-Received: by 2002:a63:530e:: with SMTP id h14mr20238258pgb.136.1555106381431;
	Fri, 12 Apr 2019 14:59:41 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	y1sm70836858pgc.29.2019.04.12.14.59.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 14:59:40 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <36247480-36e1-e1ea-c58e-93fe9c472a20@linaro.org>
Date: Fri, 12 Apr 2019 11:59:37 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-7-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: Re: [Qemu-devel] [PATCH v1 06/41] s390x/tcg: Implement VECTOR AND
 (WITH COMPLEMENT)
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
Message-ID: <20190412215937.T_F5WqhExYeqIOElk-MWVIu0l0c4rc7PhHSC_RIpx3M@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Easy, as we can reuse existing gvec helpers.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  4 ++++
>  target/s390x/translate_vx.inc.c | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


