Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A142C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E46204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guA7WTLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E46204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCTB-0000G1-HT
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqCID-0008P0-M7
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:11:05 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:41171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqCIB-00047K-4e
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:11:05 -0400
Received: by mail-ej1-x642.google.com with SMTP id dp18so19751421ejc.8
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 02:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YnRbQF4CNsI2LpFOWlrWsgpBsgv3+NtZOnnvfk8bn/Y=;
 b=guA7WTLzylFdawBiPBZ0i7/3sfcGKlgYw8MkbXtHgOvv0DLXo0sNd0bdRgaQKG1KsY
 S7ZhzK6Amyc5btP6gi2AnyEiHMYJQqYUNqoFUUz7i9oG2k4i5cByaUw5zse7TL3CBoC7
 qjdOl39z1T/7oCeWE6yiS+sfKKF/bLgBHFMrWTYXQigtqCQk2PL6B31CMWYGAKN+Hhh7
 KuFHW0SR0so3I/BC4xcL48HAdkUxrHQOjkuQsNe4Amo0sicm+HYN+enOIfO9Bc3CLktl
 9KheXNFOfdRRy+6rFZ0iQXemUPhA9rX3ZZ1udEoxNLInhIIHCQW2CnVcZL5I+iUkxLaB
 dYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YnRbQF4CNsI2LpFOWlrWsgpBsgv3+NtZOnnvfk8bn/Y=;
 b=IVdwwHnQKn3I33+XcYA5WQfBpkhIz1plqXpKfYC1f4PaSEgm6q3K1bZslKy+AZXSGb
 rR4JWYaWWt/VtAOx6F5bxT19IKF0Lw1MSKlsypFZ6KcP+LSEdt65Y1N6RqAzfK1D2l+6
 GWJIN8ZF8VNj5AAU1QmgfV6+Cg9icUQTCR5M7fkIK0NyMRZEtYoLntc+Bc45PcPe1+Q3
 IZJzWLQftqSxGuuJavNf5Y+l96ZJSJiYD6Qi2tKMgAklqEqhmGlaQNWYviO/xsgADpN+
 m+buFci7VtDZ9B+hynEUMCelkh93m2yMiCJpOrr9srdq/5VXswkwWi6uzI4Yh+Ihv87X
 Z2HA==
X-Gm-Message-State: AOAM533lqD0YATkxAgbmlEUzQZacGsBQeW5kXTSRDCgf8cSBHalWZzwQ
 9sJip6CRLnE8oEHubGdb4hQ=
X-Google-Smtp-Source: ABdhPJzVrj5XleWDNdvtqx4kfPRHfdd7PtqbbD/Tgk+7VFq/HuVwWTsPNRgBhR2egJLHaLMc47RZOQ==
X-Received: by 2002:a17:906:a058:: with SMTP id
 bg24mr17600182ejb.370.1593508261048; 
 Tue, 30 Jun 2020 02:11:01 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w15sm1527813ejk.103.2020.06.30.02.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 02:11:00 -0700 (PDT)
Subject: Re: [PATCH v3 09/26] sd/milkymist-memcard: Plug minor memory leak in
 realize
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200630090351.1247703-1-armbru@redhat.com>
 <20200630090351.1247703-10-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <70dd1d7d-a0e8-17e5-b3c6-27fb74b91d69@amsat.org>
Date: Tue, 30 Jun 2020 11:10:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630090351.1247703-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Michael Walle <michael@walle.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 11:03 AM, Markus Armbruster wrote:
> milkymist_memcard_realize() leaks an Error object when realization of
> its "sd-card" device fails.  Quite harmless, since we only ever
> realize this once, in milkymist_init() via milkymist_memcard_create().
> 
> Plug the leak.
> 
> Fixes: 3d0369ba499866cc6a839f71212d97876500762d
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/sd/milkymist-memcard.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 482e97191e..afdb8aa0c0 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -280,9 +280,8 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
>      blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
>      carddev = qdev_new(TYPE_SD_CARD);
>      qdev_prop_set_drive(carddev, "drive", blk);
> -    qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err);
> -    if (err) {
> -        error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
> +    if (!qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err)) {
> +        error_propagate_prepend(errp, err, "failed to init SD card: %s");
>          return;
>      }
>      s->enabled = blk && blk_is_inserted(blk);
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


