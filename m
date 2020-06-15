Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD68C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2872065F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELHbFKjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2872065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkkug-0003lT-Ro
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 04:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkktw-0003Fg-8K
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 04:55:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51953
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkktt-0005pJ-IR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 04:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592211328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=yCPSo4YzpQL5us3gsXo09LxPjK/O0NMCypbXJcOJyac=;
 b=ELHbFKjp0BCuNyqW6gqDYB7RQ2NzyxDBurjUXdNOAKYDZffYJKlokIyLB7cM5O2KvaeJB4
 o/69njbz3g9dMK5lhuZMbUKVlQGzOBEzWS9r+QW9TDLDPBxYiWZoi9+fXApNDJWyMn++yJ
 e9xdRz9BF9yzdErT541xN3bHTk6DF/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-woOMFP9OOHuGIVnhBA_RBQ-1; Mon, 15 Jun 2020 04:55:24 -0400
X-MC-Unique: woOMFP9OOHuGIVnhBA_RBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DD48BFC7;
 Mon, 15 Jun 2020 08:55:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-111.ams2.redhat.com [10.36.112.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 243FB60BF1;
 Mon, 15 Jun 2020 08:55:20 +0000 (UTC)
Subject: Re: [PATCH for-5.1 V4 1/4] hw/mips: Implement the kvm_type() hook in
 MachineClass
To: Huacai Chen <chenhuacai@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-2-git-send-email-chenhc@lemote.com>
 <CAHiYmc5o3GdzEeCm5KGM0kDJcGXbJ=syd9sFEg1AqLOirFNg-Q@mail.gmail.com>
 <CAAhV-H6KHOLDstUQvOV+8T872R_mLH-ZYHG1YaA6FSqd5meovw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <653db100-34fb-6cbd-215b-e4d931cc5e07@redhat.com>
Date: Mon, 15 Jun 2020 10:55:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6KHOLDstUQvOV+8T872R_mLH-ZYHG1YaA6FSqd5meovw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 22:37:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/06/2020 02.52, Huacai Chen wrote:
> Hi, Aleksandar,
> 
> On Sun, Jun 14, 2020 at 4:07 PM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
>>
>>
>>
>> уто, 2. јун 2020. у 04:38 Huacai Chen <zltjiangshi@gmail.com> је написао/ла:
>>>
>>> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
>>> can't create a VZ guest in QEMU because it lacks the kvm_type() hook in
>>> MachineClass. Besides, libvirt uses a null-machine to detect the kvm
>>> capability, so by default it will return "KVM not supported" on a VZ
>>> platform. Thus, null-machine also need the kvm_type() hook.
>>>
>>> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>
>> Huacai,
>>
>> Please take a look at Peter's remarks at:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg01878.html
>>
>> ...and refactor this patch for v5. My general advice: The simpler, the batter.
>>
> OK, I will rework this patch.

 Hi,

is there maybe also a way to do this without moving null-machine.o from
common-obj-y to obj-y, and to avoid the target-specific hacks in this
file ? We just moved the null-machine from obj-y to common-obj-y two
years ago (see commit 3858ff763985fb9e), since it's more desirable to
have as much code in common-obj to save compilation time and maybe to be
able to link a qemu with more than one target CPU in one binary one day...

ppc64 has also more than one kvm_type (kvm-hv and kvm-pr), and
apparently it also works without hacks to the null-machine code there
... so maybe you can peek into the ppc64 code to see how it is solved there?

 Thomas


>>>  hw/core/Makefile.objs  |  2 +-
>>>  hw/core/null-machine.c |  4 ++++
>>>  hw/mips/Makefile.objs  |  2 +-
>>>  hw/mips/common.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>  include/hw/mips/mips.h |  3 +++
>>>  5 files changed, 51 insertions(+), 2 deletions(-)
>>>  create mode 100644 hw/mips/common.c
>>>
>>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>>> index 1d540ed..b5672f4 100644
>>> --- a/hw/core/Makefile.objs
>>> +++ b/hw/core/Makefile.objs
>>> @@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) += vm-change-state-handler.o
>>>  common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
>>>  common-obj-$(CONFIG_SOFTMMU) += sysbus.o
>>>  common-obj-$(CONFIG_SOFTMMU) += machine.o
>>> -common-obj-$(CONFIG_SOFTMMU) += null-machine.o
>>>  common-obj-$(CONFIG_SOFTMMU) += loader.o
>>>  common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
>>>  common-obj-$(CONFIG_SOFTMMU) += numa.o
>>>  common-obj-$(CONFIG_SOFTMMU) += clock-vmstate.o
>>> +obj-$(CONFIG_SOFTMMU) += null-machine.o
>>>  obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
>>>
>>>  common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
>>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
>>> index cb47d9d..94a36f9 100644
>>> --- a/hw/core/null-machine.c
>>> +++ b/hw/core/null-machine.c
>>> @@ -17,6 +17,7 @@
>>>  #include "sysemu/sysemu.h"
>>>  #include "exec/address-spaces.h"
>>>  #include "hw/core/cpu.h"
>>> +#include "hw/mips/mips.h"
>>>
>>>  static void machine_none_init(MachineState *mch)
>>>  {
>>> @@ -50,6 +51,9 @@ static void machine_none_machine_init(MachineClass *mc)
>>>      mc->max_cpus = 1;
>>>      mc->default_ram_size = 0;
>>>      mc->default_ram_id = "ram";
>>> +#ifdef TARGET_MIPS
>>> +    mc->kvm_type = mips_kvm_type;
>>> +#endif
>>>  }
>>>
>>>  DEFINE_MACHINE("none", machine_none_machine_init)
>>> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
>>> index 739e2b7..3b3e6ea 100644
>>> --- a/hw/mips/Makefile.objs
>>> +++ b/hw/mips/Makefile.objs
>>> @@ -1,4 +1,4 @@
>>> -obj-y += addr.o mips_int.o
>>> +obj-y += addr.o common.o mips_int.o
>>>  obj-$(CONFIG_R4K) += r4k.o
>>>  obj-$(CONFIG_MALTA) += gt64xxx_pci.o malta.o
>>>  obj-$(CONFIG_MIPSSIM) += mipssim.o
>>> diff --git a/hw/mips/common.c b/hw/mips/common.c
>>> new file mode 100644
>>> index 0000000..4d8e141
>>> --- /dev/null
>>> +++ b/hw/mips/common.c
>>> @@ -0,0 +1,42 @@
>>> +/*
>>> + * Common MIPS routines
>>> + *
>>> + * Copyright (c) 2020 Huacai Chen (chenhc@lemote.com)
>>> + * This code is licensed under the GNU GPL v2.
>>> + */
>>> +
>>> +#include <linux/kvm.h>
>>> +#include "qemu/osdep.h"
>>> +#include "qemu-common.h"
>>> +#include "hw/boards.h"
>>> +#include "hw/mips/mips.h"
>>> +#include "sysemu/kvm_int.h"
>>> +
>>> +#ifndef CONFIG_KVM
>>> +
>>> +int mips_kvm_type(MachineState *machine, const char *vm_type)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +#else
>>> +
>>> +int mips_kvm_type(MachineState *machine, const char *vm_type)
>>> +{
>>> +    int r;
>>> +    KVMState *s = KVM_STATE(machine->accelerator);
>>> +
>>> +    r = kvm_check_extension(s, KVM_CAP_MIPS_VZ);
>>> +    if (r > 0) {
>>> +        return KVM_VM_MIPS_VZ;
>>> +    }
>>> +
>>> +    r = kvm_check_extension(s, KVM_CAP_MIPS_TE);
>>> +    if (r > 0) {
>>> +        return KVM_VM_MIPS_TE;
>>> +    }
>>> +
>>> +    return -1;
>>> +}
>>> +
>>> +#endif
>>> diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
>>> index 0af4c3d..2ac0580 100644
>>> --- a/include/hw/mips/mips.h
>>> +++ b/include/hw/mips/mips.h
>>> @@ -20,4 +20,7 @@ void rc4030_dma_write(void *dma, uint8_t *buf, int len);
>>>
>>>  DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr);
>>>
>>> +/* common.c */
>>> +int mips_kvm_type(MachineState *machine, const char *vm_type);
>>> +
>>>  #endif
>>> --
>>> 2.7.0
>>>
> 


