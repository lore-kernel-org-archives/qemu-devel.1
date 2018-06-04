Received: from eggs.gnu.org ([2001:4830:134:3::10]:54626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fPvyS-0003t1-0g
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fPvyO-00054F-SA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:21:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1fPvyO-00053h-FD
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:21:00 -0400
Date: Mon, 4 Jun 2018 16:20:53 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20180604202053.GG5867@char.us.oracle.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
	<20180601153809.15259-2-konrad.wilk@oracle.com>
	<20180604085440.GB19749@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180604085440.GB19749@redhat.com>
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
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, kvm@vger.kernel.org, ehabkost@redhat.com

On Mon, Jun 04, 2018 at 09:54:40AM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Jun 01, 2018 at 11:38:08AM -0400, Konrad Rzeszutek Wilk wrote:
> > AMD future CPUs expose _two_ ways to utilize the Intel equivalant
> > of the Speculative Store Bypass Disable. The first is via
> > the virtualized VIRT_SPEC CTRL MSR (0xC001_011f) and the second
> > is via the SPEC_CTRL MSR (0x48). The document titled:
> > 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
> >=20
> > gives priority of SPEC CTRL MSR over the VIRT SPEC CTRL MSR.
> >=20
> > A copy of this document is available at
> >       https://bugzilla.kernel.org/show_bug.cgi?id=3D199889
> >=20
> > Anyhow, this means that on future AMD CPUs there will be  _two_ ways =
to
> > deal with SSBD.
>=20
> Oh what fun ;-)
>=20
> Unless I'm mistaken the current Linux kernel doesn't know about these
> new amd-ssbd / amd-no-ssb flags either. Will you also be sending patche=
s
> for that half of the problem ?

I sent them as well. But forgot to CC qemu-devel :-(
