Received: from eggs.gnu.org ([2001:4830:134:3::10]:43121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgY9N-00041B-KA
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgY9K-00016p-Bo
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:44:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cgY9K-00016d-3T
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:44:10 -0500
Date: Wed, 22 Feb 2017 09:44:07 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170222144407.GS19045@localhost.localdomain>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
	<F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
	<20170220110235.GD21255@stefanha-x1.localdomain>
	<CAAo6VWNwHbsQRxU18dNCjWaNfNrZNAV9FfOKW8=JeZCND2vHnQ@mail.gmail.com>
	<20170221105918.GA22731@stefanha-x1.localdomain>
	<20170221113353.GC17041@redhat.com>
	<20170222140920.GA10201@stefanha-x1.localdomain>
	<20170222142230.GR28937@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170222142230.GR28937@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, ashish mittal <ashmit602@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Wed, Feb 22, 2017 at 02:22:30PM +0000, Daniel P. Berrange wrote:
> On Wed, Feb 22, 2017 at 02:09:20PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Feb 21, 2017 at 11:33:53AM +0000, Daniel P. Berrange wrote:
> > > On Tue, Feb 21, 2017 at 10:59:18AM +0000, Stefan Hajnoczi wrote:
> > > > On Mon, Feb 20, 2017 at 03:34:57AM -0800, ashish mittal wrote:
> > > > > On Mon, Feb 20, 2017 at 3:02 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > > > > On Sat, Feb 18, 2017 at 12:30:31AM +0000, Ketan Nilangekar wrote:
> > > > > >> On 2/17/17, 1:42 PM, "Jeff Cody" <jcody@redhat.com> wrote:
> > > > > >>
> > > > > >>     On Thu, Feb 16, 2017 at 02:24:19PM -0800, ashish mittal wrote:
> > > > > >>     > Hi,
> > > > > >>     >
> > > > > >>     > I am getting the following error with checkpatch.pl
> > > > > >>     >
> > > > > >>     > ERROR: externs should be avoided in .c files
> > > > > >>     > #78: FILE: block/vxhs.c:28:
> > > > > >>     > +QemuUUID qemu_uuid __attribute__ ((weak));
> > > > > >>     >
> > > > > >>     > Is there any way to get around this, or does it mean that I would have
> > > > > >>     > to add a vxhs.h just for this one entry?
> > > > > >>     >
> > > > > >>
> > > > > >>     I remain skeptical on the use of the qemu_uuid as a way to select the TLS
> > > > > >>     cert.
> > > > > >>
> > > > > >> [ketan]
> > > > > >> Is there another identity that can be used for uniquely identifying instances?
> > > > > >> The requirement was to enforce vdisk access to owner instances.
> > > > > >
> > > > > > The qemu_uuid weak attribute looks suspect.  What is going to provide a
> > > > > > strong qemu_uuid symbol?
> > > > > >
> > > > > > Why aren't configuration parameters like the UUID coming from the QEMU
> > > > > > command-line?
> > > > > >
> > > > > > Stefan
> > > > > 
> > > > > UUID will in fact come from the QEMU command line. VxHS is not doing
> > > > > anything special here. It will just use the value already available to
> > > > > qemu-kvm process.
> > > > > 
> > > > > QemuUUID qemu_uuid;
> > > > > bool qemu_uuid_set;
> > > > > 
> > > > > Both the above are defined in vl.c. vl.c will provide the strong
> > > > > symbol when available. There are certain binaries that do not get
> > > > > linked with vl.c (e.g. qemu-img). The weak symbol will come into
> > > > > affect for such binaries, and in this case, the default VXHS UUID will
> > > > > get picked up. I had, in a previous email, explained how we plan to
> > > > > use the default UUID. In the regular case, the VxHS controller will
> > > > > not allow access to the default UUID (non qemu-kvm) binaries, but it
> > > > > may choose to grant temporary access to specific vdisks for these
> > > > > binaries depending on the workflow.
> > > > 
> > > > That idea sounds like a security problem.  During this time window
> > > > anyone could use the default UUID to access the data?
> > > 
> > > Any use of the VM UUID as a means to control authorization on the
> > > server side is a security flaw, as this is a public value which
> > > cannot be trusted on its own.
> > > 
> > > There needs to be some kind of authentication step to verify the
> > > reported identity, eg a password associated with the VM UUID that
> > > is validated before trusting the VM UUID.
> > > 
> > > Alternatively there needs to be a completely separate UUID, unrelated
> > > to the VM UUID, which is treated as a private value (eg uses the
> > > '-object secret' framework in QEMU)
> > 
> > I thought the UUID is used to select the TLS client certificate and
> > associated private key.  So the UUID provides authorization although
> > what really matters is the client certificate, not the actual value of
> > the UUID.
> 
> The message shown a few replies earlier said:
> 
>   "VxHS controller will not allow access to the default UUID (non qemu-kvm)
>    binaries, but it may choose to grant temporary access to specific
>    vdisks"
> 
> which suggests the VxHS server is making authorization decisions based
> on UUID, but perhaps this is incorrect interpretation and it really is
> making decisions based on the x509 cert identity or something else ?
> 
> 
> In any case hardcoding a policy of using the UUID to select a cert path
> is a flawed design. We can't assume that everyone deploying QEMU is going
> to be willing to configure a separate certificate per QEMU VM instance
> launched. People's CA management policies are often so burdensome that
> it will be impractical to generate a new cert for VMs on the fly. So we
> should expect that many people will just deploy one cert per host, with
> the cert being statically created at the time they setup the host. Thus
> we need to just be able to specify certs used explicitly when adding a
> disk to QEMU, so we can support different deployment models for cert
> usage
>

I do believe it is using the UUID to select the cert/key files; from
libqnio:

https://github.com/VeritasHyperScale/libqnio/blob/securify/src/lib/qnio/utils.c#L81

That instanceid is the UUID passed in during the initial call to iio_init().

Also, does QEMU make any promises about qemu_uuid either being 0 or
undefined for qemu-img and qemu-io in the future?  If that assumption
changes in the future, it would also break the scheme in the these patches.

-Jeff
