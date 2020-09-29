Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DE4C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A53206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A53206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNIg4-0000tv-13
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 12:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNIci-0008HM-6u; Tue, 29 Sep 2020 12:37:05 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:54333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNIcd-0004qd-9o; Tue, 29 Sep 2020 12:37:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id BCEEE1470;
 Tue, 29 Sep 2020 12:36:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 12:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=YdzzrFWpDEdh+dIQSpqRfoUvAz+
 MfYgHtYPVD03aozI=; b=W+fVem2WTPVrxgZBehsrz/DhI/mV7HGuRJFOxm2FUwF
 YmFO4CaZxYHcUS2Ksxg1vHa+jtrytuie6VRodflDyJsm/2zHLk5Y4azpERgaYf79
 ZcLvpzdhxUionedshvTJgmFzUi6mBKtKalU3iBAZM0spLgPBmBQ5k2PJ4Yap1pB0
 o3lvLQDlJ/OdGK4Hgu9xuUMwirN4mOw/hUjxVI/6faaPwAdKgkFDzH9shk4kteny
 U+Khffp2cW7hNO7/ZIUCtptC6iGBqxpb7Crv/NblpsruKAlkRdp7o/Th8XMPTXud
 RiYWXZzAk2qAX8DqWQtPkdIzHRQ5KCD/A19uN1duizg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YdzzrF
 WpDEdh+dIQSpqRfoUvAz+MfYgHtYPVD03aozI=; b=KfOXiq7swHPlXKnn4ZVp7Q
 62DWDoAmRmsE0A5jmdwMEiUQXf2S8ysQuxweB4vvxyx5PiZ4jKupwoBKvSknky5s
 R6i5MOw4euG7GCKFIYExZyQz6gp/wpoFDg0pRFuPxqRE2ZDel2GK/t8/nseLB8DU
 R24JZAkB7ZjeSPchnRwK855pKw+qG7Zs2H1q1Klt9yeTKuEdM+zyphsOSregx/ai
 qwqSzWrdIvk8+8moydtCDzE9YERRP72XI+yVrPl9zXSCPncPnRQZxcXHAWQ4lBOx
 SZCjzu7GgiecXtAbjUcbdzHOpJNlF02do3aLb4yBi0+4fOWnMK4+yk9eD4GodMRw
 ==
X-ME-Sender: <xms:omJzX0p-pwzDRNrN_kmxcT-1mZ_Z9YxLFNvJQJT8crcMp6P3Csm1SA>
 <xme:omJzX6pd9b5C_NGw1ZuNroyVbccwGzRMHCGZ2NCagrQqNEtMZeJ9aMcuADHojqh0c
 dDAuOLwXyZ7gM4AS4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdekgddutdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:omJzX5P1t3x7oCEOsaZ0JDDrxfoZnuLX2LmQsu7Wa7SPeYVMps-Ylw>
 <xmx:omJzX74NXYMK5GS_fcKTbsNkK4vyE1ldpc9jh0gHK0nVZ0hQbdUKkQ>
 <xmx:omJzXz5SYzT1XiaqkxknHLPDi2qrmZ9fbFdDQFn9PrW2bP5W05ytbQ>
 <xmx:pGJzXwzwWij3AUWAVYRTy4YHbSG9JB-Ks4zz0fdAZu0pbaEu4ilD6ndU8-jXNimt>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id F33F73064610;
 Tue, 29 Sep 2020 12:36:48 -0400 (EDT)
Date: Tue, 29 Sep 2020 18:36:47 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Message-ID: <20200929163647.GA286786@apples.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200929104633.GA179147@apples.localdomain>
 <MN2PR04MB59517FB6076902451F463C5FE1320@MN2PR04MB5951.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <MN2PR04MB59517FB6076902451F463C5FE1320@MN2PR04MB5951.namprd04.prod.outlook.com>
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 29 15:43, Dmitry Fomichev wrote:
> > -----Original Message-----
> > From: Qemu-block <qemu-block-
> > bounces+dmitry.fomichev=3Dwdc.com@nongnu.org> On Behalf Of Klaus
> > Jensen
> > Sent: Tuesday, September 29, 2020 6:47 AM
> > To: Damien Le Moal <Damien.LeMoal@wdc.com>
> > Cc: Fam Zheng <fam@euphon.net>; Kevin Wolf <kwolf@redhat.com>; qemu-
> > block@nongnu.org; Niklas Cassel <Niklas.Cassel@wdc.com>; Klaus Jensen
> > <k.jensen@samsung.com>; qemu-devel@nongnu.org; Alistair Francis
> > <Alistair.Francis@wdc.com>; Keith Busch <kbusch@kernel.org>; Philippe
> > Mathieu-Daud=C3=A9 <philmd@redhat.com>; Matias Bjorling
> > <Matias.Bjorling@wdc.com>
> > Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types
> > and Zoned Namespace Command Set
> >=20
> > On Sep 28 22:54, Damien Le Moal wrote:
> > > On 2020/09/29 6:25, Keith Busch wrote:
> > > > On Mon, Sep 28, 2020 at 08:36:48AM +0200, Klaus Jensen wrote:
> > > >> On Sep 28 02:33, Dmitry Fomichev wrote:
> > > >>> You are making it sound like the entire WDC series relies on this
> > approach.
> > > >>> Actually, the persistency is introduced in the second to last pat=
ch in the
> > > >>> series and it only adds a couple of lines of code in the i/o path=
 to mark
> > > >>> zones dirty. This is possible because of using mmap() and I find =
the way
> > > >>> it is done to be quite elegant, not ugly :)
> > > >>>
> > > >>
> > > >> No, I understand that your implementation works fine without
> > > >> persistance, but persistance is key. That is why my series adds it=
 in
> > > >> the first patch. Without persistence it is just a toy. And the QEMU
> > > >> device is not just an "NVMe-version" of null_blk.
> > > >
> > > > I really think we should be a bit more cautious of commiting to an
> > > > on-disk format for the persistent state. Both this and Klaus' persi=
stent
> > > > state feels a bit ad-hoc, and with all the other knobs provided, it
> > > > looks too easy to have out-of-sync states, or just not being able to
> > > > boot at all if a qemu versions have different on-disk formats.
> > > >
> > > > Is anyone really considering zone emulation for production level st=
uff
> > > > anyway? I can't imagine a real scenario where you'd want put yourse=
lf
> > > > through that: you are just giving yourself all the downsides of a z=
oned
> > > > block device and none of the benefits. AFAIK, this is provided as a
> > > > development vehicle, closer to a "toy".
> > > >
> > > > I think we should consider trimming this down to a more minimal set=
 that
> > > > we *do* agree on and commit for inclusion ASAP. We can iterate all =
the
> > > > bells & whistles and flush out the meta data's data marshalling sch=
eme
> > > > for persistence later.
> > >
> > > +1 on this. Removing the persistence also removes the debate on
> > endianess. With
> > > that out of the way, it should be straightforward to get agreement on=
 a
> > series
> > > that can be merged quickly to get developers started with testing ZNS
> > software
> > > with QEMU. That is the most important goal here. 5.9 is around the co=
rner,
> > we
> > > need something for people to get started with ZNS quickly.
> > >
> >=20
> > Wait. What. No. Stop!
> >=20
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
> >=20
> > Please, work with me on this instead of just removing such an essential
> > feature. Since persistence seems to be the only thing we are really
> > discussing, we should have plenty of time until the soft-freeze to come
> > up with a proper solution on that.
> >=20
> > I agree that my version had a format that was pretty ad-hoc and that
> > won't fly - it needs magic and version capabilities like in Dmitry's
> > series, which incidentially looks a lot like what we did in the
> > OpenChannel implementation, so I agree with the strategy.
>=20
> Are you insinuating that I somehow took stuff from OCSSD code and try
> to claim priority this way? I am not at all that familiar with that code.
> And I've already sent you the link to tcmu-runner code that served me
> as an inspiration for implementing persistence in WDC patchset.
> That code has been around for years, uses mmap, works great and has
> nothing to do with you.
>=20

No. I am not insinuating anything. The OpenChannel device also used a
blockdev, but, yes, incidentially (and sorry, I should not have used
that word), it looked like how we did it there and I noted that I agreed
with the strategy.

> >=20
> > ZNS-wise, the only thing my implementation stores is the zone
> > descriptors (in spec-native little-endian format) and the zone
> > descriptor extensions. So there are no endian issues with those. The
> > allocation tracking bitmap is always stored in little endian, but
> > converted to big-endian if running on a big-endian host.
> >=20
> > Let me just conjure something up.
> >=20
> >     #define NVME_PSTATE_MAGIC ...
> >     #define NVME_PSTATE_V1    1
> >=20
> >     typedef struct NvmePstateHeader {
> >         uint32_t magic;
> >         uint32_t version;
> >=20
> >         uint64_t blk_len;
> >=20
> >         uint8_t  lbads;
> >         uint8_t  iocs;
> >=20
> >         uint8_t  rsvd18[3054];
> >=20
> >         struct {
> >             uint64_t zsze;
> >             uint8_t  zdes;
> >         } QEMU_PACKED zns;
> >=20
> >         uint8_t  rsvd3089[1007];
> >     } QEMU_PACKED NvmePstateHeader;
> >=20
>=20
> Why conjure something that already exists in WDC patchset? And that part
> has been published in the very first version of our patches, weeks before
> your entire ZNS series was posted. Add an rsvd[] here and there and that =
code
> can be as suitable to achieve the stated goals as what you have above.
>=20

Yes, I read your code. I know you have a header and I also noted above
that "it needs magic and version capabilities like in Dmitry's series".

> > series,
> > With such a header we have all we need. We can bail out if any
> > parameters do not match and similar to nvme data structures it contains
> > reserved areas for future use. I'll be posting a v2 with this. If this
> > still feels too ad-hoc, we can be inspired by QCOW2 and the "extension"
> > feature.
> >=20
> > I can agree that we drop other optional features like zone excursions
> > and the reset/finish recommended limit simulation, but PLEASE DO NOT
> > remove persistence and upstream a half-baked version when we are so
> > close and have time to get it right.
>=20
> One important thing IMO is to reduce future need for metadata versioning.
> This requires a really good effort to design and review the proper metada=
ta
> format that would become stable for some time. Think about portability.
> To get out something "conjured up" now and then have to move to V2
> metadata in the next release is even worse than no persistence at all.
> So maybe is makes sense to go with Keith's suggestion.

As I've said, we have time until the soft-freeze to get this right. I
"conjured" something up to show a point. The reason we review and
iterate is to NOT upstream something thats is conjured up.

But we gotta start somewhere, no? So what is so bad about me posting a
v2?

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9zYp0ACgkQTeGvMW1P
DekZ1Qf/d0Q2+ihd8c8Mzgq1reTODUfFC9lOPLQzI1i6c4ay0jwVvxoaO/r8pQGM
CaoKbXOz/5JIGybV105ZVBVB84BKQ9MzziHFIqA/4tFkFq5SGcVGMQ34TAhk1hmN
iJY5ZYozV/xU1ku0JljyJ7U/sZVjNBvA4U8ptr3upGse6tTzaWvdwVPnSCvA4bSe
U9lMqUZzQmC0zKjvU4+/KWtjOCU43DpP5YurRy4NA3Nf6yBoq5NaRd4rat0+hjex
yxzsZiQwr0NAC2a7sO9kmYLFTqejEOK2zfOjpvEoOBSsaPU/57C/Ad2u9Hphl4ze
b1mJH+Pz8nR/xBx/eQYdpCgjUTFo3Q==
=Qc00
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

