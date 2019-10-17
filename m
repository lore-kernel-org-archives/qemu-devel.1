Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5EFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C4C20872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C4C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8Do-0002f9-RU
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7OH-0003N2-SA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7OF-0000YB-Gg
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:08:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7OF-0000Xi-8h
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:08:35 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7610A2A09C4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:08:33 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id s19so1200017wmj.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dnAgdv88fqpkJJVSXS9vM0PplR+Kvi9HfVjwm6f845g=;
 b=ScReFZaIgRDPMCc4uQBq4foV+zwgK78+AoRvi8EYjkLwvMlqc7t7P+Z2Oid0/wzZqk
 rx2IBR1P1yEcDoozRAYbo23dQHZdTsqNVAWUWL3Dw+9zFyk6HoEWoYWozz/TlG1E2RYe
 zvMB1hPedlMOLnPzckCaEYj7irreZD4yKzwENZhKPyuvXydY27jDdMjWmRCakQC9DrZ+
 o9m29jkSjsPnzuw5Ebw4T/t+j4rGf0dKFaXjbvOsvvX6ZpPHI5BRFPYj7/fAe+cFS3VF
 y4FbpI+wejgiyCFUz+uVPsfWYAX79SykVg4solkpzSenYcZd8VPAVCiI1CCrvGbynoNC
 Gq4w==
X-Gm-Message-State: APjAAAXQgATua7OsfgIWVQTmtMGALl6ZB7hU4RiICGldD8kytFcD0KrC
 9ZvhyHyImJnuKX2NOm5d9T2gvVkLIa8lplV56Wpw9ufCMMQD5yot12+lne1rYlnbKaF8iW7Qw/B
 9y3GC05JXq47JFyc=
X-Received: by 2002:a5d:4286:: with SMTP id k6mr3362930wrq.192.1571324909978; 
 Thu, 17 Oct 2019 08:08:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxg9IEqKvkzKtsyM3a9kmP0NDMBLbPPViQWW70uNvm8bLhPKRJHIGoGgBAFy5C9Rn1A0gAHNw==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr3362889wrq.192.1571324909771; 
 Thu, 17 Oct 2019 08:08:29 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id t6sm3551777wmf.8.2019.10.17.08.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:08:29 -0700 (PDT)
Subject: Re: [PATCH 02/32] hw/i386/pc: Move kvm_i8259_init() declaration to
 sysemu/kvm.h
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-3-philmd@redhat.com>
 <CAL1e-=iC9hR-jqTSu9c6KtgiNWFwftnTMq9W87NWFPb37hjCoA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <46708b3d-fcef-f65c-d929-73d7c8e3f877@redhat.com>
Date: Thu, 17 Oct 2019 17:08:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iC9hR-jqTSu9c6KtgiNWFwftnTMq9W87NWFPb37hjCoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/17/19 4:57 PM, Aleksandar Markovic wrote:
>=20
>=20
> On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     Move the KVM-related call to "sysemu/kvm.h".

Maybe s/call/function declaration/

>=20
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0include/hw/i386/pc.h | 1 -
>      =C2=A0include/sysemu/kvm.h | 1 +
>      =C2=A02 files changed, 1 insertion(+), 1 deletion(-)
>=20
>=20
> Is there any other similar case in our code base?

These look appropriate:

include/hw/ppc/openpic_kvm.h:5:int kvm_openpic_connect_vcpu(DeviceState=20
*d, CPUState *cs);
include/hw/timer/i8254.h:67:static inline ISADevice *kvm_pit_init(ISABus=20
*bus, int base)
hw/intc/vgic_common.h:25: * kvm_arm_gic_set_irq - Send an IRQ to the=20
in-kernel vGIC
hw/intc/vgic_common.h:33:void kvm_arm_gic_set_irq(uint32_t num_irq, int=20
irq, int level);

although kvm_pit_init() is probably borderline.

>=20
> A.
>=20
>     diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>     index 6df4f4b6fb..09e74e7764 100644
>     --- a/include/hw/i386/pc.h
>     +++ b/include/hw/i386/pc.h
>     @@ -158,7 +158,6 @@ typedef struct PCMachineClass {
>=20
>      =C2=A0extern DeviceState *isa_pic;
>      =C2=A0qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq);
>     -qemu_irq *kvm_i8259_init(ISABus *bus);
>      =C2=A0int pic_read_irq(DeviceState *d);
>      =C2=A0int pic_get_output(DeviceState *d);
>=20
>     diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>     index 9d143282bc..da8aa9f5a8 100644
>     --- a/include/sysemu/kvm.h
>     +++ b/include/sysemu/kvm.h
>     @@ -513,6 +513,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s,
>     qemu_irq irq, int gsi);
>      =C2=A0void kvm_pc_gsi_handler(void *opaque, int n, int level);
>      =C2=A0void kvm_pc_setup_irq_routing(bool pci_enabled);
>      =C2=A0void kvm_init_irq_routing(KVMState *s);
>     +qemu_irq *kvm_i8259_init(ISABus *bus);
>=20
>      =C2=A0/**
>      =C2=A0 * kvm_arch_irqchip_create:
>     --=20
>     2.21.0
>=20
>=20

