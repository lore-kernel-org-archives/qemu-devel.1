Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185ECC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 20:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BBE218DA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 20:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NX1KqeMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BBE218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59411 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ2W9-0005WK-15
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 16:59:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ2VH-0005AK-Lq
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ2VG-0002BI-LV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:58:59 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ2VE-00029u-Mr
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:58:58 -0400
Received: by mail-pg1-x542.google.com with SMTP id v2so5781619pge.13
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=stUvOROvbgPFVjRNiSu0eagtnmxdLN05cmHxeFf/RCY=;
	b=NX1KqeMT3sR0YKw36fdHitbC/HsyjBfWgE+jcJESisOm32jzxJMc9KOyrv9Lvi6eOg
	lRscuLVqtFb0hkfIda971F9F9foByLkvFO71gsDF3igimWI9I/pdbAp5+0ymjEG+GZJs
	mC/tbhr3nAYLwVu4LfBLdE//8uO7gDaudkZplcA01a0+Z5fGNomyhfvua/EtypLuQ1cf
	qEyaq2KpTBNjjBdu5i+6uST3wFOWZ0jWcIATgbuTqMdNWTWxndnS4CfyhWXcd7A5p0A9
	SD3b+K8RBhdzs7iMtK+YQv/yqvbnqwDCYCc5vW8ADTRwrx9yuGqKVyQiExQ85iqLXTuy
	wGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=stUvOROvbgPFVjRNiSu0eagtnmxdLN05cmHxeFf/RCY=;
	b=Yu4YrW9vhCHdG5Wqe32D4lLU+a5Yo8O6yrk2Akt6WjFnpP9RczAHcAUBfDT4cy5ONp
	YxLvWZ/aG6B8Evu76CfWP/kugS3E4ogFyqnJmPkazKa4vZ9SslM/+wiRAURmHD54ZSX0
	PJZMP/sGu/Gn8NLzg2aOpTkWbrvNcBW3OTP9Xvlewv9CeS9UiuDIfUJkiSvhgG/7xzFC
	wLXDDGlekZWIj8XtfyaxpL3rsN/V+TQteuyBO5OlyD4YYbXiDzW4C9cUYYaVUwTkkfUd
	VXj8RCBuEmoa7VY8NSNcikTF0xmw7QSSnO35dPYG+wFHyP/Yuz5YoIFSDO3Z6KRhWNZn
	wZ8g==
X-Gm-Message-State: APjAAAV67y5aar6bY+A8G9sznEQl3LDbuWFAsM8jv5kUgVGjZPDcNJe3
	OjGXa1jHidT7yLh1bC029SOmHALrAIA=
X-Google-Smtp-Source: APXvYqywo53AAm+FWnKtqQZyiqvSWZsKVEVR0qVAzwWCdTBcoI4FJBSt+xJllOdkAuEbduLqf0XW8g==
X-Received: by 2002:a63:5d44:: with SMTP id o4mr26688689pgm.15.1556053135056; 
	Tue, 23 Apr 2019 13:58:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	c3sm29548001pfg.88.2019.04.23.13.58.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 13:58:54 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6f380f5c-f65b-49ba-7af8-f1c84b2fba7e@linaro.org>
Date: Tue, 23 Apr 2019 13:58:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH 07/26] target/arm: Clear CONTROL_S.SFPA in
 SG insn if FPU present
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
Message-ID: <20190423205852.kK8ns6zS-azMq3KDdiz2QD8jt5zz8IvXQTjRYW9aNPA@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> If the floating point extension is present, then the SG instruction
> must clear the CONTROL_S.SFPA bit. Implement this.
> 
> (On a no-FPU system the bit will always be zero, so we don't need
> to make the clearing of the bit conditional on ARM_FEATURE_VFP.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


