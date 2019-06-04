Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B673C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 13:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E5724642
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 13:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E5724642
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY9ju-00030I-63
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 09:44:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hY9j7-0002jA-Td
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hY9j6-0002kH-Pt
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hY9j6-0002Un-HG
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:43:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F1EB75726
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 13:43:31 +0000 (UTC)
Received: from localhost (dhcp-192-193.str.redhat.com [10.33.192.193])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 301BB60564;
	Tue,  4 Jun 2019 13:43:23 +0000 (UTC)
Date: Tue, 4 Jun 2019 15:43:21 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190604134321.txlw7wjwe247g5ug@jenstp.localdomain>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
	<20190603193648.GQ22103@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190603193648.GQ22103@habkost.net>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 04 Jun 2019 13:43:31 +0000 (UTC)
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

On Mon, Jun 03, 2019 at 04:36:48PM -0300, Eduardo Habkost wrote:
>On Mon, Jun 03, 2019 at 10:24:56AM +0200, Jens Freimann wrote:
>> On Fri, May 31, 2019 at 06:47:48PM -0300, Eduardo Habkost wrote:
>> > On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote:
>> > > On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote:
>> > > > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert wrote:
>> > > > > * Jens Freimann (jfreimann@redhat.com) wrote:
>> Why is it bad to fully re-create the device in case of a failed migration?
>
>Bad or not, I thought the whole point of doing it inside QEMU was
>to do something libvirt wouldn't be able to do (namely,
>unplugging the device while not freeing resources).  If we are
>doing something that management software is already capable of
>doing, what's the point?

Event though management software seems to be capable of it, a failover
implementation has never happened. As Michael says network failover is
a mechanism (there's no good reason not to use a PT device if it is
available), not a policy. We are now trying to implement it in a
simple way, contained within QEMU. 

>Quoting a previous message from this thread:
>
>On Thu, May 30, 2019 at 02:09:42PM -0400, Michael S. Tsirkin wrote:
>| > On Thu, May 30, 2019 at 07:00:23PM +0100, Dr. David Alan Gilbert wrote:
>| > >  This patch series is very
>| > > odd precisely because it's trying to do the unplug itself in the
>| > > migration phase rather than let the management layer do it - so unless
>| > > it's nailed down how to make sure that's really really bullet proof
>| > > then we've got to go back and ask the question about whether we should
>| > > really fix it so it can be done by the management layer.
>| > >
>| > > Dave
>| >
>| > management already said they can't because files get closed and
>| > resources freed on unplug and so they might not be able to re-add device
>| > on migration failure. We do it in migration because that is
>| > where failures can happen and we can recover.

This is something that I can work on as well, but it doesn't have to
be part of this patch set in my opinion. Let's say migration fails and we can't
re-plug the primary device. We can still use the standby (virtio-net)
device which would only mean slower networking. How likely is it that
the primary device is grabbed by another VM between unplugging and
migration failure anyway? 

regards,
Jens 


>
>-- 
>Eduardo

