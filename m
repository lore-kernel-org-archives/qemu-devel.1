Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117D8C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9682199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9682199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvSMv-0004pY-TF
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 16:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58938)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvSMX-0004N4-0h
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvSMU-0002mb-Mp
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:16:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvSMP-0002Wd-5g
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:16:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 961F0309C386
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 20:16:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0E03608AB;
 Wed,  7 Aug 2019 20:16:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37FC3113864E; Wed,  7 Aug 2019 22:16:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
Date: Wed, 07 Aug 2019 22:16:04 +0200
In-Reply-To: <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Aug 2019 19:31:54
 +0200")
Message-ID: <87a7ckrat7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 07 Aug 2019 20:16:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>> In my "build everything" tree, changing sysemu/sysemu.h triggers a
>> recompile of some 5400 out of 6600 objects (not counting tests and
>> objects that don't depend on qemu/osdep.h).
>>=20
>> hw/qdev-core.h includes sysemu/sysemu.h since recent commit e965ffa70a
>> "qdev: add qdev_add_vm_change_state_handler()".  This is a bad idea:
>> hw/qdev-core.h is widely included.
>>=20
>> Move the declaration of qdev_add_vm_change_state_handler() to
>> sysemu/sysemu.h, and drop the problematic include from hw/qdev-core.h.
>>=20
>> Touching sysemu/sysemu.h now recompiles some 1800 objects.
>> qemu/uuid.h also drops from 5400 to 1800.  A few more headers show
>> smaller improvement: qemu/notify.h drops from 5600 to 5200,
>> qemu/timer.h from 5600 to 4500, and qapi/qapi-types-run-state.h from
>> 5500 to 5000.
>>=20
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  accel/kvm/kvm-all.c               | 1 +
>>  backends/hostmem.c                | 1 +
>>  cpus.c                            | 1 +
>>  hw/arm/allwinner-a10.c            | 1 +
>>  hw/arm/aspeed_soc.c               | 1 +
>>  hw/arm/kzm.c                      | 1 +
>>  hw/arm/msf2-soc.c                 | 1 +
>>  hw/arm/stm32f205_soc.c            | 1 +
>>  hw/char/serial-isa.c              | 1 +
>>  hw/char/xen_console.c             | 1 +
>>  hw/core/numa.c                    | 1 +
>>  hw/core/vm-change-state-handler.c | 1 +
>>  hw/display/qxl-render.c           | 1 +
>>  hw/i386/xen/xen-hvm.c             | 1 +
>>  hw/i386/xen/xen-mapcache.c        | 1 +
>>  hw/intc/ioapic.c                  | 1 +
>>  hw/pci/pci.c                      | 1 +
>>  hw/riscv/sifive_e.c               | 1 +
>>  hw/riscv/sifive_u.c               | 1 +
>>  hw/riscv/spike.c                  | 1 +
>>  hw/riscv/virt.c                   | 1 +
>>  hw/sparc64/niagara.c              | 2 +-
>>  hw/usb/hcd-ehci.h                 | 1 +
>>  hw/xen/xen-common.c               | 1 +
>>  hw/xen/xen_devconfig.c            | 1 +
>>  hw/xenpv/xen_machine_pv.c         | 1 +
>>  include/hw/qdev-core.h            | 5 -----
>>  include/sysemu/sysemu.h           | 3 +++
>>  migration/global_state.c          | 1 +
>>  migration/migration.c             | 1 +
>>  migration/savevm.c                | 1 +
>>  31 files changed, 32 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index e1a44eccf5..fc38d0b9e3 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -29,6 +29,7 @@
>>  #include "exec/gdbstub.h"
>>  #include "sysemu/kvm_int.h"
>>  #include "sysemu/cpus.h"
>> +#include "sysemu/sysemu.h"
>>  #include "qemu/bswap.h"
>>  #include "exec/memory.h"
>>  #include "exec/ram_addr.h"
>
> Include missing in net/netmap.c:
>
>   CC      net/netmap.o
> net/netmap.c: In function 'netmap_update_fd_handler':
> net/netmap.c:108:5: error: implicit declaration of function
> 'qemu_set_fd_handler' [-Werror=3Dimplicit-function-declaration]
>      qemu_set_fd_handler(s->nmd->fd,
>      ^~~~~~~~~~~~~~~~~~~
> net/netmap.c:108:5: error: nested extern declaration of
> 'qemu_set_fd_handler' [-Werror=3Dnested-externs]

Can you tell me offhand what I have to install so configure enables
CONFIG_NETMAP?

