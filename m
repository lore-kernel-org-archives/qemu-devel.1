Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A500C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CB82070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPclAfAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CB82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEhR-00062y-J6
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUEgZ-0005A7-8e
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUEgX-000142-Hs
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:17:26 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUEgX-00013o-4G
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:17:25 -0400
Received: by mail-pj1-x1044.google.com with SMTP id fu13so1213773pjb.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ocF9rC9ET/lEsaC91xgiehH5tSx7QGIy5IpQgb+bGmQ=;
 b=YPclAfAs0q2yJtqfl1q2XgsBxywEe7BHiBgMP/c9RFfNeR+SA25ThUbhQovvQ20oZD
 gWaYD024sp+0IbRzLmFpFnORYNDyA7uxEzJJI/v/30npvZ7rv0zwtumA+Fv/lElgXgp2
 3jfyNF4ng6lPrk5WFgt8DrcTdUrvmt/UI8IAN7W04e/ef+HsR/YEm7JW4JmbEdQhKVeY
 WYizzvVpBuzpT5YAKcdYhpzWMLTI4ycwLY+p15CsSyNhXl5tKMv7I4ZyQTG3Y/mAl+F4
 CLerd1zC9+IRVFg4vcxUpCZi77f0DpmwzRB8768N8MMJF408/s3zRcrF+VMmj0oP9Lom
 WPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ocF9rC9ET/lEsaC91xgiehH5tSx7QGIy5IpQgb+bGmQ=;
 b=evxWfjFkf3T5E+IKjFVIzg3BnDGHwl9hXRvCr3F/NbMTxsbffkwd4QVMPe2DwWpFtF
 qgndf/YeeLaj8GBSyV0FzCCvhhH16DRhBc/49zDiUt0JKjycWQFhJ+3nLIhhktHcViiZ
 IhQ7w30njSkzRQ0pWNbp3/sZqQF9kg4T17DlGjhSVsoeR/+uN8+GUJKxk0IdbipHMDOP
 9bolB5OT0Oo1gAtsS3rHoO82uIZ7rou7kw6In7bgnH6EB8n94A41GeDEopyAL/nEUH+z
 BfA73zRF842P6lQPsoRLB7PuRSNTPDPOZEwZNXw4c9s50J6ntymTim19XMi0nZe7Wmw1
 WhkA==
X-Gm-Message-State: AGi0PuZGJMBgk66yH1mrBRSa2wq2XQ/pBJfzdjA94MlesjEypmUgOAAb
 3VlZFlP7ON3pj4mbcD1egYkAt9pyC38=
X-Google-Smtp-Source: APiQypJ41ye6J5qgW2lyYxcue2P6v3AAjmdj8Zf5V/rhuJnOs4Lh5PDH54iMQ19APUQXjG4YB95yUQ==
X-Received: by 2002:a17:90a:f2ca:: with SMTP id
 gt10mr336019pjb.160.1588274242953; 
 Thu, 30 Apr 2020 12:17:22 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j23sm473953pjz.13.2020.04.30.12.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 12:17:22 -0700 (PDT)
Subject: Re: [PATCH 12/36] target/arm: Convert Neon 'load single structure to
 all lanes' to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a07b71a-54e9-61fe-2972-5749a7efa86a@linaro.org>
Date: Thu, 30 Apr 2020 12:17:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1044
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

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert the Neon "load single structure to all lanes" insns to
> decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 73 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 55 +------------------------
>  target/arm/neon-ls.decode       |  5 +++
>  3 files changed, 80 insertions(+), 53 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

