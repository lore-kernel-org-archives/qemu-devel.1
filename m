Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F5DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E879C21775
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="JYX2emAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E879C21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMnxW-0006ny-KC
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 03:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kMnwK-0006D4-Dn
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:51:16 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:36624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kMnwI-0000kJ-Mt
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:51:16 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id F35DEC60F18;
 Mon, 28 Sep 2020 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601279473;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzkNYpo9QAUmO/3+bAy8uQ8LMISulQPvdcm5BDjzhSw=;
 b=JYX2emAu8QWzUjJmz3FliDqbQVy+BdSQ43O/3DSHx8b+TO3Q4qP9Lh5au6fhO/cyiz6m6K
 +NH3PstRqtRdtWWrmTMM0xbTo2qbKsElxRQKqxh3AhOJdujjinLtRMktnd07MXeqWx7cYT
 4s7RKNobaYnnOfZ3xcVNfXZ+qS3YlAR73O0/+8eqs2o8nLXuzF+oqDDENsvM6xx+DUfUeH
 wL5gEp5vCvciCuIR6kffw5nGJNq4klWxafZVNJcnZhYStzU/h94L+yNOtR4xgJCYy/OTki
 ktqtxr2fN+iAlmOlJzonoUKj7Kg1dKjmtHqvdYJ0giA89iTyE72UzWLT4qVF5Q==
Date: Mon, 28 Sep 2020 09:52:10 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 2/3] qdev-monitor: Display frequencies scaled to SI unit
Message-ID: <20200928075210.u6vh4py7vtozpbyw@sekoia-pc.home.lmichel.fr>
References: <20200927090820.61859-1-f4bug@amsat.org>
 <20200927090820.61859-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200927090820.61859-3-f4bug@amsat.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601279473;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzkNYpo9QAUmO/3+bAy8uQ8LMISulQPvdcm5BDjzhSw=;
 b=enEKWaf6WZDlV174yQl7zojZ5ZHB142C6DnderCYJbfysCxZmn31SlXfXZ7aSoM4km/dXL
 Ed9bCkp1w+OJFYlb49vDoNawcr8bxhkiuueGaZIZu7TDRSO5sxXIvI+IRencHCvVDPyEKk
 m9UyjvTmBp9wob4BQIy+XDxRX/2Sc1d0a53MFkHwCBS0OPA/kg2BXhk1T3gqXMEEP1JW0l
 fW0y6bgsz3/CO6sL2jK21vsya2IlxPZVEQpELE+WZBPG+girhOlDj0eXAT8xkakSZKFWFM
 xhJ07zU7gyy58CDYYsodhbWEa7l1NF5poClJDtUQVdxIrUjtj+do4TYSBQSRZQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601279473; a=rsa-sha256; cv=none;
 b=WEjz6dLvJZqYWYgzfeFBVMK9R2/WXBkKt/NLld1kYEVvgT8Qk8KJIyPve/zbQyNp0RckPY4+tGcCRI/oYGRMTjinsi8W6C/Oc3CbJxOkQ96ElGetK4qurmgDJsWzXPoXQu8Fah8Zk3VZfPJ67825Djts6ZANWUef7nq4FA2JMpW406sZOr/rAvCXFXe1JNuHU9yPmdP7QfBbalT8DSYBFJgWaIUnRtCkDdFB0jBX9maxfsGkCxZB8l0KUyvaUEI77L4s9CB00yqosgUz4vDzRTOBJKdSjBVFnu8mAd0N+j61MRl/XzgKIAZ0r0hvSW+DNVvFg97eTI/f9tU66fL79g==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:49:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11:08 Sun 27 Sep     , Philippe Mathieu-Daudé wrote:
> Since commit 9f2ff99c7f2 ("qdev-monitor: print the device's clock
> with info qtree") we can display the clock frequencies in the
> monitor. Use the recently introduced freq_to_str() to display
> the frequencies using the closest SI unit (human friendlier).
> 
> Before:
> 
>   (qemu) info qtree
>   [...]
>   dev: xilinx,zynq_slcr, id ""
>     clock-in "ps_clk" freq_hz=3.333333e+07
>     mmio 00000000f8000000/0000000000001000
> 
> After:
> 
>   dev: xilinx,zynq_slcr, id ""
>     clock-in "ps_clk" freq_hz=33.3 MHz
>     mmio 00000000f8000000/0000000000001000
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc@lmichel.fr>

> ---
>  qdev-monitor.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index e9b7228480d..a0301cfca81 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -747,11 +747,13 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
>          }
>      }
>      QLIST_FOREACH(ncl, &dev->clocks, node) {
> -        qdev_printf("clock-%s%s \"%s\" freq_hz=%e\n",
> +        g_autofree char *freq = NULL;
> +
> +        freq = freq_to_str(clock_get_hz(ncl->clock));
> +        qdev_printf("clock-%s%s \"%s\" freq_hz=%s\n",
>                      ncl->output ? "out" : "in",
>                      ncl->alias ? " (alias)" : "",
> -                    ncl->name,
> -                    CLOCK_PERIOD_TO_HZ(1.0 * clock_get(ncl->clock)));
> +                    ncl->name, freq);
>      }
>      class = object_get_class(OBJECT(dev));
>      do {
> -- 
> 2.26.2
> 

