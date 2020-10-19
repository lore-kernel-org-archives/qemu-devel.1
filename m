Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AC4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05E3222EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05E3222EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUZ3c-0001n5-43
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 13:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUZ05-0000Ye-P7; Mon, 19 Oct 2020 13:31:15 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:54673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUZ03-0005fD-18; Mon, 19 Oct 2020 13:31:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 38EAC793;
 Mon, 19 Oct 2020 13:31:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 19 Oct 2020 13:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=/mt0GAFdrGAiNoFPYWlHnOZSQWa
 3S99EftvEcSEdRGg=; b=NU+CyevPej3wm5LAakIAYJBU2MoCtZLgXk9fBijXlMS
 p/KyeM4Z55TbYJWr2hW6tYzv+oxl3bUwYkJptHTiTJWnad0H/wlOU41/M+Iwn0zE
 XPQVvI5EUyuHmb1OUl0t/hWXufvMoIDCiRBoBQ+qjKpm1efeY4ILMmWf6MV1pXYL
 gKGPrlykBEd9W6Nl1aD2zVqerRAt/Pe4jtfSWs2dRVUTBY484uUGW8NyN9ccF4jY
 ISQPSdkg0tHYti59g5v47RPrAuT3l1fhQ7DbKh5FBONM8orDjTMIph0sUvlccImP
 ISaqlWVg/yi0Hitr8WsOBRB0nwyKrHuwNw4OKX6jTQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/mt0GA
 FdrGAiNoFPYWlHnOZSQWa3S99EftvEcSEdRGg=; b=hEErORGqtBYgRQDXWYbq+r
 HqDCtZrrTDQ2MM10yWVH8hrauEYp8uZKjB+HCI6hHdRz3rjCd4D0Rk7g2vvNPnty
 XBtMpdz5VHyEaohifwlIYg3+6UGsDWeZE6EEJVyM+oySTkFECHNZSe1AQPf9cKXg
 wKfQjq/CNzt5/KLNa4RxLkV0SWxsXKMOkynYXsgmmza7SNey7CXseH9yaI1fqZ8e
 3HWf+MUXfmNA8c+wCYXzKXayZwuMFKJQCvDb+zphZMVuYB9wQX1wTSdxCzplQyjI
 f4NkqWsBWRDXSV01bjFLEBYN163xFy2lykm3GHKYMnstyDJDeVv6sFkHGcAjF9Bw
 ==
X-ME-Sender: <xms:Ws2NXyEi2okUYkBa2eYekuXVrDubc7IFc2RUiF70aGeqdjpcj3fDQg>
 <xme:Ws2NXzVK7AjPe5IuMfgoigiekXjTrsy--mRchj65L0OKaUEd_8r05JnL54H0bXDCq
 4wyIrmHyFPEiLFXWAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugdduudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:Ws2NX8KOg21ecTx329aFriQpqwB0s3lZHblaWfN5vjvcUlVdMJXE-A>
 <xmx:Ws2NX8GAAe_yOK49-n6j08f5K_tP_S312Z4wBGn6KW3zVgjBvcFpaA>
 <xmx:Ws2NX4X8gGlhCZG8G-qXVn1XH0r7fIzBWORq6e13nr_vVtnlHJxsdw>
 <xmx:W82NXyfmtVMTbRVWiLdt4lXormE07i5Sp9Lsc2jtgdW7JRHitu3MrJ8FtLk>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 55A31328005D;
 Mon, 19 Oct 2020 13:31:05 -0400 (EDT)
Date: Mon, 19 Oct 2020 19:31:03 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] hw/block/nvme: fix prp mapping status codes
Message-ID: <20201019173103.GE10549@apples.localdomain>
References: <20201019113039.76146-1-its@irrelevant.dk>
 <20201019163455.GA1435260@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <20201019163455.GA1435260@dhcp-10-100-145-180.wdc.com>
Received-SPF: pass client-ip=64.147.123.26; envelope-from=its@irrelevant.dk;
 helo=wnew1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 13:31:09
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 09:34, Keith Busch wrote:
> On Mon, Oct 19, 2020 at 01:30:39PM +0200, Klaus Jensen wrote:
> > @@ -328,7 +328,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t =
prp1, uint64_t prp2,
> >      trace_pci_nvme_map_prp(trans_len, len, prp1, prp2, num_prps);
> > =20
> >      if (unlikely(!prp1)) {
> > -        trace_pci_nvme_err_invalid_prp();
> > +        trace_pci_nvme_err_invalid_prp1_missing();
>=20
> Why is address 0 considered a missing entry? Some embedded systems
> consider that a valid address.
>=20
> Otherwise, the offset checks look correct. And I realize the check for 0
> predates this patch anyway, but it's not the correct thing to do: as
> long as the host requests a properly aligned address, and 0 is aligned,
> the controller should attempt to use it.
>=20

Uhm. That's a good point.

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+NzVUACgkQTeGvMW1P
DenTBQf/XzuDaZQ1iaCJFIJJRXMT9hSIyHJvxBUV1jwsykjRXNkeZJpltM3YgJY0
jtNCM/DU7be7YRAyE2fy+kqSPMUbjag/VFtCMUMlFTfuj10NP7wgO/on+Ipll1QL
5E885ITvjTH5LTHQnEpdFKEAhuUDq1+NT+1vukyURS6XTa6V06nLzSD1B+3Fuabl
z8vEtf28+7LB4gjlr/QxVUeH0S2+ICiAK9ItUt3gjPM2NoWrq0SYwRRrbSfAnlLW
/KKtphsIa+B3BnKp/lt7LtKp/VwYqoglpxJNHlzus1lS+YjHUxBHkte8WZu/oaxw
6aBjyWCxyXJoNJLKzogbLJZT9/WR9w==
=FCpM
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--

