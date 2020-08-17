Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51F9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 07:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A482072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 07:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="HgH8XsZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A482072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ZCu-0005Jj-QH
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 03:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1k7ZBr-0004uY-An
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 03:04:19 -0400
Received: from charlie.dont.surf ([128.199.63.193]:39192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1k7ZBp-0000xM-2b
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 03:04:19 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 8CDC0BF425;
 Mon, 17 Aug 2020 07:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1597647854;
 bh=d5HOEjIMbUDQ+4HVEbEhFmg51YX8KGbDYgNklelBRWE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HgH8XsZ6+7iR2RMEaMKbWmvg5D8CedUrKMkaqBe1tRNCvpXcU0LqjipEBCGsYdU2d
 qqUifwrQYv76xKW2ZD3vDJZFdTdWSGO6YGSJUO9Q17Qo6uxEzwHDHEWSOmhELpWuRC
 dj++WsjtW3pnbnqQW8zbTJnEZF9qAL1TJ4pLcJZNCsYZnLO4Ei32cwTC+mq0ah8ZBx
 L51WvV7QfHC9LIYGv0FtWrk9v2PkuDKX30rM5DDAHvtVBh3faUlXo+S0nombJDDGfO
 pwzDMP/5m/VftQgdAveoI1Wu4sIgUBKf/Vsn3wUOmYmXxjas1XUQd3ZF6ga/SVLKsX
 NnxtJyRkivr2g==
Date: Mon, 17 Aug 2020 09:04:08 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] pci_dma_rw: return correct value instead of 0
Message-ID: <20200817070408.GA17572@apples.localdomain>
References: <20200729221732.29041-1-e.emanuelegiuseppe@gmail.com>
 <CAFEAcA_XfRWFSp3X03=g_FrjL3eqRG_DY8AZE1crxDGKnJKNnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_XfRWFSp3X03=g_FrjL3eqRG_DY8AZE1crxDGKnJKNnQ@mail.gmail.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:29:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 30 09:48, Peter Maydell wrote:
> On Wed, 29 Jul 2020 at 23:19, Emanuele Giuseppe Esposito
> <e.emanuelegiuseppe@gmail.com> wrote:
> >
> > pci_dma_rw currently always returns 0, regardless
> > of the result of dma_memory_rw. Adjusted to return
> > the correct value.
> >
> > Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
>=20
> We also have the equivalent patch from Klaus Jensen back in 2019
> which got reviewed at the time but seems to have gotten lost along the wa=
y:
> https://patchwork.kernel.org/patch/11184911/
>=20
> thanks
> -- PMM
>=20

Yes, I posted this a while back because I need that return value in the
emulated nvme device - so please don't make it void ;)

My patch was part of a series that has not gone in yet, but I can resend
seperately - or you can just apply the patch from Emanuele. It's no
biggie to me as long as the fix is there!


Klaus

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl86K+UACgkQTeGvMW1P
Dek2Lwf/Qxe+rizbGCy0r5i/ePaUaFAvL85s+cRWwFxm+MSH1okSB4ctDRmFRy/D
7EBYmzCZdsIh4C39xkxATuk/uQldDeeTCCqRaElFtD8tqiRJxXuV8VvcAmDrWOw7
RMt3fC7rwBI5ZKruXtkU3rwY5TVffL6UsWK7Jas78ANKcMb44mHlAQd5w4s/UkGk
sPg9hc+wwhCqNEqmemLcu8jlhcYxKPj47h9u1laE0roOSc3NbRs+W6lnO4pAM34m
aH0DLMm3uNhMoaWjxKYCKbuYj9iswx4cBSbt6jx+HKoH3Z0CCXn/+cZgPBjzkXh5
QyShDE+sxmidRZEMNVLMP1UE3loO1w==
=UueB
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

