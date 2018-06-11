Received: from eggs.gnu.org ([2001:4830:134:3::10]:49230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSUEZ-0005Yk-Hp
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSUEW-0006sN-Bn
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:20:15 -0400
Received: from mail-bl2nam02on0046.outbound.protection.outlook.com
	([104.47.38.46]:34336
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fSUEV-0006rr-K6
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:20:12 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 11 Jun 2018 21:20:09 +0000
Message-ID: <DM5PR12MB2471DFFFFC825C36F5B343F795780@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-3-git-send-email-babu.moger@amd.com>
	<DM5PR12MB24718C2709BB60179BAD2F9495780@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180611204623.GV7451@localhost.localdomain>
	<20180611210515.GZ7451@localhost.localdomain>
In-Reply-To: <20180611210515.GZ7451@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v13 2/5] i386: Introduce auto_topoext bit
 to manage topoext
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
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org]
> On Behalf Of Eduardo Habkost
> Sent: Monday, June 11, 2018 4:05 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> Subject: Re: [PATCH v13 2/5] i386: Introduce auto_topoext bit to manage
> topoext
>=20
> On Mon, Jun 11, 2018 at 05:46:23PM -0300, Eduardo Habkost wrote:
> [...]
> > On PC_COMPAT_2_12, both would work:
> >   { TYPE_X86_CPU, "auto-topoext", "off" }
> > or
> >   { "EPYC" "-" TYPE_X86_CPU, "auto-topoext", "off" }.
> >
> > I prefer the latter, but both would work.
>=20
> Oh, while we're at it: please name the property "x-auto-topoext",
> to indicate it's only for QEMU internal use or debugging, and not
> a supported command-line option.

Ok. Sure.

>=20
> --
> Eduardo
