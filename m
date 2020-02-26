Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EBCC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A26E21556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A26E21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rzK-0001AA-8k
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 03:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6ryl-0000kI-Ta
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6ryk-0005bJ-Kd
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:23:39 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:60808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6ryk-0005SQ-DR
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:23:38 -0500
Received: from player772.ha.ovh.net (unknown [10.110.171.40])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 21B7D15A61F
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 09:23:35 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 736FAFD3BDF1;
 Wed, 26 Feb 2020 08:23:19 +0000 (UTC)
Date: Wed, 26 Feb 2020 09:23:17 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 10/18] target/ppc: Correct RMLS table
Message-ID: <20200226092317.1f6115e4@bahia.home>
In-Reply-To: <20200224233724.46415-11-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-11-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 3100446870791231974
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleefgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.76
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:37:16 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> The table of RMA limits based on the LPCR[RMLS] field is slightly wrong.
> We're missing the RMLS =3D=3D 0 =3D> 256 GiB RMA option, which is availab=
le on
> POWER8, so add that.
>=20
> The comment that goes with the table is much more wrong.  We *don't* filt=
er
> invalid RMLS values when writing the LPCR, and there's not really a
> sensible way to do so.  Furthermore, while in theory the set of RMLS valu=
es
> is implementation dependent, it seems in practice the same set has been
> available since around POWER4+ up until POWER8, the last model which
> supports RMLS at all.  So, correct that as well.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Irrespectively of my suggestion for the previous patch, which would
call for some adjustments in this patch, the fix is good, so:

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/mmu-hash64.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 4f082d775d..dd0df6fd01 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -762,12 +762,12 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      /*
> -     * This is the full 4 bits encoding of POWER8. Previous
> -     * CPUs only support a subset of these but the filtering
> -     * is done when writing LPCR
> +     * In theory the meanings of RMLS values are implementation
> +     * dependent.  In practice, this seems to have been the set from
> +     * POWER4+..POWER8, and RMLS is no longer supported in POWER9.
>       */
>      const target_ulong rma_sizes[] =3D {
> -        [0] =3D 0,
> +        [0] =3D 256 * GiB,
>          [1] =3D 16 * GiB,
>          [2] =3D 1 * GiB,
>          [3] =3D 64 * MiB,


