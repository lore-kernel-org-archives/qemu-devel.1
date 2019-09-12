Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2468BC49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCF32075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCF32075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8KBK-0004mv-3q
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8KAg-0004L6-6H
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8KAf-0006A1-6n
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:09:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8KAf-00069d-0v
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:09:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 05EAA18CB8E1;
 Thu, 12 Sep 2019 08:09:39 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5993D600C4;
 Thu, 12 Sep 2019 08:09:35 +0000 (UTC)
Date: Thu, 12 Sep 2019 09:09:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190912080932.GA2722@work-vm>
References: <20190911134539.25650-1-johannes@sipsolutions.net>
 <20190911134539.25650-2-johannes@sipsolutions.net>
 <20190911191514.GA2895@work-vm>
 <24d6940040c4f846eaba2154979fd6658b665c98.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d6940040c4f846eaba2154979fd6658b665c98.camel@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 12 Sep 2019 08:09:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v2 1/2] docs: vhost-user: add in-band
 kick/call messages
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Johannes Berg (johannes@sipsolutions.net) wrote:
> On Wed, 2019-09-11 at 20:15 +0100, Dr. David Alan Gilbert wrote:
> 
> > > Extend the protocol slightly, so that a message can be used for kick
> > > and call instead, if VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS is
> > > negotiated. This in itself doesn't guarantee synchronisation, but both
> > > sides can also negotiate VHOST_USER_PROTOCOL_F_REPLY_ACK and thus get
> > > a reply to this message by setting the need_reply flag, and ensure
> > > synchronisation this way.
> > 
> > I'm confused; if you've already got REPLY_ACK, why do we need anything
> > else?  We already require the reply on set_mem_table as part of
> > postcopy.
> 
> Hmm? How's this related to set_mem_table?
> 
> For simulation purposes, I need the kick and call (and error perhaps
> though it's not really used by anyone now it seems) to be synchronous
> messages instead of asynchronous event FD pushes.
> 
> But I think enough words have been expended on explaining it already, if
> I may kindly ask you to read the discussions with Stefan and Michael
> here:
> 
> https://lore.kernel.org/qemu-devel/20190902121233.13382-1-johannes@sipsolutions.net/

Ah OK.

You're actually using the same trick of using
REPLY_ACK/need_reply  to make it synchronous that set_mem_table does;
that makes sense - but then new calls are getting it to actually process
some data/commands on the ring itself?

Dave

> Thanks,
> johannes
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

