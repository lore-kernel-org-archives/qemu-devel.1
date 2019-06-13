Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9E6C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C846206BB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C846206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40614 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbR4y-0006Xx-CR
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35490)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbQSa-0008DL-8P
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbQSY-0000Q1-VO
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:12:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbQS8-000084-F2; Thu, 13 Jun 2019 10:11:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B63FFCAA74;
 Thu, 13 Jun 2019 14:11:21 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-246.ams2.redhat.com [10.36.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA0EE5D9C5;
 Thu, 13 Jun 2019 14:11:20 +0000 (UTC)
Date: Thu, 13 Jun 2019 16:11:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190613141119.GA7338@linux.fritz.box>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-10-kwolf@redhat.com>
 <874l4vymlo.fsf@dusky.pond.sub.org>
 <20190612152536.GE9699@localhost.localdomain>
 <87zhmmqc34.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhmmqc34.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 13 Jun 2019 14:11:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/11] monitor: Split out monitor/qmp.c
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.06.2019 um 07:38 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 12.06.2019 um 15:11 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >> > --- a/include/monitor/monitor.h
> >> > +++ b/include/monitor/monitor.h
> >> > @@ -21,6 +21,7 @@ bool monitor_cur_is_qmp(void);
> >> >  
> >> >  void monitor_init_globals(void);
> >> >  void monitor_init(Chardev *chr, int flags);
> >> > +void monitor_init_qmp(Chardev *chr, int flags);
> >> 
> >> Why does this one go to the non-internal header?
> >
> > Most callers already know whether they want QMP or HMP, so they can just
> > directly create the right thing instead of going through the
> > monitor_init() wrapper.
> >
> > If you prefer, I can move it to the internal header, though. It's not
> > called externally yet.
> 
> As is, monitor_init_qmp() and monitor_init_hmp() are awkward interfaces:
> what if you pass MONITOR_USE_CONTROL to monitor_init_hmp()?
> 
> I can see just one call passing flags that aren't compile-time
> constant.  I think a better interface would be
> 
>     monitor_init_hmp(Chardev *chr);
>     monitor_init_qmp(Chardev *chr, bool pretty);
> 
> replacing monitor_init() entirely.  This is my first preference.
> 
> My (somewhat distant) second is hiding the awkward interfaces in the
> internal header for now, and clean them up later.
> 
> Your choice.

I'm doing both, as in move it to the internal header in the code motion
patches, but add some patches at the end of the series to clean it up.

Kevin

