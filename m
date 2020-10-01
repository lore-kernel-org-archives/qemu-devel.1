Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC9DC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 04:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6C721D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 04:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6C721D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNpu5-00036i-6G
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 00:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNpqK-00022W-9Q; Thu, 01 Oct 2020 00:05:22 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:41715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNpqH-0004f1-27; Thu, 01 Oct 2020 00:05:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 476B49EF;
 Thu,  1 Oct 2020 00:05:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 00:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=M7OiSe5QcZ41c3Wqh8JhFET7or3
 51Wtiuk+OJ1gOsfc=; b=gC/4smKJD1JHY4XZP7gb8AsClc9WAm+Gluw9wYpSttq
 YSWHvPriQCZyrXxjNmTIE/rt+R+Tv/oQ2Bga2LkXkXrZUmDbnFOh/oDKqCMJSzDZ
 PQyzM7XWmcwTKh5mPnYBgn2mBgmFrt1QtHWA4t9MamedsXcafST/3KjRpE1YLNYA
 L3+q4dyhKm82Y+PCCwZMaQmoDw5G8QxmbclPwK41BiV10XFC11A8yp13nuRdhCIE
 BLCObWOfSfj6sH3aSmRmXSgYiOf6R7/STi2KCjALKqOBDtny571t3cp4SPpEv/A8
 1/wMA8QSyQEfxYRfYPESp0oGc/Be5GZ8VrUVeTYA27w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=M7OiSe
 5QcZ41c3Wqh8JhFET7or351Wtiuk+OJ1gOsfc=; b=Gpg95EnnkljUx9tCWiFDde
 201fiysc7p8Lyu0HeZntyhlQ+J/uMV8dWwxaubxpkri7l18CxFmBde3RV5tA+BMQ
 gDi9kjwhAA1cpBWnMPBpi0bjz6DaICOzdkTtI5mQRbuIB8o3YzrX3bTRWuIMDrNu
 PAsTb6LSehkoMOyJgLKkGGyix5Wi+v1UkbtJsfR+NEFlhm1YnRbPb7mdd5ulww7I
 thgB1SreSigZBR3w2DZ/2S7SA2jAMez/9OJM5UPiQJDBHqIul8EWBxsgg9NBCzgJ
 FdQ0jpXTPbFJvoCCkyM3WEm9c1apIWKELeljok96M70wueMOwGrsyAtF2YWdrdqQ
 ==
X-ME-Sender: <xms:eFV1XwRKQEJMjQgruVp3fG2jDyjngP9w5xM2zceMz2GQQPaBDynSiA>
 <xme:eFV1X9w3hfPm28fccsgsXgqwsZmthCkbaELVMbN02dgHDuuhD8z504_yh6sDj4sP8
 h3JmMZLNKHhc9dnTkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdekudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:eFV1X93IGJ4hKRM8SUPTLHdH_ouAGihxexLGjPMH6MUlI4TK_LdcEQ>
 <xmx:eFV1X0CAo6vDAf-DVXvQ2D_XM5sjiEMJglPes-1_mdjxETgYrpzpnw>
 <xmx:eFV1X5jfGvHS6Iht_i_BFTpmXOW2IKEisKaZkKT9ZoeprQwQO-gi6A>
 <xmx:eVV1X3b9FrqX5vO7het53nirXs0eK4RJ9bfW6wN4ZVyHq75VBAit0NLKP5k>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C27B43280063;
 Thu,  1 Oct 2020 00:05:10 -0400 (EDT)
Date: Thu, 1 Oct 2020 06:05:08 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/9] hw/block/nvme: remove pointless rw indirection
Message-ID: <20201001040508.GA681387@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20200930220414.562527-2-kbusch@kernel.org>
Received-SPF: pass client-ip=64.147.123.17; envelope-from=its@irrelevant.dk;
 helo=wnew3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 00:05:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 30 15:04, Keith Busch wrote:
> The code switches on the opcode to invoke a function specific to that
> opcode. There's no point in consolidating back to a common function that
> just switches on that same opcode without any actual common code.
> Restore the opcode specific behavior without going back through another
> level of switches.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Point taken. I could've sweared I had a better reason for this.

> ---
>  hw/block/nvme.c | 91 ++++++++++++++++---------------------------------
>  1 file changed, 29 insertions(+), 62 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index da8344f196..db52ea0db9 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -927,68 +927,12 @@ static void nvme_rw_cb(void *opaque, int ret)
>      nvme_enqueue_req_completion(nvme_cq(req), req);
>  }
> =20
> -static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t le=
n,
> -                            NvmeRequest *req)
> -{
> -    BlockAcctCookie *acct =3D &req->acct;
> -    BlockAcctStats *stats =3D blk_get_stats(blk);
> -
> -    bool is_write =3D false;
> -
> -    trace_pci_nvme_do_aio(nvme_cid(req), req->cmd.opcode,
> -                          nvme_io_opc_str(req->cmd.opcode), blk_name(blk=
),
> -                          offset, len);
> -
> -    switch (req->cmd.opcode) {
> -    case NVME_CMD_FLUSH:
> -        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
> -        req->aiocb =3D blk_aio_flush(blk, nvme_rw_cb, req);
> -        break;
> -
> -    case NVME_CMD_WRITE_ZEROES:
> -        block_acct_start(stats, acct, len, BLOCK_ACCT_WRITE);
> -        req->aiocb =3D blk_aio_pwrite_zeroes(blk, offset, len,
> -                                           BDRV_REQ_MAY_UNMAP, nvme_rw_c=
b,
> -                                           req);
> -        break;
> -
> -    case NVME_CMD_WRITE:
> -        is_write =3D true;
> -
> -        /* fallthrough */
> -
> -    case NVME_CMD_READ:
> -        block_acct_start(stats, acct, len,
> -                         is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
> -
> -        if (req->qsg.sg) {
> -            if (is_write) {
> -                req->aiocb =3D dma_blk_write(blk, &req->qsg, offset,
> -                                           BDRV_SECTOR_SIZE, nvme_rw_cb,=
 req);
> -            } else {
> -                req->aiocb =3D dma_blk_read(blk, &req->qsg, offset,
> -                                          BDRV_SECTOR_SIZE, nvme_rw_cb, =
req);
> -            }
> -        } else {
> -            if (is_write) {
> -                req->aiocb =3D blk_aio_pwritev(blk, offset, &req->iov, 0,
> -                                             nvme_rw_cb, req);
> -            } else {
> -                req->aiocb =3D blk_aio_preadv(blk, offset, &req->iov, 0,
> -                                            nvme_rw_cb, req);
> -            }
> -        }
> -
> -        break;
> -    }
> -
> -    return NVME_NO_COMPLETE;
> -}
> -
>  static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    NvmeNamespace *ns =3D req->ns;
> -    return nvme_do_aio(ns->blkconf.blk, 0, 0, req);
> +    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> +                     BLOCK_ACCT_FLUSH);
> +    req->aiocb =3D blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
> +    return NVME_NO_COMPLETE;
>  }
> =20
>  static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
> @@ -1009,7 +953,11 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, Nvme=
Request *req)
>          return status;
>      }
> =20
> -    return nvme_do_aio(ns->blkconf.blk, offset, count, req);
> +    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> +                     BLOCK_ACCT_WRITE);
> +    req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
> +                                       BDRV_REQ_MAY_UNMAP, nvme_rw_cb, r=
eq);
> +    return NVME_NO_COMPLETE;
>  }
> =20
>  static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
> @@ -1023,6 +971,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *re=
q)
>      uint64_t data_offset =3D nvme_l2b(ns, slba);
>      enum BlockAcctType acct =3D req->cmd.opcode =3D=3D NVME_CMD_WRITE ?
>          BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
> +    BlockBackend *blk =3D ns->blkconf.blk;
>      uint16_t status;
> =20
>      trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode),
> @@ -1045,7 +994,25 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *r=
eq)
>          goto invalid;
>      }
> =20
> -    return nvme_do_aio(ns->blkconf.blk, data_offset, data_size, req);
> +    block_acct_start(blk_get_stats(blk), &req->acct, data_size, acct);
> +    if (req->qsg.sg) {
> +        if (acct =3D=3D BLOCK_ACCT_WRITE) {
> +            req->aiocb =3D dma_blk_write(blk, &req->qsg, data_offset,
> +                                       BDRV_SECTOR_SIZE, nvme_rw_cb, req=
);
> +        } else {
> +            req->aiocb =3D dma_blk_read(blk, &req->qsg, data_offset,
> +                                      BDRV_SECTOR_SIZE, nvme_rw_cb, req);
> +        }
> +    } else {
> +        if (acct =3D=3D BLOCK_ACCT_WRITE) {
> +            req->aiocb =3D blk_aio_pwritev(blk, data_offset, &req->iov, =
0,
> +                                         nvme_rw_cb, req);
> +        } else {
> +            req->aiocb =3D blk_aio_preadv(blk, data_offset, &req->iov, 0,
> +                                        nvme_rw_cb, req);
> +        }
> +    }
> +    return NVME_NO_COMPLETE;
> =20
>  invalid:
>      block_acct_invalid(blk_get_stats(ns->blkconf.blk), acct);
> --=20
> 2.24.1
>=20
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl91VXAACgkQTeGvMW1P
DenO7Af/UMCl/YonCgJfIk0iJ0zw1EDSOyIy13IVbihR6QAHfvB0DyA3VeLiZseQ
7V8xQRZ/VKRrP0xp1S9uKdcdoKh+OnGJ+iZvfyE9KtZhyHobOSir/pxDpRn06ITd
dE9HHf0+GIpgZJFe0YM7fj3reYNPIg9rGAmum6GeUbrtGZ3IzBDrEs/6m0dqI4ev
Wye+hHFmYcTVYkHy9xfjhSFri6v6ob7nC1L9MZeq40lk9e7701GQALgdVa+R7reZ
sUysFSRolvG05K0E1Tn8X/VC8lGiIO1etb3iQTheUat5+5GgEoGqkqIR15NTmlHl
Pk5DFt9atgahikW1nBUKtZHGlf27Pg==
=CvOn
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

