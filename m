Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC401C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 05:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B0520801
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 05:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpCh1YWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B0520801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiWe3-0005As-L8
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 01:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiWcB-0003r4-Qy
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 01:16:00 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiWcB-0002Dd-1d
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 01:15:59 -0400
Received: by mail-wm1-x342.google.com with SMTP id y20so1721060wmi.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 22:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HX/XdRyvdypmXRxobImabXdzT7x1leojbDlrm7TINug=;
 b=fpCh1YWGwz72Z6dR8PEfYq4WOEJsUAvXU84QpFwH3jSxo2A0h2eTfPP2bfmRCP9h3L
 m+BhlZK6Xalh+RfD1NIgyZvCAtz62Q9Snu2jeUY92T47wEd53TqDZdmWqV0rc7ccPyRi
 OeVIy0aFN9k3EkWh95X2DuyQLompzkKgxtUQ33hWWLkPmcKdFveTDqBjQ4915hIzawv8
 aGBgu/HBzk0oy4olqLe2MV7IeMWYC/lZmz6wpGdmv1qX4VRrZzl8sXVK1rd5z6Io2gal
 S08OwJMu17hB1WVGTWEjqUF7BX0WBrcDGaLUREUDZuAH/9vaS1kPtO5VVmGgxOFk3QEY
 M4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HX/XdRyvdypmXRxobImabXdzT7x1leojbDlrm7TINug=;
 b=nK4j54les7n2Ph7cTT1PE1OxSS6qqeGA3kWyDHzYvvDkOgTg1+QBA0vCS0WQBISVdb
 QNLu6sVVcESyVzbOvSov27zj/GnA7OoGt5YHCS1WMtLo6OwxOmgY3+tOXHFogMsYgLK8
 Y+2b3L2sJv6MMd6kKqVDRio3thispWMnkA8FlhfeFWPXj72tzTOUSwPP2BWNjGAdiHlb
 OqSFvfm2BBCpQPBZqIfbVU6mf1HDrWzuRG75CvuaVck0NOQjO4Li0dmKYD1tDxFXar1s
 6gIcVk49liyWxt4oA0i0vqs0yaXkAa2V7vHX28aBpxu9xcahj3Q/k1qswqL7WY0SWQDk
 im6Q==
X-Gm-Message-State: AOAM531pokBn1uNV4ivI2RcjQxVJqnCq1Grb03C/P8vQBcZkMeedp0XI
 7zvovFJhy5TV9u1PRsCJzleO3to+
X-Google-Smtp-Source: ABdhPJxYjH787X0XR4OpaARMwiVW08rZITLwO9TdnCRLv3IKCwo/ufJ/RaQQg+fY+u/v8txbS7sbVg==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr2150398wmi.165.1591679756917; 
 Mon, 08 Jun 2020 22:15:56 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id d191sm1582280wmd.44.2020.06.08.22.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 22:15:55 -0700 (PDT)
Subject: Re: [PATCH v2 21/24] sparc/leon3: Fix to put grlib,* devices on sysbus
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-22-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <378a35f0-8d21-a08c-c661-c13d06918249@amsat.org>
Date: Tue, 9 Jun 2020 07:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528110444.20456-22-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, pbonzini@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 1:04 PM, Markus Armbruster wrote:
> leon3_generic_hw_init() creates a "grlib,ahbpnp" and a "grlib,apbpnp"
> sysbus device in a way that leaves them unplugged.
> 
> Create them the common way that puts them into the main system bus.
> Affects machine leon3_generic.  Visible in "info qtree":
> 
>      bus: main-system-bus
>        type System
>     +  dev: grlib,ahbpnp, id ""
>     +    mmio 00000000fffff000/0000000000001000
>     +  dev: grlib,apbpnp, id ""
>     +    mmio 00000000800ff000/0000000000001000
>        dev: grlib,irqmp, id ""
> 
> Cc: Fabien Chouteau <chouteau@adacore.com>
> Cc: KONRAD Frederic <frederic.konrad@adacore.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/sparc/leon3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 8f024dab7b..3facb8c2ae 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -213,14 +213,14 @@ static void leon3_generic_hw_init(MachineState *machine)
>      reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
>      qemu_register_reset(main_cpu_reset, reset_info);
>  
> -    ahb_pnp = GRLIB_AHB_PNP(object_new(TYPE_GRLIB_AHB_PNP));
> +    ahb_pnp = GRLIB_AHB_PNP(qdev_create(NULL, TYPE_GRLIB_AHB_PNP));
>      object_property_set_bool(OBJECT(ahb_pnp), true, "realized", &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(ahb_pnp), 0, LEON3_AHB_PNP_OFFSET);
>      grlib_ahb_pnp_add_entry(ahb_pnp, 0, 0, GRLIB_VENDOR_GAISLER,
>                              GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
>                              GRLIB_CPU_AREA);
>  
> -    apb_pnp = GRLIB_APB_PNP(object_new(TYPE_GRLIB_APB_PNP));
> +    apb_pnp = GRLIB_APB_PNP(qdev_create(NULL, TYPE_GRLIB_APB_PNP));
>      object_property_set_bool(OBJECT(apb_pnp), true, "realized", &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
>      grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
> 

Thanks, patch applied to for the next (temporary) sparc-next pull request.

