Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEB8C74A2B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52642064A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52642064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFbp-0007X1-5Y
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34063)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlFa4-0005bt-Sl
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlFa1-00007m-Vf
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:36:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlFZy-0008NX-0l
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:36:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC3A4307D983;
 Wed, 10 Jul 2019 16:36:13 +0000 (UTC)
Received: from work-vm (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B916F5D9CA;
 Wed, 10 Jul 2019 16:36:12 +0000 (UTC)
Date: Wed, 10 Jul 2019 17:36:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190710163610.GG2682@work-vm>
References: <20190610105906.28524-1-dplotnikov@virtuozzo.com>
 <87lfxfy67u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfxfy67u.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 10 Jul 2019 16:36:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] monitor: increase amount of data for
 monitor to read
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
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Did this fall through the cracks?
> 
> Denis Plotnikov <dplotnikov@virtuozzo.com> writes:
> 
> > Right now QMP and HMP monitors read 1 byte at a time from the socket, which
> > is very inefficient. With 100+ VMs on the host this easily reasults in
> > a lot of unnecessary system calls and CPU usage in the system.
> 
> Yes, reading one byte at a time is awful.  But QMP is control plane; I
> didn't expect it to impact system performance.  How are you using QMP?
> Just curious, not actually opposed to improving QMP efficiency.
> 
> > This patch changes the amount of data to read to 4096 bytes, which matches
> > buffer size on the channel level. Fortunately, monitor protocol is
> > synchronous right now thus we should not face side effects in reality.
> >
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > ---
> >  include/monitor/monitor.h | 2 +-
> >  monitor.c                 | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> > index c1b40a9cac..afa1ed34a4 100644
> > --- a/include/monitor/monitor.h
> > +++ b/include/monitor/monitor.h
> > @@ -14,7 +14,7 @@ extern __thread Monitor *cur_mon;
> >  #define MONITOR_USE_CONTROL   0x04
> >  #define MONITOR_USE_PRETTY    0x08
> >  
> > -#define QMP_REQ_QUEUE_LEN_MAX 8
> > +#define QMP_REQ_QUEUE_LEN_MAX 4096
> 
> This looks suspicious.  It's a request count, not a byte count.  Can you
> explain what led you to change it this way?
> 
> >  
> >  bool monitor_cur_is_qmp(void);
> >  
> > diff --git a/monitor.c b/monitor.c
> > index 4807bbe811..a08e020b61 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -4097,7 +4097,7 @@ static int monitor_can_read(void *opaque)
> >  {
> >      Monitor *mon = opaque;
> >  
> > -    return !atomic_mb_read(&mon->suspend_cnt);
> > +    return !atomic_mb_read(&mon->suspend_cnt) ? 4096 : 0;
> >  }
> >  
> >  /*
> 
> The ramifications are not obvious to me.  I think I need to (re-)examine
> how QMP reads input, with special consideration to its OOB feature.

Yeh that was the bit that worried me; I also wondered what happens with
monitor_suspend and things like fd passing; enough to make it
non-obvious to me.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

