Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE778C742C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974102084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974102084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwx3-0006Ju-Mg
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlwws-0005pH-Aa
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlwwq-0003hr-Ay
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:54:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlwwn-0003WD-Io
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:54:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so10261789wru.10
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 07:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eUAMjUCw8+YOZcsM6H2kywFYGiMLW+oayahDLGYBslg=;
 b=NG3QSkdbazxWqs7Hyk7r5ci6nJ1J0ImSXiw4+tefuwh5leMTWtdyvwwSAdL8t/TZ6D
 VmGj1GTGyKWNQ4+Z/98dtYiOzKH2ZmYypDnE2/Asq1kDeNqOIKcYM+/ZCha23TtJrzrr
 t2b+YZbYj4wfXmL3gTqi2AikXR3NzpDWbx5lnjXmum6BapBKRghgTHUaQiyFMKH1K+xb
 IYwPfqKU6rfjIgupv9AbwDZXYAdIbHGiiLqlWbB75rGxg5DEuy0Lsh3kquitFG0Prx8v
 SJ/JaqXaiQjztoeLSXVHDEqKIQtD+WtN2lG6SFt8ixibgPEtJyfogJ2gViBxhETlvPL3
 cd9w==
X-Gm-Message-State: APjAAAX2ssZSwo1oC91HlS1n7fQfTCEXGZ1H1k71NzrlQTcWAx7y1oiY
 yF1Nmsw+AW8T1UOOBlyFTfZgLQ==
X-Google-Smtp-Source: APXvYqyT0eWcSKUjxGrWK0WKbdEFuffmQuBk2icJgX7dR+iotg8q//lK/3/47VzOnIHHp5eTT5lS9w==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr12223936wra.273.1562943291380; 
 Fri, 12 Jul 2019 07:54:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id w14sm7712538wrk.44.2019.07.12.07.54.50
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 07:54:50 -0700 (PDT)
To: Julio Montes <julio.montes@intel.com>, qemu-devel@nongnu.org
References: <20190712145017.17879-1-julio.montes@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ca254017-cf99-d3ef-65a0-b3f109f9ff0c@redhat.com>
Date: Fri, 12 Jul 2019 16:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712145017.17879-1-julio.montes@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] hw/i386: turn off vmport if CONFIG_VMPORT
 is disabled
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/07/19 16:50, Julio Montes wrote:
> vmport device is not included when CONFIG_VMPORT is disabled, hence
> QEMU fails with the following error:
> 
> `Unknown device 'vmport' for bus 'ISA': unknown.`
> 
> Signed-off-by: Julio Montes <julio.montes@intel.com>
> ---
>  hw/i386/pc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c33ce47578..549c437050 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -83,6 +83,7 @@
>  #include "hw/mem/memory-device.h"
>  #include "sysemu/replay.h"
>  #include "qapi/qmp/qerror.h"
> +#include "config-devices.h"
>  
>  /* debug PC/ISA interrupts */
>  //#define DEBUG_IRQ
> @@ -2793,7 +2794,11 @@ static void pc_machine_initfn(Object *obj)
>  
>      pcms->max_ram_below_4g = 0; /* use default */
>      pcms->smm = ON_OFF_AUTO_AUTO;
> +#ifdef CONFIG_VMPORT
>      pcms->vmport = ON_OFF_AUTO_AUTO;
> +#else
> +    pcms->vmport = ON_OFF_AUTO_OFF;
> +#endif /* CONFIG_VMPORT */
>      /* acpi build is enabled by default if machine supports it */
>      pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
>      pcms->smbus_enabled = true;
> 

Do we also want to make it "imply VMPORT" instead of "select"?

Paolo

