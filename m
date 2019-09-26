Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39349C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0482B222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B98OagkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0482B222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXcv-0002HV-30
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDXa1-0008Tz-Hx
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDXZw-0007Av-Gi
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:29:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDXZw-00073c-AI
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:29:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so2205693pff.9
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XpvoQnKR31e83qy5pjMDFXxFVNzxV8yl5KvBj87rdsU=;
 b=B98OagkK5D9vCj/1YwykIh8E0ARnMjffjxFOryWDetUN1T/k4nrWxcO5HHtp0xtk+K
 l1Z8CE4Vr+2+uo0fqcrHYTZTbUqC+uaHd0WeU6606NC3puoyymLKOj18pfs70HrummhV
 9cAE0ZtgLOYCXQXnU/uMTv6hsrLsjbAry7b7kK1qABuBZSEqcDH5xMvr+DW80TyH0r+5
 a/saFzxinW5LnAWdMP3lTAE3el8HFxOcUWLw6HC3x1ghTSZR7Q9OB6tcHN8vlxd8P5s7
 AENV9c7jgUTXwd0mxxeuQ1wQX9glUcu1wVkUET3nedCKE1RlqKmgQfHlvoA6RnxpDw0Z
 izRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XpvoQnKR31e83qy5pjMDFXxFVNzxV8yl5KvBj87rdsU=;
 b=MiT+pNrf68/cnFXlJrnQck+r0rSe+h5EIXetxNhRUPHFtYhFHwX593XaqGMAbAAM6A
 RNN3NF6KPvljbPfUhAJRJt5h+Hb0LKSaDGIiFk+6GbpCDX/Ak7ngfBnPlNMeVl3M8rWH
 Sg2+z6i1j0k9gbMx8U0tanshVPzwH4CuRC1Fju8prZdFjU2OajhJ2PaJ6huE1Bvb2lkJ
 uFk2QDXmcwVXTIYDGU+3jRZCc1kjOipuL68h/3EeRglPPwww4h0OZAlF5nMQ3it2tQ0W
 JxJVQRsJlLsK7vEipU2aj63nHxS/R5qzqCczQuhm2pgFRA04sVpPi6tfE302rPfwdfLY
 hBOA==
X-Gm-Message-State: APjAAAW1VahggorbKRR0U+MQAI9OhXg/o/qqkZcfPNeSz1VgBZdMRaU1
 IIaIwL2kIfp37QbCVPVyvDIYpg==
X-Google-Smtp-Source: APXvYqygNkZk54spvJ4tmDzfIGToVqhlrkn8rqSfsGAvY+EXU2NMBHnsxFwWtNYTq4ccIOAlQh6ZLQ==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr4525850pgo.133.1569518895072;
 Thu, 26 Sep 2019 10:28:15 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id x37sm17096pgl.18.2019.09.26.10.28.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Sep 2019 10:28:14 -0700 (PDT)
Subject: Re: [PATCH 6/7] target/ppc: use existing VsrD() macro to eliminate
 HI_IDX and LO_IDX from dfp_helper.c
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
 <20190924153556.27575-7-mark.cave-ayland@ilande.co.uk>
 <8a6dcdda-97b6-16f6-a95b-0c53d1e2d215@linaro.org>
 <9b4860e8-917c-bb0e-4b0e-931f23102584@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <87126a1c-a68e-48e6-47fa-f38506bfaed2@linaro.org>
Date: Thu, 26 Sep 2019 10:28:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9b4860e8-917c-bb0e-4b0e-931f23102584@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.194
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 1:37 PM, Mark Cave-Ayland wrote:
> I see now that you've given R-b tags for patches 3-7, and having slept on it I'm
> inclined to leave patches 1-2 as they are now, i.e. no code changes other than
> introducing the get/set helpers to help keep the patchset as mechanical as possible.
> Do you think that seems a reasonable approach?

Yes, I should have gone back and given you r-b for patches 1 & 2 as well.

Have those now:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> Certainly ppc_vsr_t already has __uint128_t and Int128 elements but the impression I
> got from the #ifdef is that not all compilers would support it? Although having said
> that, making such a change is not something that's really on my radar.

Int128 is usable everywhere.  It's just the implementation under the hood that
changes depending on the compiler.


r~

