Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B383C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00DE420720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DE420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5Qm-0004EA-2A
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jY5QC-0003aX-W8
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:12:29 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:43875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jY5QB-0000Jy-Jn
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:12:28 -0400
Received: from player732.ha.ovh.net (unknown [10.110.208.202])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7DA3413BEF6
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 12:12:24 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id A4DA2121C8B1E;
 Mon, 11 May 2020 10:12:20 +0000 (UTC)
Date: Mon, 11 May 2020 12:12:19 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 3/6] target/ppc: Don't initialize some local variables
 in ppc_radix64_xlate()
Message-ID: <20200511121219.372eb293@bahia.lan>
In-Reply-To: <7aa5f210-6a03-7e66-ba3c-017704415989@kaod.org>
References: <158887239173.1564424.16721638327458334129.stgit@bahia.lan>
 <158887241032.1564424.1335205982073200922.stgit@bahia.lan>
 <7aa5f210-6a03-7e66-ba3c-017704415989@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 2668382780817054091
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrledtgddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeukeejkeeiffeftdevueekvdetjeegieevhffgjefgtdeluddvgfefleekueevueenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.34.219; envelope-from=groug@kaod.org;
 helo=4.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 06:12:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 11:07:06 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 5/7/20 7:26 PM, Greg Kurz wrote:
> > It is the job of the ppc_radix64_get_fully_qualified_addr() function
> > which is called at the beginning of ppc_radix64_xlate() to set both
> > lpid *and* pid. It doesn't buy us anything to initialize them first.
> >=20
> > Worse, a bug in ppc_radix64_get_fully_qualified_addr(), eg. failing to
> > set either lpid or pid, would be undetectable by static analysis tools
> > like coverity.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  target/ppc/mmu-radix64.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> > index c76879f65b78..5e2d912ee346 100644
> > --- a/target/ppc/mmu-radix64.c
> > +++ b/target/ppc/mmu-radix64.c
> > @@ -433,7 +433,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr=
 eaddr, int rwx,
> >                               bool cause_excp)
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> > -    uint64_t lpid =3D 0, pid =3D 0;
> > +    uint64_t lpid, pid;
> >      ppc_v3_pate_t pate;
> >      int psize, prot;
> >      hwaddr g_raddr;
> >=20
>=20
> I am seeing this failure with gcc version 9.3.1 20200408 (Red Hat 9.3.1-2=
) (GCC)=20
>=20
> target/ppc/mmu-radix64.c: In function =E2=80=98ppc_radix64_xlate=E2=80=99:
> target/ppc/mmu-radix64.c:314:12: error: =E2=80=98pid=E2=80=99 may be used=
 uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>   314 |     offset =3D pid * sizeof(struct prtb_entry);
>       |     ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> target/ppc/mmu-radix64.c:439:20: note: =E2=80=98pid=E2=80=99 was declared=
 here
>   439 |     uint64_t lpid, pid;
>       |                    ^~~
> target/ppc/mmu-radix64.c:458:14: error: =E2=80=98lpid=E2=80=99 may be use=
d uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>   458 |         if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
>       |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   CC      ppc64-softmmu/target/ppc/fpu_helper.o
>=20
>=20
> This seems like a compiler optimization issue.
>=20

Ah... it seems that gcc is trying to be smart but it doesn't realize
that ppc_radix64_get_fully_qualified_addr() doesn't have any path
that leaves lpid or pid unset... :-\ Adding a default: case in both
switch statements is enough to silent gcc.

I guess it may be easier for David if I post a v2 of the entire series
that addresses all the comments.

Thanks!

> C.


