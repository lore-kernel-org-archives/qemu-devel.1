Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91957C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F66820863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3YhZ47o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F66820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37041 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToPN-0004IU-Gl
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:09:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToBH-0001ig-1T
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToBG-0000gB-5H
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:54:51 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:42222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hToBF-0000fu-W1
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:54:50 -0400
Received: by mail-vs1-xe43.google.com with SMTP id z11so3620652vsq.9
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=eZSKhGCoeGB/6KycrCoWz8LKgSCyD97WerokGFlZCDY=;
	b=q3YhZ47o2s2RGfD1RDc4zipMAjfpKhfYbbEkfg2IWvHB8vk3ATgmWTeJWjK0TIHQsC
	x+tnKfHRVz632Bjei5XaYs0M4xHRx1sEAJDR/1g0SSw3rLsEZfDKc8TrnQIUMf4PQj1W
	Iuwagj/CRglQ8OADufXU6ji3z0YJAFwQjaP7THK3liu5SYY8OhatsllqT4p5MD71mw31
	VuHuM7uxgf5iKt24W3H+6VcgXEQ8iDx8S49B5gJF1bL5bzgWiQcYU4JNe8cum3mTGYXX
	i+OQ/TfEIz88slpts0ihhn6jnhfK7upQM8mNNcBgcob6DF6UojNCsJkCMDsLOdO8P9zI
	DY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=eZSKhGCoeGB/6KycrCoWz8LKgSCyD97WerokGFlZCDY=;
	b=HsuvCb/KHbG56gqkXBoLBSsITJb1Qt7tXkKvmp9866FNP/T5+oxWcGI6IC5PW4n2XZ
	nJVRuvzqWyxQzzglh+43nQqkFCpWw3m0qvKVgX0K0gDEpcZYjndcD2/MfFYFuRG08bZR
	tQtOjCHJi6JznWX5sTZBrYgAtzu0JQ0fi/xLm7JY77xwF+QeyhydrC1dcxRi7NNA2HuA
	wpjyF71qPf8RJzqICS0vJedL3bROCuaZuzYa8c7dz80cQaE01qVQ5jKSQYc5uI/QYLWS
	2axIl3OSvo5jHwQrAQQLqyVVRINyd+qHCYZL7Vyqef6Ub1C1pN8XGDubyy7LX1w9KgNg
	55Yw==
X-Gm-Message-State: APjAAAW+qtSkaTt38+VfC1hgh9FG7LCoruAncbBhr1LetCxK2UmsXmTf
	8/flmpsCjh7EdTJJF4KD6yj2mw==
X-Google-Smtp-Source: APXvYqyr/6jVTQAguKZzs3BzRpfBP/BmDT/i6/GAXc/HDywG5SMsPKhLwuFU/h4QBdlW84MtwWfqug==
X-Received: by 2002:a67:2686:: with SMTP id m128mr9088346vsm.130.1558619689128;
	Thu, 23 May 2019 06:54:49 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	n68sm36914720vkd.0.2019.05.23.06.54.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 06:54:48 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-2-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f9fd05b2-364a-2f74-99fa-fdf1912ed1b7@linaro.org>
Date: Thu, 23 May 2019 09:54:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523081538.2291-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e43
Subject: Re: [Qemu-devel] [RFC v4 1/7] Makefile: Remove code to smooth
 transition to config.status
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 4:15 AM, Markus Armbruster wrote:
> When commit bdf523e6923 made configure generate config.status, it
> added a fallback to Makefile to smooth the transition, with a TODO
> "code can be removed after QEMU 1.7."  It's been more than five years.
> Remove it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

