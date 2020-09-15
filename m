Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530D5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D93B21D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D93B21D1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI5aK-0000XS-Dl
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 03:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kI5Wp-0007vU-Jy; Tue, 15 Sep 2020 03:37:27 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kI5Wn-0005jT-Vk; Tue, 15 Sep 2020 03:37:27 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id EDD145802F0;
 Tue, 15 Sep 2020 03:37:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 15 Sep 2020 03:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=vHOJZr8OxVRwZ7xNHg0YrKeQ6kH
 XM123TxkB2lzmmwI=; b=LTRHPB+QxNrfrifWRwD6MM+vEFbsiZA0bY91Dp8mIFg
 /vz4FDpvpbXHrJR4nta2NDLgtOQeIM1LfLE2uWleOBrwhl5ZQKBGP91Ez5O9kvpv
 unhHoFidFZmuiSp+VfTzOJiCfNi1CEU09uqPrjU/3CJJI12Sh3WixAdm97D65i9V
 bI1QZTkonrg+8KZ2zLbAktyAy0xngc8CeWVj225DgJIOdFx/laruLRnzbgDt5mWX
 S6dkU1Bxhk8B5t/6qExpxm3Z2gHkymt2O5nGSjMQp6K6BHpSBdvRw4wF/BoAM9bI
 f1CXtR4OeRwr1sXa4+ZStvm23lz/yOpC5Muwm+Cn0Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=vHOJZr
 8OxVRwZ7xNHg0YrKeQ6kHXM123TxkB2lzmmwI=; b=JN07/LEmmDFf2najy2kLoe
 Gyi/eUpiBStjmK8Ov7g8uMpqSPOWPcmBbsxQVX/zZ5Yoz/6ysr+faK98aNYIJo1H
 buf7WMbbSi66y1nRE5QcXYSWRWnvHa8B1qzOwSoGFRUxx1m4KkizMX37V1uf8rS1
 4AvXR2enNCpXmOQpouOn4QOj+IzTqe9W9XwoW7I9sNqPRdQWK5mDhl2DugUXsxDE
 IL7k053v6G2wIS+ru5bV2A16DS6ztqqRDfn1Be8FRgz7diAJQCXhwm4y5WbDQZGw
 TMF9EBf3HHVAPXlxkgWl09RHT/OZV+JpWvJQ6UuKD9aGTSLHgmv76TwcHsAdX4dg
 ==
X-ME-Sender: <xms:NG9gX0LYCFfjHgwWIUxdJHW9mlQY5hmzMsVzDokS8fr5TknQCwwmFw>
 <xme:NG9gX0J83eHnH389pYwc8-BY2usELascg2EszMixFB-sRdBaOw1fzqshGaID64mqC
 3hy_TW-cdtJBbZObqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudeijedguddukecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvddu
 ffeknecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:NG9gX0uMKemDXytjx-cTuPA1Bm49LYgULgDEJ0y95FUFOF_jE1rw-g>
 <xmx:NG9gXxaKwz7Oep-f8F3_OgqM1NdOREMublq-lUR8hNoV8RQU7Q8Gwg>
 <xmx:NG9gX7ZT3QMrfOHk19MvR5FHGMlDPWY6WW4ZMswCR6h0Z4TYIHCNtA>
 <xmx:NG9gX5CrsXWq2hkKJDpE8_vM1d1K1ZxH1O4v3spmVSBD18ylhPhddmnkxCY>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6C712306468E;
 Tue, 15 Sep 2020 03:37:22 -0400 (EDT)
Date: Tue, 15 Sep 2020 09:37:20 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
Message-ID: <20200915073720.GB499689@apples.localdomain>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20200913221436.22844-2-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:34:26
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


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 14 07:14, Dmitry Fomichev wrote:
> From: Ajay Joshi <ajay.joshi@wdc.com>
>=20
> A new write command, Zone Append, is added as a part of Zoned
> Namespace Command Set. Upon successful completion of this command,
> the controller returns the start LBA of the performed write operation
> in cqe.result field. Therefore, the maximum size of this variable
> needs to be changed from 32 to 64 bit, consuming the reserved 32 bit
> field that follows the result in CQE struct. Since the existing
> commands are expected to return a 32 bit LE value, two separate
> variables, result32 and result64, are now kept in a union.
>=20
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

I know that I R-b'ed this, but can this be moved to the namespace types
patch, since that is the TP that changes this.

Also, I don't think we should touch the tracing in the block driver
since it is not aware of namespace types.


--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9gby0ACgkQTeGvMW1P
DenWkAf5ARrSy8s/+AGHgklUe2zirLJYFtZvEdcSS/xYxCMZVIPFAH8sxNjI4yZd
v9UDwAdxDNwoKwYFz9FiMxFSjYpMYkgd5KuSJkCBdr8iVfb/9HlD9/0soYGPaut1
sKVLHpZbXcoC2+B6pgghUj0kkKSPJP/Pfo3f/dZ7JBKDobOW4HMqbIedy+qZTNlw
bh520KDzAHmF1zDBOPAEHBjnwI2tklunLxm+C3kJgrTWCG1ToET+nFDgL9uE2ciH
EIZu7UWIacaUH0jr1ILRx2Xxk0kwe/Huku/PmAf4WtOew4BAx7itRWWbchU+Rvcw
sihRwbQa/2FAC3KEw9VRfB7bh8zvGw==
=5LHm
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--

