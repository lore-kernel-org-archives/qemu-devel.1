Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B498C3A5A9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 00:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A1A206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 00:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FMrZ1SRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A1A206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVlc5-00078k-Qu
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 20:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVlbO-0006fC-FE; Mon, 04 May 2020 20:38:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35071 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVlaw-00060M-T7; Mon, 04 May 2020 20:38:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49GLRD1m9Wz9sSW; Tue,  5 May 2020 10:37:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588639064;
 bh=gxVoCqIzNwD00Pb7O12s69r0plYWM5h+0WxFcdwwgUI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FMrZ1SRIxQ5Qawsir4Ff8xtDRzE0vDiEc4DJJO7Jkq4APDyNXP/pXz3wPyR8azQ/v
 6xK+hEEIe/TTSS+/BIb0TdtWFOqngpsKNuLhkVSFENlHyhXfcl+34mLvHWOiAGFHkY
 5yjisWDTrmAYEjjuRzFDX6HYvqavpf7qDZEFbU08=
Date: Tue, 5 May 2020 10:34:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 5/6] block/nvme: Align block pages queue to host page size
Message-ID: <20200505003423.GD13695@umbus.fritz.box>
References: <20200504094641.4963-1-philmd@redhat.com>
 <20200504094641.4963-6-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <20200504094641.4963-6-philmd@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 20:37:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <keith.busch@intel.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 11:46:40AM +0200, Philippe Mathieu-Daud=E9 wrote:
> In nvme_create_queue_pair() we create a page list using
> qemu_blockalign(), then map it with qemu_vfio_dma_map():
>=20
>   q->prp_list_pages =3D qemu_blockalign0(bs, s->page_size * NVME_QUEUE_SI=
ZE);
>   r =3D qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
>                         s->page_size * NVME_QUEUE_SIZE, ...);
>=20
> With:
>=20
>   s->page_size =3D MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
>=20
> The qemu_vfio_dma_map() documentation says "The caller need
> to make sure the area is aligned to page size". While we use
> multiple s->page_size as alignment, it might be not sufficient
> on some hosts. Use the qemu_real_host_page_size value to be
> sure the host alignment is respected.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Cc: C=E9dric Le Goater <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Laurent Vivier <lvivier@redhat.com>
> ---
>  block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 7b7c0cc5d6..bde0d28b39 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -627,7 +627,7 @@ static int nvme_init(BlockDriverState *bs, const char=
 *device, int namespace,
> =20
>      s->page_size =3D MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
>      s->doorbell_scale =3D (4 << (((cap >> 32) & 0xF))) / sizeof(uint32_t=
);
> -    bs->bl.opt_mem_alignment =3D s->page_size;
> +    bs->bl.opt_mem_alignment =3D MAX(qemu_real_host_page_size, s->page_s=
ize);
>      timeout_ms =3D MIN(500 * ((cap >> 24) & 0xFF), 30000);
> =20
>      /* Reset device to get a clean state. */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6wtI4ACgkQbDjKyiDZ
s5J8+xAAtRL8ELfJtWXEPq8h3/ak/v7Bp1VXknIJqzGFELuv1eVrZZaeUJKwsu8E
CKNxmyfj4CRUCNxoGSbtwi/6+Je/loJqvz+kubwX///YAKn00p8Ta3c5rTX0t+x8
ogGg9RDMxFm02IPfvfFBWBfPp4G5Uu7vGdihI5zV3eC+xyfCEgks/Q08T+oBK7k/
Vl2/zmkVk9MiRqC0TBY9QWW5sFk2EuJZAywD74Kw0H4LhVVcvOIFwZQUObuAH66Y
+TMoIPuIYw4P0NxzdW1hEUi9BbV6RM0dQkLCeS+4LKNVeJ5bpl1/CKYbA/R2KweS
2pVjdEU4+PZnZN5l0CmNNVx840ClKlm28slse1JvsVKDTOwbkUspSHn+WRuWZYoI
nbVGhOklg9AXK25OwfmuQAfchVzZcCqaauOc3cohfCNnxxdNuDDR6kKsLK1y+p2k
MMR0h9+ZTX+5R/+i2JmDTyDTXagvigDQ4Uk5Gx2WS0NNi3vcd6Z76JI36fd1T+N4
T3u2mXJTzJXdzOi0tirQaYDwicJiGfmNUifoJvKllwoJigAPzQ6mtOTEK7YXNU6H
OihO/BUxzTWY8LobIyFv9uhWWalQ1m3+8CrKfO+BxZJ7EnaBzejIRZf2RhX3LLVF
m9sb/xuEPI0I9o3LO/hN3QouD8bb1L5BygWyIBZIwE1IS6lyyTw=
=nfv/
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--

