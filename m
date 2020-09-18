Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD4C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFCF2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFCF2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJO2w-0004MS-Ul
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJNxL-0001if-4p; Fri, 18 Sep 2020 17:30:11 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJNxF-0002f5-F9; Fri, 18 Sep 2020 17:30:10 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 439ED580242;
 Fri, 18 Sep 2020 17:30:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 17:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=Ugdk6H/9UoK8j7I3G5k3zcMm5fL
 OFUCrws2sQckAm8I=; b=PccwuvR/c0hwoQDgmMwGy0WaTyVgPqaE1r5XqaYPVB7
 beIA/Lytb6CBfIx8JKMNzeFWmAw3mF/6g0XgcXRXbvWL5zMqGHNMLgpq1inkWrl5
 0t3giRKzta7JryjRXSgkiUdrMCaPdVqKIzb2syd/3SU26E1fft0oaU4Jwpnkg5B5
 pnPwqvQyS9OwfoWBOQO364nLa+JLvhxNsyIvrg25myWz/UajsGuVlWNfR84DwyT0
 h297jDUXtppwuI7VyP3qFVg5Guufzq92sBGwLfimCT+VeLB/86ISXDFR/9zc8EEJ
 DvQk8k3yTg06Uri/iZgZCQ3OXtUmLDraUOgJED5OJDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Ugdk6H
 /9UoK8j7I3G5k3zcMm5fLOFUCrws2sQckAm8I=; b=cVa4ODl+Zxby8btlj34qwt
 R5Nizbhp+Yel0kXZYq6xfnq8AggN2jnrf7CxOIJyd+iWtRq+w8qUOob477PkKY0l
 Kt/TfcOtavZqty7TXxORybdL2/YhUwiC9EgbYYVhrUuw2B+4MJd6O5O+I0TzoD+A
 Fhy/VT1ZH4N75R7li2K1rpGcj5tk2wG/bkXmF6d7HFbCkKuLv/JbBeDnGF3rl/4/
 +isF/fYht/zViDCzYbXHQ9VENCjoqJtAHPTUefynrhb3PWXkPHXPoDr4LFgeZ/Vx
 d/oEu1NDdsaQ/g8XcMKiSaBKH+A9rPBtW2TXLIza4LnRznomnUW6B6X8xFP1qpjg
 ==
X-ME-Sender: <xms:2yZlX7lPLhPI0Xggy1mviOeQs2XJCsJLRyVh7XAhVMKyMX4zuUkxLQ>
 <xme:2yZlX-1D2vpF_3oKTri-NXG0fMMH4OFv09JkIlovwUyZynoxTBzzrGxTffr9zhtp1
 V4Q9VC7JfhgC1FkvtM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduiedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:2yZlXxoy0gOoXyV-Y6ivBhIaTzuKC2k3REtWnfnfiKxdQ330tReJ9w>
 <xmx:2yZlXzkdXnoEODJq4qMsBq5oceZ38it5k-9xvT5lMk8J6KMLdHyJqw>
 <xmx:2yZlX51rI0O4MmpMdue8D44RF4r4d_a5xSHbAYHoRa0xDOmczJ74RQ>
 <xmx:3CZlX6vvD81fiPqE-lyaXW4ZMkz74BMOEs2UyZZTExUTW5hmiWeRz08vyfY>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 306B43280060;
 Fri, 18 Sep 2020 17:30:01 -0400 (EDT)
Date: Fri, 18 Sep 2020 23:29:59 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v3 06/15] hw/block/nvme: Add support for Namespace Types
Message-ID: <20200918212959.GB581752@apples.localdomain>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-7-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20200913221436.22844-7-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:36:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 14 07:14, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Namespace Types introduce a new command set, "I/O Command Sets",
> that allows the host to retrieve the command sets associated with
> a namespace. Introduce support for the command set and enable
> detection for the NVM Command Set.
>=20
> The new workflows for identify commands rely heavily on zero-filled
> identify structs. E.g., certain CNS commands are defined to return
> a zero-filled identify struct when an inactive namespace NSID
> is supplied.
>=20
> Add a helper function in order to avoid code duplication when
> reporting zero-filled identify structures.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c | 235 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 215 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 4bd88f4046..d01c1c1e06 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -595,6 +595,33 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n=
, NvmeNamespace *ns,
>      return NVME_SUCCESS;
>  }
> =20
> +static void nvme_fill_data(QEMUSGList *qsg, QEMUIOVector *iov,
> +                           uint64_t offset, uint8_t pattern)
> +{
> +    ScatterGatherEntry *entry;
> +    uint32_t len, ent_len;
> +
> +    if (qsg->nsg > 0) {
> +        entry =3D qsg->sg;
> +        for (len =3D qsg->size; len > 0; len -=3D ent_len) {
> +            ent_len =3D MIN(len, entry->len);
> +            if (offset > ent_len) {
> +                offset -=3D ent_len;
> +            } else if (offset !=3D 0) {
> +                dma_memory_set(qsg->as, entry->base + offset,
> +                               pattern, ent_len - offset);
> +                offset =3D 0;
> +            } else {
> +                dma_memory_set(qsg->as, entry->base, pattern, ent_len);
> +            }
> +            entry++;
> +        }
> +    } else if (iov->iov) {
> +        qemu_iovec_memset(iov, offset, pattern,
> +                          iov_size(iov->iov, iov->niov) - offset);
> +    }
> +}
> +
>  static void nvme_rw_cb(void *opaque, int ret)
>  {
>      NvmeRequest *req =3D opaque;
> @@ -1153,6 +1180,19 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRe=
quest *req)
>      return NVME_SUCCESS;
>  }
> =20
> +static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl *n, uint64_t prp1,
> +                                         uint64_t prp2, NvmeRequest *req)
> +{
> +    uint16_t status;
> +
> +    status =3D nvme_map_prp(n, prp1, prp2, NVME_IDENTIFY_DATA_SIZE, req);
> +    if (status) {
> +        return status;
> +    }
> +    nvme_fill_data(&req->qsg, &req->iov, 0, 0);
> +    return NVME_SUCCESS;
> +}
> +

Instead of doing the filling, why not just directly call nvme_dma_prp
with an empty NvmeIdCtrl/NvmeIdNs stack allocated variable?

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9lJtQACgkQTeGvMW1P
Dekhswf+KPuyjWaPyKgirJiyyGVgylGmu6mZHCytubSKisPhpUGo0sjtS36IocIY
45j6fAFaSQN4B9VdWbx0YH1e7OkqE+QuUgRVrNAxXCTspvmT+oyak8ZkAxZ1weCL
x+FKiDs8tA2UjnjXsKxwoW53uKdNxTwFgz4yjszb4D5Bev2I9hvuTysWb/xsn127
21bcKVWS1o2cH9WcwY3da57dYRg8qjQ7Q8p18HD2flrhGgruD7T6gMRU25Avzwsu
t4uvK13nfhFzIBmR4BUwqTpttDdwusIE3uAGi7MwUBn/K/rCjN8j97RWeX+ZL7/l
LUSOEr0czv+NKzFj6MSE/G5BuUhzaw==
=UCwl
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

