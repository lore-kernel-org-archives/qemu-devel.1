Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC661C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0514120936
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0514120936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNJzf-0006ea-6a
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNJvH-0005Kg-Fd; Tue, 29 Sep 2020 14:00:19 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:50959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNJvB-0000hg-S0; Tue, 29 Sep 2020 14:00:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 0D5F4152D;
 Tue, 29 Sep 2020 14:00:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 14:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=EjlJMO0VmEYmrtvHr2pVdLtr412
 KFF9Lds6YNa95mFI=; b=jgLIMBDoBJZl5pfux7v6OHBYjwMKiNq+mJXEUfd/bi/
 LwQVLc4ikrdDi4iuuIxuu+Z29sbLfxnc8q6TyHeJqRcfx8f16PP/h3w5MyiKCK1H
 CCCzQ5IjFWz7hBJesn8snZAE054/DyFjX5TVxN22+iTmJSO4kB67gtvG3/4ixPeq
 FNFagTzgvRK01I7EitK4hb9I/+vhn10eK9DdP2Ahugyw1K93tj3q+Ny1xFGXTgwq
 uHHd/cUpN1RRe64jDStaeKMI5D7rrrUAnTZS606d5xb1joxhkmeMPDNSibZ1WsDG
 4PdKkvQVn4lA/ZEjD+pKwl5A9ejVhQT81VqPD38TtZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=EjlJMO
 0VmEYmrtvHr2pVdLtr412KFF9Lds6YNa95mFI=; b=fJo7OiAosBGk7RKE9ZtSY0
 jiiGAGVnAtHJgoCwGWeL0fA9K/h3M41wxd3D8BcESmJZt7HWG6vHnwXtqmwbKDuG
 C+a0hkKSHgxz8vPWUZHsaho+hXGqr2A2TUkA5KAh9epBKg9OFuSqmj6GQeSyh+1Q
 OW6Cnmu4VSDr2UiQUljy5IWbrvFFIt8WcN0GZb+BWgm4bJhG+/X0dW0eIUmns0a1
 SN1JWRrHeDxYPCpHaaX43slHFRxJGH55njpv541N7h61OH0EEshw+yZmtg6LfA/N
 02bbvcakMHPasZp7RIimlr+bSz0Be7eSQIxy/CJ/dTYf3R2POKVqx1RSfCGrT+UQ
 ==
X-ME-Sender: <xms:KHZzX_1ZxcxGJpxUu2L7kq4XuIkikXutA3Xps3Vofn7sUkYi1kjBZQ>
 <xme:KHZzX-G6EiKD-vp6PImkCcBf9fhRyPb9QXQLMsctDoN-pOZ-DKF2uzqtgmrbj4Uxv
 MSZ4dU3QHM3jAYkm_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdekgdduudelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:KHZzX_4PrLLRqchRWVe1iJwp08R21qDnaw5bRJCjRh98MO1QzmAygg>
 <xmx:KHZzX01vrPBl-BUBEyuXbV7SbHcFIohT0qBezmgE7CtVzMNtEQGyGg>
 <xmx:KHZzXyFWqgIg-C7ImUefnpmVcsDlbNBZsi3f6kBTfPVnShapnFyo0A>
 <xmx:KnZzX1D9n-D6ZJSrxW5oxEPctfB2CcFbszDB9wPCYFs326hGbhTxBO3tCNBHZ1ek>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1F6483280070;
 Tue, 29 Sep 2020 14:00:07 -0400 (EDT)
Date: Tue, 29 Sep 2020 20:00:04 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Message-ID: <20200929180004.GC286786@apples.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200929104633.GA179147@apples.localdomain>
 <20200929172944.GB477114@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <20200929172944.GB477114@dhcp-10-100-145-180.wdl.wdc.com>
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


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 29 10:29, Keith Busch wrote:
> On Tue, Sep 29, 2020 at 12:46:33PM +0200, Klaus Jensen wrote:
> > It is unmistakably clear that you are invalidating my arguments about
> > portability and endianness issues by suggesting that we just remove
> > persistent state and deal with it later, but persistence is the killer
> > feature that sets the QEMU emulated device apart from other emulation
> > options. It is not about using emulation in production (because yeah,
> > why would you?), but persistence is what makes it possible to develop
> > and test "zoned FTLs" or something that requires recovery at power up.
> > This is what allows testing of how your host software deals with opened
> > zones being transitioned to FULL on power up and the persistent tracking
> > of LBA allocation (in my series) can be used to properly test error
> > recovery if you lost state in the app.
>=20
> Hold up -- why does an OPEN zone transition to FULL on power up? The
> spec suggests it should be CLOSED. The spec does appear to support going
> to FULL on a NVM Subsystem Reset, though. Actually, now that I'm looking
> at this part of the spec, these implicit transitions seem a bit less
> clear than I expected. I'm not sure it's clear enough to evaluate qemu's
> compliance right now.
>=20
> But I don't see what testing these transitions has to do with having a
> persistent state. You can reboot your VM without tearing down the
> running QEMU instance. You can also unbind the driver or shutdown the
> controller within the running operating system. That should make those
> implicit state transitions reachable in order to exercise your FTL's
> recovery.
>=20

Oh dear - don't "spec" with me ;)

NVMe v1.4 Section 7.3.1:

    An NVM Subsystem Reset is initiated when:
      * Main power is applied to the NVM subsystem;
      * A value of 4E564D64h ("NVMe") is written to the NSSR.NSSRC
        field;
      * Requested using a method defined in the NVMe Management
        Interface specification; or
      * A vendor specific event occurs.

In the context of QEMU, "Main power" is tearing down QEMU and starting
it from scratch. Just like on a "real" host, unbinding the driver,
rebooting or shutting down the controller does not cause a subsystem
reset (and does not cause the zones to change state). And since the
device does not indicate support for the optional NSSR.NSSRC register,
that way to initiate a subsystem cannot be used.

The reason for moving to FULL is that write pointer updates are not
persisted on each advancement, only when the zone state changes. So
zones that were opened might have valid data, but invalid write pointer.
So the device transitions them to FULL as it is allowed to.

                                                        QED.

> I agree the persistent state provides conveniences for developers. I
> just don't want to gate ZNS enabling on it either since the core design
> doesn't depend on it.

I just don't see why we cant have the icing on the cake when it is
already there :)

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9zdiIACgkQTeGvMW1P
DelMggf+KpkZZVuJjTRZ7LONGYYG69813iRtknujgxYcKk3e8IsrLtw2c930boyJ
xDzFkBZeXgDSgP+zn/4vHN2TRN8FqwAChvSYgAd2RRNpVPgI/cJk6i7JCI/ifEzg
Zb2hPtFadxYSxJSwRBHkD/2aC/JJ/B+2fR3Z9WVaSBnrJxN/qgroVQRpRfL9PFTk
Z4Wf/q2M1NZj4bMAZQ+8CVA0lMaU9SnJR4Y0r15ilL29Mdcnb/J6HEoIAG8Y2L63
oUQM2xhdMDS0ZvXYgBTOVOSeOiLRlJ9jvg4utcAco5gKr9mvG1s33th0Ot5HFka5
nHKzKm56fdYnKz89PlhADhBqQo19oQ==
=gF7e
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--

