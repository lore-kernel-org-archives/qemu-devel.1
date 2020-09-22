Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15911C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2439B22206
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2439B22206
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKm9q-0003dw-PE
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKm4o-0000kz-Up; Tue, 22 Sep 2020 13:27:39 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKm4n-00021l-3e; Tue, 22 Sep 2020 13:27:38 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id C030E580464;
 Tue, 22 Sep 2020 13:27:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 13:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=DwCkHNRXVfSyBtBjNOkmrjpv956
 6oywqPLFwdEJLgFI=; b=E6rN8EBgLza7LcLbSUdsDZioMEm2yNYAh1VplS/gX1h
 h3FUpBGvxfbp9pJHKYB0mYUo62fzu3/LjAHbnsxey1VZSQFsv3cvHNmrnCvLKAeh
 aitsyxwFKxJgo6T8P50T7SwavHcXLzoVt7a1zKB0z+lNGbfrdkm4H1G4ORS4olTK
 dKDl/UpbsXsLBgUUWEx90FFAiiKXp8SX665QRCUAEskADI9XRz8xhV1JBtTIDMzD
 Ib0Y/AXY1OBjznSkR9tcbjfMTGbXFPSOpleRvl6fCyK9gllEcJY985t6CBSSDhpI
 XHDsN3ItQWwI0J2dywcqNS0nhh99SqGqxTYqhfaQqLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DwCkHN
 RXVfSyBtBjNOkmrjpv9566oywqPLFwdEJLgFI=; b=COpHPWYfPyhBzg/O7977a7
 5grAYRRFz9NLLpJVl5VC2AO1AEuZCDjQvXStVqHGhc+E8Quw7ID6zzGqW748t7yy
 mxu7vD9KBz02+8MxGegTc89wgsA17awfg2fIAAfN6PKMhV7CwXVLHzt13dVxAFhg
 R7QQ+xrkQI+d71/SQTg9Y8hq+OlluCP3WXSuXjZduc2C5ME48vdr1N/N/yBf7A7Z
 /RvNzB1Vl4/c9YJVZnMg3nXZq1wODHTsDm+lWoCCAnx3uqB++vCAaqw+xH/Cmapt
 9UZNKBdIwhmnjGq9XoiE4ERikPjLpXdphUN79qiCqwlkUHtlMeVRmhaJPQmmp36g
 ==
X-ME-Sender: <xms:BTRqX057eIIZlSVnQjmtWCEe4otOUd5jct3Nz3SOQpqE8Cg6FMcfeg>
 <xme:BTRqX16w8mMJeFSH-wbEQwxyMFZKDNNWUf7eI9V5hFoc23f7YqRQSonlL-TiAm2J3
 kUbeiIEX8uIJLeVaGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:BjRqXzfk0apyJAP2Gu8OEBlMHJUqZaGJBHXKMFQu6ln_Si0CqKd1qA>
 <xmx:BjRqX5IB_6dxBGQ0cjeQtJ3j8CFM82grof3cen-6d6PGDCmyyzEshw>
 <xmx:BjRqX4Kb2O3RegeZcQJZJ520wYDUQEYHrrz7K16_PR-JhVIFIl79Iw>
 <xmx:BzRqXxoOAWOZITn4pdAf30edC7Xo7Tsp7vEFj98L0maCSrIAsXV9UQ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 948053064680;
 Tue, 22 Sep 2020 13:27:32 -0400 (EDT)
Date: Tue, 22 Sep 2020 19:27:30 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 00/17] hw/block/nvme: multiple namespaces support
Message-ID: <20200922172730.GB1236186@apples.localdomain>
References: <20200922084533.1273962-1-its@irrelevant.dk>
 <20200922153125.GC4035426@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20200922153125.GC4035426@dhcp-10-100-145-180.wdl.wdc.com>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 13:27:35
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 22 08:31, Keith Busch wrote:
> On Tue, Sep 22, 2020 at 10:45:16AM +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > This is the next round of my patches for the nvme device.
> >=20
> > This includes a bit of cleanup and two new features:
> >=20
> >   * support for scatter/gather lists
> >=20
> >   * multiple namespaces support through a new nvme-ns device
> >=20
> > Finally, the series wraps up with changing the PCI vendor and device ID=
 to get
> > rid of the internal Intel id and as a side-effect get rid of some Linux=
 kernel
> > quirks that no longer applies.
> >=20
> > "pci: pass along the return value of dma_memory_rw" has already been po=
sted by
> > Philippe in another series, but since it is not applied yet, I am inclu=
ding it
> > here.
>=20
> For the rest of the patches I haven't individually commented:
>=20
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Sorry if I am being thick here Keith, but didn't you R-b all patches
(except 3 and 9) in v2 yesterday?

I do not see any comments to any of the v3 patches, so I'm not sure how
to interpret this ;)

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9qM/0ACgkQTeGvMW1P
Den0SQf8C5DctautRisOS5NAx1iV3QdjpNGWTHLj9ptxl4966pLLk2rWbPpOS39u
Qc1bZd+dxPxmFbBGLbe5quRuVdnBG/diF5PLmfZZRjqkw517URa9w8V7LjJNZ09J
vki1TM1GXKOHwVQR/V7O7f9UjbFidMiU/Jk5CevYukjbhGREXNLeF+310dkWml5j
QhWgo8V3YQCSKfLMJnIn5/pPX4tMz82vzA1vYcr+u39yzvAey2tq11MZl7Bbhc2e
JDKgm5nwd0WX2Z/Sgs7Ftg7Rv8guSJJGQgE9ESVI/iE0Rd/E56Kgp5cvkAKzg/Ke
uWgk0ppuP0BQwT5cVH7Fxuxmad8bYw==
=L7MD
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

