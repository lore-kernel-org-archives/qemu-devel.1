Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923EAC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6445720866
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZak5Xdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6445720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbGUt-0001rG-D2
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 23:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbGSZ-0000gp-Gt
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbGSS-00077K-Bh
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:31:29 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbGSM-0006yE-TC
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:31:21 -0400
Received: by mail-pg1-x543.google.com with SMTP id s27so10082353pgl.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 20:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZVCoWNNGLE+wNXJ1vPubVCIfZmqAF8Xo0StWjJs6VgY=;
 b=zZak5XduAvaxGfVX7ZXtNF4q0+d/XRm4DAnlT1CcgLfPHdaJPyonOXWg+ZiVcpr8aM
 1Mh8PVl1EqCUvkZgQNq7PfklQJHCNHYiAEs1ztVGNTyCrEeCQcS6AHT6KyH8lRaJ+XHL
 Hp+7YcKSYkH8avtmrGmhvgrVp3w5Te/Unleo3RpuWdQqMMsUWBMlDSVozIOit5G9gP6u
 l2yjFVzOATRntIP2vmzGivwJWv1g1CqVFPOa0NTfqKFd5S3qaIyX5Wr63m2x2fE3kagt
 lLVyoHSiKkD3KvLlIMVn298jRKLb9HDIzHx1Ft9JZzIDroI6QgjNT/xGcboFqx1MhpvO
 y1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZVCoWNNGLE+wNXJ1vPubVCIfZmqAF8Xo0StWjJs6VgY=;
 b=qcXFcwX6VoDlZPZTT5yio7o5FlvuEADJLPRml50rsJI/ROpt/joJ0kFOaonkCRW3Wd
 i1bouH/9XHA/KPIcDWt3RNmMVX99Bs5G6OuT+MTgjHK2OmTDBejWvSFXJvsuKg36Qmnw
 XdAgfRWitsxwt9NXlDyU+UUiy5a1a+nJpnP9tgukozgOESLaNaJU2Q1uktchrdlo1olS
 JOa05vCoiXGxBTsOQRLLjHtFbsGJbzWATS3mjIZJoyNpmU41hOZqjyJbo48o/a2+xfro
 qJMLGywMmZfjm/lnCXBmExbg0FHKFe+J1KCsH4KQzSB64TCCUS/2NKBLDgFMwBdSUPcG
 VFkg==
X-Gm-Message-State: APjAAAWTjFQ3BzoVyEnOmdt2f6i+db1ZRc9ORCviCROICJeOdOa6lvGO
 8NtKQEFPyQMs2LhMWy1KiYAGvw==
X-Google-Smtp-Source: APXvYqyrt08m4UZHAVaWjmNVcCOl8xGq4f+ac3kLHhPu3mALKTJiSGyviUugyblzVqZhtnv+KAGi3Q==
X-Received: by 2002:a62:2ccc:: with SMTP id
 s195mr26999378pfs.256.1560396668655; 
 Wed, 12 Jun 2019 20:31:08 -0700 (PDT)
Received: from [10.1.2.220] (50-247-96-158-static.hfc.comcastbusiness.net.
 [50.247.96.158])
 by smtp.gmail.com with ESMTPSA id e124sm995491pfa.135.2019.06.12.20.31.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 20:31:07 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
 gkurz@kaod.org
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-12-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <75236c0c-861f-2168-1e28-e5b6ae92855e@linaro.org>
Date: Wed, 12 Jun 2019 20:31:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602110903.3431-12-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v2 11/15] target/ppc: introduce
 GEN_VSX_HELPER_R2 macro to fpu_helper.c
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

On 6/2/19 4:08 AM, Mark Cave-Ayland wrote:
> Rather than perform the VSR register decoding within the helper itself,
> introduce a new GEN_VSX_HELPER_R2 macro which performs the decode based
> upon rD and rB at translation time.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             | 30 ++++++++++++-----------------
>  target/ppc/helper.h                 | 20 +++++++++----------
>  target/ppc/translate/vsx-impl.inc.c | 38 +++++++++++++++++++++++++++----------
>  3 files changed, 50 insertions(+), 38 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

