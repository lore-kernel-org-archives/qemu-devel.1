Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D6DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E881C206D4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E881C206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEmA-0004qL-J3
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFEjM-0002mH-NN; Mon, 07 Sep 2020 06:50:36 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:34925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFEjK-0005d1-5d; Mon, 07 Sep 2020 06:50:36 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id 984DF363;
 Mon,  7 Sep 2020 06:50:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Mon, 07 Sep 2020 06:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=0FhPyCkd7OtM4N/rm6PPZjba8vf
 Ga6iqr/kWJS3F3bc=; b=IGc2lo/pqZklcHkDvBGSwLWjboa7KGKkdC9YL6aqyHH
 mHemNjoaCIDFyGv3OkO8F1OUMAm3ctOYP5IDefPurDZrdvrPyBlstTuGmalaMpp9
 bHDC3h4OHUoXfa/oVnmw84EYDIRWs6g4PkBCblsbbYTsKslwQyiPsE1Yff2j0EYN
 h5PzTNJmXcUbsI2q6y3r3STw9RYxek5pm+iJ+LQW2PsLcXZk2ChAPoILFLh7yUvI
 hj6kgsNe+Ww9VrGkuaruD1wD9T8Jvb/m/aoyQXMFsMxNImbruS7r/RHX57HiIyKd
 FZl9fj8kJTBIuy7DJStF9V7/801MpjdBc+1seckpNjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0FhPyC
 kd7OtM4N/rm6PPZjba8vfGa6iqr/kWJS3F3bc=; b=rhNCAIpk8hb1nEacM1952A
 fSfrJCerT49tCvBFAKGiqR2k+MbtEKxhNYjjXTUr77s56/8dfbyJb/CBfyB8yQoK
 tfA9ycDw8x+A1nZjJmbBHELWKE0e5AIpOE0oKMFvRPEcvbR011RLMjtnJNfuy1sd
 7hkaVR22x/ark6oE0NPa5RWr+9A5mmZ5SFHVlyHKtyiLbSxlGFT9sbr1mtQLMaci
 UowubhRb8851nssMYtC2f7syxdz7bLI2g3/MZBbRTdtETxWD2DlWbiRSCgc/qQ8I
 f9hT6etnTxoL8BRiPRIxY74Mmsc4ZmRbKeC4RV83+Ov5Kp2mqnTtDKYAu/0RGoKg
 ==
X-ME-Sender: <xms:dBBWX9c9oHdaW4tteiRRXetxr_xrdNO8TxVGhaNwEzTXc0TleMwUqA>
 <xme:dBBWX7Oa86KVjLafzHURtwsUmKKiUDHmHLyuQbBHxamxs9Egs3li6KzZFakl0FnOw
 3ET_EOq-Kq39fIbxIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:dBBWX2gIGg3L6uVci9CH1gDwW1vdzuswIexDMmh71SOtPv8Dd374_Q>
 <xmx:dBBWX29wZixP3abgvK7PmAldD-xZSVtY1XOAfdXhnyK1ws2UXeq9TA>
 <xmx:dBBWX5tdORWuvvXXKApDMGwuJo0TTokk5wmNfZL0BGFJ3tTKH1NWcw>
 <xmx:dBBWX_KKRMI6-Z0iB5o13kjjoxiHn2IuAgE20E-WuuO5F1CTVVX884QaFWvNFnihqZXheA>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 95D6C328005E;
 Mon,  7 Sep 2020 06:50:26 -0400 (EDT)
Date: Mon, 7 Sep 2020 12:50:24 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 17/17] hw/block/nvme: change controller pci id
Message-ID: <20200907105024.GA732668@apples.localdomain>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-18-its@irrelevant.dk>
 <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
 <20200907103708.GG2682@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20200907103708.GG2682@work-vm>
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


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  7 11:37, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=83=C2=A9 (philmd@redhat.com) wrote:
> > +David in case
> >=20
> > On 9/4/20 4:19 PM, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > >=20
> > > There are two reasons for changing this:
> > >=20
> > >   1. The nvme device currently uses an internal Intel device id.
> > >=20
> > >   2. Since commits "nvme: fix write zeroes offset and count" and "nvm=
e:
> > >      support multiple namespaces" the controller device no longer has
> > >      the quirks that the Linux kernel think it has.
> > >=20
> > >      As the quirks are applied based on pci vendor and device id, cha=
nge
> > >      them to get rid of the quirks.
> > >=20
> > > To keep backward compatibility, add a new 'x-use-intel-id' parameter =
to
> > > the nvme device to force use of the Intel vendor and device id. This =
is
> > > off by default but add a compat property to set this for 5.1 machines
> > > and older.
> >=20
> > So now what happens if you start a 5.1 machine with a recent kernel?
> > Simply the kernel will use unnecessary quirks, or are there more
> > changes in behavior?
>=20
> Seems reasonable to me...but...
>=20
> > >=20
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  hw/block/nvme.c   | 12 ++++++++++--
> > >  hw/block/nvme.h   |  1 +
> > >  hw/core/machine.c |  1 +
> > >  3 files changed, 12 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 453d3a89d475..8018f8679366 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -2749,6 +2749,15 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevi=
ce *pci_dev, Error **errp)
> > > =20
> > >      pci_conf[PCI_INTERRUPT_PIN] =3D 1;
> > >      pci_config_set_prog_interface(pci_conf, 0x2);
> > > +
> > > +    if (n->params.use_intel_id) {
> > > +        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
> > > +        pci_config_set_device_id(pci_conf, 0x5846);
>=20
> Wasn't that magic number 5845 down there ?
>=20

Argh! My first version of this just bumbed the intel device id and it
got left there.

Good find! Thank you!

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9WEG4ACgkQTeGvMW1P
DekBDAf9EsxYjOSnlBo9+hAb8l1/hWZluQ70N2XcH9XUGj/gPLP6L/E99tWl1+ND
y2nbtGKfacDXCC3yeBo05Io6yPnmSvdY/OYV8TZuDLbOe8+i5HKQLCvnCNbKR0/J
ow7jIhoy++cyTpNlgGtgNZOeFQmXa7b8FaPN29akXrhjquEcC0Onr52FTsLY1EV3
/KRG3m02UQhz+JSx36hN+bj6pvMys588nJl4/JHHfTaSoAVWzquuTUHa/6dUt++j
fMKkwq/1TTpecjb+8YgXgzcZPiwUq0LLgi3Ei3UixaMJSYORix0rP31ekUemDSMy
Jdz5NUmlkbnqeledBCEIb2pyN1B5Qg==
=XdHR
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

