Received: from eggs.gnu.org ([2001:4830:134:3::10]:37753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fL7tK-0003iq-DM
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fL7tA-0004so-Qr
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:03:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fL7tA-0004sW-Lj
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:03:44 -0400
Date: Tue, 22 May 2018 11:03:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180522140339.GC25013@localhost.localdomain>
References: <1526949675-106737-1-git-send-email-babu.moger@amd.com>
	<1526949675-106737-3-git-send-email-babu.moger@amd.com>
	<CY4PR12MB181551D174221BF3CC5F209AF9940@CY4PR12MB1815.namprd12.prod.outlook.com>
	<DM5PR12MB24713F0E6095C786E0AA8ED795940@DM5PR12MB2471.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR12MB24713F0E6095C786E0AA8ED795940@DM5PR12MB2471.namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 2/5] i386: Populate AMD Processor Cache
 Information for cpuid 0x8000001D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: "Duran, Leo" <leo.duran@amd.com>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>

On Tue, May 22, 2018 at 01:32:52PM +0000, Moger, Babu wrote:
>=20
> > -----Original Message-----
> > From: Duran, Leo
> > Sent: Monday, May 21, 2018 8:32 PM
> > To: Moger, Babu <Babu.Moger@amd.com>; mst@redhat.com;
> > marcel.apfelbaum@gmail.com; pbonzini@redhat.com; rth@twiddle.net;
> > ehabkost@redhat.com; mtosatti@redhat.com
> > Cc: qemu-devel@nongnu.org; kvm@vger.kernel.org; kash@tripleback.net;
> > geoff@hostfission.com
> > Subject: RE: [PATCH v10 2/5] i386: Populate AMD Processor Cache
> > Information for cpuid 0x8000001D
> >=20
> > Babu,
> >=20
> > If num_sharing_l3_cache() uses MAX_NODES_EPYC, then that function It=E2=
=80=99s
> > EPYC specific.
> >=20
> > An alternative would be to use a data member (e.g.,
> > max_nodes_per_socket)) that get initialized (via another helper funct=
ion) to
> > MAX_NODES_EPYC.
>=20
> Thanks Leo.  Let me see how we can handle this. This requires changes i=
n generic
> Data structure which I tried to avoid here.  I will wait for all the co=
mments for whole
> series before making this change.  Note that right now, this feature is=
 only enabled
> for EPYC. Yes. I know this could this in future.

We just need a reasonable default, by now, and it can even be the
same value used on EPYC.  This default just need to generate
reasonable results for other cases that don't match real hardware
(like cores=3D32 or cores=3D12).

--=20
Eduardo
