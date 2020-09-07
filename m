Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BFBC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 07:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F622145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 07:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F622145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFBwf-0004sj-Md
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 03:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFBts-0003Kr-Mf; Mon, 07 Sep 2020 03:49:17 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:39455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFBtp-0004cE-Ru; Mon, 07 Sep 2020 03:49:16 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id F1399768;
 Mon,  7 Sep 2020 03:49:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Mon, 07 Sep 2020 03:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=hUfR+M40P255zuvfU8Rp3svGBrJ
 GyJrc0SNXENyN5ws=; b=j4fId2uFL/XAwbot6kHa37pkLChttxWbNtOtoTgacgT
 OPnXdwKEEdrdJu4wY5QtWXUBA3zsw68PfHU8eA1uMPWx3lmxhM3hZ0rJatS8F9FH
 gskH3rpbgGzLQq+PRkAXoW8SxwmZcqNzf2bGFn8v5bfaZBTdKfecpmYMDNEgpYzy
 Vkh5AuEmx3GYOw8RZSxHOP2s0UA7E6TnKhQ2VUnwWasmUJl2alcqkd84V9rkNQ1j
 O6OAPXy+8FC+iQ3Lx60c4z+xtkUUNTpH6sk23Xj3Cl1XlIHpqp98KohDp0RJJqEX
 lfmyN6HOCndwQHMwg/t52RaHGsQF59dqYe36Qef/5xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hUfR+M
 40P255zuvfU8Rp3svGBrJGyJrc0SNXENyN5ws=; b=H2tjZ6XiDXG482xdkylS2v
 t5VEe/3dnHnxPneBn8WPH9l14fV4z4ThYku39IlraL5SblQMv4NZS3mTrDGHU8ny
 hSNt1iPiX2vcQU/aT+JFT0aTA4sM3jFCBND7oGSv8SJS+4lRjFy2m68kM80HGrNP
 ulenxRUgs5Nxkbcn7l7KdQCIkdUCuzmGMYsyd55sSk0YWAG3o+OQIZjPYhrgMBIL
 /dah6LKSjx+sU9dESpBH9vvSh4oLuQuHU01MkwO7t80pcZUM+Ok8j1gRKBt3LrR0
 0NB4ocjzaze4Ck5wbhjWfw2/pLIOUPUSZ6n2KL39Lf3gCBCmYznxx68P5/YZvOtA
 ==
X-ME-Sender: <xms:9eVVX4-Fpf8l6yux_a-F9xpSohoO712U5qCZkb0DZk47uqZF7FsrAA>
 <xme:9eVVXwt0QvlkWSsHXZTNVvpD-4vCcXNfnPdjDjrj08N2fTo6CQ6eJQGlKN-Ez1e1p
 H3NmfxOPygpnC95sQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegledgjeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeduheelvdfgfeegteefgfffudetlefgfeffkeeiffejuddtgfduteffvddugfei
 ueenucffohhmrghinhepmhgrihhlqdgrrhgthhhivhgvrdgtohhmnecukfhppeektddrud
 eijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:9eVVX-CiEVG4ZalGL6VmRwtZ1p3OGzu7so0sWgPIyXNd-bWBONoKQg>
 <xmx:9eVVX4cFOwgzCj8d2Kp1EBRKI3RwtOEXCVvU8QMgZcO4Nb_7opNfhQ>
 <xmx:9eVVX9No0O6UrKa0uNwef3QQ3_NqYbVUgyfNbsY4Sc5-A24IkuScAg>
 <xmx:9uVVX2gD773gUtpJvM_S7hFJYa5LAw2iHIDeQOFf_br2pZKWKzEzMIL8QtIlK7uGb4ou2g>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id D6DCD3280059;
 Mon,  7 Sep 2020 03:49:07 -0400 (EDT)
Date: Mon, 7 Sep 2020 09:49:06 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 02/17] hw/block/nvme: handle dma errors
Message-ID: <20200907074906.GA697696@apples.localdomain>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-3-its@irrelevant.dk>
 <80b8b35d-8bf9-6f34-6b81-7116a294faa4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <80b8b35d-8bf9-6f34-6b81-7116a294faa4@redhat.com>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:23:39
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
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  7 04:34, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Klaus,
>=20
> On 9/4/20 4:19 PM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Handling DMA errors gracefully is required for the device to pass the
> > block/011 test ("disable PCI device while doing I/O") in the blktests
> > suite.
> >=20
> > With this patch the device passes the test by retrying "critical"
> > transfers (posting of completion entries and processing of submission
> > queue entries).
> >=20
> > If DMA errors occur at any other point in the execution of the command
> > (say, while mapping the PRPs), the command is aborted with a Data
> > Transfer Error status code.
> >=20
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Acked-by: Keith Busch <kbusch@kernel.org>
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  hw/block/nvme.c       | 43 ++++++++++++++++++++++++++++++++-----------
> >  hw/block/trace-events |  2 ++
> >  include/block/nvme.h  |  2 +-
> >  3 files changed, 35 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 63078f600920..49bcdf31ced6 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -140,14 +140,14 @@ static inline void *nvme_addr_to_cmb(NvmeCtrl *n,=
 hwaddr addr)
> >      return &n->cmbuf[addr - n->ctrl_mem.addr];
> >  }
> > =20
> > -static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int si=
ze)
> > +static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int siz=
e)
>=20
> If this get merged first:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg737483.html
> then please return MemTxResult, ...
>=20

Noted! :)

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9V5e8ACgkQTeGvMW1P
DelpCQf/dkizqr/r3ouEPsXIWq5rlJqNReqT7w+kguSG2Fk7SRdU2z8PZnPsjmFk
dDMstaYfUtjqLdej9vwbJ9gqXzyoGF8mD7fDon93tNpyU0vwzmi26eHTh4BghVHq
BE3/1iGxQKRoSI4MIHYCshlxj4Bkiort3ErieCWavOBVktSHPvcE05MOufzm1kAy
4qNmomBLM0O0oTjTbkAsP/8nJ48YviYUK1B3ERX/Yo5031AgD65QNzKoVkC8SIww
fXhYUftndhv7WntT0NbMPzDSDXRN7OXNzdeYAt1+sdsbHmFVLKGQE+whKA11Khi9
4bpU41wn0SDAH2bSd6tw29TFdhkmyg==
=kk4V
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

