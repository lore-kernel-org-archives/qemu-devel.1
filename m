Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E3C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5FA20715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5FA20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iossy-0003ns-Nv
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iossK-0003Cp-84
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iossF-0003tX-FJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:42:36 -0500
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:35782)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iossE-0003qq-P2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:42:35 -0500
Received: from player756.ha.ovh.net (unknown [10.109.143.72])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 4E1FB265658
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 18:42:32 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id DC04AD1F67F1;
 Tue,  7 Jan 2020 17:42:27 +0000 (UTC)
Date: Tue, 7 Jan 2020 18:42:25 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/2] ppc/pnv: fix check on return value of blk_getlength()
Message-ID: <20200107184225.5fd9cef9@bahia.lan>
In-Reply-To: <20200107171809.15556-3-clg@kaod.org>
References: <20200107171809.15556-1-clg@kaod.org>
 <20200107171809.15556-3-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 14053482639303874955
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehhedgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.132
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

On Tue,  7 Jan 2020 18:18:09 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> blk_getlength() returns an int64_t but the result is stored in a
> uint32_t. Errors (negative values) won't be caught by the check in
> pnv_pnor_realize() and blk_blockalign() will allocate a very large
> buffer in such cases.
>=20
> Fixes Coverity issue CID 1412226.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/pnv_pnor.h | 2 +-
>  hw/ppc/pnv_pnor.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
> index c3dd28643cae..4f96abdfb402 100644
> --- a/include/hw/ppc/pnv_pnor.h
> +++ b/include/hw/ppc/pnv_pnor.h
> @@ -23,7 +23,7 @@ typedef struct PnvPnor {
>      BlockBackend   *blk;
> =20
>      uint8_t        *storage;
> -    uint32_t       size;
> +    int64_t        size;
>      MemoryRegion   mmio;
>  } PnvPnor;
> =20
> diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
> index 0e86ae2feae6..b061106d1c0c 100644
> --- a/hw/ppc/pnv_pnor.c
> +++ b/hw/ppc/pnv_pnor.c
> @@ -111,7 +111,7 @@ static void pnv_pnor_realize(DeviceState *dev, Error =
**errp)
>  }
> =20
>  static Property pnv_pnor_properties[] =3D {
> -    DEFINE_PROP_UINT32("size", PnvPnor, size, 128 << 20),
> +    DEFINE_PROP_INT64("size", PnvPnor, size, 128 << 20),
>      DEFINE_PROP_DRIVE("drive", PnvPnor, blk),
>      DEFINE_PROP_END_OF_LIST(),
>  };


