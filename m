Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84251C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154B8205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154B8205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36934 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGOA4-0004tp-8m
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:30:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGNmq-00033f-9y
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGNmp-0007az-Cj
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:06:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hGNmh-0006rn-9E; Tue, 16 Apr 2019 09:05:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A48AA307D985;
	Tue, 16 Apr 2019 13:05:17 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-171.rdu2.redhat.com
	[10.10.120.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC3AD5D71A;
	Tue, 16 Apr 2019 13:05:00 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190416091348.26075-1-armbru@redhat.com>
	<20190416091348.26075-2-armbru@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <67a714c4-d76b-06dc-cb88-71142f5fbce6@redhat.com>
Date: Tue, 16 Apr 2019 15:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190416091348.26075-2-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 16 Apr 2019 13:05:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] pc: Rearrange
 pc_system_firmware_init()'s legacy -drive loop
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
	mreitz@redhat.com, qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416130458.tOGg3KK2AClSsjr6b8IZbXE3cJtZwRGkeCnH3zyUnpQ@z>

On 04/16/19 11:13, Markus Armbruster wrote:
> The loop does two things: map legacy -drive to properties, and collect
> all the backends for use after the loop.  The next patch will factor
> out the former for reuse in hw/arm/virt.c.  To make that easier,
> rearrange the loop so it does the first thing first, and the second
> thing second.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/i386/pc_sysfw.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index c628540774..75925f5d3f 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -280,21 +280,19 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  
>      /* Map legacy -drive if=pflash to machine properties */
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> -        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>          pflash_drv = drive_get(IF_PFLASH, 0, i);
> -        if (!pflash_drv) {
> -            continue;
> +        if (pflash_drv) {
> +            loc_push_none(&loc);
> +            qemu_opts_loc_restore(pflash_drv->opts);
> +            if (pflash_cfi01_get_blk(pcms->flash[i])) {
> +                error_report("clashes with -machine");
> +                exit(1);
> +            }
> +            qdev_prop_set_drive(DEVICE(pcms->flash[i]), "drive",
> +                                blk_by_legacy_dinfo(pflash_drv), &error_fatal);
> +            loc_pop(&loc);
>          }
> -        loc_push_none(&loc);
> -        qemu_opts_loc_restore(pflash_drv->opts);
> -        if (pflash_blk[i]) {
> -            error_report("clashes with -machine");
> -            exit(1);
> -        }
> -        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
> -        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
> -                            "drive", pflash_blk[i], &error_fatal);
> -        loc_pop(&loc);
> +        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>      }
>  
>      /* Reject gaps */
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>


