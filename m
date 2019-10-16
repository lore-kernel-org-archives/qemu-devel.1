Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F347C4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062AF2082C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062AF2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKdNK-0001gN-4z
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 03:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iKdMR-00019j-DG
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iKdMO-0008GD-HF
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:04:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iKdMO-0008Fm-96
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:04:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DCF0C51EE6;
 Wed, 16 Oct 2019 07:04:37 +0000 (UTC)
Received: from localhost (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78FB667601;
 Wed, 16 Oct 2019 07:04:29 +0000 (UTC)
Date: Wed, 16 Oct 2019 09:04:28 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 01/10] qdev/qbus: add hidden device support
Message-ID: <20191016070428.7s3ptnj2u4nidpyi@jenstp.localdomain>
References: <20191011112015.11785-1-jfreimann@redhat.com>
 <20191011112015.11785-2-jfreimann@redhat.com>
 <20191015131933.7fb32962@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191015131933.7fb32962@x1.home>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 16 Oct 2019 07:04:37 +0000 (UTC)
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

On Tue, Oct 15, 2019 at 01:19:33PM -0600, Alex Williamson wrote:
>On Fri, 11 Oct 2019 13:20:06 +0200
>Jens Freimann <jfreimann@redhat.com> wrote:
>
>> This adds support for hiding a device to the qbus and qdev APIs.  The
>> first user of this will be the virtio-net failover feature but the API
>> introduced with this patch could be used to implement other features as
>> well, for example hiding pci devices when a pci bus is powered off.
>>
>> qdev_device_add() is modified to check for a net_failover_pair_id
>> argument in the option string. A DeviceListener callback
>> should_be_hidden() is added. It can be used by a standby device to
>> inform qdev that this device should not be added now. The standby device
>> handler can store the device options to plug the device in at a later
>> point in time.
>>
>> One reason for hiding the device is that we don't want to expose both
>> devices to the guest kernel until the respective virtio feature bit
>> VIRTIO_NET_F_STANDBY was negotiated and we know that the devices will be
>> handled correctly by the guest.
>>
>> More information on the kernel feature this is using:
>>  https://www.kernel.org/doc/html/latest/networking/net_failover.html
>>
>> An example where the primary device is a vfio-pci device and the standby
>> device is a virtio-net device:
>>
>> A device is hidden when it has an "net_failover_pair_id" option, e.g.
>>
>>  -device virtio-net-pci,...,failover=on,...
>>  -device vfio-pci,...,net_failover_pair_id=net1,...
>>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> ---
>>  hw/core/qdev.c         | 19 +++++++++++++++++++
>>  include/hw/qdev-core.h |  9 +++++++++
>>  qdev-monitor.c         | 43 ++++++++++++++++++++++++++++++++++++++----
>>  vl.c                   |  6 ++++--
>>  4 files changed, 71 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index cbad6c1d55..84fac591ca 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -212,6 +212,25 @@ void device_listener_unregister(DeviceListener *listener)
>>      QTAILQ_REMOVE(&device_listeners, listener, link);
>>  }
>>
>> +bool qdev_should_hide_device(QemuOpts *opts, Error **errp)
>> +{
>> +    bool res = false;
>> +    bool match_found = false;
>> +    DeviceListener *listener;
>> +
>> +    QTAILQ_FOREACH(listener, &device_listeners, link) {
>> +       if (listener->should_be_hidden) {
>> +            listener->should_be_hidden(listener, opts, &match_found, &res);
>> +        }
>> +
>> +        if (match_found) {
>> +            break;
>> +        }
>
>Calling convention here seems overly complicated, couldn't
>should_be_hidden() just return >0 (should be hidden), 0 (should not be
>hidden), <0 (don't care), ie. continue until >=0?  The errp arg is
>unused and using "res" to return should/shouldn't hide is very unclear.
>The virtio callback renames this to hide, which makes more sense, but
>as above, both the stop and hidden state could be conveyed with a
>simple int return value.  Thanks,

Yes, this can be simplified. Will be in the next version.

Thanks!

regards,
Jens  

