Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AA0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9612076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lhj4hVsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9612076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY6V5-0004yS-7h
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 07:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kY6Ty-0004Sv-P0
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kY6Tu-00062c-09
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603972354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPFjQMlAy+5rr1WmGoSYcEBupZMRlY9IALwSYe5c95I=;
 b=Lhj4hVsmvEtzzQmFDicblY6LthcOtKDaSJXP55/PJUGUr23tqPlMFE6cL4EM7jw+p+4QXs
 9Y54/685ghh+qJj5MOvPU7T2kobGXYgiqRkYon1fvRGRsi3rXq95nW+V55tV193g6bVc0Z
 hpL1FDmGtuz1tHgiZE7N5NXyLkmoeDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-D0n6zPueNlSc90kp0drMOw-1; Thu, 29 Oct 2020 07:52:30 -0400
X-MC-Unique: D0n6zPueNlSc90kp0drMOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 750E65705E;
 Thu, 29 Oct 2020 11:52:29 +0000 (UTC)
Received: from gondolin (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3752D5D9EF;
 Thu, 29 Oct 2020 11:52:24 +0000 (UTC)
Date: Thu, 29 Oct 2020 12:52:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v1] docs/devel: Add VFIO device migration documentation
Message-ID: <20201029125221.69352b48.cohuck@redhat.com>
In-Reply-To: <1603950791-27236-1-git-send-email-kwankhede@nvidia.com>
References: <1603950791-27236-1-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: mcrossley@nvidia.com, cjia@nvidia.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, dnigam@nvidia.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 11:23:11 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Document interfaces used for VFIO device migration. Added flow of state
> changes during live migration with VFIO device.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---
>  MAINTAINERS                   |   1 +
>  docs/devel/vfio-migration.rst | 119 ++++++++++++++++++++++++++++++++++++++++++

You probably want to include this into the Developer's Guide via
index.rst.

>  2 files changed, 120 insertions(+)
>  create mode 100644 docs/devel/vfio-migration.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6a197bd358d6..6f3fcffc6b3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1728,6 +1728,7 @@ M: Alex Williamson <alex.williamson@redhat.com>
>  S: Supported
>  F: hw/vfio/*
>  F: include/hw/vfio/
> +F: docs/devel/vfio-migration.rst
>  
>  vfio-ccw
>  M: Cornelia Huck <cohuck@redhat.com>
> diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
> new file mode 100644
> index 000000000000..dab9127825e4
> --- /dev/null
> +++ b/docs/devel/vfio-migration.rst
> @@ -0,0 +1,119 @@
> +=====================
> +VFIO device Migration
> +=====================
> +
> +VFIO devices use iterative approach for migration because certain VFIO devices

s/use/use an/ ?

> +(e.g. GPU) have large amount of data to be transfered. The iterative pre-copy
> +phase of migration allows for the guest to continue whilst the VFIO device state
> +is transferred to destination, this helps to reduce the total downtime of the

s/to destination,/to the destination;/

> +VM. VFIO devices can choose to skip the pre-copy phase of migration by returning
> +pending_bytes as zero during pre-copy phase.

s/during/during the/

> +
> +Detailed description of UAPI for VFIO device for migration is in the comment
> +above ``vfio_device_migration_info`` structure definition in header file
> +linux-headers/linux/vfio.h.

I think I'd copy that to this file. If I'm looking at the
documentation, I'd rather not go hunting for source code to find out
what structure you are talking about. Plus, as it's UAPI, I don't
expect it to change much, so it should be easy to keep the definitions
in sync (famous last words).

> +
> +VFIO device hooks for iterative approach:
> +-  A ``save_setup`` function that setup migration region, sets _SAVING flag in

s/setup/sets up the/
s/in/in the/

> +VFIO device state and inform VFIO IOMMU module to start dirty page tracking.

s/inform/informs the/

> +
> +- A ``load_setup`` function that setup migration region on the destination and

s/setup/sets up the/

> +sets _RESUMING flag in VFIO device state.

s/in/in the/

> +
> +- A ``save_live_pending`` function that reads pending_bytes from vendor driver
> +that indicate how much more data the vendor driver yet to save for the VFIO
> +device.

"A ``save_live_pending`` function that reads pending_bytes from the
vendor driver, which indicates the amount of data that the vendor
driver has yet to save for the VFIO device." ?

> +
> +- A ``save_live_iterate`` function that reads VFIO device's data from vendor

s/reads/reads the/
s/from/from the/

> +driver through migration region during iterative phase.

s/through/through the/

> +
> +- A ``save_live_complete_precopy`` function that resets _RUNNING flag from VFIO

s/from/from the/

> +device state, saves device config space, if any, and iteratively copies

s/saves/saves the/

> +remaining data for VFIO device till pending_bytes returned by vendor driver
> +is zero.

"...and interactively copies the remaining data for the VFIO device
until the vendor driver indicates that no data remains (pending_bytes
is zero)." ?

> +
> +- A ``load_state`` function loads config section and data sections generated by
> +above save functions.

"A ``load_state`` function that loads the config section and the data
sections that are generated by the save functions above." ?

> +
> +- ``cleanup`` functions for both save and load that unmap migration region.

..."that perform any migration-related cleanup, including unmapping the
migration region." ?

> +
> +VM state change handler is registered to change VFIO device state based on VM
> +state change.

"A VM state change handler is registered to change the VFIO device
state when the VM state changes." ?

> +
> +Similarly, a migration state change notifier is added to get a notification on

s/added/registered/ ?

> +migration state change. These states are translated to VFIO device state and
> +conveyed to vendor driver.
> +
> +System memory dirty pages tracking
> +----------------------------------
> +
> +A ``log_sync`` memory listener callback is added to mark system memory pages

s/is added to mark/marks those/ 

> +as dirty which are used for DMA by VFIO device. Dirty pages bitmap is queried

s/by/by the/
s/Dirty/The dirty/

> +per container. All pages pinned by vendor driver through vfio_pin_pages()

s/by/by the/

> +external API have to be marked as dirty during migration. When there are CPU
> +writes, CPU dirty page tracking can identify dirtied pages, but any page pinned
> +by vendor driver can also be written by device. There is currently no device

s/by/by the/ (x2)

> +which has hardware support for dirty page tracking. So all pages which are
> +pinned by vendor driver are considered as dirty.
> +Dirty pages are tracked when device is in stop-and-copy phase because if pages
> +are marked dirty during pre-copy phase and content is transfered from source to
> +destination, there is no way to know newly dirtied pages from the point they
> +were copied earlier until device stops. To avoid repeated copy of same content,
> +pinned pages are marked dirty only during stop-and-copy phase.

Let me take a quick stab at rewriting this paragraph (not sure if I
understood it correctly):

"Dirty pages are tracked when the device is in the stop-and-copy phase.
During the pre-copy phase, it is not possible to distinguish a dirty
page that has been transferred from the source to the destination from
newly dirtied pages, which would lead to repeated copying of the same
content. Therefore, pinned pages are only marked dirty during the
stop-and-copy phase." ?

> +
> +System memory dirty pages tracking when vIOMMU is enabled
> +---------------------------------------------------------
> +With vIOMMU, IO virtual address range can get unmapped while in pre-copy phase

s/IO/an I/O/

> +of migration. In that case, unmap ioctl returns pages pinned in that range and

s/unmap ioctl returns pages pinned/the unmap ioctl returns any pinned pages/ ?

> +QEMU reports corresponding guest physical pages dirty.
> +During stop-and-copy phase, an IOMMU notifier is used to get a callback for
> +mapped pages and then dirty pages bitmap is fetched from VFIO IOMMU modules for
> +those mapped ranges.
> +
> +Flow of state changes during Live migration
> +===========================================
> +Below is the flow of state change during live migration where states in brackets
> +represent VM state, migration state and VFIO device state as:
> +                (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)

"The values in the brackets represent the VM state, the migration
state, and the VFIO device state, respectively." ?

> +
> +Live migration save path
> +------------------------
> +                        QEMU normal running state
> +                        (RUNNING, _NONE, _RUNNING)
> +                                    |
> +                       migrate_init spawns migration_thread
> +                Migration thread then calls each device's .save_setup()
> +                        (RUNNING, _SETUP, _RUNNING|_SAVING)
> +                                    |
> +                        (RUNNING, _ACTIVE, _RUNNING|_SAVING)
> +            If device is active, get pending_bytes by .save_live_pending()
> +         if total pending_bytes >= threshold_size, call .save_live_iterate()
> +                  Data of VFIO device for pre-copy phase is copied
> +     Iterate till total pending bytes converge and are less than threshold
> +                                    |
> +   On migration completion, vCPUs stops and calls .save_live_complete_precopy

s/vCPUs/vCPU/ ?

> +   for each active device. VFIO device is then transitioned in _SAVING state

s/VFIO device/The VFIO device/

s/in/into/

> +                    (FINISH_MIGRATE, _DEVICE, _SAVING)
> +                                    |
> +For VFIO device, iterate in .save_live_complete_precopy until pending data is 0

s/For/For the/

> +                    (FINISH_MIGRATE, _DEVICE, _STOPPED)
> +                                    |
> +                    (FINISH_MIGRATE, _COMPLETED, _STOPPED)
> +                Migraton thread schedule cleanup bottom half and exit

s/schedule/schedules/
s/exit/exits/

> +
> +Live migration resume path
> +--------------------------
> +
> +             Incoming migration calls .load_setup for each device
> +                        (RESTORE_VM, _ACTIVE, _STOPPED)
> +                                    |
> +    For each device, .load_state is called for that device section data
> +                        (RESTORE_VM, _ACTIVE, _RESUMING)
> +                                    |
> +    At the end, called .load_cleanup for each device and vCPUs are started                        |

Stray '|', probably should go on the next line?

s/called .load_cleanup/.load_cleanup is called/


> +                        (RUNNING, _NONE, _RUNNING)
> +
> +
> +Postcopy
> +========
> +Postcopy migration is not supported for VFIO devices.

s/not/not yet/, I think? (Disregarding any time frame here.)

Generally, I think this is useful information to have in the docs.


