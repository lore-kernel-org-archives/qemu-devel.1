Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D753C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 07:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBDE2371F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 07:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBDE2371F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLidl-0002pe-A8
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 03:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLiZq-0000Oz-Nv; Fri, 25 Sep 2020 03:55:34 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:52283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLiZn-0006pU-RD; Fri, 25 Sep 2020 03:55:34 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 7AA5958042E;
 Fri, 25 Sep 2020 03:55:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 25 Sep 2020 03:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=Hd09b1Dke+4Nidz7jQvpkZva1Ey
 hYK6I5jDGOXKWlG8=; b=MTdY1yXp2/o90moVuG6yeQvsJ93Xh6kesT6zKrZJ+v5
 Gtfb5e874kcSgQ00fIQaqaUTNUlk2R3TzYTuJnbsHCwWr8XZzTNF3bgZeqr+ThY+
 mxSpS8+BOLBf5ACPsZQGDehwrfRZgIeJ/EUMWM92FZyPINUULZI4wv/prVExwts9
 eBH7Fzrvf553gyO0yNuxxYG4CmxoxAxOvJAfStq9oMWeFZbYI/tJj8H9uSgu0LOR
 uRvM1IuJUobtQ7RbSI9/Eii+QuElqr2Q7m9msNHBwU+XOOHJwzFgU9nzzoI7zyq6
 EdYjlTQ0PlqUOjNAqNVynPtl+sD2P3TilUxtoERi8+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Hd09b1
 Dke+4Nidz7jQvpkZva1EyhYK6I5jDGOXKWlG8=; b=u6kRJfXYZyciwA22JxeUxD
 U5xe32/7hJjGqlFmKh5s4ZyMzL9kNEvEhlC2VT+I1Y05+RFkxWOUBc68rJ8PGSVD
 hIwaCNO3koRX3ZI9ewLjTeYLLtDtfBZm3DVtdggqm69N3Ur6hvXs2bkQ5ZoY5NLD
 uCMpfLWvT9Geop4IA/DpxH2n4A5rg6j5biWnt8QOzr33Gbrn0tUY+jds7q/gKBl9
 MdVAMmWIu7zwndcCMifHJB4DOShUUC3JuBnn/5UyLRyBdx1AeZclhy69MN3fGkNT
 MzETFKx5QG+TqeW/EM0XiyREL5qInQbpHCnd0eW/NLnzvLZvpyWufibfm94S25JQ
 ==
X-ME-Sender: <xms:cKJtX4H8Fajhf6O2iZZDtRh7EMcQrbWUS7LCPa321-TKWit_UoBFsA>
 <xme:cKJtXxWFGj_fUYpcmMOzEofnxvA5IWMPwTJGsUdFPVla8VMu83_u6hR0xLgl-HPcZ
 8EHIOGb1wcBxx5nmpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelgdduvddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
 ertddtjeenucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgv
 vhgrnhhtrdgukheqnecuggftrfgrthhtvghrnhepleevleduffdtfeegiedtjeeghfduff
 fghfehhffgvdfgffegudfgveefheefleefnecuffhomhgrihhnpehprghttghhvgifrdho
 rhhgnecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:cKJtXyLgl44DPudwaEMsmyG3wSLqB1oXyQTtfDqphuZK6ZonaVzNLw>
 <xmx:cKJtX6FmRIolKMdZLFobCHVMdEs2F8hfSb70XjPqfv2vHc7P5fvL8w>
 <xmx:cKJtX-UcBMqnaOQUa74epsVNDSM6UAy3LvMPEuCq4xOQU6RxEKIXZQ>
 <xmx:caJtXwfmSa_43tZZPgCzu-4Z22W9-cVwdxqm-AHmJseYcvv97IDJsw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B48FE3280060;
 Fri, 25 Sep 2020 03:55:27 -0400 (EDT)
Date: Fri, 25 Sep 2020 09:55:25 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 00/16] hw/block/nvme: zoned namespace command set
Message-ID: <20200925075525.GA1901923@apples.localdomain>
References: <20200924204516.1881843-1-its@irrelevant.dk>
 <160098741693.12744.661899168797123531@66eaa9a8a123>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <160098741693.12744.661899168797123531@66eaa9a8a123>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 03:55:30
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 k.jensen@samsung.com, mreitz@redhat.com, kbusch@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24 15:43, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200924204516.1881843-1-its@irrele=
vant.dk/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Type: series
> Message-id: 20200924204516.1881843-1-its@irrelevant.dk
> Subject: [PATCH 00/16] hw/block/nvme: zoned namespace command set
>=20
> 7/16 Checking commit ab4c119d9d68 (hw/block/nvme: add commands supported =
and effects log page)
> ERROR: Macros with complex values should be enclosed in parenthesis
> #46: FILE: hw/block/nvme.c:131:
> +#define NVME_EFFECTS_NVM_INITIALIZER                   \
> +    [NVME_CMD_FLUSH]            =3D NVME_EFFECTS_CSUPP | \
> +                                  NVME_EFFECTS_LBCC,   \
> +    [NVME_CMD_WRITE]            =3D NVME_EFFECTS_CSUPP | \
> +                                  NVME_EFFECTS_LBCC,   \
> +    [NVME_CMD_READ]             =3D NVME_EFFECTS_CSUPP,  \
> +    [NVME_CMD_WRITE_ZEROES]     =3D NVME_EFFECTS_CSUPP | \
> +                                  NVME_EFFECTS_LBCC
>=20

Pffft. If anyone has a better idea how to make this nice and not too
repetitive in the code, please let me know ;)

> 11/16 Checking commit 6343d89bf734 (hw/block/nvme: add the zone managemen=
t send command)
> WARNING: Block comments use a leading /* on a separate line
> #66: FILE: hw/block/nvme.c:1118:
> +    return __nvme_allocate(ns, slba, nlb, false /* deallocate */);
>=20
> WARNING: Block comments use a leading /* on a separate line
> #77: FILE: hw/block/nvme.c:1129:
> +    return __nvme_allocate(ns, slba, nlb, true /* deallocate */);
>=20
> total: 0 errors, 2 warnings, 704 lines checked
>=20
> Patch 11/16 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

I seem to remember that this has been up before, but doesnt look like a
fix for that has gone into checkpatch.pl.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9tomsACgkQTeGvMW1P
Dek/Rgf9FwLAxE3fxb030pY6psITaxwE8m04AeS2r0CZO5RLD0jFB1hZYI9YlZdz
HQBtimlMjzn/xNTw3R3QbT9NvcJDa13Kl9q07Wa7l+ZiXZ4FRLLFV5eeTD8xqXL6
PLa7AsM5zPMz9/lByQI8eW2ZVyhddx3Q7lhPGYTMgImhWkV5Q2KSJ3axozCEMvmO
4PjHouXssQn9jPYoanhJ+66bgN//boex4x/QmSe2P97gsJ7hbr6I4D+C7Ny3smyR
qfx6WxznckeFYkAjo4wnQb2/jX7V6WBEnZy4TpIt2LjSU1k/9Des7Ptnysalyx9q
QVgK1yE7mimOP92umS6DTtfHURcFmA==
=Im2t
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

