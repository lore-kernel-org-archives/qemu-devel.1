Received: from eggs.gnu.org ([2001:4830:134:3::10]:41772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eqX0e-0002nO-3f
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 23:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eqX0a-00044a-4Q
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 23:37:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:54886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianfeng.tan@intel.com>)
	id 1eqX0Z-00041I-S4
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 23:36:56 -0500
From: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Date: Tue, 27 Feb 2018 04:36:45 +0000
Message-ID: <ED26CBA2FAD1BF48A8719AEF02201E3651452FF5@SHSMSX103.ccr.corp.intel.com>
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
	<6716e932-9ce5-3d97-41cb-f33ea94ad4ce@intel.com>
	<502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
	<20180205181521.47232aa4@redhat.com>
	<5155622d-cc49-d24c-7a7d-24ebb9ca2331@redhat.com>
	<ED26CBA2FAD1BF48A8719AEF02201E36514317E8@SHSMSX103.ccr.corp.intel.com>
	<20180207130635.4033f8b8@redhat.com>
	<8474af94-7bff-a7b5-e316-b8a0e332467e@intel.com>
	<20180208105111.7a776513@redhat.com>
	<53186984-2111-ed5e-0d47-65db12f22ea3@intel.com>
	<20180208123018.5b3c9da7@redhat.com>
	<ED26CBA2FAD1BF48A8719AEF02201E365144EAAB@SHSMSX103.ccr.corp.intel.com>
	<20180226135549.34af5dbf@redhat.com>
In-Reply-To: <20180226135549.34af5dbf@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Monday, February 26, 2018 8:56 PM
> To: Tan, Jianfeng
> Cc: Paolo Bonzini; Jason Wang; Maxime Coquelin; qemu-devel@nongnu.org;
> Michael S . Tsirkin
> Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as
> migration
>=20
> On Sat, 24 Feb 2018 03:11:30 +0000
> "Tan, Jianfeng" <jianfeng.tan@intel.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Tan, Jianfeng
> > > Sent: Saturday, February 24, 2018 11:08 AM
> > > To: 'Igor Mammedov'
> > > Cc: Paolo Bonzini; Jason Wang; Maxime Coquelin; qemu-
> devel@nongnu.org;
> > > Michael S . Tsirkin
> > > Subject: RE: [Qemu-devel] [RFC] exec: eliminate ram naming issue as
> > > migration
> > >
> > > Hi Igor and all,
> > >
> > > > -----Original Message-----
> > > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > > Sent: Thursday, February 8, 2018 7:30 PM
> > > > To: Tan, Jianfeng
> > > > Cc: Paolo Bonzini; Jason Wang; Maxime Coquelin; qemu-
> > > devel@nongnu.org;
> > > > Michael S . Tsirkin
> > > > Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as
> > > > migration
> > > >
> > > [...]
> > > > > > It could be solved by adding memdev option to machine,
> > > > > > which would allow to specify backend object. And then on
> > > > > > top make -mem-path alias new option to clean thing up.
> > > > >
> > > > > Do you mean?
> > > > >
> > > > > src vm: -m xG
> > > > > dst vm: -m xG,memdev=3Dpc.ram -object memory-backend-
> > > file,id=3Dpc.ram,size=3DxG,mem-path=3Dxxx,share=3Don ...
> > > > Yep, I've meant something like it
> > > >
> > > > src vm: -m xG,memdev=3DSHARED_RAM -object memory-backend-
> > > file,id=3DSHARED_RAM,size=3DxG,mem-path=3Dxxx,share=3Don
> > > > dst vm: -m xG,memdev=3DSHARED_RAM -object memory-backend-
> > > file,id=3DSHARED_RAM,size=3DxG,mem-path=3Dxxx,share=3Don
> > >
> > > After a second thought, I find adding a backend for nonnuma pc RAM is
> > > roundabout way.
> > >
> > > And we actually have an existing way to add a file-backed RAM: commit
> > > c902760fb25f ("Add option to use file backed guest memory"). Basicall=
y,
> this
> > > commit adds two options, --mem-path and --mem-prealloc, without
> specify
> > > a backend explicitly.
> > >
> > > So how about just adding a new option --mem-share to decide if that's=
 a
> > > private memory or shared memory? That seems much straightforward
> way
> Above options are legacy (which we can't remove for compat reasons),
> their replacement is 'memory-backend-file' backend which has all of
> the above including 'share' property.

OK, such options are legacy. I've no idea of that. Thanks! That makes sense=
.

>=20
> So just add 'memdev' property to machine and reuse memory-backend-file
> with it instead of duplicating functionality in the legacy code.

To "-m" or "-machine"?
