Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACF8C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8492071E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8492071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNKJk-0002Rs-PW
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNKCc-0006DO-PM; Tue, 29 Sep 2020 14:18:15 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:39583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNKCX-0003RI-Gu; Tue, 29 Sep 2020 14:18:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 7B8775EC;
 Tue, 29 Sep 2020 14:18:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 14:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=pWj9MTbOf/2WR22mILizdKw+jj3
 WMkgonkCr7lGSA20=; b=p6raR5InTvczCiKMMRD/mLYvr9q8reDpt4uUEMiH+j7
 tlKtA81EjemoKNuEdsOg/jvNJ0PxRVHz3gRS8yUnADDVedbhIRN3HnC2bRmc5GsL
 ACWKdsCYJYF0eRh2L+F/sFHMt0230YczZxJA+3WeBHXMoVFZsBAH1VcspC7JjFHy
 y9Gq8Z++I6hG08ieexwH+++PNn6hITryAzSnQQpm4gVwnnO9F9Nz4c+Z1XZUe2in
 TDl2BZmGrJ1TdtAWxc4NyMB2hBtbnmphFAzY6zCEMqV1RMccwgjG/jrE1yoN0c9p
 pWzY0lHJEgS4jax6Fli6G9q8GFKpImchk/L58eoCAtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pWj9MT
 bOf/2WR22mILizdKw+jj3WMkgonkCr7lGSA20=; b=HlEmZ3jZXVK82A6ELpCV3P
 3OMgTmjysBUu6P1QifszXdajReKjNyh9D4Necvchl8hp5wXqSIqRTOW3QEuAAEBI
 icHvjBE+cHVgwpxvDSwVXynvvMbgm2F2tAVHTlzS4thXjNQHdqBjjwsCwma+6kAP
 FMuzOlmt9MM6X/rudrgVqGCIqOm/GfKifF/b3ZWLfMvquGkkngELDqRhBmhCp9a6
 5yyvTs1PHsIXvepZi0LmWey0Ia/ORKGFP2bxEPSyuEZK2dtgomxcp+Xq0wTYBMY1
 9tvLtV1bDscimMWEsd91lTsGnMLWTQy37Jb5+0xPLSzdtxFOoKWWoFWpQac4Jr1Q
 ==
X-ME-Sender: <xms:XHpzXxG_ZjV7LAcQkRfj7U6-uIL75i58Gt55Y_h4EYq4bdNKVQEGeQ>
 <xme:XHpzX2W8CjYDNPlvSrnRaxWXiYeWkH2dtA9WDiPs3EtEzNvg1OJQXYEcoGYXWvAoL
 I0iMugee0ZmvTsCYqE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdekgdduvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:XHpzXzJNUeKr22Qiz6kFZ3JLPcXijbz27ckQszz9rPyr319ucYLI8A>
 <xmx:XHpzX3E29DJDz_bNOGh467WLR_YFNYWzYI8FfhheYeVbuXtKb7UdrA>
 <xmx:XHpzX3V4VIXMN6f9L2zrT5Sm36F848yDSEkafwkAAoRP2fE6bvOKIw>
 <xmx:XnpzX3TVtwCcf1WtfCnDd29NRXZeoDiowWQNpjKqTxXddvE_twx3f-lbwNODOCDu>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 41C0C3280063;
 Tue, 29 Sep 2020 14:18:03 -0400 (EDT)
Date: Tue, 29 Sep 2020 20:18:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Message-ID: <20200929181801.GD286786@apples.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200929104633.GA179147@apples.localdomain>
 <20200929172944.GB477114@dhcp-10-100-145-180.wdl.wdc.com>
 <20200929180004.GC286786@apples.localdomain>
 <20200929181503.GD477114@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20200929181503.GD477114@dhcp-10-100-145-180.wdl.wdc.com>
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 29 11:15, Keith Busch wrote:
> On Tue, Sep 29, 2020 at 08:00:04PM +0200, Klaus Jensen wrote:
> > On Sep 29 10:29, Keith Busch wrote:
> > > On Tue, Sep 29, 2020 at 12:46:33PM +0200, Klaus Jensen wrote:
> > > > It is unmistakably clear that you are invalidating my arguments abo=
ut
> > > > portability and endianness issues by suggesting that we just remove
> > > > persistent state and deal with it later, but persistence is the kil=
ler
> > > > feature that sets the QEMU emulated device apart from other emulati=
on
> > > > options. It is not about using emulation in production (because yea=
h,
> > > > why would you?), but persistence is what makes it possible to devel=
op
> > > > and test "zoned FTLs" or something that requires recovery at power =
up.
> > > > This is what allows testing of how your host software deals with op=
ened
> > > > zones being transitioned to FULL on power up and the persistent tra=
cking
> > > > of LBA allocation (in my series) can be used to properly test error
> > > > recovery if you lost state in the app.
> > >=20
> > > Hold up -- why does an OPEN zone transition to FULL on power up? The
> > > spec suggests it should be CLOSED. The spec does appear to support go=
ing
> > > to FULL on a NVM Subsystem Reset, though. Actually, now that I'm look=
ing
> > > at this part of the spec, these implicit transitions seem a bit less
> > > clear than I expected. I'm not sure it's clear enough to evaluate qem=
u's
> > > compliance right now.
> > >=20
> > > But I don't see what testing these transitions has to do with having a
> > > persistent state. You can reboot your VM without tearing down the
> > > running QEMU instance. You can also unbind the driver or shutdown the
> > > controller within the running operating system. That should make those
> > > implicit state transitions reachable in order to exercise your FTL's
> > > recovery.
> > >=20
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
> =20
> Okay. I wish the nvme twg would strip the changelog from the published
> TPs. We have unhelpful statements like this in the ZNS spec:
>=20
>   "Default active zones to transition to Closed state on power/controller=
 reset."
>=20
> > In the context of QEMU, "Main power" is tearing down QEMU and starting
> > it from scratch. Just like on a "real" host, unbinding the driver,
> > rebooting or shutting down the controller does not cause a subsystem
> > reset (and does not cause the zones to change state).=20
>=20
> That can't be right. The ZNS spec says:
>=20
>   The initial state of a zone state machine is set as a result of:
>     a) an NVM Subsystem Reset; or
>     b) all controllers in the NVM subsystem reporting Shutdown
>        processing complete ((i.e., 10b in the Shutdown Status (SHST)
>        register)
>=20
> So a CC.SHN had better cause an implicit transition of open zones to
> their "initial" state since 'open' is not a valid initial state.

Oh snap; true, you got me there.

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9zelcACgkQTeGvMW1P
DenQfgf/RguZyQZ08oVT3KocFk03MKTBFSDLMaL95AOAeo0TfSEi+/nAFMKxzFBJ
rCDYcwlubxMCsGxxkNKpphoxYdmrU3evX7vLPs1DvtNuMbukeI10FYfyeoq12SEG
ZHiHOTrH5p5S28K7D554qCxEmxFopPMFrduHzu598dd1WkTzqb0J5c2xaSiuP+J+
+XTdUMzVPPbHCxGOk/qTspO/MTk2jOZXufzP4AF7HJSSmCM5X4kXuvNeTzOQ0/l8
qbJ9m2yDidB/Gr3AWFpmBFiIzQHxQBIYyVTNFwantHr63tJRJAGJOWKttQYERD28
jvlw3Q2xbCEJDLtENL451M1kYipglw==
=CgYh
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--

