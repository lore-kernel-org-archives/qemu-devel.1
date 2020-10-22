Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45444C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 17:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4F7206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 17:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4F7206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVeh2-0001nG-4L
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 13:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVecn-0000DM-P1; Thu, 22 Oct 2020 13:43:42 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVecl-0006kq-82; Thu, 22 Oct 2020 13:43:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 00A735C00CD;
 Thu, 22 Oct 2020 13:43:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 13:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=DLM6jZqAusxBd/2K7Qk1Aae2PhH
 GBXPptzPC0PRyvlw=; b=PA2Fn1awUcEDt8n2qYdtqSzvqhd6XuJ/LBoYj0oOTPU
 O4C6u2+DXPXApoNpEdftcSiiELnE4+f3BeY8PgQoKbOBFSQcC+WKkaPN9/xb/ova
 zE06dtotpRjavLUqDmIKiegL3O4QABH6MD2lFvx1Ubd2LqXxVsQN1so/W2n9ZvRI
 DlNHZj8i4gUYx3po2/8lLSA1REjghbBqRU5fRG7qvFFUv85CAQcMAPdcG+vz7KII
 a9Xsi8J5mB5X/fH1XosEkXad44aXTKHtOlXzvZyvezBpHRbKJ3zwgNdGaH1PIKs0
 oHLBIHpe7PtvFX77vXfeG6WGHxnHSnazMxBg3Clyqxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DLM6jZ
 qAusxBd/2K7Qk1Aae2PhHGBXPptzPC0PRyvlw=; b=HP7iy8aOlU0iq9bs+1LLgs
 F5UtnwpePkDXbohaXS0XDwXnccCX8HcXDBotQOK7NvkkkeVciQm1gCWHD4fyNgw5
 MxTitQDlvGv1x0JvX6C1QetQLni3YdzUR8X7Ie7Ahvl4p4JXPg6F5md4XqJvR9o+
 n++GJiUWRJYLvPp6Dx+8wQLsEHkjBnwhhU8Eh6xGBTUJShOK0KnpMte/m2jv6eqC
 J1fMvOxZBRjEg55DbWTjceaZRYQpVDkDMItdKMyLvuwJsA305PhgXa8pemE+sews
 4N9sZohrJXGYMPutapKg9XRhSez9dG60rtEVvE3hicVjNGj65q3f0gWBIpg8/4SQ
 ==
X-ME-Sender: <xms:yMSRX0xDcpEE2c-r_cFBwREM0xEHdebiuvSRJ28snGoeA1KCqW53EA>
 <xme:yMSRX4QLI9DYbvh7OAYpJgZTUSHczJolJIZQGcTSdcd3Fq7WIXEjS8fr-QDLfRXo-
 8etFxhV592mc5WQkNY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeekgdefgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:yMSRX2XXVChtrMnLiKIttI8oBysJq4wKmAKkJJLSXf5vO84tTWf3Pw>
 <xmx:yMSRXyjgo9GPz_TCy627kfSVJJFGgWcm_-YiGBNqBvrNSiv0aDkZlg>
 <xmx:yMSRX2AlTg-6SG2e9glnCtxiaZdy0pVBKg4FOcxr_wnGSaVU9DWA1g>
 <xmx:yMSRX5-5WbUhcDLv7MCqrleR1KjxG4dvnxjM9qxMjoB-sdOA6jNnvw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 397023280065;
 Thu, 22 Oct 2020 13:43:35 -0400 (EDT)
Date: Thu, 22 Oct 2020 19:43:33 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 2/2] hw/block/nvme: add the dataset management command
Message-ID: <20201022174333.GA209677@apples.localdomain>
References: <20201022073313.143794-1-its@irrelevant.dk>
 <20201022073313.143794-3-its@irrelevant.dk>
 <20201022150103.GA1665151@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20201022150103.GA1665151@dhcp-10-100-145-180.wdc.com>
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 13:43:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 22 08:01, Keith Busch wrote:
> On Thu, Oct 22, 2020 at 09:33:13AM +0200, Klaus Jensen wrote:
> > +        if (--(*discards)) {
> > +            status =3D NVME_NO_COMPLETE;
> > +        } else {
> > +            g_free(discards);
> > +            req->opaque =3D NULL;
>=20
> This case needs a
>=20
>             status =3D req->status;
>=20
> So that we get the error set in the callback.
>=20

There are no cases that result in a non-zero status code here. If an LBA
range is invalid we simply continue with the next. In case the DMA
transfer fails, we return the error directly and the normal path takes
care of it. The else block is for when there are no pending aios for
some reason (all invalid ranges or they completed immediately) - in that
case we can just return NVME_SUCCESS directly.

> Otherwise, this looks fine. I am assuming everything still runs single
> threaded since this isn't using atomics.

Yeah, all device code (including callbacks) run on the main thread.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+RxMMACgkQTeGvMW1P
DelX+Af/S7vzzdqybZAaS2k6zs8vTeW6NlRl9tIIMQ3oKxXqUp/gaWgGXPeaQUB8
x7IGgNZK8hPr/ezOaZOSuoBQkgylGwUEA7/sW3Q2Gm8ZcjugW+FMsr3bFG9DWxSQ
IWoz+sOE+IWZrt0cpYZPs1RLkI+A97EgkjaqF6Op50sdYWwqfKahVKiKmWr8qMEW
YHVgNThASsx7XolZO9utB33tj578UcNDaMmN8oAWzFIID1IG9LmKcn+MkfBcAwy/
DKM44gcnf+WWrRpsfUniFoUn3Z20cyeD5C1Yc01gbR6EL1k5M2bwLTZGy8gyTGhP
iexXHytQFGGklMrz1NuosIqU7mbJlg==
=1KYu
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

