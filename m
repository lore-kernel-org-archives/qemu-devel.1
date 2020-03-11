Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40388C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DAD5208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maRWPSEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAD5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBusH-0004TR-7P
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBurU-0003Ny-FU
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBurS-0000WN-QA
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:00 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBurS-0000St-J8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:28:58 -0400
Received: by mail-pf1-x443.google.com with SMTP id b72so710414pfb.11
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qwPEcdtCn6rxAwMSxRA6xEedpRlfzR6nWjibbbU7Mb8=;
 b=maRWPSEYj+2wCCT1oSXlQt4OTPvXhDpiNuSf/YkwmKnWor4KBppNg+IYUIzOHFFeKZ
 OVY47jXbrm/I40Y9J9pvYxqHl9GnHHQlOLb14PAIELRFoKEUrDu9ECyK4vHyss2SSzk4
 cSMbhAiYkO2/m18s1S57eY3oKe4UdSM6YGWGAdUJeCwXbIA2QbUatFNWcyj2no24EEcK
 QLSBmzyX6RyucLWficRLfPqJayDb0eA8mvpIIe9TX0XZLDPWhYdDYbov/noSzvmOIeo3
 eyI8mJKPeVIROw5wg3FMFa8PB56iFNiXJDlSim9Dd8wU4NNW59W8OcffiedbdtoQFr4I
 hdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qwPEcdtCn6rxAwMSxRA6xEedpRlfzR6nWjibbbU7Mb8=;
 b=MFozOWYvCO5vy2AXKbejwJUTJfs36xaV9kN7Viaexqmo8Gg9BV16dTO8noKSy8Pfmk
 msydo2K7nfJcl2Y80A8k6VkMCyAXsnqGYC2dAZOZdTkTVlZhZW/KyJzoBBpYhK1XShWl
 7L65hXEcNbli+uLfifAYfgZZxj6A6kowJmXHKtdwQR8odLnVRK1XBmfZ0kIQfJL81+Zf
 uY3mxl4n0ZMavsR2blgUMbIcT6IyyyaOBs8CZ2q7OCiU9fqULmJBW6Q+gj3me3TK2iIw
 KHblQnvZ7zisPsUXfx+uAf4wREMXzdkuPSA5Xg/yg2x/QtAX65imXyT71M718NFeqN/k
 +sGQ==
X-Gm-Message-State: ANhLgQ13sNeSHkDty46RaR4dSCpvaqHpEuOsWArPfTxfcyyljU/1Fbl0
 WmQMAPBMKYbanDq2KBNxLo6+5A==
X-Google-Smtp-Source: ADFU+vt0rL/jJ+6Sic1o2SwIy0Va87mLJAzRK6V7x2SaadBxJWmhHbDWtx6FlA0t3UK+E/ENA4+sYw==
X-Received: by 2002:a62:2b8a:: with SMTP id r132mr1373513pfr.56.1583908137167; 
 Tue, 10 Mar 2020 23:28:57 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 h198sm4047848pfe.76.2020.03.10.23.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:28:56 -0700 (PDT)
Subject: Re: [PATCH v4 12/18] scripts/qapi: Remove texinfo generation support
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a710471-7a7b-1b5a-2365-cf25bc5283f5@linaro.org>
Date: Tue, 10 Mar 2020 23:23:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 8:43 AM, Peter Maydell wrote:
> We no longer use the generated texinfo format documentation,
> so delete the code that generates it, and the test case for
> the generation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile                        |   1 -
>  tests/Makefile.include          |  15 +-
>  scripts/qapi-gen.py             |   2 -
>  scripts/qapi/doc.py             | 302 --------------------------------
>  scripts/qapi/gen.py             |   7 -
>  tests/qapi-schema/doc-good.texi | 281 -----------------------------
>  6 files changed, 1 insertion(+), 607 deletions(-)
>  delete mode 100644 scripts/qapi/doc.py
>  delete mode 100644 tests/qapi-schema/doc-good.texi

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

