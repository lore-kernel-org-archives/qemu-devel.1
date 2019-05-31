Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FFCC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 425BE26B64
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425BE26B64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45071 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWjEf-0002qv-J9
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 11:14:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hWjDu-0002Ob-B9
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hWjDt-0000A5-6w
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:13:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hWjDt-0007yn-1W
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:13:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F239C0A4F4C
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 15:13:00 +0000 (UTC)
Received: from localhost (ovpn-116-234.ams2.redhat.com [10.36.116.234])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A99385D9D1;
	Fri, 31 May 2019 15:12:52 +0000 (UTC)
Date: Fri, 31 May 2019 17:12:50 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190531151250.3h37hoap6cd5pbdy@jenstp.localdomain>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190520165657.2293c5d7@x1.home>
	<20190521072157.wpb77wlc5mhfcdes@jenstp.localdomain>
	<20190521073511-mutt-send-email-mst@kernel.org>
	<20190521184918.n4nnk6ack3ssp6jv@jenstp.localdomain>
	<20190528223900-mutt-send-email-mst@kernel.org>
	<20190529074802.2cofzjkudfuilbej@jenstp.localdomain>
	<20190530141112-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190530141112-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 31 May 2019 15:13:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] add failover feature for assigned
 network devices
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
	aadam@redhat.com, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>, laine@redhat.com,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 30, 2019 at 02:12:21PM -0400, Michael S. Tsirkin wrote:
>On Wed, May 29, 2019 at 09:48:02AM +0200, Jens Freimann wrote:
>> On Tue, May 28, 2019 at 10:40:42PM -0400, Michael S. Tsirkin wrote:
>> > On Tue, May 21, 2019 at 08:49:18PM +0200, Jens Freimann wrote:
>> > > On Tue, May 21, 2019 at 07:37:19AM -0400, Michael S. Tsirkin wrote:
>> > > > On Tue, May 21, 2019 at 09:21:57AM +0200, Jens Freimann wrote:
>> > > > Actually is there a list of devices for which this has been tested
>> > > > besides mlx5? I think someone said some old intel cards
>> > > > don't support this well, we might need to blacklist these ...
>> > >
>> > > So far I've tested mlx5 and XL710 which both worked, but I'm
>> > > working on testing with more devices. But of course help with testing
>> > > is greatly appreciated.
>> >
>> > A testing tool that people can run to get a pass/fail
>> > result would be needed for that.
>> > Do you have something like this?
>>
>> I have two simple tools. One that sends packets and another one that
>> sniffs for packets to see which device the packet goes to. Find it at
>> https://github.com/jensfr/netfailover_driver_detect
>>
>> Feedback and/or patches welcome.
>>
>> regards,
>> Jens
>
>The docs say:
> ./is_legacy -d . If is_legacy returns 0 it means it has received the packets sent by send_packet. If it returns 1 it didn't receive the packet. Now run ./is_legacy -d
>
>So -d twice. What is the difference?

Should say "Now run ./is_legacy -d <vf device>" to sniff on vf device.
I'll fix the README, thanks!

regards,
Jens 

