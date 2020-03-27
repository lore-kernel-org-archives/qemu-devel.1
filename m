Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99940C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6100D20716
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ov0XqJE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6100D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtL0-0008Uc-Jp
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHtK3-00083z-7l
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHtK1-0004w7-DF
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:03:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52987)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHtK0-0004nw-K3
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585332185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tfp+HoFZVGpXPVcI7LwQfbnhm1vKadGooYgO74vAzVY=;
 b=Ov0XqJE4LcY+c5YzG0xDgc5ChQhYZpe5sgKIGhQrULY7e7WLq2fGjTwau8vdI2NioUBBQk
 +PHi39l/xgT3iSpc+2V7yScYrEU9ENamR/ucL8mTk8nygQUBv3yEBIk2mv07e5yjZfSsIa
 oqzJwfb0fJablrSJzjRsL7F45kEUoUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-YKCmeCeIM_qzurRMYUEn7w-1; Fri, 27 Mar 2020 14:03:04 -0400
X-MC-Unique: YKCmeCeIM_qzurRMYUEn7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA75E1005509;
 Fri, 27 Mar 2020 18:03:01 +0000 (UTC)
Received: from work-vm (ovpn-113-149.ams2.redhat.com [10.36.113.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA13310027A4;
 Fri, 27 Mar 2020 18:03:00 +0000 (UTC)
Date: Fri, 27 Mar 2020 18:02:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH v2] monitor/hmp-cmds: add units for migrate_parameters.
Message-ID: <20200327180258.GO2786@work-vm>
References: <bfceb9751f76533c823e9ec91ac14f4bc94a47b6.1585324937.git.maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <bfceb9751f76533c823e9ec91ac14f4bc94a47b6.1585324937.git.maozhongyi@cmss.chinamobile.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Mao Zhongyi (maozhongyi@cmss.chinamobile.com) wrote:
> When running:
> (qemu) info migrate_parameters
> announce-initial: 50 ms
> announce-max: 550 ms
> announce-step: 100 ms
> compress-wait-thread: on
> ...
> max-bandwidth: 33554432 bytes/second
> downtime-limit: 300 milliseconds
> x-checkpoint-delay: 20000
> ...
> xbzrle-cache-size: 67108864
>=20
> add units for the parameters 'x-checkpoint-delay' and
> 'xbzrle-cache-size', it's easier to read, also move
> milliseconds to ms to keep the same style.
>=20
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Thanks

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(info migrate could also be fixed, but that's a separate issue)


> ---
>  monitor/hmp-cmds.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 2a900a528a..790fad3afe 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -436,11 +436,11 @@ void hmp_info_migrate_parameters(Monitor *mon, cons=
t QDict *qdict)
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
>              params->max_bandwidth);
>          assert(params->has_downtime_limit);
> -        monitor_printf(mon, "%s: %" PRIu64 " milliseconds\n",
> +        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
>              params->downtime_limit);
>          assert(params->has_x_checkpoint_delay);
> -        monitor_printf(mon, "%s: %u\n",
> +        monitor_printf(mon, "%s: %u ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELA=
Y),
>              params->x_checkpoint_delay);
>          assert(params->has_block_incremental);
> @@ -453,7 +453,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
>          monitor_printf(mon, "%s: %s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSI=
ON),
>              MultiFDCompression_str(params->multifd_compression));
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> +        monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE=
),
>              params->xbzrle_cache_size);
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
> --=20
> 2.17.1
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


