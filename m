Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E29C4332F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 13:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC5C2081B
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 13:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC5C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6x1c-00019P-C8
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 09:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i6x0x-0000kr-A5
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 09:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i6x0v-0008AL-Pm
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 09:13:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i6x0v-0008A6-Hy
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 09:13:57 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AADB85539
 for <qemu-devel@nongnu.org>; Sun,  8 Sep 2019 13:13:56 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id 11so12891425qkh.15
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 06:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bZxNvIeBouyLBb3KFbVJBAATdYdLKnO5CV73mcJDQGg=;
 b=BKgVHjm5aQ/zgZ9q9ZIIK1n1j8c9KfaYd1bkLrNjMMQy9fkH8Y91Lyx4m36bi7KJRx
 9Oyb5HilwQH58fuqNdIdqCgrsNJw/y/mMN8ORVjKP6iq/o4c9waqnk2eGWXKCLFP+FZa
 bJrOrZZmoenqdSZ/mgmDCzXZN5V/quICdnw4gHWAR1FHoJIG3cnD8qnWthPsQFW060md
 7kElKuQDtbvrIQNAidgsT2lclcU3xiF7cB7FRXKqLOHVUoRzm5rk7o5WF/F0TFKATl/2
 O3BVUUPPnHq7NPFiO6w5kWweobbcnSJY7PI30kYDQNPQv/d5F3QHqhOCvRVsK+un2rKd
 itNw==
X-Gm-Message-State: APjAAAVS65DCXgEiKXFlIKWaUdocxLTM/Piyimmfd3P9apiLInSdphVR
 sCjv6g5HOenkOO2w16XEP3S9+E6QJVo7uExsXQhiVX07fCu1jGug8FP0Qq1Ih73eoBSvu/YvQOk
 qiYNrp5qVJEdSTgQ=
X-Received: by 2002:aed:35ef:: with SMTP id d44mr19124817qte.306.1567948435832; 
 Sun, 08 Sep 2019 06:13:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqws3Fr3Pe2mJp2GqNXAR8RNOq6hBh1yprWJ2MRZkN5uY5T4CmR5BiLxugMw6C5TR5dOxZWJ4Q==
X-Received: by 2002:aed:35ef:: with SMTP id d44mr19124802qte.306.1567948435620; 
 Sun, 08 Sep 2019 06:13:55 -0700 (PDT)
Received: from redhat.com ([212.92.124.241])
 by smtp.gmail.com with ESMTPSA id o52sm7514930qtf.56.2019.09.08.06.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 06:13:54 -0700 (PDT)
Date: Sun, 8 Sep 2019 09:13:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190908091207-mutt-send-email-mst@kernel.org>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190906121350.29202-1-johannes@sipsolutions.net>
 <20190906102217-mutt-send-email-mst@kernel.org>
 <be405c3ba658cdac7f68c91213c3b714ac24c1e3.camel@sipsolutions.net>
 <20190906110340-mutt-send-email-mst@kernel.org>
 <fe0f3f7bfa730088454790dc2d863285c4461134.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0f3f7bfa730088454790dc2d863285c4461134.camel@sipsolutions.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS
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

On Fri, Sep 06, 2019 at 05:32:02PM +0200, Johannes Berg wrote:
> Hi,
> 
> > Oh. Apparently qemu mailman chose this time to kick me out
> > of list subscription (too many bounces or something?)
> > so I didn't see it.
> 
> D'oh. Well, it's really my mistake, I should've CC'ed you.
> 
> > What worries me is the load this places on the socket.
> > ATM if socket buffer is full qemu locks up, so we
> > need to be careful not to send too many messages.
> 
> Right, sure. I really don't think you ever want to use this extension in
> a "normal VM" use case. :-)
> 
> I think the only use for this extension would be for simulation
> purposes, and even then only combined with the REPLY_ACK and SLAVE_REQ
> extensions, i.e. you explicitly *want* your virtual machine to lock up /
> wait for a response to the KICK command (and respectively, the device to
> wait for a response to the CALL command).

OK so when combined with these, it's OK I think.
Do we want to force this restriction in code maybe then?


> Note that this is basically its sole purpose: ensuring exactly this
> synchronisation! Yes, it's bad for speed, but it's needed in simulation
> when time isn't "real".
> 
> Let me try to explain again, most likely my previous explanation was too
> long winded. WLOG, I'll focus on the "kick" use case, the "call" is the
> same, just the other way around. I'm sure you know that the call is
> asynchronous, i.e. the VM will increment the eventfd counter, and
> "eventually" it becomes readable to the device. Now the device does
> something (as fast as it can, presumably) and returns the buffer to the
> VM.
> 
> Now, imagine you're running in simulation time, i.e. "time travel" mode.
> Briefly, this hacks the idle loop of the (UML) VM to just skip forward
> when there's nothing to do, i.e. if you have a timer firing in 100ms and
> get to idle, time is immediately incremented by 100ms and the timer
> fires. For a single VM/device this is already implemented in UML, and
> while it's already very useful that's only half the story to me.
> 
> Once you have multiple devices and/or VMs, you basically have to keep a
> "simulation calendar" where each participant (VM/device) can put an
> entry, and then whenever they become idle they don't immediately move
> time forward, but instead ask the calendar what's next, and the calendar
> determines who runs.
> 
> Now, for these simulation cases, consider vhost-user again. It's
> absolutely necessary that the calendar is updated all the time, and the
> asynchronous nature of the call breaks that - the device cannot update
> the calendar to put an event there to process the call message.
> 
> With this extension, the device would work in the following way. Assume
> that the device is idle, and waiting for the simulation calendar to tell
> it to run. Now,
> 
>  1) it has an incoming call (message) from VM (which waits for reply)
>  2) the device will now put a new event on the simulation scheduler for
>     a time slot to process the message
>  3) return reply to VM
>  4) device goes back to sleep - this stuff was asynchronously handled
>     outside of the simulation basically.
> 
> In a sense, the code that just ran isn't considered part of the
> simulated device, it's just the transport protocol and part of the
> simulation environment.
> 
> At this point, the device is still waiting for its calendar event to be
> triggered, but now it has a new one to process the message. Now, once
> the VM goes to sleep, the scheduler will check the calendar and
> presumably tell the device to run, which runs and processes the message.
> This repeats for as long as the simulation runs, going both ways (or
> multiple ways if there are more than 2 participants).
> 
> 
> Now, what if you didn't have this synchronisation, ie. we don't have
> this extension or we don't have REPLY_ACK or whatnot?
> 
> In that case, after the step 1 above, the VM will immediately continue
> running. Let's say it'll wait for a response from the device for a few
> hundred milliseconds (of now simulated time). However, depending on the
> scheduling, the device has quite likely not yet put the new event on the
> simulation calendar (that happens in step 2 above). This means that the
> VM's calendar event to wake it up after a few hundred milliseconds will
> immediately trigger, and the simulation ends with the driver getting a
> timeout from the device.
> 
> 
> So - yes, while I understand your concern, I basically think this is not
> something anyone will want to use outside of such simulations. OTOH,
> there are various use cases (I'm doing device simulation, others are
> doing network simulation) that use such a behaviour, and it might be
> nice to support it in a more standard way, rather than everyone having
> their own local hacks for everything, like e.g. the VMSimInt paper(**).
> 
> 
> But again, like I said, no hard feelings if you think such simulation
> has no place in upstream vhost-user.
> 
> 
> (**) I put a copy of their qemu changes on top of 1.6.0 here:
>      https://p.sipsolutions.net/af9a68ded948c07e.txt
> 
> johannes

