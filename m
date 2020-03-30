Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD560C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32A2205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32A2205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIrwU-0005oM-Sw
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 06:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jIrvT-00059v-BY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jIrvR-00037j-WC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:45:51 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:37710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jIrvR-000301-Qk
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:45:49 -0400
Received: from player738.ha.ovh.net (unknown [10.110.171.50])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 5AD5815E0A6
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 12:45:41 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id D2383110750D2;
 Mon, 30 Mar 2020 10:45:34 +0000 (UTC)
Date: Mon, 30 Mar 2020 12:45:33 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/7] target/ppc: Enforce that the root page directory
 size must be at least 5
Message-ID: <20200330124533.5ace0a0f@bahia.lan>
In-Reply-To: <20200330094946.24678-2-clg@kaod.org>
References: <20200330094946.24678-1-clg@kaod.org>
 <20200330094946.24678-2-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 14831479474975185291
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
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
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 11:49:40 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
> According to the ISA the root page directory size of a radix tree for
> either process- or partition-scoped translation must be >=3D 5.
>=20
> Thus add this to the list of conditions checked when validating the
> partition table entry in validate_pate();
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/mmu-radix64.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 224e646c5094..99678570581b 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -212,6 +212,9 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t l=
pid, ppc_v3_pate_t *pate)
>      if (lpid =3D=3D 0 && !msr_hv) {
>          return false;
>      }
> +    if ((pate->dw0 & PATE1_R_PRTS) < 5) {
> +        return false;
> +    }
>      /* More checks ... */
>      return true;
>  }


