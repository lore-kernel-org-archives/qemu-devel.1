Received: from eggs.gnu.org ([2001:4830:134:3::10]:48029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dywlS-0004vv-Dh
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dywlO-0007tC-DD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:11:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dywlO-0007rk-3J
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:11:46 -0400
Date: Mon, 2 Oct 2017 10:11:36 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171002091136.GA27086@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170926170901-mutt-send-email-mst@kernel.org>
	<2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
	<20170927190724-mutt-send-email-mst@kernel.org>
	<927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
	<20170929223152-mutt-send-email-mst@kernel.org>
	<05b3c915-d7c1-2d73-1579-68d5f3bcc3d7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05b3c915-d7c1-2d73-1579-68d5f3bcc3d7@amd.com>
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Richard Relph <richard.relph@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On Fri, Sep 29, 2017 at 02:48:45PM -0500, Richard Relph wrote:
> On 9/29/17 2:34 PM, Michael S. Tsirkin wrote:
> > On Wed, Sep 27, 2017 at 02:06:10PM -0500, Richard Relph wrote:
> > > Whether the "BIOS" is a "static shim" as Michael suggests, or a full BIOS,
> > > or even a BIOS+kernel+initrd is really not too significant. What is
> > > significant is that the GO has a basis for trusting all code that is
> > > imported in to their VM by the CP. And that NONE of the code provided by the
> > > CP is "unknown" and unauditable by the GO. If the CP has a way to inject
> > > code unknown to the GO in to the guest VM, the trust model is broken and
> > > both GO and CP suffer the consequences.
> > 
> > Absolutely.
> > 
> > > When the CP needs to update the BIOS image, they will have to inform the GO
> > > and allow the GO to establish trust in the CP's new BIOS image somehow.
> > 
> > This GO update on every BIOS change is imho is not a workable model. You
> > want something like checking the BIOS signature instead. And since
> > hardware is all hash based, you need the shim to do it in software.
> 
> A BIOS "signed" by the CP doesn't meet the security requirement. It is code
> that is "unknown" to the GO.
> 
> The (legitimate) CP does NOT want to be in that position of trust. If they
> are, then some government somewhere is going to insist that they sign a BIOS
> that allows the government to spy on the GO's VMs, and steal secrets from
> it. Or some hacker admin will do it "for fun".
> 
> How often do large public CPs really change their BIOSes? My sense is that
> large public CPs prefer stability over "latest and greatest".

It is hard to generalize, but from a RHEL POV, we typically do major updates
of the virt stack every ~6 months, and these will include BIOS updates. So if
a cloud vendor is following the RHEL update stream actively that's the kind
of cadence you'd expect.

The gotcha would come if there were out-of-band security updates for BIOS
which caused it to be updated before the 6 month window. Fortunately I've
not see these happen often, so I don't think its a fatal problem.

IOW, I tend to agree with you that this is not really a blocking problem to
the use of SEV in cloud. 

> And, perhaps more importantly, if a CP are able to sell a "more secure" VM,
> one that justifies a higher price per vCPU hour, wouldn't that warrant some
> changes in the "insecure" model being used today?

Yes.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
