Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB772ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B61206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B61206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yhl-0006Dk-JD
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i7xxe-0001Uc-Sd
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i7xxc-0007Fe-Vs
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:26:46 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:48856
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i7xxc-0007FA-Ov
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:26:44 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i7xxa-0001GZ-DG; Wed, 11 Sep 2019 10:26:42 +0200
Message-ID: <bc3409f2f0df110ff0d795ad72b5bb5b29e2b5a6.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 11 Sep 2019 10:26:41 +0200
In-Reply-To: <20190911073503.GB4181@stefanha-x1.localdomain>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <fe517ef6c6a8e2df9675388be9454b5863c7fc55.camel@sipsolutions.net>
 <20190909160039.GC20875@stefanha-x1.localdomain>
 <d095bafedcd4bcc5d76279785e5bd523aef62b58.camel@sipsolutions.net>
 <20190910150319.GB31674@stefanha-x1.localdomain>
 <e114b68dffecd9b4c4666327b15a28098c83f7ec.camel@sipsolutions.net>
 <20190911073503.GB4181@stefanha-x1.localdomain>
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

On Wed, 2019-09-11 at 09:35 +0200, Stefan Hajnoczi wrote:
> On Tue, Sep 10, 2019 at 05:14:36PM +0200, Johannes Berg wrote:
> > On Tue, 2019-09-10 at 17:03 +0200, Stefan Hajnoczi wrote:
> > > > Now, this means that the CPU (that's part of the simulation) has to
> > > > *wait* for the device to add an entry to the simulation calendar in
> > > > response to the kick... That means that it really has to look like
> > > > 
> > > > CPU               device                   calendar
> > > >      ---[kick]-->
> > > >                          ---[add entry]-->
> > > >                          <---[return]-----
> > > 
> > > What are the semantics of returning from the calendar?  Does it mean
> > > "it's now your turn to run?", "your entry has been added and you'll be
> > > notified later when it's time to run?", or something else?
> > 
> > The latter - the entry was added, and you'll be notified when it's time
> > to run; but we need to have that state on the calendar so the CPU won't
> > converse with the calendar before that state is committed.
> 
> Is the device only adding a calendar entry and not doing any actual
> device emulation at this stage?

Correct, yes.

With one exception: in the case of the simtime (calendar) device, the
actual processing *does* happen at this stage, of course - the calendar
entry has to have been added before we return.

> If yes, then this suggests the system could be structured more cleanly.
> The vhost-user device process should focus on device emulation.  It
> should not be aware of the calendar.

Decoupling the device entirely from the simulation doesn't work, at
least it depends on what you want to emulate. If you don't care that
everything in the device happens immediately (in simulation time), then
this might be OK - but in most cases you do want to model some latency,
processing time or similar in the device, and that means the device has
to request more calendar entries for its further processing.

Take a network device for example that wants to model a 50ms latency. It
has to first have a calendar event to take the packet from the deriver
onto the wire, and then have another calendar event to push the packet
from the wire out some other driver. The first of those events could be
modelled by what you suggest below, the second cannot.

> The vhost-user protocol also shouldn't require modifications.
> 
> Instead, Linux arch/um code would add the entry to the calendar when the
> CPU wants to kick a vhost-user device.  I assume the CPU is suspended
> until arch/um code completes adding the entry to the calendar.

Right, OK, so far I'm following, and it seems perfectly reasonable.

Though as I said above (the simtime exception) - suspending the CPU
while adding an entry to the calendar actually also relies on the
KICK/ACK message semantics right now. This could easily be implemented
differently in this particular device though, e.g. by waiting for an ACK
message on a response virtqueue after sending the "add-entry" request on
the command virtqueue.

> When the calendar decides to run the device entry it signals the
> vhost-user kick eventfd.

Now you have to send those FDs also to the calendar, but I guess the
calendar is a vhost-user device too anyway, so we can send it the FD
along with the request to add the calendar entry, i.e. instead of adding
a calendar entry "please tell me" you can add a calendar entry with
"please kick this FD". Seems reasonable, though it requires much deeper
integration of the virtio implementation with the calendar than I was
planning, though possibly a bit less such integration on the device
side.

> The vhost-user device processes the virtqueue
> as if it had been directly signalled by the CPU, totally unaware that
> it's running within a simulation system.

As I said above, it cannot be entirely unaware unless it's a very
trivial device emulation. That *might* be something you actually
want/don't care, for example for a "control network" within the
simulation where you don't need to model any latencies, however it also
very easily introduces issues, say if the vhost-user device emulation,
focusing completely on emulation, starts doing 'sleep()' or similar OS
calls; they really should be going to the simulation instead.


However, really the place where this breaks down is that you don't know
when the device has finished processing.

As a totally made-up example, say you're emulating a strange /dev/null
device, but as a special quirk it can only ever consume an even number
of buffers. You give it a buffer on a virtqueue and kick it, nothing
happens; you give it another one and kick it, it'll consume both and
free (call) up the two entries, doing nothing else.

In the simulation of this device, it has to essentially behave like
this:
On kick, it schedules a calendar entry to process the interrupt. Once
that entry is signalled, the interrupt processing code runs and checks
the state of the virtqueue; if there's an even number of buffers it
releases them both. Regardless of whether that happened, it will then
relinquish its time slice, telling the calendar it's done processing.

In the model you propose, that last bit of "relinquish my time slice"
part will be missing. This _might_ be fine for some devices that always
reply *immediately* and never defer any work, i.e. every single kick
will be followed by a call essentially immediately. But already in my
simple hypothetical example above the call never happens for the first
buffer, so the simulation will get completely stuck.

Similarly, you can easily imagine other device that don't just process
the buffers but also have some more internal state, or internal timers,
or something like that.

Thus I don't think the part of your proposed model that disconnects the
device from the calendar is workable, or at least is only workable for a
very limited number of devices that never defer anything and have a very
simple command/response behaviour.

Now, the question remains though if the protocol changes could be
avoided. While I think that in theory that is possible using a model
such as yours, I suspect (and this is more gut feeling for now than
really well-argued) that we're better off with the protocol changes, for
example because:

1) This lets us detect that the device was set up for simulation, and if
   it doesn't support F_KICK_CALL_MSGS we can refuse to connect to it in
   simulation mode. This is a bit handwaving, since in simulation you
   control fully your devices and everything, but for somebody who
   hasn't read all of the detailed discussions here that might save some
   time understanding they cannot just add arbitrary devices to the
   simulation and expect things to work.
   But yes, doing this would also meansort of abusing the
   F_KICK_CALL_MSGS as a moniker for simulation, which isn't really how
   I spec'ed it, because I didn't want to introduce any simulation
   calendar language into the vhost-user spec ...
   (IOW, any other device might implement F_KICK_CALL_MSGS and you could
   connect it, but I'm sort of banking on the fact that implementing
   this protocol extension outside of simulation is stupid.)

2) When we add a calendar entry on behalf of the device, we'd have to
   associate it with the device somehow, so when the device then later
   relinquishes its time slice the calendar knows what's going on.
   Theoretically this isn't needed as only one thing should be running
   (the device that was told to via the kick-fd-calendar-entry), but in
   practice bugs will happen and detecting them helps a lot.


> I'm suggesting this because it seems like a cleaner approach than
> exposing the calendar concept to the vhost-user devices.

As I argue above, for all intents and purposes that only works for
extremely trivial devices, to the extent that I'd rather exclude them
than risk unexpected behaviour.

After all, the main use cases for this are going to be
1) modelling more complex devices (I intend to model a wifi device)
2) modelling network topologies in the virtual network switch (to which
   the UML instances connect via vhost-user, requiring calendar
   integration as described above)
3) similarly modelling wireless networks
etc.

> I'm not 100%
> sure it offers the semantics you need to make everything deterministic
> though.

It sounds like it does, but it doesn't seem like a big win to me.

But like I said before, if there's enough objection to adding something
like this to the protocol then certainly we can get away without it, and
the model you propose is even a bit nicer than the model I had in mind
(I considered putting all VQs into polling mode, and then having the
calendar tell the devices to poll rather than having the calendar kick
the FDs.)

Overall, I think it becomes more manageable with the extension though.

> A different topic: vhost-user does not have a 1:1 vq buffer:kick
> relationship.  It's possible to add multiple buffers and kick only once.
> It is also possible for the device to complete multiple buffers and only
> call once.
> 
> This could pose a problem for simulation because it allows a degree of
> non-determinism.  But as long as the both the CPU and the I/O completion
> of the device happen on a strict schedule this isn't a problem.

Yes, I'm aware, but this is fine. The device will not see those buffers
until it's kicked. It could even be that when the device schedules the
interrupt processing time for some future time (say if it's super busy
now), and the CPU continues running to add more buffers and even kick
again. Or the CPU doesn't release its time slice because it just simply
has code like

  add_outbuf(vq, buf)
  kick(vq)
  add_outbuf(vq, buf)
  kick(vq)
  wait_for_response() // release time slice here

Now, most drivers would probably avoid that first kick, but it still
models fine.

johannes


