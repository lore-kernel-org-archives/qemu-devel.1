Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BDBC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3631E207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3631E207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFhM-00075e-3o
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFFbs-0008Fk-GP; Mon, 07 Sep 2020 07:46:56 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:52419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFFbq-00042K-0x; Mon, 07 Sep 2020 07:46:56 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id 8A1F8B54;
 Mon,  7 Sep 2020 07:46:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 07 Sep 2020 07:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=yI98meNgXpSXP6oYF6Pj/O94m9Y
 DRygprgitjLkmenA=; b=nL3OKerMBqTnr5+qmSWmhTp3GrdYYfRN5c2PyqwhM9L
 Gw1OtRRNbgaIHJpXm7aLcJvZ0I1ZVQbdgZKeuSHZgU53zaS93iDu1JrH3Vv+WJAq
 Ko4QC8dvdSswkNm73Ec8af6yDqfGve7j6agTpj4lEpgSaTM1h8SPnkzKoMW3M0AI
 Zlu7DdKREdyBhJd85RP86fPiKal2yuQtXQqeI/y+rvytZvLQbBG2nvtoXttMdI7m
 VVBqDj3X64WWGXrV/m+BFWroavYmai0aAZW4nkQvt3FUoZJXqd5wSSzRNLxLCq3V
 dc0j8ChEdfJ9kJrFq3INAWy4B34eUEy6A5d5ko4Xh+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=yI98me
 NgXpSXP6oYF6Pj/O94m9YDRygprgitjLkmenA=; b=JMd8as1KUYGCiEMyfSRDPJ
 z3A9M0QfFgY7nicrtzjirJoewCL3uaZg+QxUo5nAnDEYTK14Sj+F27kqdc4Ti957
 WMm8LoLNtCD0kTOrkhah8kdiwspwYen13Yj1hMV012yMNzp2wUDzyH9vXpABmJy2
 b5BC29QQ1tLoCfQqiIYLEGivV20IIWUIjR7QcvgGE0aVhGJWitw1DfPlAy4IJwNI
 NQA/3xoVt0nMx4Gc4r2gIPK8FL7j6rdLA4GnqMS2fPoAsGmeRgAW9Gi+W732hBXE
 hlFoOt/qYzIoEExVHEJLR83l1sB+4sXj8VIfhIY47Vz0EzhEolFyJO2LYDARK/sA
 ==
X-ME-Sender: <xms:qB1WX06WYjacbdFNiMdtG3JvvpZVt_lNehAEbVBVIEcoYUcqRD8geQ>
 <xme:qB1WX14v4jaZXUswGl7Xb9GZ4RqX8Qb1GwfjPrbxMRsFrd4scuKOYXq_jRjfm6wu9
 j1fDyFkI50njIhTV2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddggeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:qB1WXzf35LrPhUNA4xwlLdGPnaazDkEIvBM0Rx9JQ1tW0bI8ZSGS6A>
 <xmx:qB1WX5IYMCdqGOBHa3wOmjZir-hLLZAq_qKf5lxX7SelBH_-xgx5ug>
 <xmx:qB1WX4JmaWSplumsfdXabWipG72zy0t6cqGIqVG8dFBdnr1Xjrro7g>
 <xmx:qh1WXw8r-pp5OzlnRUTOaO7tbbVKFJ8DdNaxV_JDoTgjg2IuLeDl2Ro1CIZMG_Md>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9B1963064610;
 Mon,  7 Sep 2020 07:46:47 -0400 (EDT)
Date: Mon, 7 Sep 2020 13:46:45 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add Stefan Hajnoczi as block/nvme.c
 maintainer
Message-ID: <20200907114645.GA742971@apples.localdomain>
References: <20200907111632.90499-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20200907111632.90499-1-stefanha@redhat.com>
Received-SPF: pass client-ip=64.147.123.18; envelope-from=its@irrelevant.dk;
 helo=wnew4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 06:50:30
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  7 12:16, Stefan Hajnoczi wrote:
> Development of the userspace NVMe block driver picked up again recently.
> After talking with Fam I am stepping up as block/nvme.c maintainer.
> Patches will be merged through my 'block' tree.
>=20
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Klaus Jensen <k.jensen@samsung.com>
> Cc: Fam Zheng <fam@euphon.net>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

I'm only superficially involved in block/nvme, so my Ack doesn't carry
that much weight, but

Acked-by: Klaus Jensen <k.jensen@samsung.com>

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9WHaMACgkQTeGvMW1P
Dendcgf+N9qgTrOXd5jXrQQk+0b10CsJa8ynAbpzxyMNn0fQzYzk6Coc8o33bSi2
sXiogPRRKdDZTSpsy4IlsPV8V7mO5LrrS5MWjpZ/2cvm/tr0LX6cCDyiA3u6L23c
pxCgHyy73bxP7mBJnuzbaBgWqX7da+XJdzkupVsWdPG9GCsM9fhkxrANPsI0dWEn
q0PhGt3LgZyxOEMjTehl5DDOgV3xLg+/FBMEau4u/ccEWsGJaps69+9ubgynaxGX
s8KoqcrQlfsXz6CIe3rOdEf/ChDWkf6QDumYVpiw7GWrA1iHthzVBaGy73UCbUQX
2qeY1t/IeeFdzVNI1aZFRKgN1p9YMw==
=xR2x
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

