Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1D0C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07832199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07832199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvSPH-00067k-VA
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 16:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59431)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvSOs-0005hA-UB
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvSOr-0007pE-EP
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:19:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvSOr-0007nc-6w
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:19:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8312D87648;
 Wed,  7 Aug 2019 20:19:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 268745D9CD;
 Wed,  7 Aug 2019 20:19:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97E32113864E; Wed,  7 Aug 2019 22:19:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-29-armbru@redhat.com>
 <87h86thu8n.fsf@linaro.org>
Date: Wed, 07 Aug 2019 22:19:01 +0200
In-Reply-To: <87h86thu8n.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 07 Aug 2019 16:26:32 +0100")
Message-ID: <875zn8raoa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 07 Aug 2019 20:19:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 28/29] sysemu: Move the
 VMChangeStateEntry typedef to qemu/typedefs.h
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> In my "build everything" tree, changing sysemu/sysemu.h triggers a
>> recompile of some 1800 out of 6600 objects (not counting tests and
>> objects that don't depend on qemu/osdep.h, down from 5400 due to the
>> previous commit).
>>
>> Several headers include sysemu/sysemu.h just to get typedef
>> VMChangeStateEntry.  Move it from sysemu/sysemu.h to qemu/typedefs.h.
>> Spell its structure tag the same while there.
>>
>> Touching sysemu/sysemu.h now recompiles some 1100 objects.
>> qemu/uuid.h also drops from 1800 to 1100, and
>> qapi/qapi-types-run-state.h from 5000 to 4400.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/block/vhost-user-blk.c   | 1 +
>>  hw/block/virtio-blk.c       | 1 +
>>  hw/display/virtio-gpu.c     | 1 +
>>  hw/misc/macio/macio.c       | 1 +
>>  hw/net/virtio-net.c         | 1 +
>>  hw/s390x/s390-ccw.c         | 1 +
>>  hw/s390x/s390-virtio-ccw.c  | 1 +
>>  hw/scsi/scsi-bus.c          | 1 +
>>  hw/scsi/vhost-scsi.c        | 1 +
>>  hw/scsi/vhost-user-scsi.c   | 1 +
>>  hw/usb/hcd-ehci.c           | 1 +
>>  hw/usb/hcd-ehci.h           | 1 -
>>  hw/virtio/virtio-rng.c      | 1 +
>>  hw/virtio/virtio.c          | 1 +
>>  include/hw/ide/internal.h   | 3 ++-
>>  include/hw/ppc/spapr_xive.h | 1 -
>>  include/hw/scsi/scsi.h      | 1 -
>>  include/hw/virtio/virtio.h  | 1 -
>>  include/qemu/typedefs.h     | 1 +
>>  include/sysemu/sysemu.h     | 1 -
>>  vl.c                        | 6 +++---
>>  21 files changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index 7b44cca6d9..6b6cd07362 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -28,6 +28,7 @@
>>  #include "hw/virtio/virtio.h"
>>  #include "hw/virtio/virtio-bus.h"
>>  #include "hw/virtio/virtio-access.h"
>> +#include "sysemu/sysemu.h"
>>
>>  static const int user_feature_bits[] =3D {
>>      VIRTIO_BLK_F_SIZE_MAX,
>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>> index 8cc2a232e0..78ac371eba 100644
>> --- a/hw/block/virtio-blk.c
>> +++ b/hw/block/virtio-blk.c
>> @@ -20,6 +20,7 @@
>>  #include "hw/block/block.h"
>>  #include "hw/qdev-properties.h"
>>  #include "sysemu/blockdev.h"
>> +#include "sysemu/sysemu.h"
>>  #include "hw/virtio/virtio-blk.h"
>>  #include "dataplane/virtio-blk.h"
>>  #include "scsi/constants.h"
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 6de9689a30..28e868c021 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -17,6 +17,7 @@
>>  #include "ui/console.h"
>>  #include "trace.h"
>>  #include "sysemu/dma.h"
>> +#include "sysemu/sysemu.h"
>>  #include "hw/virtio/virtio.h"
>>  #include "migration/qemu-file-types.h"
>>  #include "hw/virtio/virtio-gpu.h"
>> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
>> index b59df4e3b8..50f20d8206 100644
>> --- a/hw/misc/macio/macio.c
>> +++ b/hw/misc/macio/macio.c
>> @@ -35,6 +35,7 @@
>>  #include "hw/char/escc.h"
>>  #include "hw/misc/macio/macio.h"
>>  #include "hw/intc/heathrow_pic.h"
>> +#include "sysemu/sysemu.h"
>>  #include "trace.h"
>>
>>  /* Note: this code is strongly inspirated from the corresponding code
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 4113729fcf..9f11422337 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -31,6 +31,7 @@
>>  #include "hw/virtio/virtio-access.h"
>>  #include "migration/misc.h"
>>  #include "standard-headers/linux/ethtool.h"
>> +#include "sysemu/sysemu.h"
>>  #include "trace.h"
>>
>>  #define VIRTIO_NET_VM_VERSION    11
>> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
>> index 22c6878b84..0c5a5b60bd 100644
>> --- a/hw/s390x/s390-ccw.c
>> +++ b/hw/s390x/s390-ccw.c
>> @@ -19,6 +19,7 @@
>>  #include "hw/s390x/css.h"
>>  #include "hw/s390x/css-bridge.h"
>>  #include "hw/s390x/s390-ccw.h"
>> +#include "sysemu/sysemu.h"
>>
>>  IOInstEnding s390_ccw_cmd_request(SubchDev *sch)
>>  {
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index a543b64e56..434d933ec9 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -40,6 +40,7 @@
>>  #include "hw/nmi.h"
>>  #include "hw/qdev-properties.h"
>>  #include "hw/s390x/tod.h"
>> +#include "sysemu/sysemu.h"
>>
>>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>  {
>> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>> index db785e6001..cb8e8d1f36 100644
>> --- a/hw/scsi/scsi-bus.c
>> +++ b/hw/scsi/scsi-bus.c
>> @@ -10,6 +10,7 @@
>>  #include "scsi/constants.h"
>>  #include "sysemu/block-backend.h"
>>  #include "sysemu/blockdev.h"
>> +#include "sysemu/sysemu.h"
>>  #include "trace.h"
>>  #include "sysemu/dma.h"
>>  #include "qemu/cutils.h"
>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>> index cd5cf1679d..c693fc748a 100644
>> --- a/hw/scsi/vhost-scsi.c
>> +++ b/hw/scsi/vhost-scsi.c
>> @@ -30,6 +30,7 @@
>>  #include "hw/fw-path-provider.h"
>>  #include "hw/qdev-properties.h"
>>  #include "qemu/cutils.h"
>> +#include "sysemu/sysemu.h"
>>
>>  /* Features supported by host kernel. */
>>  static const int kernel_feature_bits[] =3D {
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index a5be128b54..31c9d34637 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -28,6 +28,7 @@
>>  #include "hw/virtio/virtio.h"
>>  #include "hw/virtio/virtio-access.h"
>>  #include "chardev/char-fe.h"
>> +#include "sysemu/sysemu.h"
>>
>>  /* Features supported by the host application */
>>  static const int user_feature_bits[] =3D {
>> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
>> index d7d1ecd45d..e76c939751 100644
>> --- a/hw/usb/hcd-ehci.c
>> +++ b/hw/usb/hcd-ehci.c
>> @@ -35,6 +35,7 @@
>>  #include "trace.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/main-loop.h"
>> +#include "sysemu/sysemu.h"
>>
>>  #define FRAME_TIMER_FREQ 1000
>>  #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
>> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
>> index fdbcfdcbeb..0298238f0b 100644
>> --- a/hw/usb/hcd-ehci.h
>> +++ b/hw/usb/hcd-ehci.h
>> @@ -21,7 +21,6 @@
>>  #include "qemu/timer.h"
>>  #include "hw/usb.h"
>>  #include "sysemu/dma.h"
>> -#include "sysemu/sysemu.h"
>>  #include "hw/pci/pci.h"
>>  #include "hw/sysbus.h"
>>
>> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
>> index 34b4619fd3..c9c2414b7b 100644
>> --- a/hw/virtio/virtio-rng.c
>> +++ b/hw/virtio/virtio-rng.c
>> @@ -17,6 +17,7 @@
>>  #include "hw/qdev-properties.h"
>>  #include "hw/virtio/virtio-rng.h"
>>  #include "sysemu/rng.h"
>> +#include "sysemu/sysemu.h"
>>  #include "qom/object_interfaces.h"
>>  #include "trace.h"
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 721dcccc96..0ce142bc04 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -26,6 +26,7 @@
>>  #include "hw/qdev-properties.h"
>>  #include "hw/virtio/virtio-access.h"
>>  #include "sysemu/dma.h"
>> +#include "sysemu/sysemu.h"
>
> I'm confused - why do these now need to include sysemu.h if the only
> change to sysemu.h is to drop:
>
>  typedef struct vm_change_state_entry VMChangeStateEntry;
>
> in favour of the typedefs header?

The patch drops #include "sysemu/sysemu.h" from headers that only need
VMChangeStateEntry.  A bunch of .c that need more no longer get it from
these headers, and need to be patched up.

I'll amend the commit message to spell this out more clearly.

