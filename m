Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C689C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2988A2073E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5mY+iIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2988A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmE2l-0000G0-BG
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jmE1E-0005xr-OS
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:13:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24477
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jmE1C-0004XO-Sa
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592561584;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9TgD00zswi6kpjxkdsGTBBsyLXcp4Zg0SPr+uYeXtzY=;
 b=S5mY+iIaXu43BWW4WtEWto9PA+8uDxcWVkjJ+wJZgqaku6qY1Am4uybsE4IstvrAF9B6fj
 Gwqdc03OWAlT8mZMiHwXXxw/qXPgyTG1vmtCVNjVYfMkPgI1+6griZvKtffD+QnGCmXuy0
 k5GuwSN/ARK2Q5uCXUg1WhsriSPLQ4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-Vl5k1qLxM66UqSBccjOoCw-1; Fri, 19 Jun 2020 06:13:00 -0400
X-MC-Unique: Vl5k1qLxM66UqSBccjOoCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A448800053;
 Fri, 19 Jun 2020 10:12:59 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F75F71661;
 Fri, 19 Jun 2020 10:12:48 +0000 (UTC)
Date: Fri, 19 Jun 2020 11:12:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 9/9] host trust limitation: Alter virtio default
 properties for protected guests
Message-ID: <20200619101245.GC700896@redhat.com>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-10-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619020602.118306-10-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 12:06:02PM +1000, David Gibson wrote:
> The default behaviour for virtio devices is not to use the platforms normal
> DMA paths, but instead to use the fact that it's running in a hypervisor
> to directly access guest memory.  That doesn't work if the guest's memory
> is protected from hypervisor access, such as with AMD's SEV or POWER's PEF.
> 
> So, if a host trust limitation mechanism is enabled, then apply the
> iommu_platform=on option so it will go through normal DMA mechanisms.
> Those will presumably have some way of marking memory as shared with the
> hypervisor or hardware so that DMA will work.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/core/machine.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a71792bc16..8dfc1bb3f8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,6 +28,8 @@
>  #include "hw/mem/nvdimm.h"
>  #include "migration/vmstate.h"
>  #include "exec/host-trust-limitation.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-pci.h"
>  
>  GlobalProperty hw_compat_5_0[] = {
>      { "virtio-balloon-device", "page-poison", "false" },
> @@ -1165,6 +1167,15 @@ void machine_run_board_init(MachineState *machine)
>           * areas.
>           */
>          machine_set_mem_merge(OBJECT(machine), false, &error_abort);
> +
> +        /*
> +         * Virtio devices can't count on directly accessing guest
> +         * memory, so they need iommu_platform=on to use normal DMA
> +         * mechanisms.  That requires disabling legacy virtio support
> +         * for virtio pci devices
> +         */
> +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy", "on");
> +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_platform", "on");
>      }

Silently changing the user's request configuration like this is a bad idea.
The "disable-legacy" option in particular is undesirable as that switches
the device to virtio-1.0 only mode, which exposes a different PCI ID to
the guest.

If some options are incompatible with encryption, then we should raise a
fatal error at startup, so applications/admins are aware that their requested
config is broken.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


