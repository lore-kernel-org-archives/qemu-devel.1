Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93704C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69925206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69925206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsqrh-000460-OZ
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 11:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35782)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsqpx-0002ev-Pd
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsqpw-000804-2N
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:48:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsqpv-0007z7-SE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:48:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so61376736wmj.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 08:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pzcNWa/SJdc37T0/PvsU8BfmBjul9DAml0FWlPMxRHc=;
 b=sse1dlYyOY4xx3KT9IQlZ6vTj6mTrJgeFTqdT5XW3Nr71uV9QwpTHYt45X0hNpuYDw
 t9O2694YcxS7okQZXsg+t36Q+SFprbfLonZyBgtNWxchO2pVc/qd4y+Noi1r5qb9GWQ6
 ZijpniZqDlnC+2gLdKtLmqyB+OIelcp4LrRyoG5lJwiD07n9GT2fzdrL054xQXf8a7bA
 z+Zzt0Sp3RFjrGcbp2CMa2pC3J3v22GQ8vI3GvcRacaHiyRqCAnQQaEOv8iRdSSbXKif
 48zT2JoGh/mo2ZQojY6hKjz2b82NzkloyCvd6e5p2zeteMGGyisPr+KrBLV0HcMsoVCo
 cUBA==
X-Gm-Message-State: APjAAAXZSgaZLqBIdoz8wDlTh5oLypJRIkJwJT63CXWCEg+Br1qj2rqX
 ylLTe848ST1iFxNmCultgtbpvw==
X-Google-Smtp-Source: APXvYqxKAfVawW6sQbbr6LRDPlTlWMIlRAiC2RTnO6WNVepv3OB6U+ZRmcDOMrc2AmbPXK0OioBzSg==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr109103266wmc.170.1564588098872; 
 Wed, 31 Jul 2019 08:48:18 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id v23sm60305500wmj.32.2019.07.31.08.48.16
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 08:48:18 -0700 (PDT)
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-20-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ea759e77-4514-ec00-3587-8dd3a50712bb@redhat.com>
Date: Wed, 31 Jul 2019 17:48:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729145654.14644-20-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 19/33] hw/sd/pl181.c & omap_mmc.c:
 remove device_legacy_reset call
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au, thuth@redhat.com, ehabkost@redhat.com,
 alistair@alistair23.me, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 clg@kaod.org, jsnow@redhat.com, rth@twiddle.net, berrange@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/19 4:56 PM, Damien Hedde wrote:
> Replace legacy's reset call by device_reset_warm.
> 
> The new function propagates also the reset to the sub-buses tree but this has
> no impact since SDState has no child bus.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/sd/omap_mmc.c | 2 +-
>  hw/sd/pl181.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
> index 24a1edc149..3021e54b8d 100644
> --- a/hw/sd/omap_mmc.c
> +++ b/hw/sd/omap_mmc.c
> @@ -317,7 +317,7 @@ void omap_mmc_reset(struct omap_mmc_s *host)
>       * into any bus, and we must reset it manually. When omap_mmc is
>       * QOMified this must move into the QOM reset function.
>       */
> -    device_legacy_reset(DEVICE(host->card));
> +    device_reset_warm(DEVICE(host->card));
>  }
>  
>  static uint64_t omap_mmc_read(void *opaque, hwaddr offset,
> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
> index 15b4aaa67f..a59ef7eb2a 100644
> --- a/hw/sd/pl181.c
> +++ b/hw/sd/pl181.c
> @@ -480,7 +480,7 @@ static void pl181_reset(DeviceState *d)
>      /* Since we're still using the legacy SD API the card is not plugged
>       * into any bus, and we must reset it manually.
>       */
> -    device_legacy_reset(DEVICE(s->card));
> +    device_reset_warm(DEVICE(s->card));

We need to define what is a sdcard 'warm' reset.

>  }
>  
>  static void pl181_init(Object *obj)
> 

