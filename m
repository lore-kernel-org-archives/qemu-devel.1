Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A3AC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 21:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF8B207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 21:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="burMxYP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF8B207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcydk-00079Y-Oa
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 17:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcycX-0006JI-ME
 for qemu-devel@nongnu.org; Sun, 24 May 2020 17:57:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcycX-00077V-0f
 for qemu-devel@nongnu.org; Sun, 24 May 2020 17:57:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id h4so13716292wmb.4
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TWQ3+or2RRhTWhxm4VTX9bqSveuuL2t7PhyX6jhqZHI=;
 b=burMxYP9D29NvWW3twM6ZVDmihRMtHQQC8niS42cfKEdNT7ww6qeVxtKemlDJLgbsR
 JrWBoa0h5/lcxq/96eNx82eCyu+lhyRrzSBQuthLmu146osKR+D1TyQbHO17rAF8Swyh
 PRr/0j2BnOUxc+P0odx8g1238xcPjz7gPKmNjrd8gO/0dHfZ4ReUwHN172k599KfQU9h
 u2GV5kEw++NPZqHyWcTsbDWyszNBX3+NAIW3nGV0fYCUZnMxvcZK45Lj2Le8cUVY5qn/
 kucNVy5XTIXdgz+NNy2G4i81cB83+EtiJE3WoRdmeAAWfEt8CkKYb9yHIWDG6EQyN+M8
 WT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TWQ3+or2RRhTWhxm4VTX9bqSveuuL2t7PhyX6jhqZHI=;
 b=Bivp27p8RNXD6BdoHlDQWBh/lY7bz7Way+LrzsBKD6wnzo67lJGrMK0WLmegIYVLqG
 D5XRy3nQsGEtWThuI1wQTbAUG482jDShxbvEnGCbCkHMDYNhzmLluf90zRZVpOJnO5Zv
 iT1pecbVrq7HcZabvuxlr74csM9AsfKSY+sSpTnhAGHaZE+ws9ldUMftOo789y08Q2l7
 ik/M/wLmPoJWYmUPTxaMYnbg5UflH6GGLjN7LuDS6iwYEk9ImErxa/w/OxCudlP88k8B
 /i3RP3QWPbiHwUX9HnQL5KU2tUOlNeVPVHrT8mlNL6qQE3UQa6CMp7BqZOV5SdZTbcCH
 j+PA==
X-Gm-Message-State: AOAM5313Yf7qNTKK8apdxU9blWz8Ayc/CclAv24/yH59bPCIaAg/F7ZV
 Su43GkA15PGszWrWZAqLO7I=
X-Google-Smtp-Source: ABdhPJw4mohShTLum8956Pai1Wzd+X0DsFZSyFy4rBBEoxhlOtrvH3lbAZrjr95Pym0mxrlYvBHQ1w==
X-Received: by 2002:a1c:3d83:: with SMTP id k125mr12995537wma.61.1590357443742; 
 Sun, 24 May 2020 14:57:23 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id s15sm15969916wro.80.2020.05.24.14.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2020 14:57:23 -0700 (PDT)
Subject: Re: [PATCH] qemu-plugin.h: add missing include <stddef.h> to define
 size_t
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
References: <20200524202427.951784-1-cota@braap.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c72d1b13-5647-c691-d80d-2362f1abb306@amsat.org>
Date: Sun, 24 May 2020 23:57:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200524202427.951784-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/20 10:24 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qemu/qemu-plugin.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 89ed579f55..bab8b0d4b3 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -12,6 +12,7 @@
>  
>  #include <inttypes.h>
>  #include <stdbool.h>
> +#include <stddef.h>
>  
>  /*
>   * For best performance, build the plugin with -fvisibility=hidden so that
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

