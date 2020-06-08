Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6E6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279902076C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vn/bUxQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279902076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIbH-0000ST-Bu
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiIZg-0007mR-0e; Mon, 08 Jun 2020 10:16:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiIZc-0004Je-4q; Mon, 08 Jun 2020 10:16:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so4311099wmj.0;
 Mon, 08 Jun 2020 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nQPhz2+YJjCsPg8otnfDg7HceVgU+CdwJ3mFw2gnVCc=;
 b=Vn/bUxQ1xcQV7tS97fTg/0mPAIS8m/t/cEt9qQDqBg0wdQ8y0k/yPu9IVfuW26Xr43
 wpPjxjhfUWNWGr2jMTO/aZjVm8AFrFNhiT+QETES4XwJuKueJVlQYezCqWLlDuRT0+O4
 uHAueateN6Lc6H1rIC5p3TfEsoverMQ3cuqoHZu0MAQ1qAbANRzz962TIA6VzFnms/25
 gpSBm40EarVvNjmWJqGWYvbWIqKgRUrfwSQyU4Y5/cL25Vf9ftekfKFDXEMGtqfqkbHq
 WNM9BjSwTfhIhbN+7zCeRf+XVLlFITkIhR3IeTkYcJVTnjD74B8dGF8dnl+cv/SP/Kdk
 uNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nQPhz2+YJjCsPg8otnfDg7HceVgU+CdwJ3mFw2gnVCc=;
 b=qCkx4j0m9cbmX9bhnm4Pz7VqF59OWoW9ij2QLbjuXmqzSav5SwHcuguXS71qQxYjpz
 hOYIC7DmEt1IOylzgcAlCCUbDDm119tSYqrRYnRfZTfFyRHAKtduQ7AyhNYt2mk01J+S
 vX/fOeum4fT1JsO/YeCaqAXwXNqLxLCY0fR8EHFs+YjNatpFuz9LysGJh5OrtWdGzJII
 5tqO9AEFk5vh0flSbE9hKvMVH4ca3H3NX9P6Q5Dk79BeUNp2o38Zcf8xUWHHGMFT1kUM
 S7NH6Tv2b7ywNosjc0HxNyotbeBiFO/rGuA+8jHHsLT/sY+hQtflPuXJlpPU8VcREVUR
 U4vw==
X-Gm-Message-State: AOAM530mftspJ7TKFaEiuw5qZvwd2Zlby8hfM0s1NJPE9Iw3td2sMmbP
 L9KcqSrimueK82UYCvQukKc=
X-Google-Smtp-Source: ABdhPJwYlF0vPvTKeSACta2NaIpybHaUAKaUZEfn+Bi0azkkozPM8pvCZMkO93JHE3xtFSijqtS6XA==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr17742538wme.65.1591625782334; 
 Mon, 08 Jun 2020 07:16:22 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q8sm5290542wmq.1.2020.06.08.07.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 07:16:21 -0700 (PDT)
Subject: Re: [PATCH v2 02/24] display/xlnx_dp: Fix to realize "i2c-ddc" and
 "aux-to-i2c-bridge"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a64bd91c-58b5-1438-a401-5d6c04441c67@amsat.org>
Date: Mon, 8 Jun 2020 16:16:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528110444.20456-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, pbonzini@redhat.com,
 KONRAD Frederic <fred.konrad@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 1:04 PM, Markus Armbruster wrote:
> xlnx_dp_init() creates these two devices, but they're never realized.
> Affects machine xlnx-zcu102.
> 
> In theory, a device becomes real only on realize.  In practice, the
> transition from unreal to real is a fuzzy one.  The work to make a
> device real can be spread between realize methods (fine),
> instance_init methods (wrong), and board code wiring up the device
> (fine as long as it effectively happens on realize).  Depending on
> what exactly is done where, a device can work even when we neglect to
> realize it.
> 
> These two appear to work.  Nevertheless, it's a clear misuse of the
> interface.  Even when it works today (more or less by chance), it can
> break tomorrow.
> 
> Fix by realizing them in xlnx_dp_realize().
> 
> Fixes: 58ac482a66de09a7590f705e53fc6a3fb8a055e8
> Cc: KONRAD Frederic <fred.konrad@greensocs.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/display/xlnx_dp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 3e5fb44e06..bdc229a51e 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1264,9 +1264,13 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
>      DisplaySurface *surface;
>      struct audsettings as;
>  
> +    qdev_init_nofail(DEVICE(s->aux_bus->bridge));

Eh??? Why not realize the bridge in aux_init_bus()?

> +
>      qdev_init_nofail(DEVICE(s->dpcd));
>      aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
>  
> +    qdev_init_nofail(DEVICE(s->edid));

This one is OK.

> +
>      s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
>      surface = qemu_console_surface(s->console);
>      xlnx_dpdma_set_host_data_location(s->dpdma, DP_GRAPHIC_DMA_CHANNEL,
> 


