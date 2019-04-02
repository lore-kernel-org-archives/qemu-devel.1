Received: from eggs.gnu.org ([209.51.188.92]:44547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBGJB-0004Li-OX
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBG0F-0006GK-0Z
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hBG0E-0006Dh-Lw
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:46:46 -0400
Date: Tue, 2 Apr 2019 11:46:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190402114637.24cb44cc@redhat.com>
In-Reply-To: <ea1cf631-2c4c-9b66-c5d3-147d67181fab@intel.com>
References: <20190131071658.29120-1-tao3.xu@intel.com>
	<20190131071658.29120-5-tao3.xu@intel.com>
	<20190206111124.73c99f4e@Igors-MacBook-Pro.local>
	<ea1cf631-2c4c-9b66-c5d3-147d67181fab@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/8] Extend the command-line to provide
 memory latency and bandwidth information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Xu <tao3.xu@intel.com>
Cc: eblake@redhat.com, mst@redhat.com, xiaoguangrong.eric@gmail.com, ehabkost@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com, danmei.wei@intel.com, karl.heubaum@oracle.com, rth@twiddle.net, Markus Armbruster <armbru@redhat.com>

On Tue, 2 Apr 2019 12:42:37 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 2/6/19 6:11 PM, Igor Mammedov wrote:
> > On Thu, 31 Jan 2019 15:16:54 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >  =20
> >> From: Liu Jingqi <jingqi.liu@intel.com>
> >>
> >> Add -numa hmat-lb option to provide System Locality Latency and
> >> Bandwidth Information. These memory attributes help to build
> >> System Locality Latency and Bandwidth Information Structure(s)
> >> in ACPI Heterogeneous Memory Attribute Table (HMAT). =20
> > Maybe instead of adding/using more globals since the rest of numa.c was
> > written so, it's time to introduce NumaMachine type which inherits
> > form base Machine and extends it with numa extensions.
> >=20
> > You don't have to refactor all old numa code for that (just the parts
> > you use in HMAT) and later we could gradually refactor the rest of
> > numa handling.
> >  =20
> Hi Igor,
>=20
> I am sorry for replying after so long, because I am preparing the next=20
> version of patch and confusing about the implementation of NumaMachine.
> If NumaMachine inherits from Machine, and then the PCmachine and other=20
> platform machine inherits from NumaMachine (Implementation a)? Or=20
> PCmachine and other platform machine inherits from Machine=20
> (Implementation b)?
>=20
> Implementation a:		Implementation b:
> Machine                         Machine
> =E2=94=82                               =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80 NumaMachine                 =E2=94=9C=E2=94=
=80=E2=94=80 NumaMachine
>      =E2=94=82                           =E2=94=82
>      =E2=94=9C=E2=94=80=E2=94=80 PCMachine               =E2=94=9C=E2=94=
=80=E2=94=80 PCMachine
>      =E2=94=82                           =E2=94=82
>      =E2=94=94=E2=94=80=E2=94=80 none-PCMachine          =E2=94=94=E2=94=
=80=E2=94=80 none-PCMachine

I'd imagine 'a', where none-PCMachine is arm/virt and spapr machines that
support numa today. The rest would inherit from plain Machine.

> And how about add numa.c's globals into MachineState? This may not=20
> change a lot.
That's another possible way, but it's polluting generic machine with
numa specifics about which only 3-4 boards care.
=46rom my point of view it's a bit better then globals but not much.

> Looking forward to your reply.
>=20
> Tao
>=20
