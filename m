Received: from eggs.gnu.org ([2001:4830:134:3::10]:51509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctb1R-0001xA-TB
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctb1O-0005g7-Gl
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:25:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctb1N-0005fc-UM
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:25:54 -0400
Date: Thu, 30 Mar 2017 11:25:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170330142550.GJ3709@thinpad.lan.raisama.net>
References: <1490653177-131484-1-git-send-email-agraf@suse.de>
	<20170328004108.GP28530@thinpad.lan.raisama.net>
	<9d85e056-3331-9815-404b-9557ca5028cc@suse.de>
	<20170328123105.GA4418@thinpad.lan.raisama.net>
	<5d929569-8deb-2de0-4894-ec50ef98c8b9@suse.de>
	<20170330142240.GH3709@thinpad.lan.raisama.net>
	<67d1d8fe-0f0d-3c68-bcf7-6889727b8927@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d1d8fe-0f0d-3c68-bcf7-6889727b8927@suse.de>
Subject: Re: [Qemu-devel] [PATCH] i386: Allow cpuid bit override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 30, 2017 at 04:23:34PM +0200, Alexander Graf wrote:
> On 03/30/2017 04:22 PM, Eduardo Habkost wrote:
> > On Tue, Mar 28, 2017 at 02:35:57PM +0200, Alexander Graf wrote:
> > > On 03/28/2017 02:31 PM, Eduardo Habkost wrote:
> > > > On Tue, Mar 28, 2017 at 01:26:04PM +0200, Alexander Graf wrote:
> > [...]
> > > > > Putting it into a special enum sounds much more fragile than the current
> > > > > solution to me. We need to bool fallback either way, so I fail to see any
> > > > > benefit from having the enum.
> > > > I don't see why the enum would be more fragile. With the QAPI
> > > > enum, we:
> > > > * Have a meaningful value for the QOM property 'type' field,
> > > >     and have some hope to make type information for QOM properties
> > > >     really useful one day;
> > > > * Have the possible values for the property well-documented in
> > > >     the QAPI schema;
> > > > * Have the string<->enum translation code automatically generated
> > > >     for us;
> > > > * Can easily add other values later (I have been planning to
> > > >     support "feat=host" so "-cpu host/max" aren't special cases in
> > > >     the code.
> > > > 
> > > Ok, can you create the boilerplate for an OnOff enum type for me and I'll
> > > plug =force into that? All that visitor stuff scares me :).
> > I can do it, if you don't mind waiting for a few days. :)
> 
> 
> As long as we still manage to hit 2.9 with this I'm all happy :).

We won't, as this is not a bug fix and we are past hard freeze. :(

-- 
Eduardo
