Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6A6C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DE621D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DE621D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6V04-0008Gb-0G
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 02:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1j6Uyy-0007SZ-F1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:50:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1j6Uyu-0007ZT-Io
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:50:20 -0500
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:48938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1j6Uyu-0007Sh-00
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:50:16 -0500
Received: from player794.ha.ovh.net (unknown [10.108.42.184])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 0E03A7D3C2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 08:50:05 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player794.ha.ovh.net (Postfix) with ESMTPSA id BCDD3CB820A4;
 Tue, 25 Feb 2020 07:49:44 +0000 (UTC)
Subject: Re: [PATCH v6 13/18] spapr: Don't use weird units for MIN_RMA_SLOF
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-14-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4cc4ebec-44ab-1e6d-2fb8-9157fc167ff7@kaod.org>
Date: Tue, 25 Feb 2020 08:49:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224233724.46415-14-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 15108732327825279854
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrledugdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.53.132
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 12:37 AM, David Gibson wrote:
> MIN_RMA_SLOF records the minimum about of RMA that the SLOF firmware
> requires.  It lets us give a meaningful error if the RMA ends up too sm=
all,
> rather than just letting SLOF crash.
>=20
> It's currently stored as a number of megabytes, which is strange for gl=
obal
> constants.  Move that megabyte scaling into the definition of the const=
ant
> like most other things use.
>=20
> Change from M to MiB in the associated message while we're at it.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  hw/ppc/spapr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 828e2cc135..272a270b7a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -103,7 +103,7 @@
>  #define FW_OVERHEAD             0x2800000
>  #define KERNEL_LOAD_ADDR        FW_MAX_SIZE
> =20
> -#define MIN_RMA_SLOF            128UL
> +#define MIN_RMA_SLOF            (128 * MiB)
> =20
>  #define PHANDLE_INTC            0x00001111
> =20
> @@ -2959,10 +2959,10 @@ static void spapr_machine_init(MachineState *ma=
chine)
>          }
>      }
> =20
> -    if (spapr->rma_size < (MIN_RMA_SLOF * MiB)) {
> +    if (spapr->rma_size < MIN_RMA_SLOF) {
>          error_report(
> -            "pSeries SLOF firmware requires >=3D %ldM guest RMA (Real =
Mode Area memory)",
> -            MIN_RMA_SLOF);
> +            "pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Rea=
l Mode Area memory)",
> +            MIN_RMA_SLOF / MiB);
>          exit(1);
>      }
> =20
>=20


