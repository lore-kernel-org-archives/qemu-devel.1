Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F31AC04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02FFA20862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FFA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59540 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTigS-0006sB-Vt
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 04:02:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hTifV-0006YN-3J
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hTifU-0006Kn-0v
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:01:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hTifT-0006Cc-SW
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:01:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 393CE3001749
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:01:16 +0000 (UTC)
Received: from localhost (dhcp-192-193.str.redhat.com [10.33.192.193])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4511060C44;
	Thu, 23 May 2019 08:01:11 +0000 (UTC)
Date: Thu, 23 May 2019 10:01:09 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190523080109.kwvr6ufmxufenshy@jenstp.localdomain>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-2-jfreimann@redhat.com>
	<20190521093336.GA2915@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190521093336.GA2915@work-vm>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 23 May 2019 08:01:21 +0000 (UTC)
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

On Tue, May 21, 2019 at 10:33:36AM +0100, Dr. David Alan Gilbert wrote:
>* Jens Freimann (jfreimann@redhat.com) wrote:
>> In "b06424de62 migration: Disable hotplug/unplug during migration" we
>> added a check to disable unplug for all devices until we have figured
>> out what works. For failover primary devices qdev_unplug() is called
>> from the migration handler, i.e. during migration.
>>
>> This patch adds a flag to DeviceState which is set to false for all
>> devices and makes an exception for vfio-pci devices that are also
>> primary devices in a failover pair.
>>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>
>So I think this is safe in your case, because you trigger the unplug
>right at the start of migration during setup and plug after failure;
>however it's not generally safe - I can't unplug a device while the
>migration is actually in progress.

I tried to limit it to only allow it in failover case. You're saying
it's missing something and not strict enough? I could allow it only
during migration setup. I guess we'll need a similar exception for
failover in libvirt. 

regards,
Jens 

