Received: from eggs.gnu.org ([209.51.188.92]:39522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGw6M-0007Bp-2x
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 21:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGw6L-0002Zu-3R
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 21:44:34 -0400
Date: Thu, 18 Apr 2019 11:44:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
References: <20190416045552.24573-1-npiggin@gmail.com>
	<20190417015934.GH32705@umbus.fritz.box>
	<1555498879.055yucy998.astroid@bobo.none>
	<20190417140129.18980f0e@bahia.lan>
In-Reply-To: <20190417140129.18980f0e@bahia.lan>
MIME-Version: 1.0
Message-Id: <1555551562.tc1i2mngsf.astroid@bobo.none>
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
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Greg Kurz's on April 17, 2019 10:01 pm:
> On Wed, 17 Apr 2019 21:20:00 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>> [...]
>> >> @@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
>> >>      /* hcall-splpar */
>> >>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>> >>      spapr_register_hypercall(H_CEDE, h_cede);
>> >> +    spapr_register_hypercall(H_CONFER, h_confer);
>> >> +    spapr_register_hypercall(H_PROD, h_prod);
>> >> +
>> >>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset)=
; =20
>> >=20
>> > You're no longer enabling the KVM CONFER and PROD hypercalls.  Are
>> > they enabled by default, or is that an intentional change? =20
>>=20
>=20
> AFAICT they seem to be enabled by default in HV KVM.
>=20
>> Oh, it was not intentional, I must not understand how this works. Why
>> is this no longer enabling the those hcalls?
>>=20
>=20
> Since linux commit 699a0ea0823d ("KVM: PPC: Book3S: Controls for in-kerne=
l=20
> sPAPR hypercall handling"), in-kernel hypercalls are disabled by default
> and must be explicitely enabled by userspace. QEMU does that for some
> hypercalls already (search kvmppc_enable_set_mode_hcall() in QEMU for an
> example).

Thanks for the explanation, that's a nice feature.

> Since H_CONFER and H_PROD are listed in default_hcall_list[] in book3s_hv=
.c,
> no need for QEMU to enable them in KVM.

It looks like we can disable even hcalls that are in the default list
which might help with qemu H_JOIN implementation if we need to send
H_PROD to qemu to do the wake-up.

Thanks,
Nick

=
