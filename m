Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA73AC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 12:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF620214C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 12:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF620214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvhMT-0006ta-Ux
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 08:17:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34122)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvhLo-0006Th-NP
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvhLn-0005lr-HT
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:17:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvhLn-0005kP-9m
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:16:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 76903300895B
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 12:16:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB0D2194B9;
 Thu,  8 Aug 2019 12:16:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 25428113864E; Thu,  8 Aug 2019 14:16:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-17-armbru@redhat.com>
 <2739ad81-5e97-a7a6-8888-587224032a80@redhat.com>
Date: Thu, 08 Aug 2019 14:16:51 +0200
In-Reply-To: <2739ad81-5e97-a7a6-8888-587224032a80@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Aug 2019 16:50:44
 +0200")
Message-ID: <87y303g8cs.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 08 Aug 2019 12:16:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 16/29] Include exec/memory.h slightly
 less
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

> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>> Drop unnecessary inclusions from headers.  Downgrade a few more to
>> exec/hwaddr.h.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/audio/lm4549.h                   | 1 +
>>  hw/display/edid-region.c            | 1 +
>>  hw/display/tc6393xb.c               | 1 +
>>  hw/net/can/can_sja1000.h            | 1 +
>>  hw/net/ne2000.c                     | 1 +
>>  hw/xtensa/xtensa_memory.h           | 1 -
>>  include/hw/arm/boot.h               | 1 -
>>  include/hw/arm/fsl-imx7.h           | 1 -
>>  include/hw/arm/soc_dma.h            | 2 +-
>>  include/hw/block/flash.h            | 2 +-
>>  include/hw/boards.h                 | 1 +
>>  include/hw/char/parallel.h          | 1 -
>>  include/hw/display/milkymist_tmu2.h | 1 +
>>  include/hw/display/tc6393xb.h       | 2 --
>>  include/hw/display/vga.h            | 2 +-
>>  include/hw/hw.h                     | 1 -
>>  include/hw/i2c/pm_smbus.h           | 1 +
>>  include/hw/i2c/smbus_eeprom.h       | 1 +
>>  include/hw/misc/auxbus.h            | 1 +
>>  include/hw/ppc/xics.h               | 1 +
>>  include/hw/usb.h                    | 1 +
>>  include/hw/virtio/virtio.h          | 1 +
>>  migration/colo.c                    | 1 +
>>  migration/migration.h               | 1 +
>>  migration/postcopy-ram.c            | 1 +
>>  migration/rdma.c                    | 1 +
>>  26 files changed, 20 insertions(+), 10 deletions(-)
>>=20
> [...]> diff --git a/migration/colo.c b/migration/colo.c
>> index 9f84b1fa3c..0b5b620391 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -23,6 +23,7 @@
>>  #include "io/channel-buffer.h"
>>  #include "trace.h"
>>  #include "qemu/error-report.h"
>> +#include "qemu/rcu.h"
>>  #include "migration/failover.h"
>>  #ifdef CONFIG_REPLICATION
>>  #include "replication.h"
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 26f01d00f6..a7882af67a 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -14,6 +14,7 @@
>>  #ifndef QEMU_MIGRATION_H
>>  #define QEMU_MIGRATION_H
>>=20=20
>> +#include "exec/cpu-common.h"
>>  #include "qapi/qapi-types-migration.h"
>>  #include "qemu/thread.h"
>>  #include "qemu/coroutine_int.h"
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index 9faacacc9e..56054d0a73 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -25,6 +25,7 @@
>>  #include "ram.h"
>>  #include "qapi/error.h"
>>  #include "qemu/notify.h"
>> +#include "qemu/rcu.h"
>>  #include "sysemu/sysemu.h"
>>  #include "sysemu/balloon.h"
>>  #include "qemu/error-report.h"
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 3036221ee8..b0e27b6174 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -25,6 +25,7 @@
>>  #include "qemu/error-report.h"
>>  #include "qemu/main-loop.h"
>>  #include "qemu/module.h"
>> +#include "qemu/rcu.h"
>>  #include "qemu/sockets.h"
>>  #include "qemu/bitmap.h"
>>  #include "qemu/coroutine.h"
>>=20
>
> To keep this patch cleaner, can you use a preparatory patch adding the
> various "qemu/rcu.h"?

How would I explain that new patch?

Other patches that drop includes from headers also fix up their users by
adding the includes that are actually needed there, e.g.:

* PATCH 03: hw/qdev-core.h dropped, fixups add only qemu/bitops.h or
  hw/irq.h.

* PATCH 10: hw/ide/internal.h dropped, some fixups add only
  exec/address-spaces.h or sysemu/sysemu.h.

* PATCH 17: qom/object.h dropped, fixup adds only hw/hw.h.

* PATCH 20: qemu/main-loop.h dropped, some fixups add only block/aio.h
  or qemu/thread.h.  Touches five times as many files as this one...

* More.

Does each of them need preparatory patches?

Would it help if their commit messages explained the fixups more
clearly?

