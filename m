Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55229C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277642082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277642082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvU3-0008H6-Ao
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:40:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEvG2-00032q-Ft
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEvG1-0002jY-Aw
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hEvFs-0002dJ-G8; Fri, 12 Apr 2019 08:26:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAAA23088B80;
	Fri, 12 Apr 2019 12:26:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D3245D6A9;
	Fri, 12 Apr 2019 12:26:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E40EA1138648; Fri, 12 Apr 2019 14:26:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
References: <20190411135602.21725-1-armbru@redhat.com>
	<20190411135602.21725-2-armbru@redhat.com>
	<0eea5ddb-1efb-8fdf-4a37-9bc2daf86e2b@redhat.com>
	<03fb5b6f-7d95-3b9b-3172-e37825402036@redhat.com>
	<8d6c1ced-1e7b-9e52-3afb-3fe1197f7a02@redhat.com>
	<87bm1br788.fsf@dusky.pond.sub.org>
Date: Fri, 12 Apr 2019 14:26:01 +0200
In-Reply-To: <87bm1br788.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 12 Apr 2019 09:52:07 +0200")
Message-ID: <87tvf3o1eu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 12:26:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] pflash_cfi01: New
 pflash_cfi01_legacy_drive()
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, mreitz@redhat.com, qemu-arm@nongnu.org,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412122601.eVEub-CvEynQCypBWFcuOoJ-7BWHe0sb5OjlguC2V4w@z>

Markus Armbruster <armbru@redhat.com> writes:

> Laszlo Ersek <lersek@redhat.com> writes:
[...]
>> In other words, we could have written the pre-patch (original) code like
>> this:
>>
>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index c6285407748e..ed6e713d0982 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -291,9 +291,10 @@ void pc_system_firmware_init(PCMachineState *pcms,
>>              error_report("clashes with -machine");
>>              exit(1);
>>          }
>> -        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
>>          qdev_prop_set_drive(DEVICE(pcms->flash[i]),
>> -                            "drive", pflash_blk[i], &error_fatal);
>> +                            "drive", blk_by_legacy_dinfo(pflash_drv),
>> +                            &error_fatal);
>> +        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>>          loc_pop(&loc);
>>      }
>>
>> and the behavior would have been identical.
>>
>> For the sake of QOM / blk dummies like me, can you please split this
>> refactoring to a separate patch, before extracting the new function?
>
> If you think a preparatory patch is called for, I'll create one.
>
> I'd have difficulties coming up with a commit message for the one you
> proposed.
>
> I append a patch I can describe.  Would it work for you?
>
>
>
> pc: Split pc_system_firmware_init()'s legacy -drive loop
>
> The loop does two things: map legacy -drive to properties, and collect
> all the backends for use after the loop.  The next patch will factor
> out the former for reuse in hw/arm/virt.c.  To make that easier, do
> each thing in its own loop.

Inserting here:

  Note that the first loop updates pcms->flash[i]->blk for -drive
  if=pflash with qdev_prop_set_drive().  The second loop gets the
  (possibly updated) value from pflash_cfi01_get_blk().

>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/i386/pc_sysfw.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index c628540774..90db9b57a4 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -269,6 +269,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  {
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>      int i;
> +    BlockBackend *blk;
>      DriveInfo *pflash_drv;
>      BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>      Location loc;
> @@ -280,23 +281,26 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  
>      /* Map legacy -drive if=pflash to machine properties */
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> -        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
> +        blk = pflash_cfi01_get_blk(pcms->flash[i]);
>          pflash_drv = drive_get(IF_PFLASH, 0, i);
>          if (!pflash_drv) {
>              continue;
>          }
>          loc_push_none(&loc);
>          qemu_opts_loc_restore(pflash_drv->opts);
> -        if (pflash_blk[i]) {
> +        if (blk) {
>              error_report("clashes with -machine");
>              exit(1);
>          }
> -        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
> -        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
> -                            "drive", pflash_blk[i], &error_fatal);
> +        qdev_prop_set_drive(DEVICE(pcms->flash[i]), "drive",
> +                            blk_by_legacy_dinfo(pflash_drv), &error_fatal);
>          loc_pop(&loc);
>      }
>  
> +    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> +        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);

Uh, this should be pflash_cfi01_get_blk(pcms->flash[i]) instead.

> +    }
> +
>      /* Reject gaps */
>      for (i = 1; i < ARRAY_SIZE(pcms->flash); i++) {
>          if (pflash_blk[i] && !pflash_blk[i - 1]) {

