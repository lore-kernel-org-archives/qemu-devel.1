Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13FCC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6AF21743
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6AF21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1Al-0004cY-4C
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:35:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hT19f-00044k-LP
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hT19e-0001Rr-NE
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:33:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hT19e-0001NJ-Hv
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:33:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AF965AFD9
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 09:33:48 +0000 (UTC)
Received: from work-vm (ovpn-117-210.ams2.redhat.com [10.36.117.210])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 298F45C269;
	Tue, 21 May 2019 09:33:38 +0000 (UTC)
Date: Tue, 21 May 2019 10:33:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190521093336.GA2915@work-vm>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-2-jfreimann@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517125820.2885-2-jfreimann@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 21 May 2019 09:33:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/4] migration: allow unplug during
 migration for failover devices
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
	laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jens Freimann (jfreimann@redhat.com) wrote:
> In "b06424de62 migration: Disable hotplug/unplug during migration" we
> added a check to disable unplug for all devices until we have figured
> out what works. For failover primary devices qdev_unplug() is called
> from the migration handler, i.e. during migration.
> 
> This patch adds a flag to DeviceState which is set to false for all
> devices and makes an exception for vfio-pci devices that are also
> primary devices in a failover pair.
> 
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>

So I think this is safe in your case, because you trigger the unplug
right at the start of migration during setup and plug after failure;
however it's not generally safe - I can't unplug a device while the
migration is actually in progress.

Dave

> ---
>  hw/core/qdev.c         | 1 +
>  include/hw/qdev-core.h | 1 +
>  qdev-monitor.c         | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f9b6efe509..98cdaa6bf7 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -954,6 +954,7 @@ static void device_initfn(Object *obj)
>  
>      dev->instance_id_alias = -1;
>      dev->realized = false;
> +    dev->allow_unplug_during_migration = false;
>  
>      object_property_add_bool(obj, "realized",
>                               device_get_realized, device_set_realized, NULL);
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 33ed3b8dde..5437395779 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -146,6 +146,7 @@ struct DeviceState {
>      bool pending_deleted_event;
>      QemuOpts *opts;
>      int hotplugged;
> +    bool allow_unplug_during_migration;
>      BusState *parent_bus;
>      QLIST_HEAD(, NamedGPIOList) gpios;
>      QLIST_HEAD(, BusState) child_bus;
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 373b9ad445..9cce8b93c2 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -867,7 +867,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    if (!migration_is_idle()) {
> +    if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
>          error_setg(errp, "device_del not allowed while migrating");
>          return;
>      }
> -- 
> 2.21.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

