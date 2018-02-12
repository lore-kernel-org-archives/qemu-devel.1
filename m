Received: from eggs.gnu.org ([2001:4830:134:3::10]:57813)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <bp@suse.de>)
	id 1elLWU-0002Jx-Eb
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 16:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bp@suse.de>) id 1elLWP-0005GS-5s
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 16:20:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:36759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bp@suse.de>) id 1elLWO-0005Ea-VL
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 16:20:21 -0500
Date: Mon, 12 Feb 2018 22:19:48 +0100
From: Borislav Petkov <bp@suse.de>
Message-ID: <20180212211948.GK14422@pd.tnic>
References: <20180212153715.87555-1-brijesh.singh@amd.com>
	<20180212153715.87555-6-brijesh.singh@amd.com>
	<20180212183803.GR13981@localhost.localdomain>
	<4a1f22d9-da2e-618b-1423-629817389948@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a1f22d9-da2e-618b-1423-629817389948@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 05/28] target/i386: add memory
 encryption feature cpuid support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

On Mon, Feb 12, 2018 at 03:07:26PM -0600, Brijesh Singh wrote:
> In current implementation, when -cpu ...,+sev is passed without
> appropriate SEV configuration then we populate the Fn8000_001F CPUID bu=
t
> VMCB will not have SEV bit set hence a guest will be launched as
> non-SEV.

I think we should fail the guest init if sev is not really supported by
the host. Otherwise people might get mislead.

> > Changing existing CPU models is possible only on very specific
> > circumstances (where VMs that are currently runnable would always
> > stay runnable), and would require compat_props entries to keep
> > compatibility on existing machine-types.
>=20
> Ah I didn't consider that case. What is recommendation, should we creat=
e
> a new CPU Model (EPYC-SEV) ?

Can we please stop creating a new CPU model with every new CPUID feature
support added? This is just ridiculous.

If this is about live migration, then by all means, fail the migration
if the feature bits are not compatible. But replicating CPU models and
then adding one new differing feature doesn't make any sense.

--=20
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton=
, HRB 21284 (AG N=C3=BCrnberg)
--=20
