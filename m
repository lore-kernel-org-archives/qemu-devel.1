Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F000C4727E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768DF23899
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768DF23899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYrG-0005c8-3z
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLYn1-0004Vh-Eq; Thu, 24 Sep 2020 17:28:31 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:55339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLYmz-0004R5-Lj; Thu, 24 Sep 2020 17:28:31 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id B0DCC58050A;
 Thu, 24 Sep 2020 17:28:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 17:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=b5j6O22zdlYFku8IXP+EugfOdy1
 bSw8E2++dm/cCCKc=; b=QyUGGWON/BTDDCBUZ4GgwAnTdqRPyh+KqMMqmsjgFId
 pGXSO1sSb4l+J6DR+WlrIIU8ZHSQ6ge0g+SdnbJKDiM/hiVNeoib3EDptwPIA1d+
 2YNRrYSTjOdR7qkGtj8+1vAr/9KQM2BF8OSOviogvkD43xM7Hd7ryo3qbaKlsOG9
 6aJd2U/CKklWWo+39xbFPTvexgKLHkaSVQSoqLsGs5DAAyVY307Bkqitt715CFrs
 BGcKf/7cTg0qfWRPfrTE95H6SMbdPUky+xNBTw6SPIh/R+IATHhT9/3f0rfd2ZA1
 ZgalO7UTIq1dLps6UHgfdBjp+rfYXFSe8EBY0UPSRWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=b5j6O2
 2zdlYFku8IXP+EugfOdy1bSw8E2++dm/cCCKc=; b=IKIE5onK9tkdb5JgNQUJB1
 bAOTLLKcWRu7ew8W636JV/k21e9ekkTtkVwDURU9HoQErmLAF5kk7lO1G/DwrPom
 togLpy9CftIJK6AXTy2+Gp+OpVMXmRaa1PY6y8w5uSYppMcrF9Cx+0RBbQis4Eph
 zXq+ZqJ1ZN+gi2igagF8lv8cXuxmcAV6R1Y9btQ071vdLURgdjhDJFjZIxaQeni1
 5Lff0PXj1OWI85ih3zwjBoNeYuqwx7iIv6efvQqDvrXxWUT96LdW4ny0Waof3opB
 Xdo4CuSuPTIl4vbsnf7aYbCB6qnJnEr/o9CJcxmD6TnywIw8qZwzB2sEnLObJtOg
 ==
X-ME-Sender: <xms:eg9tXwJ7lD7TAwBi3zmfURAr8Nl6I8ZOQSeR_TlYrjBKkOYpIKmueg>
 <xme:eg9tXwJIinWM_XuOYYskMk80phgS2fOzOqO7oghqWr4YJIRRJdb04IhHLovWu55do
 Kpc-IyyaMiP7lAnSII>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduiedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:eg9tXwvNyl2PfBmQ2AY-l3eAx5g113PTT2r0agMyLGRxoleKIhGDmg>
 <xmx:eg9tX9abmPhB1Bae0gKTQ_bkk6cjAzyVztpnBQzSMZk3pzYFBtShPw>
 <xmx:eg9tX3ZiiG6Ht_SdOnMIfhZ4X6lEBjY0RQOCO4TAJIbYMNRK5n65Fg>
 <xmx:ew9tXzH0zQBi-1r5bI5NeNHqVB9lOLd8iuXxmwbTESsYqvqFKt8vKw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3DB84328005D;
 Thu, 24 Sep 2020 17:28:25 -0400 (EDT)
Date: Thu, 24 Sep 2020 23:28:23 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: About TODO in nvme emulation
Message-ID: <20200924212823.GA1884805@apples.localdomain>
References: <20200924142537.xctoxv7xdr2nab7o@archlinux>
 <87imc38bwa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <87imc38bwa.fsf@dusky.pond.sub.org>
Received-SPF: pass client-ip=66.111.4.230; envelope-from=its@irrelevant.dk;
 helo=new4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 17:13:16
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
Cc: Keith Busch <kbusch@kernel.org>, Amey Narkhede <ameynarkhede03@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24 16:52, Markus Armbruster wrote:
> Cc'ing nvme maintainers.
>=20
> Amey Narkhede <ameynarkhede03@gmail.com> writes:
>=20
> > Is there any TODO file/wiki for nvme emulation code?
> > I'm a beginner who is interested in getting into
> > nvme emulation. I have read nvme v1.4a specification
> > and some code in hw/block/nvme.
> >
> > Regards,
> > Amey
>=20
>=20

Hi Amey,

No, not yet at least. But we should definitely consider making a page
like that to keep track of nice-to-haves.

But I guess any v1.4 stuff you wanna do is probably gonna be
appreciated! :)

Someone needs to look at the changes to CMB in v1.4.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9tD3QACgkQTeGvMW1P
DelT9Qf/T9hlaNvSFY9ryV4hNsjRWosxl9d5Hm36309/Iw67FcgSAkJf3j1QyTPg
C+suVE6VK4RoDftliNjLQB7SJ8h0Ss822r2nAtmje3QDSljZnMELtTu6xHLcci1L
6Y+GAB8K+8Dlr8Eu86W6F7knV1ZuAJseDdVYB+umB7qZK1VlEBN28hnn7mpTCPP9
H8eqxvLu6u1R/MuiJXcFlvFchGpIOUnztVbIDypESYDBATeKN0gXZo0PUx+qejyC
HglMZfdg7UD6PYs9t9tvkYAo/6/9V38kg73bvt+Q5qMgVbnsyNYa9lGaWrfrCLCO
eTh+TYzlVba+xwrNRWkkS5R+JoGFQQ==
=Q0xr
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--

