Received: from eggs.gnu.org ([2001:4830:134:3::10]:34608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dy2wi-0002Od-Jd
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dy2we-0002nx-L6
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dy2we-0002ln-C6
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:35:40 -0400
Date: Sat, 30 Sep 2017 00:35:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170930002936-mutt-send-email-mst@kernel.org>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170926170901-mutt-send-email-mst@kernel.org>
	<2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
	<20170927190724-mutt-send-email-mst@kernel.org>
	<927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
	<20170929223152-mutt-send-email-mst@kernel.org>
	<05b3c915-d7c1-2d73-1579-68d5f3bcc3d7@amd.com>
	<151eedf4-6861-c4be-e6f8-6b33c226b298@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151eedf4-6861-c4be-e6f8-6b33c226b298@amd.com>
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Richard Relph <richard.relph@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
List-ID: <qemu-devel.nongnu.org>

On Fri, Sep 29, 2017 at 03:07:40PM -0500, Richard Relph wrote:
> On 9/29/17 2:48 PM, Richard Relph wrote:
> > On 9/29/17 2:34 PM, Michael S. Tsirkin wrote:
> > > On Wed, Sep 27, 2017 at 02:06:10PM -0500, Richard Relph wrote:
> > > > Whether the "BIOS" is a "static shim" as Michael suggests, or a
> > > > full BIOS,
> > > > or even a BIOS+kernel+initrd is really not too significant. What is
> > > > significant is that the GO has a basis for trusting all code that is
> > > > imported in to their VM by the CP. And that NONE of the code
> > > > provided by the
> > > > CP is "unknown" and unauditable by the GO. If the CP has a way to inject
> > > > code unknown to the GO in to the guest VM, the trust model is broken and
> > > > both GO and CP suffer the consequences.
> > > 
> > > Absolutely.
> > > 
> > > > When the CP needs to update the BIOS image, they will have to
> > > > inform the GO
> > > > and allow the GO to establish trust in the CP's new BIOS image somehow.
> > > 
> > > This GO update on every BIOS change is imho is not a workable model. You
> > > want something like checking the BIOS signature instead. And since
> > > hardware is all hash based, you need the shim to do it in software.
> > 
> > A BIOS "signed" by the CP doesn't meet the security requirement. It is
> > code that is "unknown" to the GO.
> > 
> > The (legitimate) CP does NOT want to be in that position of trust. If
> > they are, then some government somewhere is going to insist that they
> > sign a BIOS that allows the government to spy on the GO's VMs, and steal
> > secrets from it. Or some hacker admin will do it "for fun".
> > 
> > How often do large public CPs really change their BIOSes? My sense is
> > that large public CPs prefer stability over "latest and greatest".
> > 
> > And, perhaps more importantly, if a CP are able to sell a "more secure"
> > VM, one that justifies a higher price per vCPU hour, wouldn't that
> > warrant some changes in the "insecure" model being used today?
> 
> Ultimately, I think both approaches are "doable". It will be a CP and GO
> decision. If the GO trusts the CP, the shim+signed BIOS will work fine.

I think there's a misunderstanding. A trusted software vendor would
sign the BIOS. GO would verify it. Trusting the CP is not required.

> If
> GO requires a more secure VM and the CP wants to offer it, the CP will
> figure out a way to satisfy the GO's "trust issue" that the BIOS can't be
> used to circumvent SEV's protections. Depending on your level of paranoia,
> that may require advance notice of BIOS changes, or even allowing the GO to
> provide the BIOS themselves, written to a spec supported by the CP's HV,
> and/or based on BIOS code provided by the CP.

We are discussing this on a qemu mailing list, aren't we? And from QEMU
point of view,  I think it won't be able to support a requirement
to boot ancient bios versions on new machine types indefinitely
with good performance and also fix security issues in them
in a timely manner somehow.


> 
> It's a business decision and I think SEV can support both. That said, AMD
> currently has no plans to write a shim that can verify the signature on a
> CP-provided BIOS image.
> 
> Richard

Someone else will have to work on a supportable solution for QEMU then.

> > 
> > Richard
