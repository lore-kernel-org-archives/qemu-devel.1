Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5154C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154B6206DC
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzq1OLBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154B6206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbuWs-0000dJ-7Y
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 18:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuVd-0008Tt-4a; Sun, 08 Nov 2020 18:54:09 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:34952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuVb-0003Ga-NC; Sun, 08 Nov 2020 18:54:08 -0500
Received: by mail-wm1-x329.google.com with SMTP id w24so3896508wmi.0;
 Sun, 08 Nov 2020 15:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EiRykMvGapgWFvo7/k8wqIat1I7qQzXQJe5wbS5MoyQ=;
 b=Mzq1OLBD3Nq8DN/wFuAIipsc5P0CQL/3HVpWVV5ZvSHGncK5shIUMZHGPu6oSagl5O
 oWPmvXSEZ4JUs0gtp27/HZd+ITTa3hUtI/bMDWDR8g0LHpoH+zCrwI5APcxAYecGFE95
 T7kP9n3O6y1zmzlySX/Nh0smsRK5yp0mUPzK2HOyz1TQSam4DCH5PLBCxx8PzLlrSV9H
 zMpxxWETgCEWe1OM4MTntt4OvkSb1ETutfzsShoPnYdzLL54PelDlNah5Xiy22RrhdCa
 9AMkLBZzH3HGQRls6P6D02R7iPbOCcH51ZQNLxlc1YjrfcOXT2e3rz/D+FX7uxDBcj9/
 nR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EiRykMvGapgWFvo7/k8wqIat1I7qQzXQJe5wbS5MoyQ=;
 b=W6rbgJcnTDqxvffksRZQDyuj7DGsSSxKE1ookYedxT/z43bvDKk7cAjQh+6/ok/sTh
 NW4DhAMZcSaOd+sdaGdIc3V7YtNOPpM3Xg7Ub2TKoRSilFM9/xcejxQ2Ywm7euunxf1r
 kqo7b2t4RTfXU6QlImwx8J9EGKpgfH6uZT/cZlbhcJ5v0EE5jtIhgSyLmf7iEXxiyNUH
 MgT7hU1qaMaUevSQUyDLkl1Ht/14uZcupp5wPzZ7KdJ7YmItwOs19BKbi8j1aDLGynIr
 6w1zRY/e464naa1XoZh2jhpEMW7x+ZmbD9JkOVuG+CWgHniCAz9CaMYzl3glh6cGvVy2
 vF7A==
X-Gm-Message-State: AOAM530vGd3+o5G7GddJKUFXf1c7gvCBBJlFsOo8YQFdbSnSPwWqVDxU
 nU0+jAiwUGeC5A1QIRwlRJQ=
X-Google-Smtp-Source: ABdhPJy3Zrgi0pvwLcJ4zHsyayMwhDaXWnmoV/yVJjhadfPmHhWD3DyhryZ6wr01a+hZb+OokKtXAg==
X-Received: by 2002:a1c:a402:: with SMTP id n2mr11619519wme.121.1604879645717; 
 Sun, 08 Nov 2020 15:54:05 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b14sm11453994wrq.47.2020.11.08.15.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 15:54:04 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v3] hw/rx/rx-gdbsim: Fix memory leak
To: qemu-devel@nongnu.org
References: <20201102104542.2064745-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f758afbc-7d64-6531-7a6d-a23a3f1f3771@amsat.org>
Date: Mon, 9 Nov 2020 00:54:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102104542.2064745-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 11:45 AM, Philippe Mathieu-Daudé wrote:
> As load_device_tree() returns allocated memory,
> we need to free it.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Fixes: bda19d7bb56 ("hw/rx: Add RX GDB simulator")
> Reported-by: Coverity (CID 1432307: RESOURCE_LEAK)
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v3: Directly initialize the variable on declaration (Richard)
> ---
>  hw/rx/rx-gdbsim.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks, applied to renesas-fixes.

