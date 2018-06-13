Received: from eggs.gnu.org ([2001:4830:134:3::10]:48496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fT8LY-0002Ir-TB
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fT8LV-0000Gb-7G
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:10:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1fT8LU-000085-Su
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:10:05 -0400
Date: Wed, 13 Jun 2018 12:09:59 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20180613160959.GF11438@char.us.oracle.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
	<20180601153809.15259-2-konrad.wilk@oracle.com>
	<20180604200701.GB3184@localhost.localdomain>
	<20180604202205.GH5867@char.us.oracle.com>
	<20180613101949.GL27901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180613101949.GL27901@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] i386: define the AMD 'amd-ssbd' CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org

On Wed, Jun 13, 2018 at 11:19:49AM +0100, Daniel P. Berrang=E9 wrote:
> On Mon, Jun 04, 2018 at 04:22:05PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Mon, Jun 04, 2018 at 05:07:01PM -0300, Eduardo Habkost wrote:
> > > On Fri, Jun 01, 2018 at 11:38:08AM -0400, Konrad Rzeszutek Wilk wro=
te:
> > > > AMD future CPUs expose _two_ ways to utilize the Intel equivalant
> > > > of the Speculative Store Bypass Disable. The first is via
> > > > the virtualized VIRT_SPEC CTRL MSR (0xC001_011f) and the second
> > > > is via the SPEC_CTRL MSR (0x48). The document titled:
> > > > 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
> > > >=20
> > > > gives priority of SPEC CTRL MSR over the VIRT SPEC CTRL MSR.
> > > >=20
> > > > A copy of this document is available at
> > > >       https://bugzilla.kernel.org/show_bug.cgi?id=3D199889
> > > >=20
> > > > Anyhow, this means that on future AMD CPUs there will be  _two_ w=
ays to
> > > > deal with SSBD.
> > >=20
> > > Does anybody know if there are AMD CPUs where virt-ssbd won't
> > > work and would require amd-ssbd to mitigate vulnerabilities?
> > >=20
> > > Also, do we have kernel arch/x86/kvm/cpuid.c patches, already?
> >=20
> > Not yet. They are being discussed right now. I figured I would send
> > these patches out as a 'Hey, coming at you!', but failed to change
> > the title to be 'RFC'.
> >=20
> > > I prefer to add new CPUID flag names only after the flag name is
> > > already agreed upon on the kernel side.
> >=20
> > Of course. I will respin once that discussion has calmed down.
>=20
> Looks like the kernel side has merged now, and we'll need to rename
> the 2nd CPU bit from what I see.

What name did you have in mind?
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20
