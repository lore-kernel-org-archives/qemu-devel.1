Received: from eggs.gnu.org ([2001:4830:134:3::10]:45000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgG4W-0000ze-Hw
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgG4S-0006cN-JH
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:26:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cgG4S-0006cF-A1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:25:56 -0500
Date: Tue, 21 Feb 2017 14:25:53 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170221192553.GP19045@localhost.localdomain>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
	<F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
	<20170220110235.GD21255@stefanha-x1.localdomain>
	<CAAo6VWNwHbsQRxU18dNCjWaNfNrZNAV9FfOKW8=JeZCND2vHnQ@mail.gmail.com>
	<20170221105918.GA22731@stefanha-x1.localdomain>
	<A228B0EC-4D64-4174-A4FD-B3E00B836FD1@veritas.com>
	<20170221173912.GO17041@redhat.com>
	<20170221180658.GO19045@localhost.localdomain>
	<20170221185624.GQ17041@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170221185624.GQ17041@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, ashish mittal <ashmit602@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Tue, Feb 21, 2017 at 06:56:24PM +0000, Daniel P. Berrange wrote:
> On Tue, Feb 21, 2017 at 01:06:58PM -0500, Jeff Cody wrote:
> > On Tue, Feb 21, 2017 at 05:39:12PM +0000, Daniel P. Berrange wrote:
> > > On Tue, Feb 21, 2017 at 05:21:46PM +0000, Ketan Nilangekar wrote:
> > > > 
> > > > 
> > > > On 2/21/17, 5:59 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:
> > > > 
> > > >     On Mon, Feb 20, 2017 at 03:34:57AM -0800, ashish mittal wrote:
> > > >     > On Mon, Feb 20, 2017 at 3:02 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > >     > > On Sat, Feb 18, 2017 at 12:30:31AM +0000, Ketan Nilangekar wrote:
> > > >     > >> On 2/17/17, 1:42 PM, "Jeff Cody" <jcody@redhat.com> wrote:
> > > >     > >>
> > > >     > >>     On Thu, Feb 16, 2017 at 02:24:19PM -0800, ashish mittal wrote:
> > > >     > >>     > Hi,
> > > >     > >>     >
> > > >     > >>     > I am getting the following error with checkpatch.pl
> > > >     > >>     >
> > > >     > >>     > ERROR: externs should be avoided in .c files
> > > >     > >>     > #78: FILE: block/vxhs.c:28:
> > > >     > >>     > +QemuUUID qemu_uuid __attribute__ ((weak));
> > > >     > >>     >
> > > >     > >>     > Is there any way to get around this, or does it mean that I would have
> > > >     > >>     > to add a vxhs.h just for this one entry?
> > > >     > >>     >
> > > >     > >>
> > > >     > >>     I remain skeptical on the use of the qemu_uuid as a way to select the TLS
> > > >     > >>     cert.
> > > >     > >>
> > > >     > >> [ketan]
> > > >     > >> Is there another identity that can be used for uniquely identifying instances?
> > > >     > >> The requirement was to enforce vdisk access to owner instances.
> > > >     > >
> > > >     > > The qemu_uuid weak attribute looks suspect.  What is going to provide a
> > > >     > > strong qemu_uuid symbol?
> > > >     > >
> > > >     > > Why aren't configuration parameters like the UUID coming from the QEMU
> > > >     > > command-line?
> > > >     > >
> > > >     > > Stefan
> > > >     > 
> > > >     > UUID will in fact come from the QEMU command line. VxHS is not doing
> > > >     > anything special here. It will just use the value already available to
> > > >     > qemu-kvm process.
> > > >     > 
> > > >     > QemuUUID qemu_uuid;
> > > >     > bool qemu_uuid_set;
> > > >     > 
> > > >     > Both the above are defined in vl.c. vl.c will provide the strong
> > > >     > symbol when available. There are certain binaries that do not get
> > > >     > linked with vl.c (e.g. qemu-img). The weak symbol will come into
> > > >     > affect for such binaries, and in this case, the default VXHS UUID will
> > > >     > get picked up. I had, in a previous email, explained how we plan to
> > > >     > use the default UUID. In the regular case, the VxHS controller will
> > > >     > not allow access to the default UUID (non qemu-kvm) binaries, but it
> > > >     > may choose to grant temporary access to specific vdisks for these
> > > >     > binaries depending on the workflow.
> > > >     
> > > >     That idea sounds like a security problem.  During this time window
> > > >     anyone could use the default UUID to access the data?
> > > >     
> > > >     Just make the UUID (or TLS client certificate file) a command-line
> > > >     parameter that qemu-system, qemu-img, and other tools accept (e.g.
> > > >     qemu-img via the --image-opts/--object syntax).
> > > >     
> > > > [Ketan]
> > > > Sounds fair. Would it be ok to take this up after the driver is
> > > > merged for the upcoming QEMU release?
> > > 
> > > I don't think we can merge code with known security flaws, particularly
> > > if fixing these flaws will involve adding and/or changing command line
> > > parameters for the block driver.
> > >
> > 
> > We do support some protocols, such as gluster, that do not have robust
> > authentication frameworks over tcp/ip.  Of course, these protocols have been
> > in as a driver for several years (and, gluster does support unix sockets).
> 
> NB, gluster *does* have secure access control. It uses the verified x509
> certificate identity as a token against which access control rules are
> placed on volumes.
> 
> It isn't authentication in the traditional sense most people think of it,
> but it does provide a secure authorization facility.
>

Good point, thanks for the clarification.

> > We seem to be establishing a rule for QEMU, that is "no new protocol drivers
> > without secure authentication".  That is a good thing. The existence of
> > current protocol drivers that don't meet that criteria is potentially
> > confusing for new contributors, however.  (As a side note to myself -- this
> > is probably a good thing to add to the wiki, if it is not there already).
> 
> It's been my goal to fix / enhance everything in QEMU that uses network and
> does not have secure encryption + access control facilities. eg by adding
> TLS support to the NBD driver, and providing the secure mechanism for feeding
> passwords into QEMU for things like curl, iscsi, etc. We're getting pretty
> close to having at least the option to use encryption + access control via
> TLS certs or SASL on every key network based feature in QEMU.
> 
> > I think a non-secure scheme is worse than no scheme at all, because it
> > becomes relied upon and promises something it cannot deliver.  In that vein,
> > would you object to a vxhs protocol driver that did no authentication at all
> > (similar to gluster), or do you think the above rule is a new hard rule for
> > protocol drivers?
> 
> Adding support for a known insecure authentication scheme is a clear
> no-go as that's pretty much immediate CVE terrority when we release it,
> as you give people the illusion of security where none exists.
> 
> IMHO, any new network protocol that we add to QEMU should at least be
> capable of having secure encryption & access control enabled, unless it
> is a long term pre-existing standard - even those have pretty much all
> been given strong security extensions over the years as it became clear
> that internal networks are often just as hostile as public networks.
> eg the work we did to add TLS to VNC in 2007, or more recently adding
> TLS to NBD. SPICE by constrast as a modern protocol had TLS right from
> the start.
> 

Thanks again.  I am in agreement with you.  It is probably a good idea to
consider that "codified" now for new protocol drivers, to remove any
ambiguity in the future - and the x509 certificate method should not be too
difficult to implement.

-Jeff
