Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3506AC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0852C20715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0852C20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosrY-0001Lk-6g
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iosqc-0000o9-L5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iosqb-0002ca-Js
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:40:54 -0500
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:33830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iosqb-0002au-EP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:40:53 -0500
Received: from player786.ha.ovh.net (unknown [10.108.1.68])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 2D21C149EAA
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 18:40:50 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 46D02E1C9636;
 Tue,  7 Jan 2020 17:40:46 +0000 (UTC)
Date: Tue, 7 Jan 2020 18:40:44 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/2] ppc/pnv: check return value of blk_pwrite()
Message-ID: <20200107184044.4e2d5b2e@bahia.lan>
In-Reply-To: <20200107171809.15556-2-clg@kaod.org>
References: <20200107171809.15556-1-clg@kaod.org>
 <20200107171809.15556-2-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 14024772190868183435
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehhedgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.39.218
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

On Tue,  7 Jan 2020 18:18:08 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> When updating the PNOR file contents, we should check for a possible
> failure of blk_pwrite().
>=20
> Fixes Coverity issue CID 1412228.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/pnv_pnor.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
> index bfb1e92b0392..0e86ae2feae6 100644
> --- a/hw/ppc/pnv_pnor.c
> +++ b/hw/ppc/pnv_pnor.c
> @@ -33,6 +33,7 @@ static uint64_t pnv_pnor_read(void *opaque, hwaddr addr=
, unsigned size)
>  static void pnv_pnor_update(PnvPnor *s, int offset, int size)
>  {
>      int offset_end;
> +    int ret;
> =20
>      if (s->blk) {
>          return;
> @@ -42,8 +43,11 @@ static void pnv_pnor_update(PnvPnor *s, int offset, in=
t size)
>      offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
>      offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
> =20
> -    blk_pwrite(s->blk, offset, s->storage + offset,
> -               offset_end - offset, 0);
> +    ret =3D blk_pwrite(s->blk, offset, s->storage + offset,
> +                     offset_end - offset, 0);
> +    if (ret < 0) {
> +        error_report("Could not update PNOR: %s", strerror(-ret));
> +    }
>  }
> =20
>  static void pnv_pnor_write(void *opaque, hwaddr addr, uint64_t data,


