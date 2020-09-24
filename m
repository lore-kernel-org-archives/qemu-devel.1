Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3446C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222CE21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222CE21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLQH3-0004A7-0F
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 08:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLQ7K-0006PO-Cg; Thu, 24 Sep 2020 08:12:54 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:34749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLQ7I-0002Eu-Gv; Thu, 24 Sep 2020 08:12:54 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id 99218885;
 Thu, 24 Sep 2020 08:12:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 08:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=DTu556TEsVfXLKjIb7mT+dYnt0l
 Svscok18FSs8rzaA=; b=e6Q8NJyICxkbeNa64FKz1hQCRiyQSzAklJUgzeKQtP9
 dhToXhs6nbRB+jIyKdK32SF+5Czxyq94VqkqLesDF+pF9U24SAqyHcq4ymCvcW8k
 N3+gfX3bCBahDw/QkmhOvNZe8V9C4cSixBy5pY65qZGRqqtGhzRmUa6rBQm6wLoL
 tOEgNNQyQVrdTtIp+NtRUHiIZcWKf1PxoyxaP8lKs8PxypMUiSYuJh6MnQKmjhu+
 Z3PuQNsDn3I2jDGrasOGxyz76la2vP4N7/MW5TnJ9JPjSm9uMTe9tUqgQhK/Zr7i
 uUkcIG5xLhHpAxdRiq1FLsQy/CKefDrky/BjytTcWMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DTu556
 TEsVfXLKjIb7mT+dYnt0lSvscok18FSs8rzaA=; b=S5V0Om2ysmcfDe/eV8ChSL
 WLskqUVJ0hwoB9ozgNrpTC3JVoGEsPVcHpFZNpUNb2VcXMLRRP0QSomR5bDeoiNq
 o+elTBn7+20FXPw11s78js7EwJCq6bsf9dwhFK9AV82syKVD7Bl7qEiboHJYdthc
 LJlyie8AewgvVM0touyyEJ/kN5b7FyvdesFcGiIaQPt8HD5mML5jcskSn5sKO9ZO
 nbXQCaepaGD+TMkTi8aqXKKxqo42oL1isUQak1RmukXnKmWqZorpH9w3PlNhPVyt
 I0pTQGctXz8tF88UpdyAh6avAlVA/CndLVcbGjqXOy9j2DDBNpeGCQE+9XmSzyUg
 ==
X-ME-Sender: <xms:QI1sX0TsyiEGPdaYH1TKxu9x5ciPUJXo6p5T00DoGWR2B_8S8HhJUg>
 <xme:QI1sXxzNUcLI0Q6HjQo6t6bvKaY4ZgZmpJcFGxQcX14raCc_i378BWP1OBbepo774
 xMdGRHUMHOWL3FcJdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdehudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:QI1sXx3VS5C_nF0TcbLi2ZdGeMIrPQbyrglfdEBWPxQQ_gjTpOMqtg>
 <xmx:QI1sX4A3YXOg5XpM0BCL8VKJlWp8fUtG-i1Nf8LQ1RHsOA7BJusUAQ>
 <xmx:QI1sX9hlhd5UltZi_C1VtpHarC9Umo1-UGUlE-mlGu_lNLM_8rmYlg>
 <xmx:QI1sX4oCRjtdefuMFOGKGK8zULdqqQiTu-VhcZzyWZPyUmm0ymo9yivIYxb1U4JT>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 002A7328005D;
 Thu, 24 Sep 2020 08:12:46 -0400 (EDT)
Date: Thu, 24 Sep 2020 14:12:45 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v4 01/14] hw/block/nvme: Report actual LBA data shift in
 LBAF
Message-ID: <20200924121245.GB1738917@apples.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200923182021.3724-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <20200923182021.3724-2-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.18; envelope-from=its@irrelevant.dk;
 helo=wnew4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 08:12:11
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


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24 03:20, Dmitry Fomichev wrote:
> Calculate the data shift value to report based on the set value of
> logical_block_size device property.
>=20
> In the process, use a local variable to calculate the LBA format
> index instead of the hardcoded value 0. This makes the code more
> readable and it will make it easier to add support for multiple LBA
> formats in the future.
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Yeah, using the standard approach of the logical_block_size parameter is
probably preferable to an 'lbads' parameter as I've been doing.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9sjTsACgkQTeGvMW1P
Dek6iwf+NzRtMYCDSfVtDHo/MDjps8kV9eVTeaaWA5mpgEkGd0HCcfUf8R7EL56G
Hw07UHnPFmCcaNRMw35MNI+W0GUH4PTu92DGZg1qeXlE/x2YdH6XxDgnyKqfyvjD
7GuQMxRQRpSHldSBCxSBSS9vI1UpU3UtlwWIZesalzBqoEiCFNNoGD1WEftQWKkZ
F91Yr0zo6HWjB11b9LwpDW+fFxUVbl9tdPd3gMAqLIC4bugxlUxod8/AXwH3fXZN
HIIDQBmCoF0Gb52UxRTxK64/eL5La9oyIua2Mos4VzervwuuSiw1RI7IYt9KQARk
oxBq+ea2ha49HXLctVz8i9V1KzLyZw==
=tcCY
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

