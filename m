Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCC0C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C36206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDltO6Fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C36206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htHuA-0003Z5-Q9
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 16:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htHsr-00036e-I6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htHsp-00010Z-K2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:41:09 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htHsn-0000xx-Ig
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:41:07 -0400
Received: by mail-pl1-x644.google.com with SMTP id 4so25709417pld.10
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U33vgluNmV+jUGzSQIQHsocBWoGBIyl4owY9AJ14C94=;
 b=DDltO6FxOBJdAnupZYSXpGQyz/JlrL2sBjxyEBjpY+RLjvUP74tgSqUCnEmlE2QzOY
 KO4SvkSmvdVjUgPvSX3FpYWPbrWOIs1BQAG9Mt1DwT+yQDXsbB+mhzd5/qbPoWudwgWn
 JbWhJeYlun41oqBmn8mYK0dSiApLVnSqWgdrMBYyLGaDy0UV0XBjpnyWUykHgPlt4YBr
 D9EtHCvwYsj1rss90tykEuldBJzim0AJrViNL6K6prIQc7M1IRtet7S1FRBjU2JAgMEf
 0EN7QwLlvmFSwdVTqhoSCHPFPyEESXlU/M6y1xv9q3W2cu8fyPbcqM/z2EESQxPQNj7s
 /vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U33vgluNmV+jUGzSQIQHsocBWoGBIyl4owY9AJ14C94=;
 b=J/DFynA90CuJUqZQpw0fAdVV9bMnqe/xeMNvSRTM1pA7RqR0yZwydeCbW5u2PTjmRA
 oMvN/0ftvwyXb2JtL8iqdMgxaVvKpAHqBcd5pkggQzXfys6qmIy1/CUDvcCPlj8Wcxa6
 GNXOLWjmE5Rnucih2GiJWpOUJYwAxssQLPjEHELgqrLHjJjvegY1ATBJACcbN0w3TeIh
 fdiCDxNVD+ieONObYJVVJ2uXdf2K+nxlNyk7wynwn+h9KK/RixDHOF04Y4fgEp272tUh
 xvlxV9J2h2tJeGbGl6xksRlsWASl3r+2uDnEe9cA8hCIKTG/LDZzZz0ZKZ7+RQ0jdvG5
 U44g==
X-Gm-Message-State: APjAAAURy6x7JlSm3h5lafUxr4+0NzwElorKhalwGNKNQXbBqY81wxHU
 JshQI3zXPtNu+Dh/mckKyQc8hw==
X-Google-Smtp-Source: APXvYqxdMI5VSNUoJ+yKG6kQmlYRMC3CiuCKrjMQlQq9/h4dWiv7toPHh50MUSTZRL322167nEWcAA==
X-Received: by 2002:a17:902:848b:: with SMTP id
 c11mr127291371plo.217.1564692061384; 
 Thu, 01 Aug 2019 13:41:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w132sm75027026pfd.78.2019.08.01.13.41.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 13:41:00 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190801183012.17564-1-peter.maydell@linaro.org>
 <20190801183012.17564-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9b189020-f450-0f3a-a5d4-c073bc1f133d@linaro.org>
Date: Thu, 1 Aug 2019 13:40:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801183012.17564-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH 5/7] target/sparc: Handle bus errors in
 mmu_probe()
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/1/19 11:30 AM, Peter Maydell wrote:
> +    /*
> +     * TODO: MMU probe operations are supposed to set the fault
> +     * status registers, but we don't do this.
> +     */

Well, the todo should be using sparc_cpu_tlb_fill with probe=true, since this
function appears to be otherwise redundant.  Of course, there's currently a big
fixme for that as well.

In the meantime, this does one step better than before.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

