Received: from eggs.gnu.org ([2001:4830:134:3::10]:59813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fT94N-0006P3-2V
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fT94J-0006SG-7r
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:56:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fT94J-0006Ps-15
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:56:23 -0400
Date: Wed, 13 Jun 2018 13:56:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613165620.GY7451@localhost.localdomain>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
	<20180601153809.15259-2-konrad.wilk@oracle.com>
	<20180604200701.GB3184@localhost.localdomain>
	<20180604202205.GH5867@char.us.oracle.com>
	<20180613101949.GL27901@redhat.com>
	<20180613160959.GF11438@char.us.oracle.com>
	<20180613162129.GI19901@redhat.com>
	<20180613163421.GB21340@char.us.oracle.com>
	<20180613163950.GK19901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180613163950.GK19901@redhat.com>
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
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, pbonzini@redhat.com, rth@twiddle.net, kvm@vger.kernel.org, qemu-devel@nongnu.org

On Wed, Jun 13, 2018 at 05:39:50PM +0100, Daniel P. Berrang=E9 wrote:
[...]
> > The code that finds the AMD_SSBD and sets the 'ssbd' is:
> >=20
> > +       if (cpu_has(c, X86_FEATURE_AMD_SSBD)) {
> > +               set_cpu_cap(c, X86_FEATURE_SSBD);
> > +               set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
> > +               clear_cpu_cap(c, X86_FEATURE_VIRT_SSBD);
> > +       }
> >=20
> > Meaning the 'ssbd' will show up in /proc/cpuinfo
>=20
> Given that, there's no exposed kernel naming we need to align with.
>=20
> So personally I'd be fine with the current patches that exist, but
> I'll defer to Eduardo for the final say, wrt amd-ssb-no vs amd-no-ssb.

I prefer amd-no-ssb, so I plan to apply these patches as is.

--=20
Eduardo
