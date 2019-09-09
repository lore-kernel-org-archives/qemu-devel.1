Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93234C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E997218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E997218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NlZ-00006C-5o
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i7Nk6-00085y-33
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i7Nk2-0006GB-PK
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i7Nk2-0006FY-Jr
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:46:18 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 38971C03D470
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 17:46:17 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id f63so147219wma.7
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 10:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lGi0vonfEUreFFUeRcjIo6P3nVSQg4RRz71i12pFfrM=;
 b=MzKWP4oEn8JI//Q6UmEQON+TOMSjl32LaX0XZ5WGoW4b8F072si18PhcI3TAUFDkKN
 dW1wh6I13wpwDB5EP+9iQybwf73x3lRcVvREhOp38TENCuUbTEdVLI6OenXfL7KycVx2
 VPbJ6gf9UIe/LXFJVcByIB7oZYgT3MGUYUfLM4hOAt5QUXsRDyTU/agY9X16mk/Z9C8f
 V8uPZtwKrChBw+24YU1fYO9eoP6qXOkQKW1ElVZCKIe4E671/83a8fp/tjGVZS9rqPe8
 4KErd3hlmvBR4E5MTrMPlxgSZ3vQM1eWpYaynXiMafrCrvbHGlV9R1TPfNrOCTq8JLa0
 arCw==
X-Gm-Message-State: APjAAAVGvOmdMTKaCItX4s83InOxIKiBru7muU2qZzFIlei+27F9n8RX
 PmUCPJ10GvwhgtdWBHACvMH/SOhB0lcVTf0w3ZSjzjO/arEk3WiMbgOSM/LrqZehIhZlCIvOSWQ
 pKR7x9tnvWKKJJj0=
X-Received: by 2002:a7b:c856:: with SMTP id c22mr196969wml.107.1568051175668; 
 Mon, 09 Sep 2019 10:46:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCI/qdCoCqs/0GvbvA9OWKBdfbAG9xxwB/aWd+996YwtyNRRc6hbfwQmOrhLcob2lOWvtmDw==
X-Received: by 2002:a7b:c856:: with SMTP id c22mr196960wml.107.1568051175411; 
 Mon, 09 Sep 2019 10:46:15 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s1sm22038259wrg.80.2019.09.09.10.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 10:46:14 -0700 (PDT)
To: Cole Robinson <crobinso@redhat.com>, qemu-devel@nongnu.org
References: <e73e6edff68fd30d69c6a1d02c9ef9192f773c63.1568049871.git.crobinso@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <61f10b0e-7d9a-b4f3-feb6-8ef86d679305@redhat.com>
Date: Mon, 9 Sep 2019 19:46:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e73e6edff68fd30d69c6a1d02c9ef9192f773c63.1568049871.git.crobinso@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Move CONFIG_ACPI_PCI to CONFIG_PC
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
Cc: richardw.yang@linux.intel.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/19 19:34, Cole Robinson wrote:
> CONFIG_ACPI_PCI is a hard requirement of acpi-build.c, which is built
> unconditionally for x86 target. Putting it in default-configs/ suggests
> that it can be easily disabled, which isn't true.
> 
> Relocate the symbol with the other acpi-build.c requirements, under
> 'config PC'. This is similar to what is done for the arm 'virt' machine
> type and CONFIG_ACPI_PCI
> 
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
>  default-configs/i386-softmmu.mak | 1 -
>  hw/i386/Kconfig                  | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index cd5ea391e8..ba3fb3ff50 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -25,4 +25,3 @@
>  CONFIG_ISAPC=y
>  CONFIG_I440FX=y
>  CONFIG_Q35=y
> -CONFIG_ACPI_PCI=y
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 6350438036..c7a9d6315c 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -29,6 +29,7 @@ config PC
>      select MC146818RTC
>      # For ACPI builder:
>      select SERIAL_ISA
> +    select ACPI_PCI
>      select ACPI_VMGENID
>      select VIRTIO_PMEM_SUPPORTED
>  
> 

Queued, thanks.

Paolo

