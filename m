Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E7FC2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3F420770
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3F420770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIGOT-0000lb-GM
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 15:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kIGKo-0006De-UK; Tue, 15 Sep 2020 15:09:46 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kIGKl-0001JZ-Ru; Tue, 15 Sep 2020 15:09:46 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 69B59580428;
 Tue, 15 Sep 2020 15:09:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 15 Sep 2020 15:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=qBxt4ZY+jTJNBMPMhzSIYWC1R6u
 Soosjxdb4d9837sQ=; b=IW5HazdMKFC4/DkVpF+vYolp0KSoWuvcFx9Edu4g8Qj
 9/l3ZosQujMhKiVc/B9Z8o2aM+/s1cWEDoZkIpt8t1ZwOmYYkVgV8QF38iUJvHMO
 wG1Gs4Bxuazk0u2cNDmUAl78l1UwyaTBAyIcyHK5ZlkubAA4kfeKWWElOQBDGzCx
 ykvEAkdrGWz1LO7KzQ+abpELcqRyjttDsV+RPHyEvpeSWlPtx96l0daE28A9skkW
 gTtPirL1xjwDQeY16ehIauRYE24KdvOVZSr3EU8Dv863YUrgejerve1kfxXWCS+1
 5V2CriM7Zzw2UZMkOD/HrNMFxZWfRUpswLyc33bed0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qBxt4Z
 Y+jTJNBMPMhzSIYWC1R6uSoosjxdb4d9837sQ=; b=cwuCiFfIA483i7fTugm5iH
 Eb5p9jzpkn71RGKCjRnQECiXiqZfm6Aw22LgAyi5ijhZ4I6TNQCIuyf+AHpvx0KC
 NuZAyGkmLUK5OsoxzBVZioYzHhgEwmjKHrEnSAVa6/HsPCDEO1Uo4pl3C7R3Pub7
 UfsZHHB84aLLWLs/QNtgu87qDmk14xtpKUVUX1D5KHIxPXYcm8y7FJkV+XVgncxZ
 YplS5dC360TKauEI+S2WX93ncYP1DpGsG8WtHlKB2XTYp3XLyOz6M6WdnQRsBNOY
 BZy4L03KCQmu3ADv8s26D5d5+83lT8b8DmaThdAG5koEuggQedJEMKfPYMbEyTlg
 ==
X-ME-Sender: <xms:cxFhXylG7sJhFqYFDKNMUWSwe2rhD9camueymtvSgMda17junU0dyw>
 <xme:cxFhX53RPpaMzh9Qmpdn-pfTqedD0ZU_GiBiOVRvqPnfAHhYdPzUiWPaRbbMp9zSu
 rWj6DsFEM8BPBN3jI8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtddtgddutdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:cxFhXwqmLsM7xXCWutDtmN33QP4FoSPnxL0zX7a_rqjsZoIbeSiSMg>
 <xmx:cxFhX2kaJQa7fN9S1mq_zmAFu0M4_gEYLE4Jm8asNYT6LQs4zFCP8A>
 <xmx:cxFhXw1ZlpZhr9a_3itvGEZrefa0KjhqZl8t9Ur-L3QDKZ-e79dcLA>
 <xmx:dhFhX1s0MW2SRa6nUEuIpr5cKh4Nm0g7jxuX3GJKnqeuenpICdK6pzyIM5w>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0B5883280060;
 Tue, 15 Sep 2020 15:09:37 -0400 (EDT)
Date: Tue, 15 Sep 2020 21:09:35 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v3 14/15] hw/block/nvme: Use zone metadata file for
 persistence
Message-ID: <20200915190935.GD499689@apples.localdomain>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-15-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <20200913221436.22844-15-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.230; envelope-from=its@irrelevant.dk;
 helo=new4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 15:09:42
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


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 14 07:14, Dmitry Fomichev wrote:
> A ZNS drive that is emulated by this module is currently initialized
> with all zones Empty upon startup. However, actual ZNS SSDs save the
> state and condition of all zones in their internal NVRAM in the event
> of power loss. When such a drive is powered up again, it closes or
> finishes all zones that were open at the moment of shutdown. Besides
> that, the write pointer position as well as the state and condition
> of all zones is preserved across power-downs.
>=20
> This commit adds the capability to have a persistent zone metadata
> to the device. The new optional module property, "zone_file",
> is introduced. If added to the command line, this property specifies
> the name of the file that stores the zone metadata. If "zone_file" is
> omitted, the device will be initialized with all zones empty, the same
> as before.
>=20
> If zone metadata is configured to be persistent, then zone descriptor
> extensions also persist across controller shutdowns.
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

This doesn't build on mingw.

> ---
>  hw/block/nvme.c | 370 +++++++++++++++++++++++++++++++++++++++++++++---
>  hw/block/nvme.h |  37 +++++
>  2 files changed, 386 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index b49ae83dd5..41f4c0dacd 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -3429,7 +3557,188 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeN=
amespace *ns,
>      return 0;
>  }
> =20
> -static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
> +static int nvme_open_zone_file(NvmeCtrl *n, bool *init_meta)
> +{
> +    struct stat statbuf;
> +    size_t fsize;
> +    int ret;
> +
> +    ret =3D stat(n->params.zone_file, &statbuf);
> +    if (ret && errno =3D=3D ENOENT) {
> +        *init_meta =3D true;
> +    } else if (!S_ISREG(statbuf.st_mode)) {
> +        fprintf(stderr, "%s is not a regular file\n", strerror(errno));
> +        return -1;
> +    }
> +
> +    n->zone_file_fd =3D open(n->params.zone_file,
> +                           O_RDWR | O_LARGEFILE | O_BINARY | O_CREAT, 64=
4);

mode is wrong - I think you meant for it to be octal.

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9hEWoACgkQTeGvMW1P
DelbzQf+Pr81abkC8urVZyW3pistjSxLnCgph8S6WI+L1gBS1wnI45qIUjOE1Smy
VeauaURt8oZdL+jQkPWqLQdJgD2hLf340em2ffimAG4rjyR4J2pgMhxeHXSwzRJ0
mMDlfjNPYPMmMhs1RhrHhY4nE51+pCUW63iFgFqpvTvZLZv+qpPgLiEwETYvKMeL
v5jSHJ8KQx8MabfzqSTdKeXaTV2m7eAXhX+Ar/BwXQH8bJtEASSH874kZUzg6WLd
kxM093pfq26TB+K7zmZF1mQAIEjzX1IfY6CqYEqcmAUvsXC9k8p8zVIa3+4TAaOn
/lhaK7/IwwF9m91XzNieJtDFSWT1sA==
=VvBU
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--

