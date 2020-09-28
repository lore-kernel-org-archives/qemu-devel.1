Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45978C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 06:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995FB23119
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 06:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995FB23119
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMmy3-0003SN-Af
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 02:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kMmtv-0002QS-1p; Mon, 28 Sep 2020 02:44:43 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:58265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kMmtq-0001SX-IY; Mon, 28 Sep 2020 02:44:42 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 9D1765801DA;
 Mon, 28 Sep 2020 02:44:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Mon, 28 Sep 2020 02:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=0REE54PKNGGn0ZEWlvffak9GQgj
 3rccrULRr8yJMrW8=; b=enuPnkSy5/+vTOj9qFfNikMtry5JCz2kOMwPE7/eKFz
 t55+H9dGUDwoxx5tzKPapvqdZsBygOEHFhA3r3plJYiq/ZccOJXoANMrV13UsPhh
 vK3w+tmphj888+Up3fkSqj6YeJIA3J0OfTaIYsRdn6cTx5b894l4teLvg7T6ifwW
 Eji90jaVhXTswCzYNkKvJcQUWFbQZGk4COceNFpetZoM2lwwl6M52gJV5+2xDrne
 fMqZXErLIKoFsD/r7m8XoAKOKRAaJHTr2EfdV24XdXQs+Nj6b4Q5DSlfUYVjZJ4Q
 tkJDJm2dL9BQeE2qv2Ef/nuN7WMC0bWmLeRWg3mmEJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0REE54
 PKNGGn0ZEWlvffak9GQgj3rccrULRr8yJMrW8=; b=uGUAnGg1nnfj22QgWhCI/n
 odkl1sUDOpvHcLzO16BNBwZEpZMizCHTqn2KmxONFvnU36tnCUU9ETOUhLTiavDe
 KGZ3cuVbenfZchUpVzun0c5BHZT5CwKmt7FD4c3eSEVZAbRaG1EG6mOG1s2q96OH
 RpUQa2Q4BwX4jw9/zObh3EhYJNUDsK8s9VNAZGx6M7vRhp15AzLx1fKWvlcNIRfa
 Z3Gg/IaLrAdsVbbC9dgwjh6/I4osNSKHUxaaYSXsDVhEJEkGnyNsVgDoeaCDlXW1
 AYxV6IA05/EHzf1YyJB/NjL1H/2vSd8pp+XEV82zToo4sVgfkLg5WxFHmVlzdx8g
 ==
X-ME-Sender: <xms:VIZxXzqGyvw3Mu4aNmPHZMPTuaLwZxznoprXVQgiIZonJ683pTs8NQ>
 <xme:VIZxX9peQegeh_9pHmIrl52Vw7J9dmaeMOaOH-UVR6D5zC8L-H6JTla1Ycfwc0L4c
 ZutDVmpOCvuNsB60ck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehgdduuddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:VIZxXwOXZROjqXRzy7djXJn6LZOr03Fwz8dPJTZ2G96uOlDKQZcLMQ>
 <xmx:VIZxX25qlZ0qCfz-3EJQrpqqcSf51_54fAjJv47bycMkRsru7qmHrQ>
 <xmx:VIZxXy7p6BM3diaNQaObsbTR5vtaonWTxM0ATM-s5vFxOfKHQqNs7w>
 <xmx:VYZxX6hVb88oB-PgzQVJJInDVtShpLhK2jQLXOzlNVszxSg1Rjc2qjrgdJA>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id DCAEB328005D;
 Mon, 28 Sep 2020 02:44:34 -0400 (EDT)
Date: Mon, 28 Sep 2020 08:44:32 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20200928064432.GB1967@apples.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-10-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20200928023528.15260-10-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 02:36:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


--24zk1gE8NUlDmwG9
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
> diff --git a/block/nvme.c b/block/nvme.c
> index 05485fdd11..7a513c9a17 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -1040,18 +1318,468 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest=
 *req)
>          goto invalid;
>      }
> =20
> +    if (ns->params.zoned) {
> +        zone_idx =3D nvme_zone_idx(ns, slba);
> +        assert(zone_idx < ns->num_zones);
> +        zone =3D &ns->zone_array[zone_idx];
> +
> +        if (is_write) {
> +            status =3D nvme_check_zone_write(zone, slba, nlb);
> +            if (status !=3D NVME_SUCCESS) {
> +                trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
> +                goto invalid;
> +            }
> +
> +            assert(nvme_wp_is_valid(zone));
> +            if (append) {
> +                if (unlikely(slba !=3D zone->d.zslba)) {
> +                    trace_pci_nvme_err_append_not_at_start(slba, zone->d=
=2Ezslba);
> +                    status =3D NVME_ZONE_INVALID_WRITE | NVME_DNR;
> +                    goto invalid;
> +                }
> +                if (data_size > (n->page_size << n->zasl)) {
> +                    trace_pci_nvme_err_append_too_large(slba, nlb, n->za=
sl);
> +                    status =3D NVME_INVALID_FIELD | NVME_DNR;
> +                    goto invalid;
> +                }
> +                slba =3D zone->w_ptr;
> +            } else if (unlikely(slba !=3D zone->w_ptr)) {
> +                trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
> +                                                   zone->w_ptr);
> +                status =3D NVME_ZONE_INVALID_WRITE | NVME_DNR;
> +                goto invalid;
> +            }
> +            req->fill_ofs =3D -1LL;
> +        } else {
> +            status =3D nvme_check_zone_read(ns, zone, slba, nlb);
> +            if (status !=3D NVME_SUCCESS) {
> +                trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
> +                goto invalid;
> +            }
> +
> +            if (slba + nlb > zone->w_ptr) {
> +                /*
> +                 * All or some data is read above the WP. Need to
> +                 * fill out the buffer area that has no backing data
> +                 * with a predefined data pattern (zeros by default)
> +                 */
> +                if (slba >=3D zone->w_ptr) {
> +                    req->fill_ofs =3D 0;
> +                } else {
> +                    req->fill_ofs =3D nvme_l2b(ns, zone->w_ptr - slba);
> +                }
> +                req->fill_len =3D nvme_l2b(ns,
> +                    nvme_zone_rd_boundary(ns, zone) - slba);

OK then. Next edge case.

Now what happens if the read crosses into a partially written zone and
reads above the write pointer in that zone?

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9xhk4ACgkQTeGvMW1P
DekLOwf/UNRKqNQ4BN4BqJI2VQmhtH1+k+hQjiRNGf39wOLwNQH/4AgJUD6/iqpd
S0v6kqHq6VJfbr4Ld6H/X/+J8JLBRvqKmr0m/D6RJQT4pAKI/cA9FObnVBDLx5Hx
4UZUV85mhy4cmuPf++Z9KLDSjiotkNMSU4cxBSOnzENTt40Wq1Rbxxa+4FO+KhS2
+fz6faOu/YyT+qIZXJNvJgP9uPfSS9ueMqrMt+5l53kv+dxArA9LDmGJhTLyR0UJ
VwgCeEb/QSia+lwRKFwUtlI1ugsSlEmq77fvyVteRKyLn/Q9zsMsBvvj5xzf6CQg
JAiItZqqizj+sx1P5WvkEoLF5bV89w==
=UwaT
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

