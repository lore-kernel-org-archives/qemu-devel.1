Received: from eggs.gnu.org ([2001:4830:134:3::10]:60243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTZ3q-0004VD-1Y
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTZ3l-00083e-Aj
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:41:38 -0400
Received: from mail-sn1nam01on0088.outbound.protection.outlook.com
	([104.47.32.88]:12560
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTZ3l-00082q-46
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:41:33 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Thu, 14 Jun 2018 20:41:31 +0000
Message-ID: <DM5PR12MB24711F3ECCEAF8CA16D58D88957D0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
	<1528939107-17193-4-git-send-email-babu.moger@amd.com>
	<20180614184051.GW7451@localhost.localdomain>
In-Reply-To: <20180614184051.GW7451@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v14 3/6] i386: Disable TOPOEXT feature on
 pc-2.12
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
> Sent: Thursday, June 14, 2018 1:41 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> Subject: Re: [PATCH v14 3/6] i386: Disable TOPOEXT feature on pc-2.12
>=20
> On Wed, Jun 13, 2018 at 09:18:24PM -0400, Babu Moger wrote:
> > Disable TOPOEXT feature for older machines.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  include/hw/i386/pc.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 04d1f8c..ecccf6b 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -303,6 +303,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *,
> uint64_t *);
> >          .driver   =3D TYPE_X86_CPU,\
> >          .property =3D "legacy-cache",\
> >          .value    =3D "on",\
> > +    },{\
> > +        .driver   =3D TYPE_X86_CPU,\
> > +        .property =3D "topoext",\
> > +        .value    =3D "off",\
> >      },
>=20
> This is OK, if combined with the first hunks of patch 2/6.
Ok. Sure.
>=20
> --
> Eduardo
