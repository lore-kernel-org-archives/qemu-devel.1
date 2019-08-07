Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F086C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 21:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4371B217D9
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 21:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4371B217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvT8Y-0003C6-KK
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 17:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38471)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvT7t-0002lp-AR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 17:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvT7s-0002PV-6K
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 17:05:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvT7s-0002Nb-0I
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 17:05:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so92850047wru.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 14:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jf/+Im+Z8OH28EvG5pMpMiuRsKkqx6ATBQtsR3ME5Ms=;
 b=ggz78ry5jXeUcVdqsQdyfEtWY6fBzUY4dLjE/zV5lU+MAKF2HC8BMHN0QqSVAxyNbW
 DX0Ig57vnN3191hQAM7yhNC+F48h6IV1gAS0CQntjdBqVNCdpIDVh0a2xRKGr2mUPZO7
 xKZKVrd4y9WicS0YQ67r9Lfk1hmK3SBZH0NHNtyk904l3p0C0g7ykkZwt07LKXzseVlZ
 AjGfyh1voFdW58qyLlVKVgFhVa8ik6lGm/4y3+9qvfKTuBvm8UaldS7Xd9HRTfKqikGP
 yQL8KQLPxLuBmtHTMTwyWAI7RHURLAoIcKItnLH3/3CeZNKakftzV+rekOIQfU075srP
 YKpQ==
X-Gm-Message-State: APjAAAWVDAf3HQzScMjWJ2eLMrXw/WQXDEOadSUGdnRnjNmlA1PKsDcG
 3msZzED/4LBVys00WSvehfhgqw==
X-Google-Smtp-Source: APXvYqwt6KO06pa1UoCbEqRHS0OYjoizAIKM3Q1HgMWeEloRDRXprTK7tqsRArDxuPwZwBpiJNd6hA==
X-Received: by 2002:adf:e390:: with SMTP id e16mr4111149wrm.153.1565211938194; 
 Wed, 07 Aug 2019 14:05:38 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id q124sm206805wma.33.2019.08.07.14.05.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 14:05:37 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
Date: Wed, 7 Aug 2019 23:05:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87a7ckrat7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 27/29] Include sysemu/sysemu.h a lot less
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 10:16 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>>> In my "build everything" tree, changing sysemu/sysemu.h triggers a
>>> recompile of some 5400 out of 6600 objects (not counting tests and
>>> objects that don't depend on qemu/osdep.h).
>>>
>>> hw/qdev-core.h includes sysemu/sysemu.h since recent commit e965ffa70a
>>> "qdev: add qdev_add_vm_change_state_handler()".  This is a bad idea:
>>> hw/qdev-core.h is widely included.
>>>
>>> Move the declaration of qdev_add_vm_change_state_handler() to
>>> sysemu/sysemu.h, and drop the problematic include from hw/qdev-core.h.
>>>
>>> Touching sysemu/sysemu.h now recompiles some 1800 objects.
>>> qemu/uuid.h also drops from 5400 to 1800.  A few more headers show
>>> smaller improvement: qemu/notify.h drops from 5600 to 5200,
>>> qemu/timer.h from 5600 to 4500, and qapi/qapi-types-run-state.h from
>>> 5500 to 5000.
>>>
>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  accel/kvm/kvm-all.c               | 1 +
>>>  backends/hostmem.c                | 1 +
>>>  cpus.c                            | 1 +
>>>  hw/arm/allwinner-a10.c            | 1 +
>>>  hw/arm/aspeed_soc.c               | 1 +
>>>  hw/arm/kzm.c                      | 1 +
>>>  hw/arm/msf2-soc.c                 | 1 +
>>>  hw/arm/stm32f205_soc.c            | 1 +
>>>  hw/char/serial-isa.c              | 1 +
>>>  hw/char/xen_console.c             | 1 +
>>>  hw/core/numa.c                    | 1 +
>>>  hw/core/vm-change-state-handler.c | 1 +
>>>  hw/display/qxl-render.c           | 1 +
>>>  hw/i386/xen/xen-hvm.c             | 1 +
>>>  hw/i386/xen/xen-mapcache.c        | 1 +
>>>  hw/intc/ioapic.c                  | 1 +
>>>  hw/pci/pci.c                      | 1 +
>>>  hw/riscv/sifive_e.c               | 1 +
>>>  hw/riscv/sifive_u.c               | 1 +
>>>  hw/riscv/spike.c                  | 1 +
>>>  hw/riscv/virt.c                   | 1 +
>>>  hw/sparc64/niagara.c              | 2 +-
>>>  hw/usb/hcd-ehci.h                 | 1 +
>>>  hw/xen/xen-common.c               | 1 +
>>>  hw/xen/xen_devconfig.c            | 1 +
>>>  hw/xenpv/xen_machine_pv.c         | 1 +
>>>  include/hw/qdev-core.h            | 5 -----
>>>  include/sysemu/sysemu.h           | 3 +++
>>>  migration/global_state.c          | 1 +
>>>  migration/migration.c             | 1 +
>>>  migration/savevm.c                | 1 +
>>>  31 files changed, 32 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index e1a44eccf5..fc38d0b9e3 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -29,6 +29,7 @@
>>>  #include "exec/gdbstub.h"
>>>  #include "sysemu/kvm_int.h"
>>>  #include "sysemu/cpus.h"
>>> +#include "sysemu/sysemu.h"
>>>  #include "qemu/bswap.h"
>>>  #include "exec/memory.h"
>>>  #include "exec/ram_addr.h"
>>
>> Include missing in net/netmap.c:
>>
>>   CC      net/netmap.o
>> net/netmap.c: In function 'netmap_update_fd_handler':
>> net/netmap.c:108:5: error: implicit declaration of function
>> 'qemu_set_fd_handler' [-Werror=implicit-function-declaration]
>>      qemu_set_fd_handler(s->nmd->fd,
>>      ^~~~~~~~~~~~~~~~~~~
>> net/netmap.c:108:5: error: nested extern declaration of
>> 'qemu_set_fd_handler' [-Werror=nested-externs]
> 
> Can you tell me offhand what I have to install so configure enables
> CONFIG_NETMAP?

The steps are listed in tests/docker/dockerfiles/debian-amd64.docker,
but you can get to this point running:

  $ make docker-image-debian-amd64 V=1 DEBUG=1

This will build the docker image with netmap (so you don't have to mess
with your workstation setup), then build QEMU within the image.

