Received: from eggs.gnu.org ([209.51.188.92]:39822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGw7Y-0007xJ-FL
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 21:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGw7U-0003CQ-Nc
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 21:45:46 -0400
Date: Thu, 18 Apr 2019 11:45:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
References: <20190416045552.24573-1-npiggin@gmail.com>
	<20190417015934.GH32705@umbus.fritz.box>
	<1555498879.055yucy998.astroid@bobo.none>
	<20190417140129.18980f0e@bahia.lan>
	<20190417124734.GT32705@umbus.fritz.box>
In-Reply-To: <20190417124734.GT32705@umbus.fritz.box>
MIME-Version: 1.0
Message-Id: <1555551876.gpgdiz67vs.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] spapr: add splpar hcalls
 H_PROD, H_CONFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

David Gibson's on April 17, 2019 10:47 pm:
> On Wed, Apr 17, 2019 at 02:01:29PM +0200, Greg Kurz wrote:
>> On Wed, 17 Apr 2019 21:20:00 +1000
>> Nicholas Piggin <npiggin@gmail.com> wrote:
>> > [...]
>> > >> @@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
>> > >>      /* hcall-splpar */
>> > >>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>> > >>      spapr_register_hypercall(H_CEDE, h_cede);
>> > >> +    spapr_register_hypercall(H_CONFER, h_confer);
>> > >> +    spapr_register_hypercall(H_PROD, h_prod);
>> > >> +
>> > >>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_rese=
t); =20
>> > >=20
>> > > You're no longer enabling the KVM CONFER and PROD hypercalls.  Are
>> > > they enabled by default, or is that an intentional change? =20
>> >=20
>>=20
>> AFAICT they seem to be enabled by default in HV KVM.
>>=20
>> > Oh, it was not intentional, I must not understand how this works. Why
>> > is this no longer enabling the those hcalls?
>> >=20
>>=20
>> Since linux commit 699a0ea0823d ("KVM: PPC: Book3S: Controls for in-kern=
el=20
>> sPAPR hypercall handling"), in-kernel hypercalls are disabled by default
>> and must be explicitely enabled by userspace. QEMU does that for some
>> hypercalls already (search kvmppc_enable_set_mode_hcall() in QEMU for an
>> example).
>>=20
>> Since H_CONFER and H_PROD are listed in default_hcall_list[] in book3s_h=
v.c,
>> no need for QEMU to enable them in KVM.
>=20
> Ah, ok.  Oops, that means the guest environment has been visibly
> different for KVM and TCG all this time, which isn't great.
>=20
>> Not sure about David's "no longer" wording though.
>=20
>=20
> "no longer" meaning the previous patch version had some
> kvmppc_enable_hcall(), but this version doesn't.

Let me do one more iteration with the comment fixed up at least,
and I'll do a bit of testing with KVM vs TCG behaviour and see
if there are any problems around this.

Thanks,
Nick

=
