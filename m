Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113D9C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21E620815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpHCKyEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21E620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRIgc-00073q-5i
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 11:52:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRIfA-0006Ty-1o
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRIf7-0006MY-5V
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:51:19 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRIf6-0006H7-Sy
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:51:17 -0400
Received: by mail-pf1-x444.google.com with SMTP id n19so2075328pfa.1
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Zg3R2EaZjIuwH2W6H36X6sFNnA3P2QIq5nhLM4zxQp8=;
	b=EpHCKyEEamV+3znzeA29yXam+jTlkuGuEcy0l8uucNi6pY2eyILNpKhU6u0Bt1uQas
	GLb1PKhfJj4IlaOY4oq9u1N38M9kaCOPSpS6mXZi0/QoKnbI4iePth7tKGE1TuB288cO
	eg6pDMH4jtXw5mIs478OTk/RJslx1jNIMNV7Se1daZBH7nIJZJqZAJA4fPgtlRk7QRaE
	7F1tn+1ZxTmWlIlwFXrb6JMB3GEal54gGXwv20iP+0nuakaEnyjIyw2IoEy54zqebNQK
	CI54OhOcMAUCZvcVaB67owmmZ/ueJun/sMIZyKjaile1qjmQ+fDUIRjXonIVx7FC+Tef
	Quqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Zg3R2EaZjIuwH2W6H36X6sFNnA3P2QIq5nhLM4zxQp8=;
	b=J3hzpu0w9L5CnN8yxv6N1VmAgB1EyFJpV5bdnHd5FvSD5ofshwDSHa5KClhNtzmcwP
	laLPvcD+DMn6ieZL31abmTkPTbin9jBkJCgwTOAcuy4nf2vTeXM3j8s41Esp3eYtnsyI
	LDd6u6pDTTHBC0PFa9wEFMNWNVcxR8wRLhIZpJd+B0yuWw8fJdz24uF3InjBu81xeTw9
	ND3JIg+PkevrtpIM7jWmGxuWbkhnv3gVxOLuyJvB4hkT5ZspB32tCkjqUoqdY/KWTaEc
	i2Yg8zKgWN9VRJkFEK4QbG+EN+lP6v4L+y+I1DYqALMmZ3ND1vL/eBTpP2MY3LZnFEMI
	fluw==
X-Gm-Message-State: APjAAAWPh/hMpTMnFBQl88WSXHWLVCDS3oGVbd/CEpMumaKvK3RF36Q2
	MIZjw9CBK9hJDdbLmhRdGbtb8Q==
X-Google-Smtp-Source: APXvYqzhduIO1Aglbw/pQt47oOuVqu+KiAkcf9iLAN/saoLdUdqd8YUeCC/jgbYBR4WzmiEsLP2AjA==
X-Received: by 2002:a63:b90a:: with SMTP id z10mr10121778pge.257.1558021872904;
	Thu, 16 May 2019 08:51:12 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	g71sm9251083pgc.41.2019.05.16.08.51.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 08:51:12 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
References: <20190516113922.8383-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ab943375-3820-eaf6-870f-3ed052ac8eb0@linaro.org>
Date: Thu, 16 May 2019 08:51:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516113922.8383-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] configure: only link capstone to emulation
 targets
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/19 4:39 AM, Daniel P. Berrangé wrote:
> Only the emulators link to code that uses capstone, so adding it to the
> global LIBs places undesirable dependancies on other binaries, in
> particular the tools.
> 
> There is no variable that covers both user emulation and machine
> emulation, so add a new "$libs_cpu" for this purpose.
> 
> In particular this removes the 8 MB capstone dep from the things
> qemu-img links against, allowing for a more minimal installation
> in scenarios that don't want system emulators installed.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  Makefile.target | 1 +
>  configure       | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

