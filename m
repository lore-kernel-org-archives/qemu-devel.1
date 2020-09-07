Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6FDC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACF3208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACF3208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFD1G-0005GO-5n
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFCyo-0003i1-AN; Mon, 07 Sep 2020 04:58:26 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:39971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFCym-0000HC-2c; Mon, 07 Sep 2020 04:58:25 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id D85F1A53;
 Mon,  7 Sep 2020 04:58:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 07 Sep 2020 04:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=oDyOCVXba4CwOEUwe04KMrvJM0f
 j+Xt79L3AYdNl9IE=; b=KALwWFo9Oes/uGaUWIrmsQciqCQ6xRUqY9ZDHxj3kyT
 JYAY2LSGIC1IJLzXidhJpA5NvuSMceoSAsqC+bEIrEK7QDmTOJnhXLYvOpXKxoP1
 RWNevfltQY/iW0Yj2xp5VcfKo6SQ+v+xIpQJ1u7/XxE0ebu131OtTWwMhpiWsow4
 I3Dc/Ndt12d6r84W2FNZ+mOris59D0ooV6A9piF5RiqMXfDKtGIeFTxXHqV+RlxU
 CreWL2GddCYy64KZZqWHdfOdygWpWC3fG9gfjuL6BzpTFYaNjJn1+Aagkuy2Hnvg
 xcK+/C5kRsMqpT40buv3ZJQEN/ZfpQBS9rq+tH3deQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=oDyOCV
 Xba4CwOEUwe04KMrvJM0fj+Xt79L3AYdNl9IE=; b=ve4nZUYVWcKUjtHi/IH6Ug
 pnHvzj7goNb/5kpmZMhNHkJW2GuCAFrL0xruyXlRzuqgnFHGWJTnlFQ9ZDDtnwZ+
 p6gX/P0Xm2sR2H/nsyLqgkHaKsT553nswT82bjts7BD7B8KrhOJDaqNjIhEVO9UH
 q2H8AL0okwXP7aweJ3/wXN49trKhe5JykS3tHQXyiqHgKveRWExs///K8OFref1e
 G2qV9wT3aZYgGMPWo5p57EN7cbWz6RjIWV1az/xdMIBGmbo4mKM6i9www6m+VP1t
 5VBHKvc8AZKshUvokHbAOrgp4JVEhiWwGV4UBByiHbmmZIsqFaTw/1kzdeCAVYQg
 ==
X-ME-Sender: <xms:KfZVXyHW9iDRiAfCEGIO8Khvx0rRFjeIrrZBT3hjZ-YG0emWNDypcw>
 <xme:KfZVXzXu3BlSHyzeplV2olGVJQKXYMNTcTDm9MWyBPEMAnqXIfDWQUDmXiqf3JW_8
 wBmr9sgVnAOm_c_FbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddguddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:KfZVX8JiUQf6Yj8xcpbt6ZifVFwlDJhaalZueghUBWD51g8UElMwbg>
 <xmx:KfZVX8HEHMjEtaj-dAw9eMQw5RPyViqF0-EbGDrNGFVtDOSu4-dGJw>
 <xmx:KfZVX4XwNAmj7vwLpx5jGx-Azp7FERCr8qqWVusokxZyiy8J8x7zkA>
 <xmx:K_ZVX8p_BjYu30XQzcimL9DZrJ0MaExlAhJMlU17XLBu-uUxyieF9wCXqMVtFlG1qhHEJw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4846D3064674;
 Mon,  7 Sep 2020 04:58:16 -0400 (EDT)
Date: Mon, 7 Sep 2020 10:58:14 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 17/17] hw/block/nvme: change controller pci id
Message-ID: <20200907085814.GA698329@apples.localdomain>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-18-its@irrelevant.dk>
 <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
 <20200907072332.GA690013@apples.localdomain>
 <8651d3fa-becf-7b86-8c16-bbfb8926cec7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <8651d3fa-becf-7b86-8c16-bbfb8926cec7@redhat.com>
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  7 10:36, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/7/20 9:23 AM, Klaus Jensen wrote:
> > On Sep  7 04:28, Philippe Mathieu-Daud=C3=A9 wrote:
> >> +David in case
> >>
> >> On 9/4/20 4:19 PM, Klaus Jensen wrote:
> >>> From: Klaus Jensen <k.jensen@samsung.com>
> >>>
> >>> There are two reasons for changing this:
> >>>
> >>>   1. The nvme device currently uses an internal Intel device id.
> >>>
> >>>   2. Since commits "nvme: fix write zeroes offset and count" and "nvm=
e:
> >>>      support multiple namespaces" the controller device no longer has
> >>>      the quirks that the Linux kernel think it has.
> >>>
> >>>      As the quirks are applied based on pci vendor and device id, cha=
nge
> >>>      them to get rid of the quirks.
> >>>
> >>> To keep backward compatibility, add a new 'x-use-intel-id' parameter =
to
> >>> the nvme device to force use of the Intel vendor and device id. This =
is
> >>> off by default but add a compat property to set this for 5.1 machines
> >>> and older.
> >>
> >> So now what happens if you start a 5.1 machine with a recent kernel?
> >> Simply the kernel will use unnecessary quirks, or are there more
> >> changes in behavior?
> >>
> >=20
> > Yes, the kernel will then just apply unneccesary quirks, these are:
> >=20
> >   1. NVME_QUIRK_IDENTIFY_CNS which says that the device does not support
> >      anything else than values 0x0 and 0x1 for CNS (Identify Namespace =
and
> >      Identify Namespace). With multiple namespace support, this just
> >      means that the kernel will "scan" namespaces instead of using
> >      "Active Namespace ID list" (CNS 0x2).
> >=20
> >   2. NVME_QUIRK_DISABLE_WRITE_ZEROES. The nvme device started out with a
> >      broken Write Zeroes implementation which has since been fixed in
> >      commit 9d6459d21a6e ("nvme: fix write zeroes offset and count").
>=20
> OK thanks. Can you amend that information in the commit
> description please?
>=20

Yes, absolutely.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9V9iQACgkQTeGvMW1P
Dek/uQgAt7r1Rg5N2BHEb8V4ryGaNQJfwxilUwbmJ9z0t0IAW/LVvXZnsBpzCzM8
JxsivPoelXOcBsW6EEeEuA1OSXFtd/lkXz34meaaF7EFKtDlpjqC+D1oXa30HoJc
GGnCA39PzHacQsxGi5jeRafzCh7PJ94cSEjKcqieeXopLdUZhPfEIE2Z7wrHzavs
CDMjN+8IEsu4ErZCFCiJuLpSca1aFfTio3XLKvfce2vdwthoDBOwGy7Ipzf3D+s0
fDNof3QbuNjZ1AqjBn9XrbsAHHt0XRmde9OZT87arocRYLPOCHU/+Z7cguGJOHc8
hFnMsq8VOw/d++gQT/jvswQd/pHQog==
=TcZM
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

