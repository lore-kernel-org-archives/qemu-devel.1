Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610F8C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3689C21855
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3689C21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEzEc-0003S2-0C
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 13:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iEzCc-0001oG-Kq
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iEzCb-0005ej-HF
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:11:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iEzCb-0005dT-8z
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:11:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 484AD8980E8;
 Mon, 30 Sep 2019 17:11:12 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FBD35D6D0;
 Mon, 30 Sep 2019 17:11:11 +0000 (UTC)
Date: Mon, 30 Sep 2019 18:11:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: Thoughts on VM fence infrastructure
Message-ID: <20190930171109.GL2759@work-vm>
References: <42837590-2563-412B-ADED-57B8A10A8E68@nutanix.com>
 <20190930142954.GA2801@work-vm>
 <C5374DA3-A1FC-4F1A-AA36-DC02D350F5A1@nutanix.com>
 <20190930160316.GH2759@work-vm>
 <417D4B96-2641-4DA8-B00B-3302E211E939@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417D4B96-2641-4DA8-B00B-3302E211E939@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Mon, 30 Sep 2019 17:11:12 +0000 (UTC)
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
Cc: Aditya Ramesh <aramesh@nutanix.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Felipe Franciosi (felipe@nutanix.com) wrote:
> 
> 
> > On Sep 30, 2019, at 5:03 PM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > 
> > * Felipe Franciosi (felipe@nutanix.com) wrote:
> >> Hi David,
> >> 
> >>> On Sep 30, 2019, at 3:29 PM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> >>> 
> >>> * Felipe Franciosi (felipe@nutanix.com) wrote:
> >>>> Heyall,
> >>>> 
> >>>> We have a use case where a host should self-fence (and all VMs should
> >>>> die) if it doesn't hear back from a heartbeat within a certain time
> >>>> period. Lots of ideas were floated around where libvirt could take
> >>>> care of killing VMs or a separate service could do it. The concern
> >>>> with those is that various failures could lead to _those_ services
> >>>> being unavailable and the fencing wouldn't be enforced as it should.
> >>>> 
> >>>> Ultimately, it feels like Qemu should be responsible for this
> >>>> heartbeat and exit (or execute a custom callback) on timeout.
> >>> 
> >>> It doesn't feel doing it inside qemu would be any safer;  something
> >>> outside QEMU can forcibly emit a kill -9 and qemu *will* stop.
> >> 
> >> The argument above is that we would have to rely on this external
> >> service being functional. Consider the case where the host is
> >> dysfunctional, with this service perhaps crashed and a corrupt
> >> filesystem preventing it from restarting. The VMs would never die.
> > 
> > Yeh that could fail.
> > 
> >> It feels like a Qemu timer-driven heartbeat check and calls abort() /
> >> exit() would be more reliable. Thoughts?
> > 
> > OK, yes; perhaps using a timer_create and telling it to send a fatal
> > signal is pretty solid; it would take the kernel to do that once it's
> > set.
> 
> I'm confused about why the kernel needs to be involved. If this is a
> timer off the Qemu main loop, it can just check on the heartbeat
> condition (which should be customisable) and call abort() if that's
> not satisfied. If you agree on that I'd like to talk about how that
> check could be made customisable.

There are times when the main loop can get blocked even though the CPU
threads can be running and can in some configurations perform IO
even without the main loop (I think!).
By setting a timer in the kernel that sends a signal to qemu, the kernel
will send that signal however broken qemu is.

> 
> > 
> > IMHO the safer way is to kick the host off the network by reprogramming
> > switches; so even if the qemu is actually alive it can't get anywhere.
> > 
> > Dave
> 
> Naturally some off-host STONITH is preferable, but that's not always
> available. A self-fencing mechanism right at the heart of the emulator
> can do the job without external hardware dependencies.

Dave

> Cheers,
> Felipe
> 
> > 
> > 
> >> Felipe
> >> 
> >>> 
> >>>> Does something already exist for this purpose which could be used?
> >>>> Would a generic Qemu-fencing infrastructure be something of interest?
> >>> Dave
> >>> 
> >>> 
> >>>> Cheers,
> >>>> F.
> >>>> 
> >>> --
> >>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >> 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

