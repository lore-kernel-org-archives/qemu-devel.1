Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A8C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A622073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A622073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieilO-0002sM-Lr
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieihF-0007Gt-Q0
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieihE-00062e-Ix
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:49:13 -0500
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:51281)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieihE-00061V-De
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:49:12 -0500
Received: from player695.ha.ovh.net (unknown [10.108.42.142])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 125AC84F74
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 17:49:09 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id E4959D06690C;
 Tue, 10 Dec 2019 16:49:03 +0000 (UTC)
Date: Tue, 10 Dec 2019 17:49:01 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/2] ppc/pnv: Loop on the whole hierarchy to populate
 the DT with the XSCOM nodes
Message-ID: <20191210174901.6215ddd4@bahia.tlslab.ibm.com>
In-Reply-To: <20191210135845.19773-2-clg@kaod.org>
References: <20191210135845.19773-1-clg@kaod.org>
 <20191210135845.19773-2-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 14737185358297733515
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelfedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.44.197
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

On Tue, 10 Dec 2019 14:58:44 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Some PnvXScomInterface objects lie a bit deeper (PnvPBCQState) than

I didn't find any trace of PnvPBCQState in the code... what is it ?

> the first layer, so we need to loop on the whole object hierarchy to
> catch them.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv_xscom.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index bed41840845e..006d87e970d9 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -326,7 +326,12 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_=
offset)
>      args.fdt =3D fdt;
>      args.xscom_offset =3D xscom_offset;
> =20
> -    object_child_foreach(OBJECT(chip), xscom_dt_child, &args);
> +    /*
> +     * Loop on the whole object hierarchy to catch all
> +     * PnvXScomInterface objects which can lie a bit deeper the first

s/deeper the first/deeper than the first/

> +     * layer.
> +     */
> +    object_child_foreach_recursive(OBJECT(chip), xscom_dt_child, &args);
>      return 0;
>  }
> =20


