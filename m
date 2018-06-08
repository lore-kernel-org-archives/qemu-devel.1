Received: from eggs.gnu.org ([2001:4830:134:3::10]:53952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fRLuy-0007uc-02
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fRLuu-000443-SK
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:15:19 -0400
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com
	([104.47.38.44]:64053
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fRLuu-00043x-L3
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:15:16 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Fri, 8 Jun 2018 18:15:14 +0000
Message-ID: <DM5PR12MB2471FC17CBDFBE15555E93A7957B0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528295806-90593-1-git-send-email-babu.moger@amd.com>
	<1528295806-90593-2-git-send-email-babu.moger@amd.com>
	<20180606212626.GB7451@localhost.localdomain>
In-Reply-To: <20180606212626.GB7451@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v12 1/4] i386: Add support for
 CPUID_8000_001E for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>


> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Wednesday, June 6, 2018 4:26 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> Subject: Re: [PATCH v12 1/4] i386: Add support for CPUID_8000_001E for
> AMD
>=20
> On Wed, Jun 06, 2018 at 10:36:43AM -0400, Babu Moger wrote:
> [...]
> > +    /*
> > +     * CPUID_Fn8000001E_EBX
> > +     * 31:16 Reserved
> > +     * 15:8  Threads per core (The number of threads per core is
> > +     *       Threads per core + 1)
> > +     *  7:0  Core id (see bit decoding below)
> > +     *       SMT:
> > +     *           4:3 node id
> > +     *             2 Core complex id
> > +     *           1:0 Core id
> > +     *       Non SMT:
> > +     *           5:4 node id
> > +     *             3 Core complex id
> > +     *           1:0 Core id
> > +     */
>=20
> Where are those bit offsets documented?  AMD Family 17h PPR just
> says "7:0 Core ID".

Yes. That is right. AMD Family 17h PPR does not list all the details for co=
re_id.
We are working with our document writer's to make those details public.
Thanks for pointing that out.
>=20
> --
> Eduardo
