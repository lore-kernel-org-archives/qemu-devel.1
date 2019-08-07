Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C8C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2E221BE6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2E221BE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvI5Q-0002ex-ML
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52749)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jfreimann@redhat.com>) id 1hvI38-00013x-4k
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1hvI36-0005gt-Kz
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1hvI36-0005Ty-Eo
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:16:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2194112AC9
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 09:15:49 +0000 (UTC)
Received: from localhost (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3EDC600CC;
 Wed,  7 Aug 2019 09:15:46 +0000 (UTC)
Date: Wed, 7 Aug 2019 11:15:45 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190807091545.l7eirnlmymmjp6yt@jenstp.localdomain>
References: <20190802150605.5880-1-jfreimann@redhat.com>
 <20190802112047-mutt-send-email-mst@kernel.org>
 <20190805131215.c6cl3lgvcpnzfx3x@jenstp.localdomain>
 <20190805102148-mutt-send-email-mst@kernel.org>
 <20190805184949.kmv7qra67jfxie2j@jenstp.localdomain>
 <20190806043953-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190806043953-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 07 Aug 2019 09:15:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/9] add failover feature for assigned
 network devices
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 06, 2019 at 04:43:35AM -0400, Michael S. Tsirkin wrote:
>On Mon, Aug 05, 2019 at 08:49:49PM +0200, Jens Freimann wrote:
>> On Mon, Aug 05, 2019 at 10:22:25AM -0400, Michael S. Tsirkin wrote:
>> > On Mon, Aug 05, 2019 at 03:12:15PM +0200, Jens Freimann wrote:
>> > > On Fri, Aug 02, 2019 at 11:22:10AM -0400, Michael S. Tsirkin wrote:
>> > > > On Fri, Aug 02, 2019 at 05:05:56PM +0200, Jens Freimann wrote:
>> > > > > This is implementing the host side of the net_failover concept
>> > > > > (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
>> > > > >
>> > > > > Changes since v1:
>> > >
>> > > [...]
>> > >
>> > > > Didn't read this yet, one question: how do migration commands look
>> > > > like?
>> > >
>> > > You mean the hmp commands I think:
>> > >
>> > > migrate -d tcp:host:port
>> > >
>> > > and to cancel
>> > >
>> > > migrate_cancel
>> > >
>> > >
>> > > regards,
>> > > Jens
>> >
>> > Sorry, no. I mean the command line on the incoming side.
>>
>> It looks the same with -incoming tcp:0:4444 added. Pci address of
>> vfio-pci device can be changed.
>
>
>Sounds good. And I assume one can also skip the vfio device and
>hotplug it later, right?

yes, the vfio device can be hotplugged later both on target and
source.

regards,
Jens 

