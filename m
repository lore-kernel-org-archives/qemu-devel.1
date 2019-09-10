Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694D6C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400DA208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400DA208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hu7-000720-DW
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i7hr0-0004en-9G
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i7hqv-0005ri-46
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:14:50 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:55756
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i7hqt-0005nV-6W
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:14:44 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i7hqn-0000aF-QK; Tue, 10 Sep 2019 17:14:37 +0200
Message-ID: <e114b68dffecd9b4c4666327b15a28098c83f7ec.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 10 Sep 2019 17:14:36 +0200
In-Reply-To: <20190910150319.GB31674@stefanha-x1.localdomain>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <fe517ef6c6a8e2df9675388be9454b5863c7fc55.camel@sipsolutions.net>
 <20190909160039.GC20875@stefanha-x1.localdomain>
 <d095bafedcd4bcc5d76279785e5bd523aef62b58.camel@sipsolutions.net>
 <20190910150319.GB31674@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call
 messages
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
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-09-10 at 17:03 +0200, Stefan Hajnoczi wrote:
> 
> > Now, this means that the CPU (that's part of the simulation) has to
> > *wait* for the device to add an entry to the simulation calendar in
> > response to the kick... That means that it really has to look like
> > 
> > CPU               device                   calendar
> >      ---[kick]-->
> >                          ---[add entry]-->
> >                          <---[return]-----
> 
> What are the semantics of returning from the calendar?  Does it mean
> "it's now your turn to run?", "your entry has been added and you'll be
> notified later when it's time to run?", or something else?

The latter - the entry was added, and you'll be notified when it's time
to run; but we need to have that state on the calendar so the CPU won't
converse with the calendar before that state is committed.

> >      <-[return]--
> 
> What are the semantics of returning to the CPU?  Does it mean the
> submitted I/O request is now complete?

No, it just means that the interrupt was triggered; it will be handled
once the calendar decide that it's the device's turn to run its
interrupt processing event.

The I/O request completion will be done later in a very similar fashion
(just inverting the participants, and replacing "kick" by "call").

> Sorry for these questions.  If this becomes tedious for you I will look
> into the paper you linked.

No no, don't worry, it's fine. Also, the paper doesn't really concern
itself with issues such as this, they just assume everything is
synchronous and make their code that way - they have a simulated device
in qemu that they wrote themselves, and it just happens to be
synchronous by way of their implementation...

What I'm trying to do here now is not really replicate that paper or
anything, but - because I'm working on similar things and simulation -
get some pieces into the upstreams (qemu for vhost-user, Linux for user-
mode-Linux running in a simulation) so (a) I don't have to maintain it
out-of-tree, and (b) it's available for others for use without a monster
patch to an ancient version of the software stack :-)

Happy to answer any questions.

Aside from the interrupt processing semantics in UML which I'll work on
next I do have the whole simulation calendar working etc., i.e. I have
full UML "VM" controlled entirely by the simulation calendar, also over
virtio.



Btw, that reminds me ... there's yet another process to add a virtio
device ID. I'm currently defining a virtio simulation calendar protocol
like this:

+/*
+ * A message passed on either of the VQs (input and output).
+ */
+struct virtio_simtime_msg {
+       __u64 op;               /* see below */
+       __u64 time;             /* time in nanoseconds */
+};
+
+/**
+ * enum virtio_simtime_ops - Operation codes
+ */
+enum virtio_simtime_ops {
+       /**
+        * @VIRTIO_SIMTIME_REQUEST: request from device to run at the given time
+        */
+       VIRTIO_SIMTIME_REQUEST          = 1,
+
+       /**
+        * @VIRTIO_SIMTIME_WAIT: wait for the requested runtime, new requests
+        *      may be made while waiting (due to interrupts); the time field
+        *      is ignored
+        */
+       VIRTIO_SIMTIME_WAIT             = 2,
+
+       /**
+        * @VIRTIO_SIMTIME_GET: ask device to fill the buffer with the current
+        *      simulation time
+        */
+       VIRTIO_SIMTIME_GET              = 3,
+
+       /**
+        * @VIRTIO_SIMTIME_UPDATE: time update to/from the control device
+        */
+       VIRTIO_SIMTIME_UPDATE           = 4,
+
+       /**
+        * @VIRTIO_SIMTIME_RUN: run time request granted, current time is in
+        *      the time field
+        */
+       VIRTIO_SIMTIME_RUN              = 5,
+
+       /**
+        * @VIRTIO_SIMTIME_FREE_UNTIL: enable free-running until the given time,
+        *      this is a messag from the device telling the user that it can do
+        *      its own scheduling for anything before the given time
+        */
+       VIRTIO_SIMTIME_FREE_UNTIL       = 6,
+};


Above, I've basically only described _REQUEST, _WAIT and _RUN, I'm
pretty sure I need _GET for interrupt handling (or maybe more
efficiently a _REQUEST_NOW, rather than using _GET && _REQUEST); I think
I need _UPDATE before a "kick" to the device if I have _FREE_UNTIL which
is an optimization to not have to talk to the calendar all the time.


Is any of you familiar with the process of getting a virtio device ID
assigned, and if so, do you think it'd be feasible? Without that, it'd
probably be difficult to upstream the patch to support this protocol to
user-mode Linux.

Thanks,
johannes


