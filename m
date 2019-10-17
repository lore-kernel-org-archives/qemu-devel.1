Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7CBECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BFD2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BFD2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL389-0001ne-0o
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iL36a-0000ct-As
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iL36X-000736-6N
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:34:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iL36X-00070p-1d
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:34:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1190C84A5;
 Thu, 17 Oct 2019 10:33:59 +0000 (UTC)
Received: from localhost (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B0ED5C1D6;
 Thu, 17 Oct 2019 10:33:48 +0000 (UTC)
Date: Thu, 17 Oct 2019 12:33:47 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 0/10] add failover feature for assigned network devices
Message-ID: <20191017103347.gdlkkplpj64ivw5q@jenstp.localdomain>
References: <20191011112015.11785-1-jfreimann@redhat.com>
 <20191015130317.64d68031@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191015130317.64d68031@x1.home>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 17 Oct 2019 10:33:59 +0000 (UTC)
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

On Tue, Oct 15, 2019 at 01:03:17PM -0600, Alex Williamson wrote:
>On Fri, 11 Oct 2019 13:20:05 +0200
>Jens Freimann <jfreimann@redhat.com> wrote:
>
>> This is implementing the host side of the net_failover concept
>> (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
>>
>> Changes since v2:
>> * back out of creating failover pair when it is a non-networking
>>   vfio-pci device (Alex W)
>> * handle migration state change from within the migration thread. I do a
>>   timed wait on a semaphore and then check if all unplugs were
>>   succesful. Added a new function to each device that checks the device
>>   if the unplug for it has happened. When all devices report the succesful
>>   unplug *or* the time/retries is up, continue with the migration or
>>   cancel. When not all devices could be unplugged I am cancelling at the
>>   moment. It is likely that we can't plug it back at the destination which
>>   would result in degraded network performance.
>> * fix a few bugs regarding re-plug on migration source and target
>> * run full set of tests including migration tests
>> * add patch for libqos to tolerate new migration state
>> * squashed patch 1 and 2, added patch 8
>>
>> The general idea is that we have a pair of devices, a vfio-pci and a
>> virtio-net device. Before migration the vfio device is unplugged and data
>> flows to the virtio-net device, on the target side another vfio-pci device
>> is plugged in to take over the data-path. In the guest the net_failover
>> module will pair net devices with the same MAC address.
>>
>> * Patch 1 adds the infrastructure to hide the device for the qbus and qdev APIs
>>
>> * Patch 2 sets a new flag for PCIDevice 'partially_hotplugged' which we
>>   use to skip the unrealize code path when doing a unplug of the primary
>>   device
>>
>> * Patch 3 sets the pending_deleted_event before triggering the guest
>>   unplug request
>
>These only cover pcie hotplug, is this feature somehow dependent on
>pcie?  There's also ACPI-based PCI hotplug, SHPC hotplug, and it looks
>like s390 has it's own version (of course) of PCI hotplug.  IMO, we
>either need to make an attempt to support this universally or the
>option needs to fail if the hotplug controller doesn't support partial
>removal.  Thanks,

It is possible to make it work with non-pcie hotplug but as the first
step I want to enable it for pcie only. For that I would add a check
into pci_qdev_realize(), where I also check if the device is an
ethernet device, and fail if it is not a pcie device. Would that work
for you?

regards,
Jens 

