Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1DCC28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392F228006
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392F228006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXjK1-000812-8k
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:32:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hXjFF-0004Xj-O0
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hXjFE-0005WW-ID
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hXjFE-0005Vb-CH
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:27:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9FBCC049DFC
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 09:27:07 +0000 (UTC)
Received: from localhost (dhcp-192-193.str.redhat.com [10.33.192.193])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 82D7A2C27C;
	Mon,  3 Jun 2019 09:27:00 +0000 (UTC)
Date: Mon, 3 Jun 2019 11:26:59 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190603092659.qjccxcljyjpx52d6@jenstp.localdomain>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 03 Jun 2019 09:27:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
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
Cc: pkrempa@redhat.com, berrange@redhat.com, mst@redhat.com, aadam@redhat.com,
	qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, laine@redhat.com,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 10:24:56AM +0200, Jens Freimann wrote:
>On Fri, May 31, 2019 at 06:47:48PM -0300, Eduardo Habkost wrote:
>>On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote:
>>>On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote:
>>>> On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert wrote:
>>>> > * Jens Freimann (jfreimann@redhat.com) wro
>>What exactly is preventing QEMU from closing the host VFIO device
>>after the guest OS has handled the unplug request?
>
>We qdev_unplug() the VFIO device and want the virtio-net standby device to
>take over. If something goes wrong with unplug or
>migration in general we have to qdev_plug() the device back.

I meant qdev_device_add, not qdev_plug.

regards,
Jens 

