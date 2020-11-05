Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC99C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 06:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6716E2071A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 06:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6716E2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaYwi-0000uB-2R
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 01:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaYtN-00007P-U3; Thu, 05 Nov 2020 01:37:06 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:45755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaYtL-0005fS-Kr; Thu, 05 Nov 2020 01:37:05 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 26A628D9;
 Thu,  5 Nov 2020 01:37:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 05 Nov 2020 01:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=+dFQUmd30StGbeg8y5GCTvWgZuu
 lKuqWfiVc6GsvESk=; b=kNEqNUcvK9zYj1hb65e0BJ3XnHzkQ8jC0HBcWK2uUEi
 pR1BXos9eoCpNJUR8hyvR6hYYuHsrY3PS3FP4OEg2k/pUQvEm8wA6o0rhwJj2UzO
 yJ8Jc8whpC97ZlXbsfxqWT3lngrEANvdLgQV8Xg+f/p0DcCbvTGk/dP/qn5dsRpO
 NvKDb2v1Zo81LAiACkACf0PB8XmiUSOgI1dWDZF8GIDPUZD/JHNURl4ug6wRnWJ1
 WjgO2jRPYCZ4QdMlDql3ejLb+M6zxCBCutU/NsKzRdZGT7SNJ23ZNq397GVVMBwj
 AqAWLWQ4ctkE048NKEPAyjWY7Toh+4gfvXfXK6lAE1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+dFQUm
 d30StGbeg8y5GCTvWgZuulKuqWfiVc6GsvESk=; b=hyjZD9zuTOcbTzfnKCL0Mq
 NqQC7qGW83hNZLkuokBeaBv+EEwE2v9aGYDTzQHrhMqi+pJ98bnlIqq4R4b5NDdk
 P5LjGwWdZVbnl9Q+TWS07qGnoCjQKwmCoBfkKYhf9IcAEV9+eeKBZy8s3BNFYPoT
 tnn1Eymx/f3CDx2/Ol+0/u+whILBhFVkSkG0t7ceY4PofBeIaXowTRz4r6sjiUCM
 ql6HHJsSB4VIv2j1CqiO5Cj+EnGBbFsTy4TfWwMSpf38iEvj9LjEKTc/Poxu9sLv
 DWp5kb+jpIRqhj6wAj4ViIWvRvWvR5LPIcrx91N2azuraI7IkJccOLWsplRPzg2Q
 ==
X-ME-Sender: <xms:ip2jX4h3DIA5SZwpRA4UcUCZkuq75wOSWkdrXu2Od4s5RIYbOFOplw>
 <xme:ip2jXxAxCSLfHcOlndqfIYcNXC2c2uT9kUcbJRSYHzlwQJvaHLFE1r35bWcjU3tf2
 U6EKpwoviRN5Zb7CRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:ip2jXwGcHtJqiDtnyvzwakY2gytrYACdjlyZVSwyYKA7xd2PpreZog>
 <xmx:ip2jX5S-AOvXFkmVFnCpRMg7AqQv5o1i8isJAHg0x_PDLbcybowusg>
 <xmx:ip2jX1zhPf9f80KqNRx3an5ArQdXyWYMDJmnibLQR9pNWi6Z9TPSsw>
 <xmx:i52jX4r2fZA-qGMaRxS8nFrcU3hOptJt_1qKrQXJsmb6ZWlGdWtYS3CLuoc>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9475E306005B;
 Thu,  5 Nov 2020 01:36:56 -0500 (EST)
Date: Thu, 5 Nov 2020 07:36:54 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v9 02/12] hw/block/nvme: Generate namespace UUIDs
Message-ID: <20201105063654.GA95130@apples.localdomain>
References: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
 <20201105025342.9037-3-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20201105025342.9037-3-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:37:01
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Niklas Cassel <niklas.cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov  5 11:53, Dmitry Fomichev wrote:
> In NVMe 1.4, a namespace must report an ID descriptor of UUID type
> if it doesn't support EUI64 or NGUID. Add a new namespace property,
> "uuid", that provides the user the option to either specify the UUID
> explicitly or have a UUID generated automatically every time a
> namespace is initialized.
>=20
> Suggested-by: Klaus Jensen <its@irrelevant.dk>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Klaus Jensen <its@irrelevant.dk>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>

Please use the tag that I originally R-b'ed with:

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+jnYIACgkQTeGvMW1P
DenrywgAqRepc9U+gHQ9gYWXAPOaqvJ6pW/SeuD78G7Et8jJcWJXg1DZfGtyeePw
0ycWZIl721nieTiq2mgERF0gVVtN+XfXFnL63nzStmopwyBK0AjA5/GEOQCBVzUU
1bxCMiTU/w9sAKOBP9nFMlmG5zRdXhQQNpD4xm/yWAha+hOrQ+u2xL73a5b6gNUj
r7Pgpn2z+9dv8Q3DKnlYM8fYYRqs1MZZnai1knqVSX/pCEUKPa7VmORkop9Zqm+t
aT1ZKBY39BcmHT2uR4YAjWR8Zuc9rWrBmEUIF1CdVVkzZhvJccOYNTC7BWyH/anT
P5OajTp6mYXQN+S+52zB3xDtQuzMAA==
=bK6d
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

