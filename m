Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E774C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FE42080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FE42080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMr1z-0003Vi-HS
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 07:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kMqkm-0000tD-At; Mon, 28 Sep 2020 06:51:32 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kMqkj-0007LH-0d; Mon, 28 Sep 2020 06:51:32 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id E54C3580189;
 Mon, 28 Sep 2020 06:51:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Mon, 28 Sep 2020 06:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=7gsnOsYfE/ntIeAZF3xHpNaTiDq
 faTSMi3VRMKUkL4E=; b=jGsO8KYOrSukWYccM/N1xkkP369m8uiWJrVNyxwLsFs
 v5oVe3IjQDx7bs5UVS5oJy47WxSPm/YX5B4w0orDPqFp9zIs7DhblyZ5sujwaP3r
 IEVhudHeSCGHMUAEl4xj9O/H2SvVn49Y4BdweOBPs9yA63Z+Z9i/qOzgsoDdru2q
 t3bAmiEpIU9N37dv/TLQ1SgqbL3UHikM8pukMuyJ/TGliHSQMSavFYckT7DsWPUb
 CB52U7zFEovtnpJcnFxps4D34IRncSCR7MJ8zs4vXmt9JKSto93KbcT/7dCXFlaG
 SLtBFFr5u7idWdWgIGvq/0zIzTlcka43KjJ5iozlwPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7gsnOs
 YfE/ntIeAZF3xHpNaTiDqfaTSMi3VRMKUkL4E=; b=VA0PYziO76EFg/zONWN9ox
 4/hDr+inhW1yojt5rDDFHUYLw21qaMTt9f1hTbnkoIIqlkaLFVxDkoB9dPgF2W+c
 t6Olj854jAL3ssVYZxCA7HR9HkTcpp2nT0o9eytvdDMtOzXA72LBuWA8OUlH9TKb
 5PW+z18oPQ6zApuILt+v/K9OE3E5MDX2zjOGX2s2qQSwwEWNLGHH6HSD80qQNgtG
 QuqkwA3B1fw7zXFfgj0O5lmsvhCj0sq4vHdfENXm/5w2L8YdrZBOFEcRoMfbAwQ1
 o47meEnzAT40sB+hMIlc2lX4M2HosNKpXLhX/xUUbLfavjbM21IDcONrOIdkXoyQ
 ==
X-ME-Sender: <xms:LMBxXxBRuktaa-8C1IrnIhy3PvyyZRl-8v7YqM977mxnjietb4Ixjw>
 <xme:LMBxX_j_3oU_1HMa-R_gPIISLj-34ElA_LRPFxFufH2YAZjch-hgKRkiNBfecH3NJ
 I7h-OnRVIw_U7ZVF98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdefudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepkeehheffheejuddvtedutdfftdehkedvheetueehtedujedvkeduhffhueethefg
 necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpihhnfhhrrgguvggrugdrohhrghenuc
 fkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:LMBxX8kk7Fkn91wM9fYha0_qj0Cz0q-gVAEW9U-1cTU0Dcc-Ir-wrQ>
 <xmx:LMBxX7yrx-7l_VcZPMfYxIBCU42cnHyROIyKlu-sxKVpWCZP7ECQgQ>
 <xmx:LMBxX2TL4qQthhBHSFXb7wUDOSd-NcfkT0pJ-4zUQN8XD0qosOG9Yw>
 <xmx:LcBxX8PJEPAB6TxSLwQ7VKjYpHnMi4bn8K97InRM9Zj5xqyxkRgbYQ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5207F328005A;
 Mon, 28 Sep 2020 06:51:23 -0400 (EDT)
Date: Mon, 28 Sep 2020 12:51:21 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v6] nvme: allow cmb and pmr emulation on same device
Message-ID: <20200928105121.GC33043@apples.localdomain>
References: <20200729220107.37758-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <20200729220107.37758-1-andrzej.jakowski@linux.intel.com>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 06:43:03
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
Cc: kbusch@kernel.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 29 15:01, Andrzej Jakowski wrote:
> Resending series recently posted on mailing list related to nvme device
> extension with couple of fixes after review.
>=20
> This patch series does following:
>  - Fixes problem where CMBS bit was not set in controller capabilities
>    register, so support for CMB was not correctly advertised to guest.
>    This is resend of patch that has been submitted and reviewed by
>    Klaus [1]
>  - Introduces BAR4 sharing between MSI-X vectors and CMB. This allows
>    to have CMB and PMR emulated on the same device. This extension
>    was indicated by Keith [2]
>=20
> v6:
>  - instead of using memory_region_to_absolute_addr() function local helpe=
r has
>    been defined (nvme_cmb_to_absolute_addr()) to calculate absolute addre=
ss of
>    CMB in simplified way. Also a number of code style changes has been do=
ne
>    (function rename, use literal instead of macro definition, etc.)
>=20
> v5:
>  - fixed problem introduced in v4 where CMB buffer was represented as
>    subregion of BAR4 memory region. In that case CMB address was used
>    incorrectly as it was relative to BAR4 and not absolute. Appropriate
>    changes were added to v5 to calculate CMB address properly ([6])
>=20
> v4:
>  - modified BAR4 initialization, so now it consists of CMB, MSIX and
>    PBA memory regions overlapping on top of it. This reduces patch
>    complexity significantly (Klaus [5])
>=20
> v3:
>  - code style fixes including: removal of spurious line break, moving
>    define into define section and code alignment (Klaus [4])
>  - removed unintended code reintroduction (Klaus [4])
>=20
> v2:
>  - rebase on Kevin's latest block branch (Klaus [3])
>  - improved comments section (Klaus [3])
>  - simplified calculation of BAR4 size (Klaus [3])
>=20
> v1:
>  - initial push of the patch
>=20
> [1]: https://lore.kernel.org/qemu-devel/20200408055607.g2ii7gwqbnv6cd3w@a=
pples.localdomain/
> [2]: https://lore.kernel.org/qemu-devel/20200330165518.GA8234@redsun51.ss=
a.fujisawa.hgst.com/
> [3]: https://lore.kernel.org/qemu-devel/20200605181043.28782-1-andrzej.ja=
kowski@linux.intel.com/
> [4]: https://lore.kernel.org/qemu-devel/20200618092524.posxi5mysb3jjtpn@a=
pples.localdomain/
> [5]: https://lore.kernel.org/qemu-devel/20200626055033.6vxqvi4s5pll7som@a=
pples.localdomain/
> [6]: https://lore.kernel.org/qemu-devel/9143a543-d32d-f3e7-c37b-b3df7f853=
952@linux.intel.com/
>=20

Hi Andrzej,

Any chance you can respin this on git.infradead.org/qemu-nvme.git
nvme-next branch?


Thanks,
Klaus

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9xwCQACgkQTeGvMW1P
Del5yggAmILQXpeRnLQfg28VtbcOkjc9q7JmyRJkLbMfzBgmsVSpvmzPwQDJYhSV
7snKQsv4pAIDIk+RSeVsxYtLdYri6GrmIGMQ117SjTrGAgwkMqk/Z774Bgh22WZy
/N5/624twAEH2it4RLXsZ9Aa8s0hrkjRm6VOYkLz4kyONGIPkBMJ6m5Smft4Ki8e
FRmDOci9guAnawBdLoeyDOuavilhIqSiyjAkiD+3EzsKv7jwQtWgRJx06gjd+gnk
hm6gxbpRZSLGaF2TQUlvwokbzCgb2HNDPViivdRK0RlRNtxp2ZOwI3nscleh1kyv
TJUbQfyCIRmU0Y9274RTNVggxzgNHg==
=TIgK
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--

