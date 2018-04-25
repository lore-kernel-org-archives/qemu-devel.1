Received: from eggs.gnu.org ([2001:4830:134:3::10]:48655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <erik.schmauss@intel.com>) id 1fBNZg-0001Ro-CJ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <erik.schmauss@intel.com>) id 1fBNZd-0005fW-AG
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:47:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:37915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <erik.schmauss@intel.com>)
	id 1fBNZc-0005eE-Sv
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:47:17 -0400
From: "Schmauss, Erik" <erik.schmauss@intel.com>
Date: Wed, 25 Apr 2018 16:47:07 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53973CBC2@ORSMSX110.amr.corp.intel.com>
References: <1524524398-41342-1-git-send-email-mst@redhat.com>
	<CF6A88132359CE47947DB4C6E1709ED53973A729@ORSMSX110.amr.corp.intel.com>
	<20180424035504-mutt-send-email-mst@kernel.org>
	<20180424095722.76105b40@redhat.com>
	<20180424201554-mutt-send-email-mst@kernel.org>
	<CF6A88132359CE47947DB4C6E1709ED53973A87A@ORSMSX110.amr.corp.intel.com>
	<20180424210040-mutt-send-email-mst@kernel.org>
	<20180425154938.78deea44@redhat.com>
	<20180425165847-mutt-send-email-mst@kernel.org>
	<20180425173152.4c2c1c4f@redhat.com>
In-Reply-To: <20180425173152.4c2c1c4f@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] acpi/nvdimm: remove forward name references
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Williams,
	Dan J" <dan.j.williams@intel.com>



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Wednesday, April 25, 2018 8:32 AM
> To: Michael S. Tsirkin <mst@redhat.com>
> Cc: Schmauss, Erik <erik.schmauss@intel.com>; qemu-devel@nongnu.org; Xiao
> Guangrong <xiaoguangrong.eric@gmail.com>; Williams, Dan J
> <dan.j.williams@intel.com>
> Subject: Re: [PATCH] acpi/nvdimm: remove forward name references
>=20
> On Wed, 25 Apr 2018 17:17:04 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Wed, Apr 25, 2018 at 03:49:38PM +0200, Igor Mammedov wrote:
> > > On Tue, 24 Apr 2018 21:06:37 +0300
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > > On Tue, Apr 24, 2018 at 05:47:58PM +0000, Schmauss, Erik wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > > > > Sent: Tuesday, April 24, 2018 10:43 AM
> > > > > > To: Igor Mammedov <imammedo@redhat.com>
> > > > > > Cc: Schmauss, Erik <erik.schmauss@intel.com>;
> > > > > > qemu-devel@nongnu.org; Xiao Guangrong
> > > > > > <xiaoguangrong.eric@gmail.com>; Williams, Dan J
> > > > > > <dan.j.williams@intel.com>
> > > > > > Subject: Re: [PATCH] acpi/nvdimm: remove forward name
> > > > > > references
> > > > > >
> > > > > > On Tue, Apr 24, 2018 at 09:57:22AM +0200, Igor Mammedov wrote:
> > > > > > > On Tue, 24 Apr 2018 04:02:40 +0300 "Michael S. Tsirkin"
> > > > > > > <mst@redhat.com> wrote:
> > > > > > >
> [...]
> > > > > > > From spec
> > > > > > >  DefOpRegion :=3D OpRegionOp NameString RegionSpace
> > > > > > > RegionOffset RegionLen  RegionOffset :=3D TermArg =3D> Intege=
r
> > > > > > > TermArg :=3D Type2Opcode
> > > > > > > | DataObject | ArgObj | LocalObj
> > > > > > >
> > > > > > > So named object is not accepted,
> > > > > >
> > > > > > might be worth checking what happens with actual OSPMs.
> > > > > > If it does happen to work, we can try tweaking the ACPI spec to=
 allow
> this.
> > > > >
> > > > > I'm looking at the ACPI6.2a spec on page 840 and it says
> > > > > TermArg :=3D Type2Opcode | DataObject | Argterm |LocalTerm
> |NameString |SymbolicExpression
> > > >
> > > > Oh right, that's there since ACPI 6.0.
> > > Strange, I've rechecked AML definition of TermArg in 6.0 and 6.2a
> > > and it still says only
> > >
> > >   TermArg :=3D Type2Opcode | DataObject | ArgObj | LocalObj
> > >
> > > For 6.2a, I'm looking at chapter "20.2.5 Term Objects Encoding"
> > > where exactly do you guys see that longer variant?
> >
> > Oh interesting. That's in
> > 19.2.3 ASL Root and Secondary Terms
> >
> > How come it's not the same?
> bugs are everywhere, see "20.2.5 Term Objects Encoding"
>=20
> >
> > >
> > > > As usual, the issue is that
> > > > we can't easily check what does OSPM support.
> > > > This is really something worth fixing in the spec IMHO.
> > > > We could just try and test a bunch of guest OSPMs and if they
> > > > happen to work, switch to that. Lots of work for uncertain
> > > > benefit.
> > > I think some windows versions weren't happy with it when we were
> > > trying to use dynamic operation regions with offset as namestring.
> >
> >
> > Good to know, thanks.

I have made a big mistake. I was comparing the resulting SSDT of this patch=
 to an SSDT
Generated by a much older version of kvm/qemu. The latest kvm/qemu upstream=
 builds
the SSDT with the operation region contained inside of methods. This should=
 resolve
MEMA of the operation region when the method is invoked. The older SSDT tha=
t I was
looking at declared the memory region outside of methods and had a forward =
reference
to MEMA which we no longer support.

So the latest qemu/kvm works just fine and this patch is not needed, Dan ha=
s confirmed that
the latest qemu/kvm works for his nvdimm setup.

Thanks for all of the help and I'm sorry for any confusion that I might hav=
e caused!

> I'll try to retest MS VMs I have here, to see which one breaks.
>=20
