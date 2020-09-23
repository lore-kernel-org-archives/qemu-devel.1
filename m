Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ACCC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24BFF20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BFF20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLALr-0006EA-OO
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLAIH-0004WV-MK; Wed, 23 Sep 2020 15:19:09 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:59651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLAIF-0006aW-7h; Wed, 23 Sep 2020 15:19:09 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 9F580580421;
 Wed, 23 Sep 2020 15:19:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Wed, 23 Sep 2020 15:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=c/7n/hyhOCrbZ/MSoc3iW2SO9ox
 rC4e9P2ERfsBcMzc=; b=eEC1rHSUxu2Pr9KR2cG09rdeYrfQCOqB/HXdAi63kCN
 nV9u2M+i0Lms+bjAXv5yfCI9GpM71VS4p6BkzOvMCpatLzT2fSIgvtTpu2UrH/b2
 XiBHu5p5UGncTp0qiTmFXJwPsnpr5QK2K5DgvqCesPmGD21MbeWpP7lG65mGsJWb
 1bZQv8VB6a2IXFfpv3sI2LXj8yehS+e8xNX0QiIlIb97iajJN/zFpgxt3fWLA/rf
 ZAV6/+PPmEH7+J0dktychtxoW2dHCWTYTavm5WiGqzEKmijkpa3USU50cm1yNIdr
 twvtK792zMW+i6VC/5M/L/y+oODx2qLNEqYaSOc6XDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=c/7n/h
 yhOCrbZ/MSoc3iW2SO9oxrC4e9P2ERfsBcMzc=; b=uE3gDLMvm+0WEb3YizDjRF
 pMFfEdum30l2w7Z72zww38Lf6Ok+hjBVmpVJf3tfjcgWg8n+42jh6z6OJ1mjAzuS
 67DWSEb2L5SJKNGlh01xkvtcajVh+2OEU755/YDp3AbpZTcfEH+tCeifEZYXPGo9
 xosk9y1kWTgegOvktFPuh5mVo/+ickqGE4JWPeCMLm6C8gTbSMC21/hEmlZpBSi/
 53EdTNASGYVlG/0hjLhB0NPTm+8wlG/hyxr4R2JrSCV/OCra7sR3iG8TGJrJpIxe
 EB0Fed8s9Azvl2mAFBu0ZVqEat4rBb+LZLabdlManQHWmPQMliEUyNUzx19us6Wg
 ==
X-ME-Sender: <xms:p59rX0gdg1xoNIQPkw_8603bUfNi-5ATHbYIvO2E8SfRCihN6cj9kA>
 <xme:p59rX9BDeOZfReAUZ5iGDQRZ452OTdHLAGcq6q92Zhos9Z_KOZwFo-nKsZLeeAhTn
 NM_sLtnO64Qnwhp5a8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeigddufeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:p59rX8EXQgmeeF7PDFj3wjh2_V87Etk-6T0wkZxM8XR_3-scvBMAPA>
 <xmx:p59rX1TvStvv_8kEDr7idZeGpQaKPMfs-hsvQQkahD_KlM_-ljQ4OA>
 <xmx:p59rXxwjoWcxsKe7CaJy1gMMqPluWrpcdb2MwsK8WBQpE7BLCcE-UQ>
 <xmx:qJ9rXwxiuiHTWA0GfRmTIuW2rnyAG7HgZcJXtHGyogRucPGoCtzCqg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0B9173280067;
 Wed, 23 Sep 2020 15:19:01 -0400 (EDT)
Date: Wed, 23 Sep 2020 21:19:00 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/17] hw/block/nvme: multiple namespaces support
Message-ID: <20200923191900.GA1635361@apples.localdomain>
References: <20200922084533.1273962-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20200922084533.1273962-1-its@irrelevant.dk>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 15:19:04
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 22 10:45, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> This is the next round of my patches for the nvme device.
>=20
> This includes a bit of cleanup and two new features:
>=20
>   * support for scatter/gather lists
>=20
>   * multiple namespaces support through a new nvme-ns device
>=20
> Finally, the series wraps up with changing the PCI vendor and device ID t=
o get
> rid of the internal Intel id and as a side-effect get rid of some Linux k=
ernel
> quirks that no longer applies.
>=20
> "pci: pass along the return value of dma_memory_rw" has already been post=
ed by
> Philippe in another series, but since it is not applied yet, I am includi=
ng it
> here.
>=20
> Changes for v3
> ~~~~~~~~~~~~~~
>=20
>   * hw/block/nvme: handle dma errors
>     Do not retry DMA, just set Controller Fatal Status (CFS). This causes
>     the Linux kernel to most likely disable the controller when running t=
he
>     blktests block/011 test case, which causes some havoc when running
>     blktests, but I have submitted a patch for blktests to fix this. (Kei=
th)
>=20
>   * hw/block/nvme: refactor aio submission
>     Dropped the unneeded nvme_req_is_write function. (Keith)
>=20
>   * Added R-b's from Keith and Philippe.
>=20
> Changes for v2
> ~~~~~~~~~~~~~~
>=20
>   * Added a new patch ("hw/block/nvme: fix typo in trace event") that doe=
s what
>     it says on the tin.
>=20
>   * Dropped the "hw/block/nvme: support multiple parallel aios per reques=
t"
>     patch (Keith).
>=20
>   * hw/block/nvme: add symbolic command name to trace events
>     Changed to single quote (Philippe)
>=20
>   * hw/block/nvme: default request status to success
>     Commit message typo fixed (Philippe)
>=20
>   * hw/block/nvme: change controller pci id
>     Do NOT bump the device id for the legacy Intel id (David)
>=20
> Gollu Appalanaidu (1):
>   hw/block/nvme: add support for sgl bit bucket descriptor
>=20
> Klaus Jensen (16):
>   hw/block/nvme: fix typo in trace event
>   pci: pass along the return value of dma_memory_rw
>   hw/block/nvme: handle dma errors
>   hw/block/nvme: commonize nvme_rw error handling
>   hw/block/nvme: alignment style fixes
>   hw/block/nvme: add a lba to bytes helper
>   hw/block/nvme: fix endian conversion
>   hw/block/nvme: add symbolic command name to trace events
>   hw/block/nvme: refactor aio submission
>   hw/block/nvme: default request status to success
>   hw/block/nvme: harden cmb access
>   hw/block/nvme: add support for scatter gather lists
>   hw/block/nvme: refactor identify active namespace id list
>   hw/block/nvme: support multiple namespaces
>   pci: allocate pci id for nvme
>   hw/block/nvme: change controller pci id
>=20
>  docs/specs/nvme.txt    |  23 ++
>  docs/specs/pci-ids.txt |   1 +
>  hw/block/nvme-ns.h     |  74 ++++
>  hw/block/nvme.h        |  83 +++-
>  include/block/nvme.h   |   6 +-
>  include/hw/pci/pci.h   |   4 +-
>  hw/block/nvme-ns.c     | 167 ++++++++
>  hw/block/nvme.c        | 848 ++++++++++++++++++++++++++++++-----------
>  hw/core/machine.c      |   1 +
>  MAINTAINERS            |   1 +
>  hw/block/meson.build   |   2 +-
>  hw/block/trace-events  |  23 +-
>  12 files changed, 978 insertions(+), 255 deletions(-)
>  create mode 100644 docs/specs/nvme.txt
>  create mode 100644 hw/block/nvme-ns.h
>  create mode 100644 hw/block/nvme-ns.c
>=20
> --=20
> 2.28.0
>=20

Pushed to nvme-next.

Thanks for the reviews everyone. I think I posted the first version of
this more than a year ago. This feels so good!

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9rn6EACgkQTeGvMW1P
Demukgf+NIR7sq7LFQgAw3K41YmI0hi20SDgagDFdR9YwvvrnJV9doKKOOvf34Ll
e1ULs4PSGLoN5K3B34/cJ0N2YskMBS2Ajvyzqrjq0EzIRqS/IHuvRmgCp7w8dBuQ
koJXUg5qudSZccIzbH72/xxlCy+6E1MXL3wvZq4xo1Owrsr/Dk1jUmWCC4qMMRJv
q+nLoThwlfXsbwq/qJgQXxfyCim19nssLDN5TEAqNHkJ6A9BklFkP01o/SfNoFSw
us07rc1gwTl2ZrYWUVYVs0hVb+ZAar4/mkK52KPloFbOjcW48um5fDwrtgb9QPL9
oGxZu3eNoljzNQna28zCFBOAGDIXGA==
=TxoB
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

