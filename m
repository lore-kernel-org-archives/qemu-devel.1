Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64781C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824D820878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824D820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLsSF-0007uT-5N
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLsOg-0007Cw-He; Fri, 25 Sep 2020 14:24:42 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:39047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLsOe-000611-2C; Fri, 25 Sep 2020 14:24:42 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id 9D960608;
 Fri, 25 Sep 2020 14:24:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 25 Sep 2020 14:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=t/yIuFHq+Ay9ZnSepNAhjmPFwAg
 HF5ZAin62AJsvyEU=; b=p/Reka1arJ23v5Z6Oc8CtGdQBi8nds06tttdr1XhwqU
 4FCIkikJM+BV1bvXALfV1YvDbD58f8kiHgMnd9Pv/L0XaxhRPpko1H2FCfKTpV61
 ljQ/yIo4gz+xCmJpNA+KhjYU28MjPSAxT20p1sYieLxlQQHmu/wMwM7FFuvRdXj0
 dlDjztgdpM0Aqb2hItJeCqNe4791pkekkka9xlowZWdeUXc0rc/jZncL53mXkrAb
 yt27y6JFT/2srqcX9Y9qZQx1fbTgSp7YFulue+k+kluvtBFPMkaCMIwmubhOJmQq
 JIuRHPtiYl/L6sP+5Nyk1A2f6vAamkZcJdMivfzXbtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=t/yIuF
 Hq+Ay9ZnSepNAhjmPFwAgHF5ZAin62AJsvyEU=; b=HSEYl9w5JaWz364qMTS89/
 sHOeDm0mN0Hfk/0b7tiGTjeqRXlPa+VneEO76CiUBXjSeMwLkG54RlxGTcNjLX9s
 LzEB51AuwFB/AXBu5A+f7fAyXMpYHpfcOtnqHpBDHhH/o4ZMRvE6UmZ7+S1WqnvZ
 jHkLiZRg+mXAdLiT1JRZrHJ2G48wKTzvUi7Lgmt3IylnNq0s2ANsGmoT4FR8a5ft
 odHZ5Ah8S8OPGXBRSxx/Frbd+gwwgPuDbK/xnJNgHvaEfVahbXi02pE8jEn4z38r
 TWlPAMl5ViCf+JceyKGEsz67VZ/vRLTju/EiOG/L3Rp558M6qUSPj9IngMZYdjXQ
 ==
X-ME-Sender: <xms:4DVuXzcVVI1FZptKH4oI0eW2sitAWBUUKT6fMUPtZPCUp8tTUxb1Cg>
 <xme:4DVuX5OOhkBHqxmJ50kuPKlDPPgKRs_umesAOxMh_jcC3ga8HeeEsYkS5GnIkAo2g
 Amup_eDTOPjPbIy1dk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtgdduvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:4DVuX8geRz4bN3UkdF3PdN0ADrjupT_VRi8J_hU796vr-2BmrRt_vw>
 <xmx:4DVuX083M397vu5lmyr0KbE-To3XPozTyE-lKM-xWRnK-Hd1yMLn3A>
 <xmx:4DVuX_tKl-ezWvdXoPKK-WGjYvQtB27GbkNemaABz1PCTnwm8-ddqw>
 <xmx:4jVuXzFMtm4UVXhIl2OzBSCHcQDp_KpCwHs95nzCqNYT6eLdKGZjj-ybmeA1eqho>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id BA0AF306467E;
 Fri, 25 Sep 2020 14:24:30 -0400 (EDT)
Date: Fri, 25 Sep 2020 20:24:25 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v4 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20200925182349.GA1933223@apples.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200923182021.3724-10-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20200923182021.3724-10-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.26; envelope-from=its@irrelevant.dk;
 helo=wnew1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 14:24:37
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


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24 03:20, Dmitry Fomichev wrote:
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
>  block/nvme.c         |    2 +-
>  hw/block/nvme.c      | 1057 ++++++++++++++++++++++++++++++++++++++++--
>  include/block/nvme.h |    6 +-
>  3 files changed, 1026 insertions(+), 39 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 05485fdd11..7a513c9a17 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -682,11 +1005,77 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *=
req)
>          return status;
>      }
> =20
> +    if (n->params.zoned) {
> +        zone_idx =3D nvme_zone_idx(n, slba);
> +        assert(zone_idx < n->num_zones);
> +        zone =3D &ns->zone_array[zone_idx];
> +
> +        if (is_write) {
> +            status =3D nvme_check_zone_write(zone, slba, nlb);
> +            if (status !=3D NVME_SUCCESS) {
> +                trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
> +                return status | NVME_DNR;
> +            }
> +
> +            assert(nvme_wp_is_valid(zone));
> +            if (append) {
> +                if (unlikely(slba !=3D zone->d.zslba)) {
> +                    trace_pci_nvme_err_append_not_at_start(slba, zone->d=
=2Ezslba);
> +                    return NVME_ZONE_INVALID_WRITE | NVME_DNR;
> +                }
> +                if (data_size > (n->page_size << n->zasl)) {
> +                    trace_pci_nvme_err_append_too_large(slba, nlb, n->za=
sl);
> +                    return NVME_INVALID_FIELD | NVME_DNR;
> +                }
> +                slba =3D zone->w_ptr;
> +            } else if (unlikely(slba !=3D zone->w_ptr)) {
> +                trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
> +                                                   zone->w_ptr);
> +                return NVME_ZONE_INVALID_WRITE | NVME_DNR;
> +            }
> +            req->fill_ofs =3D -1LL;
> +        } else {
> +            status =3D nvme_check_zone_read(n, zone, slba, nlb,
> +                                          n->params.cross_zone_read);
> +            if (status !=3D NVME_SUCCESS) {
> +                trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
> +                return status | NVME_DNR;
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
> +                    req->fill_ofs =3D ((zone->w_ptr - slba) << data_shif=
t);
> +                }

If Read Across Zone Boundaries is enabled and the read in zone A
includes LBAs above the write pointer, but crossing into a full zone
(zone B), then you are gonna overwrite the valid data in zone B with the
fill pattern.

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9uNdgACgkQTeGvMW1P
Del2Agf7BfLKjafkQbsIpOqE8hkrnkp3NQu1btrXce97MZiJMTYEggpTbFCtzL3H
3ZrmpnIhUWIDva+M3PKnjhrdWfRcI4wMma+wo7z1k5A9NyeUYsQfM2D9fFugjrSQ
gE+ggb4v5shBz2DKbS1uK6mCH29ZjioG+s8oXauwdCEJp3sDgX/C+JpJ86V3APl8
W8C89e217Dm63Vx4bqk9zzqr16omUzAWJh5PZBtpNo1NDj+M6jjz3Y5LAZrzny7B
Nn/XAq36+LpcVglUt2j/awxRXE4M116bINHOA0gA2NE24OihzmhvIeloxDHB+7O7
CtHbC/57DyyFeU0wA2l+KSBglsJYyw==
=2zoS
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--

