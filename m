Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE3BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4216B20789
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4216B20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqgz-0003Xp-2L
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kMqce-0007SS-2N; Mon, 28 Sep 2020 06:43:08 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kMqcb-0006Fs-4R; Mon, 28 Sep 2020 06:43:07 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id B82955801BE;
 Mon, 28 Sep 2020 06:43:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 28 Sep 2020 06:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=reA3ZTj9bvvfkSna4uY7Zzo7GOw
 UiqBX8J9abnD573k=; b=0MlGvapMj1Xe4QhASWj1r/JwrshoLFpmpFRrL7Xslfl
 bLfd4IxtjuIvNDwHQwJDhYFCRtOdKgpbib1+oCQloEClv55l5KC5BTs/YdmWPyLj
 5Z/O3wyNT2EgkGfI00JaI2K1KkmEGc5xBRkRLaQv6I9TsHeaYYhdEIWHPnvr084P
 gCNYYBQXTaRkapf0+5pBO77NYDWWjRYAzXQ9GKKF7A9SfhjmWX3gl+vUdibVvIcq
 e/bMnPeT7r2OyAX+LlJ5KTsH7KUHd6dKlpdMWf/q9Vx90pAemwM6Qlnh/Iy2K36x
 +I28W3UzarmwF8KPtnLexfNaVdvadf70VwCTN+9RgLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=reA3ZT
 j9bvvfkSna4uY7Zzo7GOwUiqBX8J9abnD573k=; b=OhxX2Oyw7soYgOdTO6gPYk
 DiA9oJ5XD2rHUCPoQR3Dh+Tb2pj/wdJCxtT/81pXxa/s+feQhVYYtwhkojpPb8mh
 q10NQLFn8tVN/HYQ3/czeJOiW8t68+L/mA1ZconLqvCVz3dIkvmZL0zSulO9AMzx
 adIGK3ZqX0O0sMbIO7rMmFe/5aCO9i0JTECGHjceeJ2VxjAvx7jzrkDkG0EeZph0
 ecrWHR98W32RUMY3YTsKNtyVN6+GLJT1UGQAqCW0BZijr607p35TwEdzAqi9ZsEV
 ZFaq8LysSzzaihSqxof4LiA/s1jF151kSumy/lsBDWkH4hqrnPaNVH5WnnM5yTKw
 ==
X-ME-Sender: <xms:Nb5xX7MAPw5qy-ziknzKsthlKgnj8XWClN9g8yizka-Sz1nY5_uuKA>
 <xme:Nb5xX186btI8qi9kxq2Tmoery5QYtK6ruwkhpseiJsW5CVbeZqj8C_tpK9eAodGxL
 QYUDcVBIeUavoi57JI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdefudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Nr5xX6SMVMqn3eJAq0-L_NU_K62Mq2M8ICSeXTfdySqoSTmnJM9ZdA>
 <xmx:Nr5xX_ulbkCggD_ijLaLStBUC1Ks_WFtG-vnpDeBAfPhxSQhcwO9JQ>
 <xmx:Nr5xXzfy48GnBlrWZo9E1wmgCeFdKstctv5zpGQalcnb7ZylFOzo7Q>
 <xmx:N75xX72jWVVInKu2ZZOHmuCWAmPk5BFI6L6B7kzKjk-N5wH_Lh_6BRu7F1Q>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 360D5306467E;
 Mon, 28 Sep 2020 06:43:00 -0400 (EDT)
Date: Mon, 28 Sep 2020 12:42:58 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20200928104258.GB33043@apples.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-10-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20200928023528.15260-10-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 06:43:03
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Niklas Cassel <niklas.cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 28 11:35, Dmitry Fomichev wrote:
> The emulation code has been changed to advertise NVM Command Set when
> "zoned" device property is not set (default) and Zoned Namespace
> Command Set otherwise.
>=20
> Handlers for three new NVMe commands introduced in Zoned Namespace
> Command Set specification are added, namely for Zone Management
> Receive, Zone Management Send and Zone Append.
>=20
> Device initialization code has been extended to create a proper
> configuration for zoned operation using device properties.
>=20
> Read/Write command handler is modified to only allow writes at the
> write pointer if the namespace is zoned. For Zone Append command,
> writes implicitly happen at the write pointer and the starting write
> pointer value is returned as the result of the command. Write Zeroes
> handler is modified to add zoned checks that are identical to those
> done as a part of Write flow.
>=20
> The code to support for Zone Descriptor Extensions is not included in
> this commit and ZDES 0 is always reported. A later commit in this
> series will add ZDE support.
>=20
> This commit doesn't yet include checks for active and open zone
> limits. It is assumed that there are no limits on either active or
> open zones.
>=20

I think the fill_pattern feature stands separate, so it would be nice to
extract that to a patch on its own.

> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  block/nvme.c         |   2 +-
>  hw/block/nvme-ns.c   | 185 ++++++++-
>  hw/block/nvme-ns.h   |   6 +-
>  hw/block/nvme.c      | 872 +++++++++++++++++++++++++++++++++++++++++--
>  include/block/nvme.h |   6 +-
>  5 files changed, 1033 insertions(+), 38 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> index 04172f083e..daa13546c4 100644
> --- a/hw/block/nvme-ns.h
> +++ b/hw/block/nvme-ns.h
> @@ -38,7 +38,6 @@ typedef struct NvmeZoneList {
> =20
>  typedef struct NvmeNamespaceParams {
>      uint32_t nsid;
> -    uint8_t  csi;
>      bool     attached;
>      QemuUUID uuid;
> =20
> @@ -52,6 +51,7 @@ typedef struct NvmeNamespace {
>      DeviceState  parent_obj;
>      BlockConf    blkconf;
>      int32_t      bootindex;
> +    uint8_t      csi;
>      int64_t      size;
>      NvmeIdNs     id_ns;

This should be squashed into the namespace types patch.

> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 63ad03d6d6..38e25a4d1f 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -54,6 +54,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
> +#include "crypto/random.h"

I think this is not used until the offline/read-only zones injection
patch, right?

> +static bool nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *re=
q,
> +                                      bool failed)
> +{
> +    NvmeRwCmd *rw =3D (NvmeRwCmd *)&req->cmd;
> +    NvmeZone *zone;
> +    uint64_t slba, start_wp =3D req->cqe.result64;
> +    uint32_t nlb, zone_idx;
> +    uint8_t zs;
> +
> +    if (rw->opcode !=3D NVME_CMD_WRITE &&
> +        rw->opcode !=3D NVME_CMD_ZONE_APPEND &&
> +        rw->opcode !=3D NVME_CMD_WRITE_ZEROES) {
> +        return false;
> +    }
> +
> +    slba =3D le64_to_cpu(rw->slba);
> +    nlb =3D le16_to_cpu(rw->nlb) + 1;
> +    zone_idx =3D nvme_zone_idx(ns, slba);
> +    assert(zone_idx < ns->num_zones);
> +    zone =3D &ns->zone_array[zone_idx];
> +
> +    if (!failed && zone->w_ptr < start_wp + nlb) {
> +        /*
> +         * A preceding queued write to the zone has failed,
> +         * now this write is not at the WP, fail it too.
> +         */
> +        failed =3D true;
> +    }
> +
> +    if (failed) {
> +        if (zone->w_ptr > start_wp) {
> +            zone->w_ptr =3D start_wp;
> +        }

It is possible (though unlikely) that you already posted the CQE for the
write that moved the WP to w_ptr - and now you are reverting it.  This
looks like a recipe for data corruption to me.

Take this example. I use append, because if you have multiple regular
writes in queue you're screwed anyway.

  w_ptr =3D 0, d.wp =3D 0
  append 1 lba  -> w_ptr =3D 1, start_wp =3D 0, issues aio A
  append 2 lbas -> w_ptr =3D 3, start_wp =3D 1, issues aio B

  aio B success -> d.wp =3D 2 (since you are adding nlb),

Now, I totally do the same. Even though the zone descriptor write
pointer gets "out of sync", it will be reconciled in the absence of
failures and its fair to define that the host cannot expect a consistent
view of the write pointer without quescing I/O.

The problem is if a write then fails:

  aio A fails   -> w_ptr > start_wp (3 > 1), so you revert to w_ptr =3D 1

That looks bad to me. I dont think this is ever reconciled? If another
append then comes in:

  append 1 lba -> w_ptr =3D 2, start_wp =3D 1, issues aio C and overwrites
                                           the second append from before.
  aio C success -> d.wp =3D 3 (but it should be 2)

> @@ -1513,11 +2267,16 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, N=
vmeRequest *req)
>  static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> +    NvmeIdCtrlZoned id =3D {};
> =20
>      trace_pci_nvme_identify_ctrl_csi(c->csi);
> =20
>      if (c->csi =3D=3D NVME_CSI_NVM) {
>          return nvme_rpt_empty_id_struct(n, req);
> +    } else if (c->csi =3D=3D NVME_CSI_ZONED) {
> +        id.zasl =3D n->zasl;

I dont think it should overwrite the zasl value specified by the user.
If the user specified 0, then it should return 0 for zasl here.

> @@ -2310,16 +3086,28 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>              continue;
>          }
>          ns->params.attached =3D false;
> -        switch (ns->params.csi) {
> +        switch (ns->csi) {
>          case NVME_CSI_NVM:
>              if (NVME_CC_CSS(n->bar.cc) =3D=3D CSS_NVM_ONLY ||
>                  NVME_CC_CSS(n->bar.cc) =3D=3D CSS_CSI) {
>                  ns->params.attached =3D true;
>              }
>              break;
> +        case NVME_CSI_ZONED:
> +            if (NVME_CC_CSS(n->bar.cc) =3D=3D CSS_CSI) {
> +                ns->params.attached =3D true;
> +            }
> +            break;
>          }
>      }
> =20
> +    if (!n->zasl_bs) {
> +        assert(n->params.mdts);

A value of 0 for MDTS is perfectly valid.

> @@ -2382,10 +3170,11 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr of=
fset, uint64_t data,
>                  case CSS_NVM_ONLY:
>                      trace_pci_nvme_css_nvm_cset_selected_by_host(data &
>                                                                   0xfffff=
fff);
> -                    break;
> +                break;

Spurious misaligned break here.

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9xvjAACgkQTeGvMW1P
DemYcQf+Pmx2UaDDAHbw+1UlXUPteSSCOIsYjw9JnGqbsw1AaaI0cVrq/AkWDfdK
KXUSNfDssDwwDLGMHjxGQN8nQcTFXF3RQ0xcxjHlDkR9nzWw3PGVA8f0y/WGg2hF
gYNJ+UuJu7HB6EFUcDaBUPx+wNC+NW/a4zj2wWmc79NBL4ZjbqBGTr9dlVvLeRSq
9DSahMo1RX12aGwjyqzPnMli0hizhGT7kRVs7f5U+gqPz+NmI0N4y3bocqMNGF35
bAFbAMkC17yirLkZgO3RVJX2aAufT7DIlAAplcu3lkOlvTbxugQ+jnXm2Oc6NhSq
v0jIPCqvrRUdDamDl8l3Mc8kU+69iw==
=acaF
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--

