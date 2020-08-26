Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BA8C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 05:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C25E206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 05:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="hjNJgxJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C25E206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAoMU-0003ej-9C
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 01:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1kAoLX-0002s0-1C
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 01:51:43 -0400
Received: from charlie.dont.surf ([128.199.63.193]:59220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1kAoLT-0005ML-UG
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 01:51:42 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 9C59BBF827;
 Wed, 26 Aug 2020 05:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1598421096;
 bh=MEEL5jTSSUgb37dNylQmWwiFLzjQkVvC8oSdVcqy2e4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hjNJgxJDlIjNi+BUwCrqfAppktF/YVb/banmSoXwRQF5uqIHQT4Z1pRAMcPQuUMPR
 ci4MwPE2wl1sop5aEw/mKdfkeENB7/Yh+Yv8TX78I+TYxXhkErcnIDzcBc1w6b3OkN
 dGze7lbH/21vS2HDb7TxZEbtP/LrAmRyRVy6Nli7kCGQjzIVJBzW3e8u6RTHG8scWR
 gxwPdV8nvJA95LzTGJMK74SzWOne9a7PjtZLeeYPUYjlNALlQcWURVMIXnQp+xZEys
 XF7DHsWkFKKLWX4Vgq2ARTYN8IteruvLPrZCxIotsUbgVz3cHdKz5Z3a+WmhFBgxAt
 ZieL4iX/g1qoQ==
Date: Wed, 26 Aug 2020 07:51:33 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PULL] nvme updates
Message-ID: <20200826055133.GA897000@apples.localdomain>
References: <20200819192240.GA25305@dhcp-10-100-145-180.wdl.wdc.com>
 <CAFEAcA8-VgEDTZ7+T9ZgB2LR9KWRrejBtZN=iwy2GGPcuFuz2Q@mail.gmail.com>
 <20200825201242.GA20971@redsun51.ssa.fujisawa.hgst.com>
 <CAFEAcA-SD1WMODNzZpJkq_39bk72Gf+XFhCKWEDjTb0Lvdfe9g@mail.gmail.com>
 <20200825222804.GB20971@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20200825222804.GB20971@redsun51.ssa.fujisawa.hgst.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:51:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 26 07:28, Keith Busch wrote:
> On Tue, Aug 25, 2020 at 10:43:23PM +0100, Peter Maydell wrote:
> > On Tue, 25 Aug 2020 at 21:12, Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > On Sun, Aug 23, 2020 at 02:56:12PM +0100, Peter Maydell wrote:
> > > > Hi; it looks like this isn't a gpg-signed tag?
> > > >
> > > > error: remotes/nvme/nvme-next: cannot verify a non-tag object of ty=
pe commit.
> > >
> > > Oops, sorry I forgot about that part of the procedure here. The repo =
should
> > > have a signed tag now:
> >=20
> > Thanks; the gpg key setup looks ok.
> >=20
> > I notice that all the commits in the repo have Klaus's signed-off-by.
> > Usually the expectation is that the person who sends the pull req
> > is the one who's curated the tree and added their signed-off-by,
> > but are you doing a jointly-administered tree here ?
>=20
> Right, Klaus is the primary committer for our joint repository, and I
> added his info to the MAINTAINERS file in the first commit of this pull.
> Since he's not currently listed upstream, I thought it made sense to
> make the introduction here. We'll coordinate pull requests as you've
> described going forward.
> =20
> > The build has a format string issue that shows up on OSX, Windows,
> > and 32-bit builds:
>=20
> Sorry about that, we'll fix it up ASAP.
>=20
> > In file included from ../../hw/block/trace.h:1:0,
> >                  from ../../hw/block/fdc.c:48:
> > ./trace/trace-hw_block.h: In function '_nocheck__trace_pci_nvme_err_mdt=
s':
> > ./trace/trace-hw_block.h:2162:18: error: format '%llu' expects
> > argument of type 'long long unsigned int', but argument 6 has type
> > 'size_t {aka unsigned int}' [-Werror=3Dformat=3D]
> >          qemu_log("%d@%zu.%06zu:pci_nvme_err_mdts " "cid %"PRIu16" len
> > %"PRIu64"" "\n",
> >                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >=20

That's on me. Keith, fixed in our tree now.

Peter, this doesn't seem to get picked up by, say, `make
docker-test-mingw@fedora`. Should it?

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9F+GAACgkQTeGvMW1P
Dek/Egf/VUxbyOsSg3ojM4aNXXfb5K6tB2yCodF25LV/LLvgZ2Ycq58BikzASXzI
5JPUk0KoNyFu96oS8imfHazQ1PQ1dr2RG3cQK2uHi04CSO5A6EOoiTFX01n3Onpw
sKvR9yFoyw8L4o6GvQZkwJx7MV6nWNhIaxgkSZBYSgyx8ZqBFzdkBYoIXlK0AiVv
8gGKRS/8SGwoeSSkyZ3NlfYQizSDjlc6rkebPrsijJvA0b5MMt2eyFmGxskVqK8K
+y5cuw9B6pTu1nUtOKH9Cn7T4WGO0HwiNpAx9MDkHwnjqGXIaFyc4k4T9gpoEeyb
OjMwl5JH5NGYimmFLdk7JC/6HNECzA==
=X5Og
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--

