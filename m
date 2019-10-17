Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADACFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4775921835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4775921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8lG-0002s0-Ve
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7ku-0006xX-LB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7ks-0003Pg-AT
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:31:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7kr-0003NB-6K
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:31:57 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C43073A6E
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:31:56 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id q9so1321226wmj.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2F49FEDc7LzFngXJgzRZqW78fRDnmjAzCNR79FZigrE=;
 b=kt4xNv/CUxkrsl834O100881BfrBgep/uKogCH/pCXFAnN0lkKwNAnpZpjQ1yLosde
 QJxWV3zuD+SjKFjI0G7h7wwBkVcySS2lFwdrCnME+Frj7RLcE3EMoIYNxY0xlqcQe+Kv
 eKayxpiTIDUKQL4esrmg+uwT5VLdkDZ3dtCkdgtRUlDO9dATjmVUsEDyNpcWFbsTFXAu
 yAyLKPOICs3aKLDb5sikJj8qXqocw3vNN8YaGdI5ukKlTwLEcUWxXtHIRE3wZLiaMUGM
 m+eRt/bYVqgmHRZ/rOQLyqiiNM+Wf/3ODeiRQzIfIofIz759BIdiexUIa0nWInOt+1cv
 IM7g==
X-Gm-Message-State: APjAAAWJgAorBuvGFOBJnUuomhigq4fESClvKhAvLvGv+Xo4/GDFbHYy
 IeAy8ZwzDKyxWgoDMxuRrSVW9RjLDHQ/sAxMT84MQiKOl54GJb04YVSc/u6Lx/POIiXJHCNlezA
 jD7LuncVB81l1T3A=
X-Received: by 2002:a5d:4644:: with SMTP id j4mr2879861wrs.355.1571326312493; 
 Thu, 17 Oct 2019 08:31:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwoIjP3X5/5M57pPiqoVb4QqAFAlZi3TJe2flVh04t5Rg9ZUsN3ciAgDSe7HR76Hc+W9yzeqA==
X-Received: by 2002:a5d:4644:: with SMTP id j4mr2879827wrs.355.1571326312297; 
 Thu, 17 Oct 2019 08:31:52 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id g1sm2872055wrv.68.2019.10.17.08.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:31:51 -0700 (PDT)
Subject: Re: [PATCH 02/32] hw/i386/pc: Move kvm_i8259_init() declaration to
 sysemu/kvm.h
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-3-philmd@redhat.com>
 <1e8c724b-8846-255a-eace-6bf135471566@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1e1bffc6-a7cc-5beb-3f9f-da8e644c8d4b@redhat.com>
Date: Thu, 17 Oct 2019 17:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1e8c724b-8846-255a-eace-6bf135471566@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 5:04 PM, Thomas Huth wrote:
> On 15/10/2019 18.26, Philippe Mathieu-Daud=C3=A9 wrote:
>> Move the KVM-related call to "sysemu/kvm.h".
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   include/hw/i386/pc.h | 1 -
>>   include/sysemu/kvm.h | 1 +
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 6df4f4b6fb..09e74e7764 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -158,7 +158,6 @@ typedef struct PCMachineClass {
>>  =20
>>   extern DeviceState *isa_pic;
>>   qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq);
>> -qemu_irq *kvm_i8259_init(ISABus *bus);
>>   int pic_read_irq(DeviceState *d);
>>   int pic_get_output(DeviceState *d);
>>  =20
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index 9d143282bc..da8aa9f5a8 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -513,6 +513,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu=
_irq irq, int gsi);
>>   void kvm_pc_gsi_handler(void *opaque, int n, int level);
>>   void kvm_pc_setup_irq_routing(bool pci_enabled);
>>   void kvm_init_irq_routing(KVMState *s);
>> +qemu_irq *kvm_i8259_init(ISABus *bus);
>=20
> Why? The function is defined in hw/i386/kvm/ - so moving its prototype
> to a generic header sounds wrong to me.

This function is declared when compiling without KVM, and is available=20
on the Alpha/HPPA/MIPS which don't have it.

You'd rather move the kvm_pc_* declarations to hw/i386/kvm/?

