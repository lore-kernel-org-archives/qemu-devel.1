Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A344FC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA7E2075A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA7E2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNKYj-00033E-Gt
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNKUO-0001pO-7b; Tue, 29 Sep 2020 14:36:36 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:36025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNKUK-0005wW-Ut; Tue, 29 Sep 2020 14:36:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 86E11EC7;
 Tue, 29 Sep 2020 14:36:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 14:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=BO1+/YH3omON5wdZE3F3vGUFJCj
 P2OaiiVkCbvOrQeA=; b=s078oeux65deHMF+/1SQ8cg9tNMq+alLgdbrFtKn1Te
 LGhpm8LkoRSuaJDWhstBHOlJaewvtHadmBCO3/93d1l81errLdKzj9JfhfkUNdBo
 BeGmqXM7UX2fl+p8n45ZCpX8oQ9wqN8u7ws2aqlGD5HiEpdgOjBNYdA5XUMyWr33
 LDkjwCRLQ0t6geNM1FsjQgcOq3O5ZvVNhemDiMfNgAKZNs4ftVyJGou3Qm0nY7NX
 SUqRug06Ectw/BIh3LHl2E/MvGn9cRmiZcy8sHTDMsdhZowsmUKW6oi/0i56MSXT
 wEc+PbYzBhTYdAm1AXvWkYCrO3AuHmESi1mm89SXKeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=BO1+/Y
 H3omON5wdZE3F3vGUFJCjP2OaiiVkCbvOrQeA=; b=ZWqO6Fnm1nF/QGMcukxwlu
 CRRFltKKikjNyCdGqwmgOEGDH1yOG63MydP/ssL6Ug9594iziSHYxgbnOQaUL+rm
 D/7R+0QoAAPs8G1bJOHfBF89xIcdW4rsrJrBoEHXUmmQYfcEGvp5/vx2eP1LbL9S
 zyl5j7KIRHbqVWHiv7+fPV3ouzhJhAPYAAlJUMqPN4xF3cFJN0FFrD+jHrTrrTRl
 G2mDmek8NikeOosNFb4BIRPynmtaORV2gcaswsWZF0lQZOsPla/Rc+AfTzy3U0K9
 kUALGIVP97V7H/3E6mENXTZHn1I2k/l+rJofeYbb+EsIhTCF4tuLWIsxUC+7CXcQ
 ==
X-ME-Sender: <xms:qX5zXyLN5K-1JpdNMxD-35TfXmTuOPKqF3YeGzls9qE_wLdzJZTr4A>
 <xme:qX5zX6L_BVRmzG8saqX7BKDRDxL5aeUnEyD6R7cma7hsqkMocUkdog9WW_a4mbAIZ
 OH3gEf6-5-xCAeMc-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdekgdduvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:qX5zXyu88UY_dcQNgoCQX2sNdt4nGVibCnJCltWxJ0eg8o6kIsa-kQ>
 <xmx:qX5zX3Ysg2o-at8eGvarsT5nb3X8b2RMw3u1L0nuMzwmjJO3kC0esg>
 <xmx:qX5zX5a218AyrF6vRaS-6Iynh5qQtjYDBG_17pA_hvpe-wfdOrqzEw>
 <xmx:qn5zX7lWNJRD5xZpK2mWdWdKJHcjHv6632jpBhL7alZptMmBzah2KbEIgaDQ48PU>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 83DB73064610;
 Tue, 29 Sep 2020 14:36:23 -0400 (EDT)
Date: Tue, 29 Sep 2020 20:36:21 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Message-ID: <20200929183621.GE286786@apples.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200929104633.GA179147@apples.localdomain>
 <20200929172944.GB477114@dhcp-10-100-145-180.wdl.wdc.com>
 <20200929180004.GC286786@apples.localdomain>
 <MN2PR04MB62232F2E33E3FCC880E47472F1320@MN2PR04MB6223.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <MN2PR04MB62232F2E33E3FCC880E47472F1320@MN2PR04MB6223.namprd04.prod.outlook.com>
Received-SPF: pass client-ip=64.147.123.17; envelope-from=its@irrelevant.dk;
 helo=wnew3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 12:36:54
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
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 29 18:17, Matias Bjorling wrote:
>=20
>=20
> > -----Original Message-----
> > From: Klaus Jensen <its@irrelevant.dk>
> > Sent: Tuesday, 29 September 2020 20.00
> > To: Keith Busch <kbusch@kernel.org>
> > Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Fam Zheng
> > <fam@euphon.net>; Kevin Wolf <kwolf@redhat.com>; qemu-
> > block@nongnu.org; Niklas Cassel <Niklas.Cassel@wdc.com>; Klaus Jensen
> > <k.jensen@samsung.com>; qemu-devel@nongnu.org; Alistair Francis
> > <Alistair.Francis@wdc.com>; Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>;
> > Matias Bjorling <Matias.Bjorling@wdc.com>
> > Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
> > Zoned Namespace Command Set
> >=20
> > On Sep 29 10:29, Keith Busch wrote:
> > > On Tue, Sep 29, 2020 at 12:46:33PM +0200, Klaus Jensen wrote:
> > > > It is unmistakably clear that you are invalidating my arguments
> > > > about portability and endianness issues by suggesting that we just
> > > > remove persistent state and deal with it later, but persistence is
> > > > the killer feature that sets the QEMU emulated device apart from
> > > > other emulation options. It is not about using emulation in
> > > > production (because yeah, why would you?), but persistence is what
> > > > makes it possible to develop and test "zoned FTLs" or something that
> > requires recovery at power up.
> > > > This is what allows testing of how your host software deals with
> > > > opened zones being transitioned to FULL on power up and the
> > > > persistent tracking of LBA allocation (in my series) can be used to
> > > > properly test error recovery if you lost state in the app.
> > >
> > > Hold up -- why does an OPEN zone transition to FULL on power up? The
> > > spec suggests it should be CLOSED. The spec does appear to support
> > > going to FULL on a NVM Subsystem Reset, though. Actually, now that I'm
> > > looking at this part of the spec, these implicit transitions seem a
> > > bit less clear than I expected. I'm not sure it's clear enough to
> > > evaluate qemu's compliance right now.
> > >
> > > But I don't see what testing these transitions has to do with having a
> > > persistent state. You can reboot your VM without tearing down the
> > > running QEMU instance. You can also unbind the driver or shutdown the
> > > controller within the running operating system. That should make those
> > > implicit state transitions reachable in order to exercise your FTL's
> > > recovery.
> > >
> >=20
> > Oh dear - don't "spec" with me ;)
> >=20
> > NVMe v1.4 Section 7.3.1:
> >=20
> >     An NVM Subsystem Reset is initiated when:
> >       * Main power is applied to the NVM subsystem;
> >       * A value of 4E564D64h ("NVMe") is written to the NSSR.NSSRC
> >         field;
> >       * Requested using a method defined in the NVMe Management
> >         Interface specification; or
> >       * A vendor specific event occurs.
> >=20
> > In the context of QEMU, "Main power" is tearing down QEMU and starting =
it
> > from scratch. Just like on a "real" host, unbinding the driver, rebooti=
ng or
> > shutting down the controller does not cause a subsystem reset (and does=
 not
> > cause the zones to change state). And since the device does not indicate
> > support for the optional NSSR.NSSRC register, that way to initiate a su=
bsystem
> > cannot be used.
> >=20
> > The reason for moving to FULL is that write pointer updates are not per=
sisted
> > on each advancement, only when the zone state changes. So zones that we=
re
> > opened might have valid data, but invalid write pointer.
> > So the device transitions them to FULL as it is allowed to.
> >=20
>=20
> How about when one must also recover from intermediate states (i.e.,
> open/closed upon power loss). For example, I don't hope a real SSD
> implementation transition zones to full when it has thousands of open
> simultaneously. That could be a disaster for the PE cycles, and a lot
> of media going to waste. One would want applications to support that
> kind of failure mode as well.=20

Christ. The WDC Strike Force is really jumping out of lightspeed here.
I'm afraid I don't have an opposing force to engage with. So I'll be
your only boxing bag for the evening.

As Keith just said, "Opened" is not a valid intial state. Didn't you
write the spec? ;) As for Closed, they will be brought up as is.

With that in mind, I'm not sure what you specifically refer to? I'll
gently remind you that the QEMU nvme device is not a real SSD and does
not deal with NAND so it does not really do any "recovering" of
intermediate states on power on if that is what you refer to?

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9zfqMACgkQTeGvMW1P
Dem+Vwf/e71wzfkRkKz5KpW2QAHNJdT7mVfPk6n6fb1Ln8VnwT57qGQ6dUus33WF
xEkE5+7esx28bCj55829g0Z0T/XeacgA50K5MIpymXrMOpjiS4eYam3IziwRXzsQ
lyxeAp1T5S4FK7dzkFhHdDOYbQ07PS9ho71i+R0X8UAcEDUmYAUAg30qIqZGwL3E
QsAnaqDN5opSO9plaN9/EdAWVJlr6/K1xDjMF8mHIhwn+ZoQpboIwlj3p8ee3VOg
P3bgo/unvvf5mxP14RodGznLKhogZlZPLDPvKx0ElnduY4ZL3GjOL40YljOFvTPT
YSuGIWulcTx/RBou7CTh23Oy+9QOQQ==
=8Cqy
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

