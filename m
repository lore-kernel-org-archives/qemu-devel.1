Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAECC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 22:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DD12051A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 22:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1x4v0PM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DD12051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEtG-0004nH-11
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 18:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDEsE-0003sK-67
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDEsC-0003Rg-UX
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:03:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46511
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDEsB-0003Pt-4Y
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 18:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584223390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLLPqnS1SZOfkOYfue7aBAkFq+0SkMtgYqn6iSnLJ/I=;
 b=a1x4v0PMA1pD1MsNIuiV4F+jIr19yOgsF94dTk9TcyS7AegyqIfbRm3LZ0IoqAeepQ0XfZ
 WVR9KbjVtkR9GYlM38iXumbUUo1+Ztco9Stuz/LTTMz4DuENR6fDpE3iIhNKGWlrIw3JcV
 Fwi7cwTwiBL76aZOI30wawoPzcBGs1E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-NJEOshxzPnuvfrhPyFN_xw-1; Sat, 14 Mar 2020 18:03:08 -0400
X-MC-Unique: NJEOshxzPnuvfrhPyFN_xw-1
Received: by mail-wr1-f70.google.com with SMTP id b12so6543333wro.4
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 15:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SqlwElm8adzTgQJquEj6DDNjkMjL8WDo7R1R84ELcNc=;
 b=DNXFtmPXOAXeofbQCEQu6qT24P8/YR9vkf/XzjvPx0W2xE1j95JTwC/4Z0+NNOYduU
 zrPvodWhYBvO6z0infCpOfQSStDaBr6gWZej35pS0N3YzP8cPQATKVMyDsi68J4IZjBR
 eVzDhN9l0WDPhZh+SgT5FXqy6qx+RHKNcZS2WErgdS00UD7+uopWApZ0rZQBNxtv3taT
 zURvmGd8fypW4x6MazS+e4SGngo4UYU8lM6P4wYxzW0uemHwAcoD3fcgt0qZ4+EBkVJU
 TGuw5rYd/vNjRgBTdaRTfAhI6R7lYJhKWL2CMw5588i1bX5x8A+UzexU5XKEmDX8MEJv
 utKg==
X-Gm-Message-State: ANhLgQ30tRXdNOJqGTPRljqcxOvDCF9vBf/VQCt+8Tylj767g5RXDjMo
 jCvqXdMU/siW/Tjc/VMhdoR4kb7Mqe5omimbGxFfJyYCAqaH4VkdA1P9syZVBzZ9j1ZuS2tWquW
 /EGNfvl2YZ4i6v7s=
X-Received: by 2002:adf:979b:: with SMTP id s27mr24336432wrb.134.1584223387702; 
 Sat, 14 Mar 2020 15:03:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtpatWRLWS+7JX5Kvzd3sXYjtjHmlGTTW94IeEWEQjw3XSYr30B97gKnxiikihEbNA257a4UA==
X-Received: by 2002:adf:979b:: with SMTP id s27mr24336403wrb.134.1584223387432; 
 Sat, 14 Mar 2020 15:03:07 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id b16sm84339605wrq.14.2020.03.14.15.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 15:03:06 -0700 (PDT)
Subject: Re: [PATCH 3/8] hw/ide: Remove now unneded #include "hw/pci/pci.h"
 from hw/ide.h
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <7679b82b4f26fdb16f00c3b130f8e6a807724f73.1584134074.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b06a8839-730d-7ce7-b0b1-f8b83068dc9e@redhat.com>
Date: Sat, 14 Mar 2020 23:03:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7679b82b4f26fdb16f00c3b130f8e6a807724f73.1584134074.git.balaton@eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 10:14 PM, BALATON Zoltan wrote:
> After previous patches we don't need hw/pci/pci.h any more in
> hw/ide.h. Some files depended on implicit inclusion by this header
> which are also fixed up here.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/ide/ahci_internal.h        | 1 +
>   include/hw/ide.h              | 1 -
>   include/hw/ide/pci.h          | 1 +
>   include/hw/misc/macio/macio.h | 1 +
>   4 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
> index 73424516da..bab0459774 100644
> --- a/hw/ide/ahci_internal.h
> +++ b/hw/ide/ahci_internal.h
> @@ -27,6 +27,7 @@
>   #include "hw/ide/ahci.h"
>   #include "hw/ide/internal.h"
>   #include "hw/sysbus.h"
> +#include "hw/pci/pci.h"
>  =20
>   #define AHCI_MEM_BAR_SIZE         0x1000
>   #define AHCI_MAX_PORTS            32
> diff --git a/include/hw/ide.h b/include/hw/ide.h
> index 21bd8f23f1..d52c211f32 100644
> --- a/include/hw/ide.h
> +++ b/include/hw/ide.h
> @@ -2,7 +2,6 @@
>   #define HW_IDE_H
>  =20
>   #include "hw/isa/isa.h"
> -#include "hw/pci/pci.h"
>   #include "exec/memory.h"
>  =20
>   #define MAX_IDE_DEVS=092
> diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
> index a9f2c33e68..98ffa7dfcd 100644
> --- a/include/hw/ide/pci.h
> +++ b/include/hw/ide/pci.h
> @@ -2,6 +2,7 @@
>   #define HW_IDE_PCI_H
>  =20
>   #include "hw/ide/internal.h"
> +#include "hw/pci/pci.h"
>  =20
>   #define BM_STATUS_DMAING 0x01
>   #define BM_STATUS_ERROR  0x02
> diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.=
h
> index 070a694eb5..87335a991c 100644
> --- a/include/hw/misc/macio/macio.h
> +++ b/include/hw/misc/macio/macio.h
> @@ -27,6 +27,7 @@
>   #define MACIO_H
>  =20
>   #include "hw/char/escc.h"
> +#include "hw/pci/pci.h"
>   #include "hw/ide/internal.h"
>   #include "hw/intc/heathrow_pic.h"
>   #include "hw/misc/macio/cuda.h"
>=20


