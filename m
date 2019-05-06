Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B79C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EA220449
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EA220449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57581 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNenl-00070d-Jq
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:41:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNemW-0006B7-N9
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNemV-0007n5-Kd
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:39:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hNemQ-0007bq-HH; Mon, 06 May 2019 10:39:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F87C309B149;
	Mon,  6 May 2019 14:39:45 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-124-221.rdu2.redhat.com
	[10.10.124.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E9CEB57DE8;
	Mon,  6 May 2019 14:39:41 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20190505200602.12412-1-philmd@redhat.com>
	<20190505200602.12412-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <310808da-71c5-19d8-be81-ae255682e79e@redhat.com>
Date: Mon, 6 May 2019 16:39:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190505200602.12412-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 06 May 2019 14:39:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/block/pflash_cfi01: Removed an
 unused timer
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/05/19 22:05, Philippe Mathieu-Daud=C3=A9 wrote:
> The 'CFI01' NOR flash was introduced in commit 29133e9a0fff, with
> timing modelled. One year later, the CFI02 model was introduced
> (commit 05ee37ebf630) based on the CFI01 model. As noted in the

You got those commit references backwards, I believe:

* Commit 29133e9a0fff ("AMD NOR flash device support (initial patch by
Jocelyn Mayer)", 2006-06-25) introduced "hw/pflash_cfi02.c".

* Commit 05ee37ebf630 ("Gumstix 'connex' board support by Thorsten
Zitterell.", 2007-11-17) introduced "hw/pflash_cfi01.c".

> header, "It does not support timings". 12 years later, we never
> had to model the device timings. Time to remove the unused timer,
> we can still add it back if required.
>=20
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Yes, I plan to model those timings later. Actually I have a series
> working, but I'd rather first
> 1/ refactor common code between the both CFI implementations,

Good idea.

> 2/ discuss on list whether or not use timings for the Virt flash.

What would the timer buy us (specifically wrt. cfi01 / OVMF / ArmVirt)?

Being faithful to actual hardware is always good... except when it runs
a significant risk of regressions. :) By that I don't mean "programming
errors"; I mean that guest code would now have to conform to various
timeouts, and that always makes me a bit concerned.


For this patch, with the commit references fixed:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks,
Laszlo

> ---
>  hw/block/pflash_cfi01.c | 15 ---------------
>  1 file changed, 15 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 16dfae14b80..6dc04f156a7 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -42,7 +42,6 @@
>  #include "hw/block/flash.h"
>  #include "sysemu/block-backend.h"
>  #include "qapi/error.h"
> -#include "qemu/timer.h"
>  #include "qemu/bitops.h"
>  #include "qemu/host-utils.h"
>  #include "qemu/log.h"
> @@ -86,7 +85,6 @@ struct PFlashCFI01 {
>      uint8_t cfi_table[0x52];
>      uint64_t counter;
>      unsigned int writeblock_size;
> -    QEMUTimer *timer;
>      MemoryRegion mem;
>      char *name;
>      void *storage;
> @@ -110,18 +108,6 @@ static const VMStateDescription vmstate_pflash =3D=
 {
>      }
>  };
> =20
> -static void pflash_timer (void *opaque)
> -{
> -    PFlashCFI01 *pfl =3D opaque;
> -
> -    trace_pflash_timer_expired(pfl->cmd);
> -    /* Reset flash */
> -    pfl->status ^=3D 0x80;
> -    memory_region_rom_device_set_romd(&pfl->mem, true);
> -    pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> -}
> -
>  /* Perform a CFI query based on the bank width of the flash.
>   * If this code is called we know we have a device_width set for
>   * this flash.
> @@ -771,7 +757,6 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
>          pfl->max_device_width =3D pfl->device_width;
>      }
> =20
> -    pfl->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, pflash_timer, pfl)=
;
>      pfl->wcycle =3D 0;
>      pfl->cmd =3D 0;
>      pfl->status =3D 0;
>=20


