Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB92C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC4120757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUZjkLo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC4120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJDV-0004Cj-QG
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jKJCo-0003Ri-T0
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jKJCl-0002lP-8D
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:05:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jKJCk-0002kY-ET
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585908338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0dRk2BoTcybgYviqYzLyJWnFD/3cimjY/6NqCSnVmU=;
 b=ZUZjkLo/59Chg0UoyLWPsHr0su3llap/NYTZUAWwfMGq+ui06fePQMLaCacJ2yrJ9dkB75
 P8bRwCbMQfOyotj2ryAb+LYn0FZd0hGkAokyNfZr/NXii7k9KPpV6h6u6cFAw0WViUL/yU
 1LVHdY6DsMSIriwS4MOLb/UBNHsaGyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-dCN_H3FjNv69giEK64BwYA-1; Fri, 03 Apr 2020 06:05:34 -0400
X-MC-Unique: dCN_H3FjNv69giEK64BwYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAE568017F3;
 Fri,  3 Apr 2020 10:05:33 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE748196AE;
 Fri,  3 Apr 2020 10:05:20 +0000 (UTC)
Date: Fri, 3 Apr 2020 12:05:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 06/12] acpi: add ISADeviceClass->build_aml()
Message-ID: <20200403120518.1f20d008@redhat.com>
In-Reply-To: <20200403080502.8154-7-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-7-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  3 Apr 2020 10:04:56 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Also add isa_aml_build() function which walks all isa devices.
> This allows to move aml builder code to isa devices.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/isa/isa.h |  2 ++
>  hw/i386/acpi-build.c |  1 +
>  hw/isa/isa-bus.c     | 15 +++++++++++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index e9ac1f1205a4..1534f8826453 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -70,6 +70,7 @@ typedef struct IsaDmaClass {
>  
>  typedef struct ISADeviceClass {
>      DeviceClass parent_class;
> +    void (*build_aml)(ISADevice *dev, Aml *scope);
>  } ISADeviceClass;
>  
>  struct ISABus {
> @@ -108,6 +109,7 @@ ISADevice *isa_try_create(ISABus *bus, const char *name);
>  ISADevice *isa_create_simple(ISABus *bus, const char *name);
>  
>  ISADevice *isa_vga_init(ISABus *bus);
> +void isa_build_aml(ISABus *bus, Aml *scope);
>  
>  /**
>   * isa_register_ioport: Install an I/O port region on the ISA bus.
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 5d2b9b099684..77fc9df74735 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1259,6 +1259,7 @@ static void build_isa_devices_aml(Aml *table)
>          error_report("No ISA bus, unable to define IPMI ACPI data");
>      } else {
>          build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
> +        isa_build_aml(ISA_BUS(obj), scope);
>      }
>  
>      aml_append(table, scope);
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 798dd9194e8f..1f2189f4d5db 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -207,6 +207,21 @@ ISADevice *isa_vga_init(ISABus *bus)
>      }
>  }
>  
> +void isa_build_aml(ISABus *bus, Aml *scope)
> +{
> +    BusChild *kid;
> +    ISADevice *dev;
> +    ISADeviceClass *dc;
> +
> +    QTAILQ_FOREACH(kid, &bus->parent_obj.children, sibling) {
> +        dev = ISA_DEVICE(kid->child);
> +        dc = ISA_DEVICE_GET_CLASS(dev);
> +        if (dc->build_aml) {
> +            dc->build_aml(dev, scope);
> +        }
> +    }
> +}
> +
>  static void isabus_dev_print(Monitor *mon, DeviceState *dev, int indent)
>  {
>      ISADevice *d = ISA_DEVICE(dev);


