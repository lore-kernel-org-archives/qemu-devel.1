Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7738DC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4968820B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4968820B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOcd-0007UY-8q
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58153)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbOat-0006GW-0W
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbOar-0002NZ-0u
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:12:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbOap-0002KS-1c
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:12:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so9944053wme.4
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GSZI4IS8sHWWVqZNM5E0sBZLHejo8F94zdAhW1H45Ys=;
 b=Ow51vkVcEbi5IWiKr8iXMU9VIaySDr5I1oDmTftqe7alCAjPZmIaUGT/nKF4qY2uZo
 AkDh+VlMv+AEyvRtTrlUQRzXzAeqEn7uj0HidSGd/19KvbQoNqV1CMk+dkTTa1cNn9lI
 zKzgcMW2EC4y8LXUtoND/UWocQ5uLZweG8yi7y7z7gXsNA8HROkTH6mW65mwMkoYgR5y
 vWCPSDWOPiBlZmv9tqtCARSSrSvM+770oDvUt7YS+yUcvt/qb9Bri9wn7HqvR1V2ehzB
 YJsrcblQfJ06Xmm2GXBUw+L14IE7gpKru9lF1jFp7ED9+ew7/oeYHHukDP7gOQ1rOhqJ
 2/yQ==
X-Gm-Message-State: APjAAAUdLHyw/8XVwkQv+GG/D8Eag6HfT0J/d02gCbHPvirnDQD4kPbu
 rro2I5YvSA6Shmu8DlwCskuvcQ==
X-Google-Smtp-Source: APXvYqzbSbAoPCtZYkWBUAd425MQL61XQmBK4rNKH5LJXQMqu7BUSMC7d1M06YYAaok0jntx3FyYbQ==
X-Received: by 2002:a1c:f70f:: with SMTP id v15mr3501029wmh.102.1560427953426; 
 Thu, 13 Jun 2019 05:12:33 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id 32sm6072010wra.35.2019.06.13.05.12.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:12:32 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 atar4qemu@gmail.com, pbonzini@redhat.com
References: <20190612203916.16875-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6b07961c-1372-5b66-919b-a39b8fa150a5@redhat.com>
Date: Thu, 13 Jun 2019 14:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612203916.16875-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
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

On 6/12/19 10:39 PM, Mark Cave-Ayland wrote:
> Commit 6807874d55 "sun4m: obey -vga none" changed the sun4m machines so that
> they could be started without a framebuffer installed, but as no default
> display type was configured the machines would start in headless mode without
> an explict -vga option.
> 
> Set the default display type for all sun4m machines to TCX so that they will
> start with a framebuffer if one is not specifically requested.

Sorry, I missed that because only test headless (and I don't plan to do
UI testing without a decent Avocado UI API).

> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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

