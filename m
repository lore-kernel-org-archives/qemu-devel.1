Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4371AC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1220821BE3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1220821BE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLvy-0005xW-5N
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56400)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvLvS-0005Wc-Mr
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvLvR-0004KR-Df
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:24:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvLvR-0004K6-70
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:24:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id k2so5519813wrq.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b6KPpo+ug99vOAqR4otVRS2JMRpeqaLi7HxQyZWfBFA=;
 b=roEQxGghsiEoe7i7t7TCbRdkV1C9sD5bjrnPmY0s032tVf+1r7hHUmhDAm9K4NnNPW
 DdhSJukGF0PXeDtjbdFxkYGqYj9O+z5aqkPp4j3N9X/xadfq0xqu3ikOiqJx04J6nYZq
 ab8eMBZy3zSDZiuCcrzjhNV+JfzhqCshqW67q0BxeWioXorp8F+q/SO5rZYQKQf8GZvR
 DG1WvZIAfB2+OqNSxU4XE0ZQPfaR1I8fPeApSKvg95wVXF5PGX1qCOmeE9UxJEoExITX
 6rzEDOlEdgc8ZjLVIV2YGmHnR50XbnKXkNQPNoqixk8jKAO5GZ5w2N3kHVVh8gGzwFsB
 cdmQ==
X-Gm-Message-State: APjAAAWN3mgWYCzMJS8TZkADSSariBU4YOW3KwABuaT9cdu9H4AqM2x+
 EJQPe9/jb3RHGVEUEMUn0Va6eA==
X-Google-Smtp-Source: APXvYqxjO7wKj+shQCZDrliuqiKfhmEgeG1KmI7f6p2YubB4/60SPRxVd3HJ5VF6BfI6s70loSkGPA==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr10568907wrp.116.1565184260080; 
 Wed, 07 Aug 2019 06:24:20 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id v23sm82458613wmj.32.2019.08.07.06.24.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 06:24:19 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dd5a7bd9-a9b6-b388-855c-36755a74fa55@redhat.com>
Date: Wed, 7 Aug 2019 15:24:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-28-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 5:14 PM, Markus Armbruster wrote:
> In my "build everything" tree, changing sysemu/sysemu.h triggers a
> recompile of some 5400 out of 6600 objects (not counting tests and
> objects that don't depend on qemu/osdep.h).
> 
> hw/qdev-core.h includes sysemu/sysemu.h since recent commit e965ffa70a
> "qdev: add qdev_add_vm_change_state_handler()".  This is a bad idea:
> hw/qdev-core.h is widely included.
> 
> Move the declaration of qdev_add_vm_change_state_handler() to
> sysemu/sysemu.h, and drop the problematic include from hw/qdev-core.h.
> 
> Touching sysemu/sysemu.h now recompiles some 1800 objects.
> qemu/uuid.h also drops from 5400 to 1800.  A few more headers show
> smaller improvement: qemu/notify.h drops from 5600 to 5200,
> qemu/timer.h from 5600 to 4500, and qapi/qapi-types-run-state.h from
> 5500 to 5000.
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  accel/kvm/kvm-all.c               | 1 +
>  backends/hostmem.c                | 1 +
>  cpus.c                            | 1 +
>  hw/arm/allwinner-a10.c            | 1 +
>  hw/arm/aspeed_soc.c               | 1 +
>  hw/arm/kzm.c                      | 1 +
>  hw/arm/msf2-soc.c                 | 1 +
>  hw/arm/stm32f205_soc.c            | 1 +
>  hw/char/serial-isa.c              | 1 +
>  hw/char/xen_console.c             | 1 +
>  hw/core/numa.c                    | 1 +
>  hw/core/vm-change-state-handler.c | 1 +
>  hw/display/qxl-render.c           | 1 +
>  hw/i386/xen/xen-hvm.c             | 1 +
>  hw/i386/xen/xen-mapcache.c        | 1 +
>  hw/intc/ioapic.c                  | 1 +
>  hw/pci/pci.c                      | 1 +
>  hw/riscv/sifive_e.c               | 1 +
>  hw/riscv/sifive_u.c               | 1 +
>  hw/riscv/spike.c                  | 1 +
>  hw/riscv/virt.c                   | 1 +
>  hw/sparc64/niagara.c              | 2 +-
>  hw/usb/hcd-ehci.h                 | 1 +
>  hw/xen/xen-common.c               | 1 +
>  hw/xen/xen_devconfig.c            | 1 +
>  hw/xenpv/xen_machine_pv.c         | 1 +
>  include/hw/qdev-core.h            | 5 -----
>  include/sysemu/sysemu.h           | 3 +++
>  migration/global_state.c          | 1 +
>  migration/migration.c             | 1 +
>  migration/savevm.c                | 1 +
>  31 files changed, 32 insertions(+), 6 deletions(-)
> 
[...]
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index e5b62dd2fc..de70b7a19a 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -5,7 +5,6 @@
>  #include "qemu/bitmap.h"
>  #include "qom/object.h"
>  #include "hw/hotplug.h"
> -#include "sysemu/sysemu.h"

Another build errors on OSX:

ui/cocoa.m:445:10: error: use of undeclared identifier 'cursor_hide'
    if (!cursor_hide) {
         ^
ui/cocoa.m:453:10: error: use of undeclared identifier 'cursor_hide'
    if (!cursor_hide) {
         ^
ui/cocoa.m:596:13: error: use of undeclared identifier 'qemu_name'
        if (qemu_name)
            ^
warning: format specifies type 'char *' but the argument has type
'<dependent type>' [-Wformat]
ui/cocoa.m:597:75: error: use of undeclared identifier 'qemu_name'
            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU
%s", qemu_name]];
                                                                         ^
ui/cocoa.m:995:13: error: use of undeclared identifier 'qemu_name'
        if (qemu_name)
            ^
warning: format specifies type 'char *' but the argument has type
'<dependent type>' [-Wformat]
ui/cocoa.m:996:117: error: use of undeclared identifier 'qemu_name'
            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s
- (Press ctrl + alt + g to release Mouse)", qemu_name]];

                                            ^
ui/cocoa.m:1013:13: error: use of undeclared identifier 'qemu_name'
        if (qemu_name)
            ^
warning: format specifies type 'char *' but the argument has type
'<dependent type>' [-Wformat]
ui/cocoa.m:1014:75: error: use of undeclared identifier 'qemu_name'
            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU
%s", qemu_name]];
                                                                          ^
ui/cocoa.m:1164:5: warning: implicit declaration of function
'qemu_system_shutdown_request' is invalid in C99
[-Wimplicit-function-declaration]
    qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
    ^
ui/cocoa.m:1164:5: warning: this function declaration is not a prototype
[-Wstrict-prototypes]
make: *** [ui/cocoa.o] Error 1

>  
>  enum {
>      DEV_NVECTORS_UNSPECIFIED = -1,
> @@ -451,8 +450,4 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
>  void device_listener_register(DeviceListener *listener);
>  void device_listener_unregister(DeviceListener *listener);
>  
> -VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
> -                                                     VMChangeStateHandler *cb,
> -                                                     void *opaque);
> -
>  #endif
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 227202999d..908f158677 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -29,6 +29,9 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>                                                       void *opaque);
>  VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>          VMChangeStateHandler *cb, void *opaque, int priority);
> +VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
> +                                                     VMChangeStateHandler *cb,
> +                                                     void *opaque);
>  void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
>  void vm_state_notify(int running, RunState state);

