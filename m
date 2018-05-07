Received: from eggs.gnu.org ([2001:4830:134:3::10]:44668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fFgVq-0005k6-Sa
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fFgVm-00041U-13
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:49:10 -0400
Message-ID: <679d506dbec32c4978a03fe07f21de3e43fba2c0.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Mon, 07 May 2018 15:48:54 +0200
In-Reply-To: <20180427121700.GP8800@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
	<1524672566.23669.15.camel@redhat.com>
	<20180426005555.GA8800@umbus.fritz.box>
	<1524732340.23669.21.camel@redhat.com>
	<20180427021422.GL8800@umbus.fritz.box>
	<1524817870.23669.25.camel@redhat.com>
	<20180427121700.GP8800@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org

On Fri, 2018-04-27 at 22:17 +1000, David Gibson wrote:
> On Fri, Apr 27, 2018 at 10:31:10AM +0200, Andrea Bolognani wrote:
> > On Fri, 2018-04-27 at 12:14 +1000, David Gibson wrote:
> > > Right.. note that with the draft qemu patches a TCG guest will be
> > > prevented from using hugepages *by default* (the default value of the
> > > capability is 16).  You have to explicitly change it to allow
> > > hugepages to be used in a TCG guest (but you don't have to supply
> > > hugepage backing).
> > 
> > ... this will already happen. That's okay[1], we can't really
> > avoid it if we want to ensure consistent behavior between KVM and
> > TCG.
> 
> So.. regarding [1].  The draft patches *do* change the behaviour on
> older machine types.  I'll consider revisiting that, but I'd need to
> be convinced.  Basically we have to choose between consistency between
> accelerator and consistency between versions.  I think the former is
> the better choice; at least I think it is given that we *can* get both
> for the overwhelmingly common case in production (KVM HV).

Forgot to answer this point.

I agree that consistency between accelerators is the sane option
going forward, but changing the behavior for old machine types will
cause existing guests which have been using hugepages to lose the
ability to do so after being restarted on a newer QEMU.

Isn't that exactly the kind of scenario versioned machine types are
supposed to prevent?

-- 
Andrea Bolognani / Red Hat / Virtualization
