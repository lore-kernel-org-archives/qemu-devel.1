Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9A3C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5C020BED
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3s1zThT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5C020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW2Fq-0008Q1-QW
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW2FA-0007qy-12
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW2F7-00046M-7o
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603479408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Cmywu2mB/+5b3eKqelzE2yh22wvYxE1LiWJvej35vM=;
 b=L3s1zThTF9ThrkEkuvkF07uCSw1Qodfsu91AQMPdNmR1PzDD34BIkWbYmxUCn0VtNKC6XO
 y1IucHr3ZYCuoZC+fAFnaz6IKYTGlQoP2YAYJgMp/TcQUO9us9BU3mkwTv44Z4A6tcKDXw
 bVEnG5JlMf7yocMsr9zh7yuK1I4QyIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-85sAo0fYOAuE06xm5EKlVA-1; Fri, 23 Oct 2020 14:56:44 -0400
X-MC-Unique: 85sAo0fYOAuE06xm5EKlVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C5BD804B72;
 Fri, 23 Oct 2020 18:56:43 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFD851992D;
 Fri, 23 Oct 2020 18:56:30 +0000 (UTC)
Date: Fri, 23 Oct 2020 20:56:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/4] microvm: add second ioapic
Message-ID: <20201023205629.54a573c2@redhat.com>
In-Reply-To: <20201016114328.18835-4-kraxel@redhat.com>
References: <20201016114328.18835-1-kraxel@redhat.com>
 <20201016114328.18835-4-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Oct 2020 13:43:27 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Add more IRQ lines.  Depends on ACPI.
> Also enable this only with userspace ioapic,
> not sure whenever the kernel can handle two ioapics.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

For ACPI part:
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/ioapic_internal.h |  2 +-
>  include/hw/i386/x86.h             |  1 +
>  hw/i386/acpi-common.c             | 10 ++++++++++
>  hw/i386/microvm.c                 | 30 ++++++++++++++++++++++++++++--
>  4 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_internal.h
> index 0ac9e2400d6b..4cebd2e32c9f 100644
> --- a/include/hw/i386/ioapic_internal.h
> +++ b/include/hw/i386/ioapic_internal.h
> @@ -27,7 +27,7 @@
>  #include "qemu/notify.h"
>  #include "qom/object.h"
>  
> -#define MAX_IOAPICS                     1
> +#define MAX_IOAPICS                     2
>  
>  #define IOAPIC_LVT_DEST_SHIFT           56
>  #define IOAPIC_LVT_DEST_IDX_SHIFT       48
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index bfa9cb2a258b..6da57033a875 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -120,6 +120,7 @@ bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms);
>  typedef struct GSIState {
>      qemu_irq i8259_irq[ISA_NUM_IRQS];
>      qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
> +    qemu_irq ioapic2_irq[IOAPIC_NUM_PINS];
>  } GSIState;
>  
>  qemu_irq x86_allocate_cpu_irq(void);
> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> index 8a769654060e..f0689392a39f 100644
> --- a/hw/i386/acpi-common.c
> +++ b/hw/i386/acpi-common.c
> @@ -103,6 +103,16 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>      io_apic->address = cpu_to_le32(IO_APIC_DEFAULT_ADDRESS);
>      io_apic->interrupt = cpu_to_le32(0);
>  
> +    if (object_property_find(OBJECT(x86ms), "ioapic2")) {
> +        AcpiMadtIoApic *io_apic2;
> +        io_apic2 = acpi_data_push(table_data, sizeof *io_apic);
> +        io_apic2->type = ACPI_APIC_IO;
> +        io_apic2->length = sizeof(*io_apic);
> +        io_apic2->io_apic_id = ACPI_BUILD_IOAPIC_ID + 1;
> +        io_apic2->address = cpu_to_le32(IO_APIC_DEFAULT_ADDRESS + 0x10000);
> +        io_apic2->interrupt = cpu_to_le32(24);
> +    }
> +
>      if (x86ms->apic_xrupt_override) {
>          intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
>          intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 638e95c39e8c..15c3e078a4aa 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -99,7 +99,11 @@ static void microvm_gsi_handler(void *opaque, int n, int level)
>  {
>      GSIState *s = opaque;
>  
> -    qemu_set_irq(s->ioapic_irq[n], level);
> +    if (n >= 24) {
> +        qemu_set_irq(s->ioapic2_irq[n - 24], level);
> +    } else {
> +        qemu_set_irq(s->ioapic_irq[n], level);
> +    }
>  }
>  
>  static void create_gpex(MicrovmMachineState *mms)
> @@ -157,6 +161,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>      ISABus *isa_bus;
>      ISADevice *rtc_state;
>      GSIState *gsi_state;
> +    bool ioapic2 = false;
>      int i;
>  
>      /* Core components */
> @@ -165,8 +170,13 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>      if (mms->pic == ON_OFF_AUTO_ON || mms->pic == ON_OFF_AUTO_AUTO) {
>          x86ms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PINS);
>      } else {
> +        int pins = GSI_NUM_PINS;
> +        if (!kvm_ioapic_in_kernel() && x86_machine_is_acpi_enabled(x86ms)) {
> +            ioapic2 = true;
> +            pins += 24;
> +        }
>          x86ms->gsi = qemu_allocate_irqs(microvm_gsi_handler,
> -                                        gsi_state, GSI_NUM_PINS);
> +                                        gsi_state, pins);
>      }
>  
>      isa_bus = isa_bus_new(NULL, get_system_memory(), get_system_io(),
> @@ -175,6 +185,22 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>  
>      ioapic_init_gsi(gsi_state, "machine");
>  
> +    if (ioapic2) {
> +        DeviceState *dev;
> +        SysBusDevice *d;
> +        unsigned int i;
> +
> +        dev = qdev_new(TYPE_IOAPIC);
> +        object_property_add_child(OBJECT(mms), "ioapic2", OBJECT(dev));
> +        d = SYS_BUS_DEVICE(dev);
> +        sysbus_realize_and_unref(d, &error_fatal);
> +        sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS + 0x10000);
> +
> +        for (i = 0; i < IOAPIC_NUM_PINS; i++) {
> +            gsi_state->ioapic2_irq[i] = qdev_get_gpio_in(dev, i);
> +        }
> +    }
> +
>      kvmclock_create(true);
>  
>      mms->virtio_irq_base = 5;


