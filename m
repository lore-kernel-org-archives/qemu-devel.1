Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FFBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741C722450
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741C722450
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGdz-0001b6-81
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaGaR-0007Dm-Gq; Wed, 04 Nov 2020 06:04:19 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:53681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaGaL-0007Ak-7C; Wed, 04 Nov 2020 06:04:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 082F4AD2;
 Wed,  4 Nov 2020 06:04:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 04 Nov 2020 06:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=VNLMYS9jQ4bqOPQZ5H7E9zA+fiK
 Pn0PARpX5xuN8L18=; b=03sFWR2GthpvvXIgGmLFRkE4m7p8QmkaM7tyxdhT6cH
 jsPuy6TpyxRs6HsEmBq46ZBm8vjXv9QefVDlUyb9sqW9ouLgjnmuVE16dUbHZcvG
 HGNLRPTESGfNgn+Ynl3OlC+V8fwSVJPJIr6ZUnN89BCbC1fCo5Fn7w6BmUqBaWhv
 EDr0rXeYUHJVtGIbKIXjc/0RHPhVDndzE8qVxOxgi+nYfLmfRdfv2HV/jvBPCetm
 Fe4/My90RmBWZtHm/SLyZkqUJyZYXo3NtsVOaydRUZ2hWiz9Q3f19upSGB7Yxv3i
 q4UukcFKLMjm4dx/Xoj+8fqWOikSyH+rYae/rQ7dgWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VNLMYS
 9jQ4bqOPQZ5H7E9zA+fiKPn0PARpX5xuN8L18=; b=P0614mfjru2GObNBLY1/zh
 8h+pcoOnhYKEjMsgC3pX56zf4oC1vPH265bowlUeFoOXylq7Q9eY9xl+heQAk+8g
 DoxvLqBgd0wKDlMbA3trypXpA7gNfF2+u1jvpHFp0rrhVwMXfDI756/oDOMu+VAr
 13P+YHUJGOmQXw6L0+8dw3w3BhFKcBxJHLRT797w3wAYR8NP3/2gSb6NSX/gZej8
 Byv9lBIZ8xemoBk8ycTLstmemnJKivJobvurtPzFUmiWJX2/TDkmqSNY6AQm++6y
 cytzeIlWncIjXumYsu3T/vyLUQVB470LOD0Z+Id7yiHOgHJINtVb+mcezFOK5LCw
 ==
X-ME-Sender: <xms:qIqiXxX_EVRKfTAb48e1gjSroSA4Ve-0jcbqihl5nn6x6520tqka5A>
 <xme:qIqiXxmWKJwNtniI6izRUmY5BiqJxTC7FiscrHyCqOhwbEyBxQDw4s-k8YqX5yoPR
 EN8Y9rMG4d7p8AdPbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:qIqiX9a2jvg9TxDZK917sOaGvcwaJvC2rVCR65xewlMgQDq22Xdr3w>
 <xmx:qIqiX0WJM3PTJiAMeL4h75kzTCuhsb_0U21aYYI-7uGb1I5LUWj3cw>
 <xmx:qIqiX7k0Jfh2V5t5wOLBNn6pGBEjDCp6Dz_sR5HCgR90SGgRyFLhfw>
 <xmx:qYqiX5XYN02pUFcR8IkL_QR0NqYL3WcSBFvrKqwdnkEN8qoEdIa9gA>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3D533306467E;
 Wed,  4 Nov 2020 06:04:07 -0500 (EST)
Date: Wed, 4 Nov 2020 12:04:05 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.2 3/3] hw/block/nvme: fix free of array-typed value
Message-ID: <20201104110405.GB35038@apples.localdomain>
References: <20201104102248.32168-1-its@irrelevant.dk>
 <20201104102248.32168-4-its@irrelevant.dk>
 <6b54b9a6-a6f8-3009-b3a9-99aecad6fb3b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <6b54b9a6-a6f8-3009-b3a9-99aecad6fb3b@redhat.com>
Received-SPF: pass client-ip=64.147.123.21; envelope-from=its@irrelevant.dk;
 helo=wout5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 05:22:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov  4 11:59, Max Reitz wrote:
> On 04.11.20 11:22, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Since 7f0f1acedf15 ("hw/block/nvme: support multiple namespaces"), the
> > namespaces member of NvmeCtrl is no longer a dynamically allocated
> > array. Remove the free.
> >=20
> > Fixes: 7f0f1acedf15 ("hw/block/nvme: support multiple namespaces")
> > Reported-by: Coverity (CID 1436131)
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c | 1 -
> >  1 file changed, 1 deletion(-)
>=20
> Thanks! :)
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20

Will Peter pick up fixes like this directly so we don't have to go
through a pull request from nvme-next?

Did I correctly annotate with "for-5.2"? :)

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+iiqMACgkQTeGvMW1P
Dekpdwf/U4R5gJ3uTC+Lj32/s5Q4c/Xw96hfGOgK5aGUUGI6fdEpr10KDW5grbRW
sGjy8yFfg2BwAQauIqEJKaiL6Pfa9OwQuwJDujws4YdyAfeU0kkapRyAX/vQpEKG
91tKuZkPgyp3d+q0fDDhLTOYaIUMB9C45WYVRNIcQ96gCq66C7+0EAq1tjwnMi6j
Gthj4PoJCEjq/pymTboESbH6g4D0FGpbuZg4LFw/8Z4qFp7+Q+ppRCmsDg5p3zKW
9xio3KYX2jo1Lp8kOMEZ3p0nJSew0auHLwgv9B/z3RfKh1FfDZAnyc7/ia/wBrqA
QypjDj3b7BzyEwjibnTMyb4Bt2cvvA==
=/b7F
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

