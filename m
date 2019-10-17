Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DCDC4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 07:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00F42082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 07:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00F42082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL0UO-0004wB-Sk
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 03:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iL0TT-0004Vq-Tm
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 03:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iL0TR-0003Zw-BO
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 03:45:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iL0TR-0003Zk-2f
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 03:45:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 87D35307D98A;
 Thu, 17 Oct 2019 07:45:27 +0000 (UTC)
Received: from localhost (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12F6E5D713;
 Thu, 17 Oct 2019 07:45:26 +0000 (UTC)
Date: Thu, 17 Oct 2019 09:45:25 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 10/10] vfio: unplug failover primary device before
 migration
Message-ID: <20191017074525.3z4m6zg45qhq4ezc@jenstp.localdomain>
References: <20191011112015.11785-1-jfreimann@redhat.com>
 <20191011112015.11785-11-jfreimann@redhat.com>
 <20191015195212.27e0f944@x1.home>
 <20191016201847.izgvkxfoepci4w23@jenstp.localdomain>
 <20191016183958.2f66f055@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191016183958.2f66f055@x1.home>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 17 Oct 2019 07:45:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 06:39:58PM -0600, Alex Williamson wrote:
>On Wed, 16 Oct 2019 22:18:47 +0200
>Jens Freimann <jfreimann@redhat.com> wrote:
>
>> On Tue, Oct 15, 2019 at 07:52:12PM -0600, Alex Williamson wrote:
>> >On Fri, 11 Oct 2019 13:20:15 +0200
>> >Jens Freimann <jfreimann@redhat.com> wrote:
>> >
>> >> As usual block all vfio-pci devices from being migrated, but make an
>> >> exception for failover primary devices. This is achieved by setting
>> >> unmigratable to 0 but also add a migration blocker for all vfio-pci
>> >> devices except failover primary devices. These will be unplugged before
>> >> migration happens by the migration handler of the corresponding
>> >> virtio-net standby device.
>> >>
>> >> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> >> ---
>> >>  hw/vfio/pci.c | 35 ++++++++++++++++++++++++++++++++++-
>> >>  hw/vfio/pci.h |  2 ++
>> >>  2 files changed, 36 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> >> index c5e6fe61cb..64cf8e07d9 100644
>> >> --- a/hw/vfio/pci.c
>> >> +++ b/hw/vfio/pci.c
>> >> @@ -40,6 +40,9 @@
>> >>  #include "pci.h"
>> >>  #include "trace.h"
>> >>  #include "qapi/error.h"
>> >> +#include "migration/blocker.h"
>> >> +#include "qemu/option.h"
>> >> +#include "qemu/option_int.h"
>> >>
>> >>  #define TYPE_VFIO_PCI "vfio-pci"
>> >>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
>> >> @@ -2698,6 +2701,12 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>> >>      vdev->req_enabled = false;
>> >>  }
>> >>
>> >> +static int has_net_failover_arg(void *opaque, const char *name,
>> >> +                           const char *value, Error **errp)
>> >> +{
>> >> +    return (strcmp(name, "net_failover_pair_id") == 0);
>> >> +}
>> >> +
>> >>  static void vfio_realize(PCIDevice *pdev, Error **errp)
>> >>  {
>> >>      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
>> >> @@ -2710,6 +2719,20 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>> >>      int groupid;
>> >>      int i, ret;
>> >>      bool is_mdev;
>> >> +    uint16_t class_id;
>> >> +
>> >> +    if (qemu_opt_foreach(pdev->qdev.opts, has_net_failover_arg,
>> >> +                         (void *) pdev->qdev.opts, &err) == 0) {
>> >
>> >Why do we need a qemu_opt_foreach here versus testing
>> >vdev->net_failover_pair_id as you do below or similar to how we test
>> >sysfsdev immediately below this chunk?
>>
>> We don't need it, I will change it and move it to where we check for
>> the PCI class.
>> >
>> >> +        error_setg(&vdev->migration_blocker,
>> >> +                "VFIO device doesn't support migration");
>> >> +        ret = migrate_add_blocker(vdev->migration_blocker, &err);
>> >
>> >Where's the migrate_del_blocker()/error_free() for any other realize
>> >error or device removal?
>> >
>> >> +        if (err) {
>> >> +            error_propagate(errp, err);
>> >> +            error_free(vdev->migration_blocker);
>> >> +        }
>> >
>> >As Connie noted, unclear if this aborts or continues without a
>> >migration blocker, which would be bad.
>>
>> It aborts in my test. PCI realize propagates it further and eventually
>> it leads to aborting qemu.
>>
>> It looks like this now:
>>
>>      if (!pdev->net_failover_pair_id) {
>>           error_setg(&vdev->migration_blocker,
>>                   "VFIO device doesn't support migration");
>>           ret = migrate_add_blocker(vdev->migration_blocker, &err);
>>           if (err) {
>>               error_propagate(errp, err);
>>           } else {
>>               error_propagate(errp, vdev->migration_blocker);
>>           }
>>           goto error;
>
>This unconditionally goes to error when we don't have a failover pair
>set :-\
>
>I suspect we don't want any sort of error propagate in the success
>case, the migration_blocker pre-defines the error when the migration is
>blocked, right?  Thanks,

I shouldn't code or send mails late at night :) I'll fix it in v4

Thanks!

regards,
Jens 

