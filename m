Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB75C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FB321481
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FB321481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEwm-0000aE-Hd
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFEuo-0008Se-KG; Mon, 07 Sep 2020 07:02:26 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:47637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFEum-0007Bk-Ej; Mon, 07 Sep 2020 07:02:26 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id 82589839;
 Mon,  7 Sep 2020 07:02:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 07 Sep 2020 07:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=7U/ZlxOgzp5CMcm+5t3hZ1+xKQc
 F34UxOR+oUIYKdyk=; b=l3uvvodW0OMfBwJ7lugQhJYVeT3bbc0RfH77dm+c86U
 7w79NCBI6mpH9n+nChA3DKvzQi7EV1yU9quaaw1ws1L9QRbt1/X9yH/lAFxryINK
 0rQ0daqcumnbpNzR2QKGJFBhsnYUF29uEKEUSGmd9wD0TKTc6vS2V8Gx8L3snsf8
 hGt3ALO0rSgNg0tXtQNYUlE++W6+nBo+I8CsySfwUR8a5D/9OMmCRqdy216s4Pq5
 0hIhG+oda/8p9BMv6L74EOs5+7BQu2sQCq35Qe+OFMtz1MCRE3mX6mrwv2ecswFt
 HWED6qz6jxWihvlmnwnyHTTNy9sxw706dlz1wproOEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7U/Zlx
 Ogzp5CMcm+5t3hZ1+xKQcF34UxOR+oUIYKdyk=; b=odTkLSOk2b6JvBmJ1caIIm
 +/yc89CLP1o5BPDPW3OpgbDxQ+VuzqIdSIcNlvwxI4cAN+pl4SvXl1xZqV/g8Jep
 o6DJVj8NXKidFiLs3QykQjOTcNjATuiDtd7sfSVKqy2oIvq7n38QuswP6bMj3mYe
 SNEYf7R2+3RctmCtU9vbcA7Nc0My5XyFWHnByXVUtPPucBNG5jKgTn7JUaD33YWm
 hyNf/fNXHejoBIYTMWbhxLYa8dq0b8SK/hJx/+ipUPaOW6xJQATTWiSXuelwXYmw
 AAv0x31NZNq8k1/FnlSpgs8Quc3D1FwUDnbEVdfc/PQFEDMDobOeD4R3h0he6EEg
 ==
X-ME-Sender: <xms:OxNWX6p8pZ_8RY8yxmeBx8J2VmDG48rU_TxzQST4yi7Rur2Vlh1g4w>
 <xme:OxNWX4rsJEjRiEh6UEDxpFS9FwbkBs_Z2Tu7H3LnV6ESSpvci7l5geesQs0220r_4
 g9W-lCBDA3Dl5FhOos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddgfeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:OxNWX_MK1ZY63n6BQNd2IGrlgru_LvNqIJiRMT6CKlZoQTuRrsGElA>
 <xmx:OxNWX55nc7dD3heYY1ncbEOcFHVQmYHIaaA9YnQv5AmSIxDups807g>
 <xmx:OxNWX57WJpFuVP7xPiC_Rykpg5u3_QEN8kpGdP1Qki4okgROOHpcaA>
 <xmx:PBNWX-GryctLo7fdjt9vq6O9T1e_wRztDjCLQtR5t-S4u6eXL59J1p__cdKj4lIIrIaekA>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C26063064674;
 Mon,  7 Sep 2020 07:02:17 -0400 (EDT)
Date: Mon, 7 Sep 2020 13:02:16 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 17/17] hw/block/nvme: change controller pci id
Message-ID: <20200907110216.GB732668@apples.localdomain>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-18-its@irrelevant.dk>
 <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
 <20200907103708.GG2682@work-vm>
 <20200907105024.GA732668@apples.localdomain>
 <20200907105257.GH2682@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <20200907105257.GH2682@work-vm>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  7 11:52, Dr. David Alan Gilbert wrote:
> * Klaus Jensen (its@irrelevant.dk) wrote:
> > On Sep  7 11:37, Dr. David Alan Gilbert wrote:
> > > * Philippe Mathieu-Daud=C3=83=C2=83=C3=82=C2=A9 (philmd@redhat.com) w=
rote:
> > > > +David in case
> > > >=20
> > > > On 9/4/20 4:19 PM, Klaus Jensen wrote:
> > > > > From: Klaus Jensen <k.jensen@samsung.com>
> > > > >=20
> > > > > There are two reasons for changing this:
> > > > >=20
> > > > >   1. The nvme device currently uses an internal Intel device id.
> > > > >=20
> > > > >   2. Since commits "nvme: fix write zeroes offset and count" and =
"nvme:
> > > > >      support multiple namespaces" the controller device no longer=
 has
> > > > >      the quirks that the Linux kernel think it has.
> > > > >=20
> > > > >      As the quirks are applied based on pci vendor and device id,=
 change
> > > > >      them to get rid of the quirks.
> > > > >=20
> > > > > To keep backward compatibility, add a new 'x-use-intel-id' parame=
ter to
> > > > > the nvme device to force use of the Intel vendor and device id. T=
his is
> > > > > off by default but add a compat property to set this for 5.1 mach=
ines
> > > > > and older.
> > > >=20
> > > > So now what happens if you start a 5.1 machine with a recent kernel?
> > > > Simply the kernel will use unnecessary quirks, or are there more
> > > > changes in behavior?
> > >=20
> > > Seems reasonable to me...but...
> > >=20
> > > > >=20
> > > > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > > > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > > > > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > > ---
> > > > >  hw/block/nvme.c   | 12 ++++++++++--
> > > > >  hw/block/nvme.h   |  1 +
> > > > >  hw/core/machine.c |  1 +
> > > > >  3 files changed, 12 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > > > index 453d3a89d475..8018f8679366 100644
> > > > > --- a/hw/block/nvme.c
> > > > > +++ b/hw/block/nvme.c
> > > > > @@ -2749,6 +2749,15 @@ static void nvme_init_pci(NvmeCtrl *n, PCI=
Device *pci_dev, Error **errp)
> > > > > =20
> > > > >      pci_conf[PCI_INTERRUPT_PIN] =3D 1;
> > > > >      pci_config_set_prog_interface(pci_conf, 0x2);
> > > > > +
> > > > > +    if (n->params.use_intel_id) {
> > > > > +        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
> > > > > +        pci_config_set_device_id(pci_conf, 0x5846);
> > >=20
> > > Wasn't that magic number 5845 down there ?
> > >=20
> >=20
> > Argh! My first version of this just bumbed the intel device id and it
> > got left there.
> >=20
> > Good find! Thank you!
>=20
> It may be best to turn it into a constant in include/hw/pci/pci_ids.h if
> it corresponds to some real Intel device.
>=20

Yes, but that is just the thing - it does not correspond to an
officially allocated device; which is why I think we should leave it out
of pci_ids.h.

The end goal is to get rid of its use in the code by deprecating the
use-intel-id parameter in the future. I guess the parameter should just
be deprecated immediately? Then we can get rid of it in, what, 5.4?

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9WEzMACgkQTeGvMW1P
Delxlwf/U9C6mJ4n06tdlEetoiHfhgBhV4MuJzb1GIU2CS86dopak7uCpQWOguZ5
3OSw/p0pNvFOi+LJoEapQw09xj6Xv+5AYvUiHurN8D9Tk3gEME0E19JH+meczS3p
WwQzEUQjzc/FD1iJn2FZZrP0vY8nuwoOI1LmVClKy124a+ulKHeeK5z7Ck+q+lNo
jTLwd3pGWMjvL8SSqCuPfmIRbfYiErvBHvwajgxurha/4SPAvimYpLog7u1J+P94
b9UFUkyGDPnvS3FZ5huAhYi7Vca+oyAgwq8jx2T6UAcZ4BHZPEf/8Yp9IqbBHXDH
h1M+dJYOruTrY78LYXIGPkgiXRp4Vg==
=HHp7
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

