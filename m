Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E9DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34BD2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34BD2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY6Y8-0005zi-87
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 07:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kY6UO-0004bC-Oh; Thu, 29 Oct 2020 07:53:09 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:44523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kY6UK-0006C4-PD; Thu, 29 Oct 2020 07:53:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id B382C76F;
 Thu, 29 Oct 2020 07:52:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 29 Oct 2020 07:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=RgSYDsPGLqOscQlXpsOEdZC/nkk
 V8nUJ46v7yFZuydU=; b=LWb85vbhOZ0GXirzQdYiscZuK+2DX3YfZE7oJQI964u
 uzjCzxpgjwnxJ0Y/WuFDMy/Xt8L2uknQoNHKPxRrfp2QrGnDIDUc5+Ar+iO7BDWz
 h6kqeGtgplTuZ3BkBsH5W8jauh27Z9dS8Lf3QRyImuezeCkW7wTScrdgBWsQZaX2
 qGuSvYjavBtXeQnEmaZQqbhIQ7NwNqf0Q/6NKOKzLgtPChbyP08yPvQHxz2whiYE
 yQunci/D+kAA9IJX8L6fOrs7zaMkAZyyWdi+lFxvgZXKgI8fyuD+MuiEg4INOxV9
 Xy/1KC59orI5Venav5kRUQJhTXvjSHwP+c70j7Cuf4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RgSYDs
 PGLqOscQlXpsOEdZC/nkkV8nUJ46v7yFZuydU=; b=aD0TfY3rr5FauRs3Bnhv3+
 UBgD7XRol9kR04cS+sZOt/R/is8PDRcR7HsMv57wI5EBNIMXfOoHs9lZmPSvsgVM
 O9jcqPMDFeEZpgA9wxJ04YzbrpiHOQILNORwyEo3obZn2M+VleGFYgJ94zriEOyC
 E5h1HUr9NW/EXcZ7bJFX7K1BY/pULVqBBQibl2x/DU5pjl9Hg7Oa8y6FANgSUIpg
 0f31kQQVxiHKE6KS19GdoMn/fRIKtwwr8O7Sw0//P1FhPwKu2CyU7qZFU3/YbQGR
 f9WMNlh2uMzaac+M4kjqAbnbM/6lqHwFpEHVwWE3/duXwSfkVGoegtP49fWYWIHQ
 ==
X-ME-Sender: <xms:Ga2aX-SkFfKvE_TCAecTatMz4EcQUFctJtcwaSc8wDvFJM_9wA6D1w>
 <xme:Ga2aXzwpgoeImWY5o_8kzrWPSN4Lhkw_E0_8o7e2bpHc5BLsLIAFxMlD0bKYwotGj
 -FSR9VQMrK-vR3kOzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleefgdeffecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepuddtheelledvtedvfeeuheegvefhjeeuleeihfduhfeiffffhfdutdekkeeikeef
 necuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecukfhppeektddrudeijedrle
 ekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
 mhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Ga2aX73OJ6Zj9CNgShTNegMR4PbXPaxyRVkRH3rOFTSTpbBMeGKleA>
 <xmx:Ga2aX6BA0EMetrLXi0H0eq63EhXKDg1POzEuzo3P2hXk5WE3DGbpIQ>
 <xmx:Ga2aX3gIf4mqxb0F_7cGjdMXNE0OgmwRjfssWggfjsmLgys-Md9Yeg>
 <xmx:Gq2aX0sw78xd9Jb-T6eUgXFtFgjqkzeTVfkm3mC58_BCopemfVSGbw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C93B93064610;
 Thu, 29 Oct 2020 07:52:56 -0400 (EDT)
Date: Thu, 29 Oct 2020 12:52:54 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/30] nvme emulation patches for 5.2
Message-ID: <20201029115254.GA777050@apples.localdomain>
References: <20201027104932.558087-1-its@irrelevant.dk>
 <CAFEAcA8EcEfaFZYUicbL5ShA5y5sTP7hmNNX5Ot=3ZyAGnV81A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8EcEfaFZYUicbL5ShA5y5sTP7hmNNX5Ot=3ZyAGnV81A@mail.gmail.com>
Received-SPF: pass client-ip=64.147.123.20; envelope-from=its@irrelevant.dk;
 helo=wout4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 07:52:59
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
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 29 11:39, Peter Maydell wrote:
> On Tue, 27 Oct 2020 at 10:49, Klaus Jensen <its@irrelevant.dk> wrote:
> >
> > From: Klaus Jensen <k.jensen@samsung.com>
> >
> > Hi Peter,
> >
> > The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c=
06d5:
> >
> >   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-2020=
1026' into staging (2020-10-26 17:19:26 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.infradead.org/qemu-nvme.git tags/nvme-next-pull-request
> >
> > for you to fetch changes up to 843c8f91a7ad63f8f3e4e564d3f41f3d030ab8a9:
> >
> >   hw/block/nvme: fix queue identifer validation (2020-10-27 11:29:25 +0=
100)
> >
> > ----------------------------------------------------------------
> > nvme emulation patches for 5.2
> >
> >   - lots of cleanups
> >   - add support for scatter/gather lists
> >   - add support for multiple namespaces (adds new nvme-ns device)
> >   - change default pci vendor/device id
> >   - add support for per-namespace smart log
>=20
> Hi. This tag appears to have been signed with a GPG key
> which isn't one that's been used before for an nvme pullreq
> and which isn't on the public GPG servers...
>=20

Uhm. Keith, can we coordinate a keysigning?

Would a signature by Keith on my key be acceptable to you Peter? That
way Keith doesn't have to create a new tag and bomb the list again.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+arRQACgkQTeGvMW1P
Del7Jwf+MS9g9MsqIo2qN3QK0AdmGkonrrwl8teYYDrt5zVd6XLxdxZQtgj0dRBa
o4IMnOALG8Mw67m/DEGHAfsCuoWFxsBYyx7OlLIiwEjhsxuUzDkKTYbSaoJ4y9qc
gw6P07yvpzz4K+frc43nhcsM1S8G41krpqsVVA+oQWC3h8vjknzEWsD9KMhq32I1
zREHP+kWNCIYZzHi64I49q3Q54QX0t8xkdT8yrHm/VlpdYPTWGBj1kaYNDHeipXm
TkK+XjCy5LQ8EWVGzMvStQAaUlB0TTBd/g2di94oc8A5ammaBC/xnKDDjqQYlr0j
y/Vn2p6fpm+Jk94qSMgHJ22G61sx4g==
=dUFx
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

