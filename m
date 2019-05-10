Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3CCC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C115217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjmNBCyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C115217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPB0Q-0007th-Fs
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 15:16:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hPAzM-0007PN-0Q
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hPAzL-0005kh-5W
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:15:23 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hPAzK-0005hh-VN
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:15:23 -0400
Received: by mail-pl1-x643.google.com with SMTP id x15so3247062pln.9
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=8yfIZyFKLrRsNknpRX42NFD+HKsnDmkaRzzlwChgWL0=;
	b=qjmNBCyD33sHTAVcOzv8kkTpThJM9vMeUM50zYv8Re4LcymmmjzYCbIMklk+IGy7Gi
	i9VmlRY7GrrbtUD4vLTenK/xzFRMbUtxXxvchQXpZ25w5PzHq5e8RZW0LsAvlb1fxeu2
	BXGWi8NjGt64di0p+0ENkETQK1wDif0L6drbpbIlSiIOvEk6Olo6APKgQDdcA+qYX+xM
	GQp7qfNCH+czBylH2640d4layMoI9KvKc4pbcfLYRWYrFZsgS8ya2KEn8m4UBvG/Q+H+
	14DvDa52YcVEJv6KIraHfThh3gqNqnMAytvH+qnZF5W18uvxa0o12V7V8NQfus7F8EBM
	Y8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8yfIZyFKLrRsNknpRX42NFD+HKsnDmkaRzzlwChgWL0=;
	b=qYXxqB1b4mff1mWgFgGlAQgABj8+Ud8OCc3KKMypVVsQezm9RpDRAvo0zV41PDqwX5
	jqCViHShef9siGxAZVetJsQpmvJnAxvq/R6GwAoUstl8+VHGzQB80XzpYLJHLPp9sstZ
	6NqqsAfswbxBR5zIldPv23DjnxVr5ywH9wO+CcNSzaDAzasTu09PVb8QGe33JvHsoNi7
	SDVC285sJU3kQ/DM/krC1ofgkUgbzt5fUb3RuCgmosJjnFFuzBbLkYr/Hi1Ro/PFHBsh
	X/KRhrBZ8mA6AhYN8Y/v8vlTHsaho/yyvzgzwwv10yFMPsbuws1EXG7NIPDc7cI8rBoZ
	QzJQ==
X-Gm-Message-State: APjAAAVojJQxiuqVdB45uRld51BPc3ju2gz+ozXEH57+O7vjldI9ykjd
	SLEdBN3SZqgS4fh9H+/nCBiVKQ==
X-Google-Smtp-Source: APXvYqzXqGJ/BIOaxvgMUV+Ufm+G1k2EC7vR1iwVWj2Zl6SmjthSJHteA0ltAguNE4MgqdAWtfSvpg==
X-Received: by 2002:a17:902:28e4:: with SMTP id
	f91mr15035650plb.321.1557515721756; 
	Fri, 10 May 2019 12:15:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	13sm7696808pfi.172.2019.05.10.12.15.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 12:15:20 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190510185620.15757-1-ehabkost@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ffe6be45-7c22-1264-08f2-faa21ab9db69@linaro.org>
Date: Fri, 10 May 2019 12:15:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510185620.15757-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH] monitor: Call mon_get_cpu() only once at
 hmp_gva2gpa()
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/10/19 11:56 AM, Eduardo Habkost wrote:
> hmp_gva2gpa() calls mon_get_cpu() twice, which is unnecessary.
> Not an actual bug, but this is reported as a defect by Coverity
> Scan (CID 1401346).
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  monitor.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I was about to send the same patch.  ;-)


r~

