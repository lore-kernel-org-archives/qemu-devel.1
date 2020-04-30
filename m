Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C16C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C0120775
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjqsWHyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C0120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8LX-0007aO-Hr
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:31:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jU8Hu-0001W6-8l
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jU7xf-0006H0-QR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:11:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58564
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jU7xf-0006DZ-8Q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588248398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gn0iF02KaEsiCGiYMyDPpqDuCTW4BR3liH4QJply92o=;
 b=LjqsWHybZpSb42bYQ0E2TDu5Rd0OlCc8RDSvDPTFR3J25p5aHZBjRwp9CTLc+oxS0rJNiL
 IMe0ZwThFWFDN9QoDPU4B3MOcRSx+x5IAgS27lv5jHVXgE4tV+vfHK+6+J3pfq1Q+wHglq
 ZPwjGBOJUg7Sbmc5SsSiNGrvbMaqfTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-pJ8Uj4wMMweWKE-k6-OdKw-1; Thu, 30 Apr 2020 08:06:36 -0400
X-MC-Unique: pJ8Uj4wMMweWKE-k6-OdKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90B90462;
 Thu, 30 Apr 2020 12:06:35 +0000 (UTC)
Received: from localhost (unknown [10.40.208.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04846605CB;
 Thu, 30 Apr 2020 12:06:20 +0000 (UTC)
Date: Thu, 30 Apr 2020 14:06:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 06/15] rtc: add RTC_ISA_BASE
Message-ID: <20200430140619.565376bb@redhat.com>
In-Reply-To: <20200429140003.7336-7-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-7-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Apr 2020 15:59:54 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Add and use RTC_ISA_BASE define instead of hardcoding 0x70.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/rtc/mc146818rtc.h | 1 +
>  hw/rtc/mc146818rtc.c         | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
> index 10c93a096a1d..3713181b56fe 100644
> --- a/include/hw/rtc/mc146818rtc.h
> +++ b/include/hw/rtc/mc146818rtc.h
> @@ -47,6 +47,7 @@ typedef struct RTCState {
>  } RTCState;
>  
>  #define RTC_ISA_IRQ 8
> +#define RTC_ISA_BASE 0x70
>  
>  ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
>                               qemu_irq intercept_irq);
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index dc4269cc55cb..d18c09911be2 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -908,7 +908,6 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
>  {
>      ISADevice *isadev = ISA_DEVICE(dev);
>      RTCState *s = MC146818_RTC(dev);
> -    int base = 0x70;
>  
>      s->cmos_data[RTC_REG_A] = 0x26;
>      s->cmos_data[RTC_REG_B] = 0x02;
> @@ -951,7 +950,7 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
>      qemu_register_suspend_notifier(&s->suspend_notifier);
>  
>      memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
> -    isa_register_ioport(isadev, &s->io, base);
> +    isa_register_ioport(isadev, &s->io, RTC_ISA_BASE);
>  
>      /* register rtc 0x70 port for coalesced_pio */
>      memory_region_set_flush_coalesced(&s->io);
> @@ -960,7 +959,7 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
>      memory_region_add_subregion(&s->io, 0, &s->coalesced_io);
>      memory_region_add_coalescing(&s->coalesced_io, 0, 1);
>  
> -    qdev_set_legacy_instance_id(dev, base, 3);
> +    qdev_set_legacy_instance_id(dev, RTC_ISA_BASE, 3);
>      qemu_register_reset(rtc_reset, s);
>  
>      object_property_add_tm(OBJECT(s), "date", rtc_get_date, NULL);


