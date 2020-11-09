Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C42C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F8A206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjLG61f5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F8A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcD6Q-0003mX-G3
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 14:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kcD5h-0003MK-V5
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:44:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kcD5b-0001VL-Fi
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604951069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04zSg1wfjqeTTL4OfYZJDdptqJN4H0DhFzAZiKgAqek=;
 b=SjLG61f5XfxbpmxiP5fBb6BpiLCIbQz9u7NBSqX3YKkvdf4BuM8mY7Wa37v8znqFJRUNZ6
 F9i4JSRRgsqO93BEJ9u7DVNFGket3J6D6UUx+Xh65pGCSDglsrVY6sodFWEu/ts0evLIzb
 F3upBE1VR5mXsrstpF2OKVSrIz3Tz+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-asS4GHdzPtu2oLTqwRZXCg-1; Mon, 09 Nov 2020 14:44:25 -0500
X-MC-Unique: asS4GHdzPtu2oLTqwRZXCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2A3664087;
 Mon,  9 Nov 2020 19:44:24 +0000 (UTC)
Received: from work-vm (ovpn-114-198.ams2.redhat.com [10.36.114.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38D3A7B40D;
 Mon,  9 Nov 2020 19:44:20 +0000 (UTC)
Date: Mon, 9 Nov 2020 19:44:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH for-QEMU-5.2] vfio: Make migration support experimental
Message-ID: <20201109194417.GR3024@work-vm>
References: <160494787833.1473.10514376876696596117.stgit@gimli.home>
MIME-Version: 1.0
In-Reply-To: <160494787833.1473.10514376876696596117.stgit@gimli.home>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
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
Cc: Neo Jia <cjia@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Williamson (alex.williamson@redhat.com) wrote:
> Per the proposed documentation for vfio device migration:
> 
>   Dirty pages are tracked when device is in stop-and-copy phase
>   because if pages are marked dirty during pre-copy phase and
>   content is transfered from source to destination, there is no
>   way to know newly dirtied pages from the point they were copied
>   earlier until device stops. To avoid repeated copy of same
>   content, pinned pages are marked dirty only during
>   stop-and-copy phase.
> 
> Essentially, since we don't have hardware dirty page tracking for
> assigned devices at this point, we consider any page that is pinned
> by an mdev vendor driver or pinned and mapped through the IOMMU to
> be perpetually dirty.  In the worst case, this may result in all of
> guest memory being considered dirty during every iteration of live
> migration.  The current vfio implementation of migration has chosen
> to mask device dirtied pages until the final stages of migration in
> order to avoid this worst case scenario.
> 
> Allowing the device to implement a policy decision to prioritize
> reduced migration data like this jeopardizes QEMU's overall ability
> to implement any degree of service level guarantees during migration.
> For example, any estimates towards achieving acceptable downtime
> margins cannot be trusted when such a device is present.  The vfio
> device should participate in dirty page tracking to the best of its
> ability throughout migration, even if that means the dirty footprint
> of the device impedes migration progress, allowing both QEMU and
> higher level management tools to decide whether to continue the
> migration or abort due to failure to achieve the desired behavior.

I don't feel particularly badly about the decision to squash it in
during the stop-and-copy phase; for devices where the pinned memory
is large, I don't think doing it during the main phase makes much sense;
especially if you then have to deal with tracking changes in pinning.

Having said that, I agree with marking it as experimental, because
I'm dubious how useful it will be for the same reason, I worry
about whether the downtime will be so large to make it pointless.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Link: https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg00807.html
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Neo Jia <cjia@nvidia.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> Given that our discussion in the link above seems to be going in
> circles, I'm afraid it seems necessary to both have a contigency
> plan and to raise the visibility of the current behavior to
> determine whether others agree that this is a sufficiently
> troubling behavior to consider migration support experimental
> at this stage.  Please voice your opinion or contribute patches
> to resolve this before QEMU 5.2.  Thanks,
> 
> Alex
> 
>  hw/vfio/migration.c           |    2 +-
>  hw/vfio/pci.c                 |    2 ++
>  include/hw/vfio/vfio-common.h |    1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 3ce285ea395d..cd44d465a50b 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -882,7 +882,7 @@ int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
>      Error *local_err = NULL;
>      int ret = -ENOTSUP;
>  
> -    if (!container->dirty_pages_supported) {
> +    if (!vbasedev->enable_migration || !container->dirty_pages_supported) {
>          goto add_blocker;
>      }
>  
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 58c0ce8971e3..1349b900e513 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3194,6 +3194,8 @@ static Property vfio_pci_dev_properties[] = {
>                      VFIO_FEATURE_ENABLE_REQ_BIT, true),
>      DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>                      VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
> +    DEFINE_PROP_BOOL("x-enable-migration", VFIOPCIDevice,
> +                     vbasedev.enable_migration, false),
>      DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>      DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>                       vbasedev.ram_block_discard_allowed, false),
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index baeb4dcff102..2119872c8af1 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -123,6 +123,7 @@ typedef struct VFIODevice {
>      bool needs_reset;
>      bool no_mmap;
>      bool ram_block_discard_allowed;
> +    bool enable_migration;
>      VFIODeviceOps *ops;
>      unsigned int num_irqs;
>      unsigned int num_regions;
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


