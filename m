Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15389C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A4B20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A4B20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOJw-0004Kb-2J
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 07:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53074)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hbOIV-0003rW-3H
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hbOIT-0004KQ-QC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:53:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hbOIT-0004Iy-JP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:53:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so9891829wms.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 04:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2rouVN50cRK4pEglHtE5qKb+bzW8IJVJrc4mUQsgE6Y=;
 b=Il483RtTIrCEbRe+p5m2v75E0jHAgLMr4e7ANBmZ6oFgOfXhNjYu8JMz0/rWBkroOT
 1pjss2ChPw+d4cb0CctGibmP8y+smb0CsQILDng2Ys6g+dgxsm0qC902UEjDMYP7ouiq
 oc5PCnJmr+9Pgrcz6k2+hegDD0HTXH3jVrLX3ATCf9BYPQOc8Y4DDCuYKxBp4+pcxmLT
 k8WDPCBsst5WPr/iYm7OQU0jyFnezMr5nbduXXtu6+KfmlnDv/l9ZUMTSjIzikTcLY45
 yCkQ6HOtcd3u/mE+BCMLuHlxkHhtg+nIwIrDux0qf6NEQH0B0J1ghbutEQSImSOmbvGN
 0vXg==
X-Gm-Message-State: APjAAAUk69iw6zpdooDLikv5KPMrtDkDrPcvzXp+UaHlx4LNELX/cUfU
 gBaxyTmwF5KS8Bc80N8n+G95ZQ==
X-Google-Smtp-Source: APXvYqxmp3walREYT3wLOE1VE9gr0GsTUKAQcMOFMXV8Ml0zQ2+ybnthas+GYG3eMgMBZjqoJjIwWA==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr3510887wml.28.1560426815445;
 Thu, 13 Jun 2019 04:53:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:49d3:a711:c5a3:8ebf?
 ([2001:b07:6468:f312:49d3:a711:c5a3:8ebf])
 by smtp.gmail.com with ESMTPSA id u6sm4442292wml.9.2019.06.13.04.53.34
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 04:53:34 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 atar4qemu@gmail.com
References: <20190612203916.16875-1-mark.cave-ayland@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d1feb628-7455-1ba1-a3e9-bac6b3c6f9f0@redhat.com>
Date: Thu, 13 Jun 2019 13:53:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612203916.16875-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] sun4m: set default display type to TCX
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

On 12/06/19 22:39, Mark Cave-Ayland wrote:
> Commit 6807874d55 "sun4m: obey -vga none" changed the sun4m machines so that
> they could be started without a framebuffer installed, but as no default
> display type was configured the machines would start in headless mode without
> an explict -vga option.
> 
> Set the default display type for all sun4m machines to TCX so that they will
> start with a framebuffer if one is not specifically requested.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Oops, sorry.  Do you want me to queue it, or are you doing that?

Paolo

> ---
>  hw/sparc/sun4m.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 7e4f61fc3e..99f53e87f7 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -1406,6 +1406,7 @@ static void ss5_class_init(ObjectClass *oc, void *data)
>      mc->is_default = 1;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
> +    mc->default_display = "tcx";
>  }
>  
>  static const TypeInfo ss5_type = {
> @@ -1424,6 +1425,7 @@ static void ss10_class_init(ObjectClass *oc, void *data)
>      mc->max_cpus = 4;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
> +    mc->default_display = "tcx";
>  }
>  
>  static const TypeInfo ss10_type = {
> @@ -1442,6 +1444,7 @@ static void ss600mp_class_init(ObjectClass *oc, void *data)
>      mc->max_cpus = 4;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
> +    mc->default_display = "tcx";
>  }
>  
>  static const TypeInfo ss600mp_type = {
> @@ -1460,6 +1463,7 @@ static void ss20_class_init(ObjectClass *oc, void *data)
>      mc->max_cpus = 4;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
> +    mc->default_display = "tcx";
>  }
>  
>  static const TypeInfo ss20_type = {
> @@ -1477,6 +1481,7 @@ static void voyager_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_SCSI;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
> +    mc->default_display = "tcx";
>  }
>  
>  static const TypeInfo voyager_type = {
> @@ -1494,6 +1499,7 @@ static void ss_lx_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_SCSI;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
> +    mc->default_display = "tcx";
>  }
>  
>  static const TypeInfo ss_lx_type = {
> @@ -1511,6 +1517,7 @@ static void ss4_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_SCSI;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
> +    mc->default_display = "tcx";
>  }
>  
>  static const TypeInfo ss4_type = {
> @@ -1528,6 +1535,7 @@ static void scls_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_SCSI;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
> +    mc->default_display = "tcx";
>  }
>  
>  static const TypeInfo scls_type = {
> @@ -1545,6 +1553,7 @@ static void sbook_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_SCSI;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
> +    mc->default_display = "tcx";
>  }
>  
>  static const TypeInfo sbook_type = {
> 


