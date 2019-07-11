Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344E5C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0051420872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8rXvL3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0051420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYqA-0003gn-BB
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36570)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hlYpf-0003Gq-Mc
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hlYpe-00008y-QE
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:09:55 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hlYpe-00007k-Ju
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:09:54 -0400
Received: by mail-oi1-x241.google.com with SMTP id e189so4385872oib.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VRPkD0l4/L3tMngwP4IRFkO6jRwiBrcTsnuRwAScetQ=;
 b=X8rXvL3+4PfDnm1W+FEhkf9ir70htdQvYhCXKPIukaDKHf2xaCSip0uaS1aWkZUpO0
 AbNSYJ5ZEboujouxbnJSv1O3VWFvXuh1bqrDl9IUR0aKINgYrBSsL6KTBAQp5lMu3EzZ
 09gzKmZ6Hrm03RgiZyVQ5iicJsBAcWMkJoSskpiQwqJIwCn/HA/drJuqzlhRP3OIpxGq
 dCBJNJLkWpZm8XDGdQ1NNfx1CSqGIdwfeNS+8yUYVSMk4A4ugjIBrCRLUOqmYwCIesVn
 Tli77ohVaP8/RQEo3k6Jke07oTcmS/Rqi0TmFW+Zkldw/i270lBkepi70q0S/d9NmY/F
 ruqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VRPkD0l4/L3tMngwP4IRFkO6jRwiBrcTsnuRwAScetQ=;
 b=PKfNyo4yYAwt2X524fCNVWpVFCi5wQ09wqCX8JbUc/yZ/y2SOlF46pkIaXBx8iNIEZ
 1U68eGEErWST+rvGspurewd80JRyFdSICortefvSzr7c86W2kyE+K1bFFYwdvzaKkAKD
 hA4wThTgrJuDNCROknx8yDgpeWG+ra/kZR+AmwkuoMk4xDPGFp/iMl6NfOlBkvy9JE3Z
 HJVep2PCK2IAU0alJ5ktTqEmWoG/vLmKBl8q4qVu2zZh2MteQuLFuJMcR+x8/MG2VKE4
 LBkLH5FDqzdB9kG0vQOaPDGBCZevKq9GbooQet91/X0aOo0DhzsvLuMpkPtTHV/cBKN5
 18Mw==
X-Gm-Message-State: APjAAAV23o65DZWO2TUMU1onVh8Xs5n9WLSpz+JSY/KxBp9foPdczOoe
 vaGZZ8KCzeyARg2uQ29/4MmRaw==
X-Google-Smtp-Source: APXvYqzaJdfBSm9TQt3vlwoEGs3G/DvNXUqMRjq+IH215WyuU62sJ8M6fiB+KbGNbbWom4U+JETPlA==
X-Received: by 2002:aca:5e88:: with SMTP id s130mr2372264oib.91.1562850593571; 
 Thu, 11 Jul 2019 06:09:53 -0700 (PDT)
Received: from [192.168.43.94] ([208.54.86.238])
 by smtp.gmail.com with ESMTPSA id o82sm2013640oig.27.2019.07.11.06.09.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 06:09:52 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190711130546.18578-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <63c350c3-235e-9ef6-b9ae-2b7a3f4adde2@linaro.org>
Date: Thu, 11 Jul 2019 15:09:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190711130546.18578-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH for 4.1?] includes: remove stale
 [smp|max]_cpus externs
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
Cc: Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 3:05 PM, Alex Bennée wrote:
> Commit a5e0b3311 removed these in favour of querying machine
> properties. Remove the extern declarations as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Like Xu <like.xu@linux.intel.com>
> ---
>  include/sysemu/sysemu.h | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

