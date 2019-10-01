Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17028ECE589
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E123121924
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E123121924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFFSU-000488-Vo
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 06:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iFFRG-0003dk-I8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iFFRA-0004gh-SP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:31:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iFFR8-0004dQ-OA
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:31:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 07D5A307D931;
 Tue,  1 Oct 2019 10:31:16 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E553B5D6D0;
 Tue,  1 Oct 2019 10:31:13 +0000 (UTC)
Date: Tue, 1 Oct 2019 11:31:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: Thoughts on VM fence infrastructure
Message-ID: <20191001103111.GF26133@redhat.com>
References: <20190930142954.GA2801@work-vm>
 <C5374DA3-A1FC-4F1A-AA36-DC02D350F5A1@nutanix.com>
 <20190930160316.GH2759@work-vm>
 <417D4B96-2641-4DA8-B00B-3302E211E939@nutanix.com>
 <20190930171109.GL2759@work-vm>
 <CA2CBDDF-99ED-4693-8622-89D4F2E71DE9@nutanix.com>
 <20190930175914.GM2759@work-vm>
 <DE224DBA-FEFF-42C4-8F04-43BA75DF26AA@nutanix.com>
 <20191001082345.GA2781@work-vm>
 <2248E813-102F-4E60-AF9B-A5A2F21C1687@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2248E813-102F-4E60-AF9B-A5A2F21C1687@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 01 Oct 2019 10:31:16 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 Aditya Ramesh <aramesh@nutanix.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 01, 2019 at 09:56:17AM +0000, Felipe Franciosi wrote:
> 
> 
> > On Oct 1, 2019, at 9:23 AM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > 
> > * Felipe Franciosi (felipe@nutanix.com) wrote:
> >> 
> >> 
> >>> On Sep 30, 2019, at 6:59 PM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> >>> 
> >>> * Felipe Franciosi (felipe@nutanix.com) wrote:
> >>>> 
> >>>> 
> >>>>> On Sep 30, 2019, at 6:11 PM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> >>>>> 
> >>>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
> >>>>>> 
> >>>>>> 
> >>>>>>> On Sep 30, 2019, at 5:03 PM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> >>>>>>> 
> >>>>>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
> >>>>>>>> Hi David,
> >>>>>>>> 
> >>>>>>>>> On Sep 30, 2019, at 3:29 PM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> >>>>>>>>> 
> >>>>>>>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
> >>>>>>>>>> Heyall,
> >>>>>>>>>> 
> >>>>>>>>>> We have a use case where a host should self-fence (and all VMs should
> >>>>>>>>>> die) if it doesn't hear back from a heartbeat within a certain time
> >>>>>>>>>> period. Lots of ideas were floated around where libvirt could take
> >>>>>>>>>> care of killing VMs or a separate service could do it. The concern
> >>>>>>>>>> with those is that various failures could lead to _those_ services
> >>>>>>>>>> being unavailable and the fencing wouldn't be enforced as it should.
> >>>>>>>>>> 
> >>>>>>>>>> Ultimately, it feels like Qemu should be responsible for this
> >>>>>>>>>> heartbeat and exit (or execute a custom callback) on timeout.
> >>>>>>>>> 
> >>>>>>>>> It doesn't feel doing it inside qemu would be any safer;  something
> >>>>>>>>> outside QEMU can forcibly emit a kill -9 and qemu *will* stop.
> >>>>>>>> 
> >>>>>>>> The argument above is that we would have to rely on this external
> >>>>>>>> service being functional. Consider the case where the host is
> >>>>>>>> dysfunctional, with this service perhaps crashed and a corrupt
> >>>>>>>> filesystem preventing it from restarting. The VMs would never die.
> >>>>>>> 
> >>>>>>> Yeh that could fail.
> >>>>>>> 
> >>>>>>>> It feels like a Qemu timer-driven heartbeat check and calls abort() /
> >>>>>>>> exit() would be more reliable. Thoughts?
> >>>>>>> 
> >>>>>>> OK, yes; perhaps using a timer_create and telling it to send a fatal
> >>>>>>> signal is pretty solid; it would take the kernel to do that once it's
> >>>>>>> set.
> >>>>>> 
> >>>>>> I'm confused about why the kernel needs to be involved. If this is a
> >>>>>> timer off the Qemu main loop, it can just check on the heartbeat
> >>>>>> condition (which should be customisable) and call abort() if that's
> >>>>>> not satisfied. If you agree on that I'd like to talk about how that
> >>>>>> check could be made customisable.
> >>>>> 
> >>>>> There are times when the main loop can get blocked even though the CPU
> >>>>> threads can be running and can in some configurations perform IO
> >>>>> even without the main loop (I think!).
> >>>> 
> >>>> Ah, that's a very good point. Indeed, you can perform IO in those
> >>>> cases specially when using vhost devices.
> >>>> 
> >>>>> By setting a timer in the kernel that sends a signal to qemu, the kernel
> >>>>> will send that signal however broken qemu is.
> >>>> 
> >>>> Got you now. That's probably better. Do you reckon a signal is
> >>>> preferable over SIGEV_THREAD?
> >>> 
> >>> Not sure; probably the safest is getting the kernel to SIGKILL it - but
> >>> that's a complete nightmare to debug - your process just goes *pop*
> >>> with no apparent reason why.
> >>> I've not used SIGEV_THREAD - it looks promising though.
> >> 
> >> I'm worried that SIGEV_THREAD could be a bit heavyweight (if it fires
> >> up a new thread each time). On the other hand, as you said, SIGKILL
> >> makes it harder to debug.
> >> 
> >> Also, asking the kernel to defer the SIGKILL (ie. updating the timer)
> >> needs to come from Qemu itself (eg. a timer in the main loop,
> >> something we already ruled unsuitable, or a qmp command which
> >> constitutes an external dependency that we also ruled undesirable).
> > 
> > OK, there's two reasons I think this isn't that bad/is good:
> >   a) It's an external dependency - but if it fails the result is the
> >      system fails, rather than the system keeps on running; so I think
> >      that's the balance you were after; it's the opposite from
> >      the external watchdog.
> 
> Right. I like where you are coming from. And I think a mix of these
> may be the best way forwards. I'll elaborate on it below.
> 
> > 
> >   b) You need some external system anyway to tell QEMU when it's
> >      OK - what's your definitino of a failed system?
> 
> The feature is targeted at providing a self-fencing mechanism for
> Qemu. If a host is unreachable for whatever reason (eg. sshd down, ovs
> died, oomkiller took services out, physical network failure), it
> should guarantee that VMs won't be running after a certain amount of
> time. To your point, if this external software doesn't come in and
> touch the file, that's because it can't reach the host or it wants the
> host to self-fence. The qualifying Qemus should therefore be
> considered dead after a "deadline" period (since the last time the
> control file was touched).

This all sounds reasonable, but I don't see the value in doing this
work
of this work in QEMU.  

> 
> > 
> >> What if, when self-fencing is enabled, Qemu kicks off a new thread
> >> from the start which does nothing but periodically wake up, verify the
> >> heartbeat condition and log()+abort() if required? (Then we wouldn't
> >> need the kernel timer.)
> > 
> > I'd make that thread bump the kernel timer along.
> 
> I think combining the thread's logic with the kernel timer makes the
> whole thing a lot more solid. See below.
> 
> > 
> >>> 
> >>>> I'm still wondering how to make this customisable so that different
> >>>> types of heartbeat could be implemented (preferably without creating
> >>>> external dependencies per discussion above). Thoughts welcome.
> >>> 
> >>> Yes, you need something to enable it, and some safe way to retrigger
> >>> the timer.  A qmp command marked as 'oob' might be the right way -
> >>> another qm command can't block it.
> >> 
> >> This qmp approach is slightly different than the external dependency
> >> that itself kills Qemu; if it doesn't run, then Qemu dies because the
> >> kernel timer is not updated. But this is also a heavyweight approach.
> >> We are talking about a service that needs to frequently connect to all
> >> running VMs on a host to reset the timer.
> >> 
> >> But it does allow for the customisable heartbeat: the logic behind
> >> what triggers the command is completely flexible.
> >> 
> >> Thinking about this idea of a separate Qemu thread, one thing that
> >> came to mind is this:
> >> 
> >> qemu -fence heartbeat=/path/to/file,deadline=60[,recheck=5]
> >> 
> >> Qemu could fire up a thread that stat()s <file> (every <recheck>
> >> seconds or on a default interval) and log()+abort() the whole process
> >> if the last modification time of the file is older than <deadline>. If
> >> <file> goes away (ie. stat() gives ENOENT), then it either fences
> >> immediately or ignores it, not sure which is more sensible.
> >> 
> >> Thoughts?
> > 
> > As above; I'm OK with using a file with that; but I'd make that thread
> > bump the kernel timer along; if that thread gets stuck somehow the
> > kernel still nukes your process.
> 
> 
> Awesome. So check this out:
> 
> qemu -fence heartbeat=/path/to/file,deadline=60[,recheck=5][,harddeadline=61]
> 
> We can default <harddeadline> to <deadline+1> and enforce that:
> -  <deadline> is a multiple of <recheck>.
> - <harddeadline> is bigger than <deadline>
> 
> When <deadline> expires, we can log() + abort(), but if <harddeadline>
> expires, we can rest assured the kernel will come around and SIGKILL
> Qemu. If there's demand for it, this can later be enhanced by adding
> more parameters which set the fence thread scheduling priority, &c.
> 
> If that sounds ok I'll send an RFC as soon as I get a chance and we
> can take it from there.

I don't really see the point in doing any of this in QEMU, as opposed to
using the general purpose self-fencing features of the host OS. As an
example, hardware watchdogs are a built-in feature of systemd

   "To make use of the hardware watchdog it is sufficient to set the
    RuntimeWatchdogSec= option in /etc/systemd/system.conf. It defaults
    to 0 (i.e. no hardware watchdog use). Set it to a value like 20s 
    and the watchdog is enabled. After 20s of no keep-alive pings the 
    hardware will reset itself. Note that systemd will send a ping to
    the hardware at half the specified interval, i.e. every 10s. And 
    that's already all there is to it. By enabling this single, simple
    option you have turned on supervision by the hardware of systemd 
    and the kernel beneath it.[2]"

    http://0pointer.de/blog/projects/watchdog.html


When a host becomes non-responsive, for example, due to a network error
I would not have confidence in QEMU being reliable enough to trigger
any self-fencing code. I've seen many bug reports where QEMU has entirely
hung due to non-responsive network based storage. 

IMHO doing this at the host OS level is going to be more reliable in
terms of detecting the problem in the first place, as well as more
reliable in taking the action - its very difficult for a hardware CPU
reset to fail to work.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

