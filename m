Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15EBC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 17:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8632520B7C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 17:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjhkLh2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8632520B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNKkG-0002cU-My
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 13:16:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKjA-00029H-0W
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKj9-0000Yp-80
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:15:03 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNKj8-0000Xo-W3
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:15:03 -0400
Received: by mail-pl1-x641.google.com with SMTP id n8so5139984plp.10
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=2uwI5LFTIk7eo6JAWTjnQMYFpzVzFaiKBrVJkCZiMMA=;
	b=MjhkLh2RVZm+Ew66GzIizoJ4A4am5Fh4aeiCxyN8ZmRN+VKwvoZAHx/9rm2hUTUJI+
	PfrUBquTdne4vbnQCcRGbjiwVq+xuMhX6b0KYr0k6osF5pP7jWEy7VPmOYoJYaE71K8F
	u2XqfyrdXFBr6aI5mSaYGp1t2+Uk9tkvOGsJ6GyLkMtxwnyRmKC+L0kZi2g5JRaUJpjW
	LCfdNu7N4wE3jL3aW6eiH5g45xuzOW+KXkiSXApU37wb3Zp+hEeYzcPoqA79E+nPu2m1
	tL7Yp1H3R8bST2HcLA3NlF5qThJ7UCmcR+7T/CQxasLwlbmC0ugYNWI+iSuByT0HgPUO
	Ylaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=2uwI5LFTIk7eo6JAWTjnQMYFpzVzFaiKBrVJkCZiMMA=;
	b=SYngyvqxzDWShS5G/LusvHaZBU6goBoCjRc7dXBuN+sFfrWo21bmi1fe5TNS9dwzZT
	gGVt6w8CwSGMMFfCXM2XWOuLs6l2icruIlTNpl4we3Huyk6HQCLCjJVqLV3FOoJBPjRH
	+XG2YuMmwli8oFttxKNpE2+Na+Og6bju7yXZulx+4x71wnm1EyezrkUUz+pVCrBvUXCM
	4Fv/K8TnuSumJjngLW0YTdkAoWT7RyXxqdiJa8SRNNirlEHibTK7TorWOC3kEODTf4nN
	dwWrS5EXYnz+e8YI3lbYTSdL67GeJkxCCG5B12OuR58EVkaJRZjt3omr/HMlx/9gfoju
	YtrA==
X-Gm-Message-State: APjAAAXZ7AwvQ4g0HjAa42HUEJiu0r/BFsRIl1Izx/0HcWNMxCTHmxkZ
	sPwuFqdkMIzz/pvCFbh/lthF3A==
X-Google-Smtp-Source: APXvYqzD6y4k6n/0AQHHQoObuUf+0IRXQpIyT+LSIhYqCPyIZD6ehpKEfoT3jMsrFXgJns4/TpWL5g==
X-Received: by 2002:a17:902:28e4:: with SMTP id
	f91mr25977305plb.321.1557076501590; 
	Sun, 05 May 2019 10:15:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	v19sm17692948pfa.138.2019.05.05.10.15.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 10:15:00 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<20190504120528.6389-9-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ce18b2de-9518-d94e-758d-8d79db5c2f8c@linaro.org>
Date: Sun, 5 May 2019 10:14:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504120528.6389-9-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH 8/9] tcg/i386: add support for IBT
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505171458.cRMz8Fcy94x-8fQn2RHbXdi_avaE2fQ36mVl9NSxjoQ@z>

On 5/4/19 5:05 AM, Paolo Bonzini wrote:
> Add endbr annotations before indirect branch targets.  This lets QEMU enable
> IBT even for TCG-enabled builds.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile.target           |  2 ++
>  configure                 |  9 +++++++++
>  include/qemu/cpuid.h      |  5 +++++
>  tcg/i386/tcg-target.inc.c | 19 +++++++++++++++++++
>  4 files changed, 35 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


