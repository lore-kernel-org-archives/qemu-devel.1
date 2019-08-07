Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1D4C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 19:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A117C21EF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 19:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A117C21EF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvRtz-0002gg-S8
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 15:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53265)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvRtP-0002GD-9v
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 15:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvRtO-0007DC-57
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 15:46:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvRtN-00078d-PA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 15:46:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4E143002C7D
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 19:46:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A7CE5D9DC;
 Wed,  7 Aug 2019 19:46:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 072A1113864E; Wed,  7 Aug 2019 21:46:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-10-armbru@redhat.com>
 <b14e627d-d9e0-bd33-9f6f-c3e5cb59f8cd@redhat.com>
 <e529d823-f5db-bd34-197d-a4460938a6dc@redhat.com>
Date: Wed, 07 Aug 2019 21:46:30 +0200
In-Reply-To: <e529d823-f5db-bd34-197d-a4460938a6dc@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Aug 2019 19:30:08
 +0200")
Message-ID: <87sgqcrc6h.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 07 Aug 2019 19:46:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/29] Include
 migration/qemu-file-types.h a lot less
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/7/19 2:25 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>>> In my "build everything" tree, changing migration/qemu-file-types.h
>>> triggers a recompile of some 2600 out of 6600 objects (not counting
>>> tests and objects that don't depend on qemu/osdep.h).
>>>
>>> The culprit is again hw/hw.h, which supposedly includes it for
>>> convenience.
>>>
>>> Include migration/qemu-file-types.h only where it's needed.  Touching
>>> it now recompiles less than 200 objects.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  hw/acpi/piix4.c             | 1 +
>>>  hw/block/virtio-blk.c       | 1 +
>>>  hw/char/virtio-serial-bus.c | 1 +
>>>  hw/display/virtio-gpu.c     | 1 +
>>>  hw/intc/apic_common.c       | 1 +
>>>  hw/nvram/eeprom93xx.c       | 1 +
>>>  hw/nvram/fw_cfg.c           | 1 +
>>>  hw/pci-host/piix.c          | 1 +
>>>  hw/pci/msix.c               | 1 +
>>>  hw/pci/pci.c                | 1 +
>>>  hw/pci/shpc.c               | 1 +
>>>  hw/ppc/spapr.c              | 1 +
>>>  hw/s390x/s390-skeys.c       | 1 +
>>>  hw/s390x/tod.c              | 1 +
>>>  hw/s390x/virtio-ccw.c       | 1 +
>>>  hw/scsi/mptsas.c            | 1 +
>>>  hw/scsi/scsi-bus.c          | 1 +
>>>  hw/scsi/scsi-disk.c         | 1 +
>>>  hw/scsi/scsi-generic.c      | 1 +
>>>  hw/scsi/virtio-scsi.c       | 1 +
>>>  hw/timer/i8254_common.c     | 1 +
>>>  hw/timer/twl92230.c         | 1 +
>>>  hw/usb/redirect.c           | 1 +
>>>  hw/virtio/vhost.c           | 1 +
>>>  hw/virtio/virtio-mmio.c     | 1 +
>>>  hw/virtio/virtio-pci.c      | 1 +
>>>  hw/virtio/virtio.c          | 1 +
>>>  include/hw/hw.h             | 1 -
>>>  include/migration/cpu.h     | 1 +
>>>  target/ppc/kvm.c            | 1 +
>>>  30 files changed, 29 insertions(+), 1 deletion(-)
>> [...]
>>> diff --git a/include/hw/hw.h b/include/hw/hw.h
>>> index a4fb2390e8..b399627cbe 100644
>>> --- a/include/hw/hw.h
>>> +++ b/include/hw/hw.h
>>> @@ -11,7 +11,6 @@
>>>  #include "exec/memory.h"
>>>  #include "hw/irq.h"
>>>  #include "migration/vmstate.h"
>>> -#include "migration/qemu-file-types.h"
>>=20
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Oops another miss:
>
> hw/intc/s390_flic_kvm.c: In function 'kvm_flic_save':
> hw/intc/s390_flic_kvm.c:395:9: error: implicit declaration of function
> 'qemu_put_be64' [-Werror=3Dimplicit-function-declaration]
>          qemu_put_be64(f, FLIC_FAILED);
>          ^~~~~~~~~~~~~

Patchew found this, too.  I'll fix it.  Thanks!

