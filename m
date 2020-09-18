Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B61C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5254D20795
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5254D20795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOad-0007w9-4W
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJNnn-0003gz-4U; Fri, 18 Sep 2020 17:20:20 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJNnj-0001NK-MA; Fri, 18 Sep 2020 17:20:18 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 6750F5801ED;
 Fri, 18 Sep 2020 17:20:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 17:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=BKtX63HZuxZseAmwXeoUJyx65o7
 8utr9hQ+xhH3vB6s=; b=UwR1xKJZAPkNBMqQ15i4uaOIxZ+0zy4TxR2as9QHyh2
 QmcKyZiSxzn1f0hCFP27Pg1lRYcDq5nqQscmhE2X72LbNoaATD+NfPD7/axBTxRU
 0gWb+8ajylvwjylwZ4JWD52JNayrgljP7jqFQQISjENLJCM1JzcU8yBiJHvGq+to
 eYu7zzSmjFgblkZkY4qvRZRL1+WYObj58p9bmoSREuKa18WJuxABXeWb17RK5cAZ
 An4UsrzNdT+FyJhwadOYEN08IQRlzA8EoQf/3HosACtVyZd8Yd7KbXL57YJto+R8
 1BmH9yqvS7039bNWOrGghKpl4pda3W2PUzR/SFE+lCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=BKtX63
 HZuxZseAmwXeoUJyx65o78utr9hQ+xhH3vB6s=; b=tL3fqDNtI5j7XlFIhT9TIw
 EiDcmZZZXhB87xE3Lbdj+jAyiAg7KT1ABK8kmJkPCqKoqxwsOJfVgEptJ4jCy1RA
 LUm4gMd3TfNozFPKFwJhSCUpPXYKJzAixtgnFvCJqcaTzcozhp1Sqa6jrPnLdClP
 zRfFiJrIfKOfOJybERXorQTHJnHeH1zKgOxwkord6JNtGlL9zhIUVzv5n8nF1SLp
 3ecHEUaEvDsxyMoyOb+msCsIisIVR+2yHlEi/0A4hrTSHJqzOdTNEyJZr/ihF2ow
 lPP6LDytM7eisMPZz7m9cPi37nMkPVNbsX+o9+tXkjiFl/ra+C943dXb6tooJMew
 ==
X-ME-Sender: <xms:iyRlX9zylKSjxXo2oun-8cVjX1U-eK8JzZATtvcRCkZhAxjQFRXtkg>
 <xme:iyRlX9QrY9g2yn0U2q71dyIx3rrV-J27hW4zKb4fAgdvraglwjN8yjb92s9aod9Wk
 _SXjYt5DC7oKy9vVmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduiedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:jCRlX3V5anIeqIBhn2o39bDyiOUQFU9DV0-o_oBQ88yvvtQozoHUPA>
 <xmx:jCRlX_hANBNtLpyRuf_WFeYIzu8V3W8ZFJ4BSjVuA5xVpQbQZyk0mw>
 <xmx:jCRlX_A9glCFuRhTGJvvgFNbxl0ee9Biq_WzxXS_em36nbEGese1FQ>
 <xmx:jiRlX8KSHEwaD09WW7fd4B7MpUMeVdB9OW96FRhw0TUzpEvn02upIxVjtD0>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2D84A3064674;
 Fri, 18 Sep 2020 17:20:10 -0400 (EDT)
Date: Fri, 18 Sep 2020 23:20:08 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v3 10/15] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20200918212008.GA581752@apples.localdomain>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-11-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20200913221436.22844-11-dmitry.fomichev@wdc.com>
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


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 14 07:14, Dmitry Fomichev wrote:
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
>  hw/block/nvme.c | 968 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 939 insertions(+), 29 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index c740cbcf1f..0bf7471815 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -709,11 +965,77 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *r=
eq)
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
> +                slba =3D zone->d.wp;

Your append is broken.

Since you moved the write pointer update to post aio completion (which I
totally agree with), you are now assigning the same SLBA to all appends
that are in queue when nvme_process_sq is invoked.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9lJIUACgkQTeGvMW1P
DelZagf+O++Bz+Noa5XUcqCh5AjiqwsaKyd4zgz2m5ABWrw71eyZG/UPAEhYjXfD
zNXGa5a45qU4NHyYr9twlbsu3oQ5eZkvpLBnnWRjjhcc5CnhPGFKJ227AKmqIBXj
DDxYmh8irpZshR0HTCY5erhqkal9u2flfgZFVuz/8GWzh16lqLbKIHkS0kDtytGl
dQ4JQ8Mg5mV9E86NuMDGz3y0vMaIUaG1XUHqpEP6U9NfTy4nAP7+G36WWpwDLWFE
cFwDqzKdeFbYeuGRRfs/zmQhAKzkQ/FzhwzlnKMj9IQa3bzWP+VKRJUxqYdVskYK
r8GhRTGLvecKC6RfCLnaUpNkbFUDMQ==
=VCmd
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

