Received: from eggs.gnu.org ([2001:4830:134:3::10]:36889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dQ20G-0006ld-BJ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 21:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dQ20D-0002zj-7e
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 21:42:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1dQ20C-0002z3-UD
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 21:42:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5S1e3q9111378
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 21:42:43 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bbreu1yjf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 21:42:42 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 27 Jun 2017 22:42:40 -0300
Date: Tue, 27 Jun 2017 22:42:31 -0300
From: joserz@linux.vnet.ibm.com
References: <20170622112648.24815-1-lvivier@redhat.com>
	<caa25331-5005-78e8-fba2-19bf67116d92@redhat.com>
	<20170623092124.GG12089@umbus>
	<c0a0667e-8c60-a8e7-a041-caddac8c8b88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0a0667e-8c60-a8e7-a041-caddac8c8b88@redhat.com>
Message-Id: <20170628014231.GA791@pacoca>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, Jun 23, 2017 at 04:10:55PM +0200, Laurent Vivier wrote:
> On 23/06/2017 11:21, David Gibson wrote:
> > On Thu, Jun 22, 2017 at 01:31:24PM +0200, Thomas Huth wrote:
> >> On 22.06.2017 13:26, Laurent Vivier wrote:
> >>> CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v1.0.
> >>>
> >>> When we run qemu on a POWER9 DD1 host, we must use either
> >>> "-cpu host" or "-cpu POWER9", but in the latter case it fails with
> >>>
> >>>     Unable to find sPAPR CPU Core definition
> >>>
> >>> because POWER9 DD1 doesn't appear in the list of known CPUs.
> >>>
> >>> This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
> >>> PVR instead of CPU_POWERPC_POWER9_BASE.
> >>>
> >>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >>> ---
> >>>  target/ppc/cpu-models.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> >>> index 4d3e635..a22363c 100644
> >>> --- a/target/ppc/cpu-models.c
> >>> +++ b/target/ppc/cpu-models.c
> >>> @@ -1144,7 +1144,7 @@
> >>>      POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,             =
   970,
> >>>                  "PowerPC 970 v2.2")
> >>> =20
> >>> -    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,         =
   POWER9,
> >>> +    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_DD1,          =
   POWER9,
> >>>                  "POWER9 v1.0")
> >>> =20
> >>>      POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,           =
   970,
> >>>
> >>
> >> I think this also makes sense for running in TCG mode to get a valid
> >> real PVR there.
> >=20
> > I'm not so convinced.
> >=20
> > IIUC, this will make TCG default (for now) to a DD1 POWER9.  That's a=
)
> > probably not what anyone wants - who'd select a buggy prototype and b=
)
> > not accurate - TCG does not implement DD1's bugs.
>=20
> According to the POWER8 user manual (I didn't fine the POWER9 one):
>=20
> "3.6.3.1 Processor Version Register (PVR)
>=20
> The processor revision level (PVR[16:31]) starts at x=E2=80=980100=E2=80=
=99, indicating
> revision =E2=80=981.0=E2=80=99. As revisions are made, bits [29:31] wil=
l indicate minor
> revisions. Similarly, bits [20:23] indicate major changes."
>=20
> POWER9 DD1 PVR is 0x004E0100, so this is really version 1.0 of the POWE=
R9.
>=20
> Perhaps we can define POWER9_v1.0 as CPU_POWERPC_POWER9_DD1, and
> introduce a POWER9_v0.0 set to CPU_POWERPC_POWER9_BASE and define it as
> the default one?

I like the suggestion to set a v0.0 to CPU_POWERPC_POWER9_BASE. But, I
think we could have only that option, removing the
CPU_POWERPC_POWER9_DD1 entry. Then, we add the v2.0 (when ready) as the C=
PU
emulated by TCG.

To TCG, DD1 wouldn't be listed because it cannot be emulated today.

What do you think?

Ziviani

>=20
> Laurent
>=20
>=20
