Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC4C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 08:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DC02087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 08:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzZN2OM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DC02087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38517 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHl0z-0001CI-5Q
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 04:06:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHknd-0006cS-Dr
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkYL-0001kV-Sw
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:51 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkYL-0001j1-Kw
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:49 -0400
Received: by mail-pg1-x543.google.com with SMTP id z9so3581615pgu.10
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=sMbcziJplxwkeZ5tfQcmpSmLDrBjvwgWvNdIDOUKpck=;
	b=lzZN2OM+92dpI0NdgY8DyJ/0V6fbwaHgifXbhFQOeo57dGBKZEkeTFUhctp7gp5iJy
	i4JFbA+wTfsIvVR3z+sMuf7D8yWxPeyfCY6DUPzGx5C5p/DYLgeUMexS/PlJXD0SB/TZ
	VdGxmhONW7tUz7DfsPGkIGNHoFMJvLHROJ0pTEY2EYPv1Aodp6ps7yn6zpOWeZVt2sW9
	ol7AhJvVa+JImJq0FnCRyoxg8jMyS16thqb1TbbMefIuieqEf5M+sFwHfdoAQo20lcBI
	4HZxNkO2aNtLlmghkHQXYps/7pEyKn9pQRWAC3EOwWKlyGDcRtddKTX4Zyn95LTFb1GT
	b3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=sMbcziJplxwkeZ5tfQcmpSmLDrBjvwgWvNdIDOUKpck=;
	b=Qc1nHyYD4CxXyxmUKKWmzoaYs/FuUFCIYptNV3tz4JFeVUpxmV2rlP0oBoZ+ucREgp
	vmvOOTAerM4H8a9ZC34ERizCRCB1PA8awr/A6VC8FhU8dtiJIu85pKzAYyzvxXcJtils
	4FUntW7Hfv3SlbHsioAwie7DfCDbdJvrGXkbnyiQwBZIToMJiIOr5xE5wOnRvvkFXN3k
	fsqykV31Jc6IurdfzAmZ687rTRmxnRYxqa66343vlnM5n6zluYBLieg/V1u66tU0jBaM
	+U+h+PAXgscELzlvuLC4UQMr1Lu1Km1XfShXVWqIKPcBCeznnzXM6A6AgMXUAUlBLwdY
	oUCw==
X-Gm-Message-State: APjAAAUgdpTNj4TI9wkbJaYfUcGeHvZffUZtnAnJ5lOeGu+rwY+b7B52
	7Z0+PTG3WV1nVZYB4N98wLENgA==
X-Google-Smtp-Source: APXvYqxYYz22gN88kOHyM8NZ2MjlnhqyWHkn8Mg2chX4bMvRqcNtW20Qn4zBZWMR3JJ0mUM4chsYBw==
X-Received: by 2002:aa7:864a:: with SMTP id a10mr8726457pfo.181.1555745808657; 
	Sat, 20 Apr 2019 00:36:48 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	f15sm8277671pgf.18.2019.04.20.00.36.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:36:47 -0700 (PDT)
To: Shahab Vahedi <shahab.vahedi@gmail.com>,
	"open list:Overall" <qemu-devel@nongnu.org>
References: <20190420072236.12347-1-shahab.vahedi@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9059f1f6-fb28-7291-72e4-ae0fd3d4cca9@linaro.org>
Date: Fri, 19 Apr 2019 21:36:44 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420072236.12347-1-shahab.vahedi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v3] cputlb: Fix io_readx() to respect the
 access_type
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190420073644.F3ChAQzevEtCBlg4J4a0qdEagboBHIRliU6hcBbjDbU@z>

On 4/19/19 9:22 PM, Shahab Vahedi wrote:
> This change adapts io_readx() to its input access_type. Currently
> io_readx() treats any memory access as a read, although it has an
> input argument "MMUAccessType access_type". This results in:
> 
> 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> 2) Considering only entry->addr_read as the tlb_addr
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
> 
> Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> ---
> Changelog:
> v3
>   - Only handle read/fetch. There must be no write access.
> 
> v2
>   - Extra space before closing parenthesis is removed
> 
> v1
>   - Initial submit
> 
>  accel/tcg/cputlb.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

