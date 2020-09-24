Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C62C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737D823772
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737D823772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLQ9X-00079C-Aq
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 08:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLQ6i-0006Ar-Dp; Thu, 24 Sep 2020 08:12:16 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:58049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLQ6f-0002CX-WE; Thu, 24 Sep 2020 08:12:16 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id E78AA871;
 Thu, 24 Sep 2020 08:12:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 08:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=6IK7TzQXElnByGPtTxW84d34Hwf
 xTEA7wiw3tbKOkTY=; b=qQ0GbubkjbhyAEaFufrOoX1RVBcJYr4vwGx0XihY6KM
 9Ognhi9YB24gLYTdGqK1VzD9YNOixfKfKehGJooM7jOo0LGd01FfAWqU0nDHezyy
 DVNgD0qPzHODWAlH9gPI8gCaw9wm9NeZY2ILCadjuURNKqrykUTUgWL7UloQhbwD
 VDVPpmK2DvnCESQ1iSVxv2NBbMDX/8aLe49XtlarH03ntNbk07mhFJZx5Kl6QQMy
 +8YKcZbFaa0qpb4tvhmnjq394cvz/lRi8knK5JDdMtju/DWpO9gS4bowCedUFsH5
 MB1rBIvFQOZd8ZNHvtPuAmaAxySdiGIN/bzcpZPXUTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6IK7Tz
 QXElnByGPtTxW84d34HwfxTEA7wiw3tbKOkTY=; b=jNqdiRODgojbdNqu5x1EDw
 5eP3dGmjWOrkgcIfmU31SUYa8mG5NswpSkOdcVmKS8bdNnLr07sTnvySH9UjNhJQ
 zq9ZOKuYdlbj6wT0V1d6eDlOb+7nrNNQaC3O8XNhhYKrENenkDkvimydnkJiK+nN
 QlzPTkXgGe4bv1JibXEqBrzu+55qGxwmf+uPlUDbNMjHltIQMTELH5mi3wIIJVkh
 aCL9sPHpLNZuH78tpYZJVyvj+yLwOPbz4wT0VCd1QEKBEV6dnO2gjJv5Kxb/fSbJ
 I/88nqZNBhTodnQ8qmqPZ2XASP+m2CNz2Ub7gefqlZGMbcV/9mJZX3LFKjKScCgQ
 ==
X-ME-Sender: <xms:F41sX2apODXyvbisYxr-fClpH5RHnUBep6ka6FUgOjV2IaZQcyfR4w>
 <xme:F41sX5bgT3e7BQ4WyLm4se_JYhr6UaQ-QKfeHNHaYDx3hZlzM5pgJHjZHWy3gfbRA
 TMGfkQPjdHwWZ5Re9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdehudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnheptdeggeevleevffevtdeuffehgeevhfeiudetheeuvdegueejkeelueekgedvieeh
 necuffhomhgrihhnpehophgtohguvgdrmhihnecukfhppeektddrudeijedrleekrddule
 dtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihht
 shesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:F41sXw-8caYoe_kdb2p3AAG_kQAq8U5kUYuq2vtEUmqDxqiYWnrERA>
 <xmx:F41sX4r4GbKHd6DBhSwp3jzGWkheBnIq7dLcgHZFyr0PTwSrWvX3xg>
 <xmx:F41sXxqT1jEmQWbOiMkU9_QVX1i5T07ep8pSn2iV9JIQFOiElc3Ccw>
 <xmx:GY1sXyQOpn_u_yZeXzw3gngsJPhFJPGyRwuguKN1BPyf29iPvN6sb7oAomzLvTlb>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B17A33064680;
 Thu, 24 Sep 2020 08:12:05 -0400 (EDT)
Date: Thu, 24 Sep 2020 14:12:03 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v4 06/14] hw/block/nvme: Add support for active/inactive
 namespaces
Message-ID: <20200924121203.GA1738917@apples.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200923182021.3724-7-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20200923182021.3724-7-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.18; envelope-from=its@irrelevant.dk;
 helo=wnew4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 08:12:11
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Niklas Cassel <niklas.cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24 03:20, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> In NVMe, a namespace is active if it exists and is attached to the
> controller.
>=20
> CAP.CSS (together with the I/O Command Set data structure) defines what
> command sets are supported by the controller.
>=20
> CC.CSS (together with Set Profile) can be set to enable a subset of the
> available command sets. The namespaces belonging to a disabled command set
> will not be able to attach to the controller, and will thus be inactive.
>=20
> E.g., if the user sets CC.CSS to Admin Only, NVM namespaces should be
> marked as inactive.
>=20

Hmm. I'm not convinced that this is correct. Can you reference the spec?

On the specific case you mention the spec is actually pretty clear:

  "When only the Admin Command Set is supported, any command submitted
  on an I/O Submission Queue and any I/O Command Set Specific Admin
  command submitted on the Admin Submission Queue is completed with
  status Invalid Command Opcode."

My /interpretation/ (because the spec is vague on this point) is that
with TP 4056, if the host writes 0x0 to CC.CSS, you will (should) just
see Invalid Command Opcode for namespaces not supporting the NVM command
set since we are operating in a backward compatible way.

Now, if the host sets CC.CSS to 0x6, then it is obviously aware of
namespaces and other rules apply. For instance, it may set the I/O
Command Set Combination Index through a Set Features command, but TP
4056 is clear that the host will not be allowed to choose a combination
that leaves an attached namespace unsupported.

For this device, that does not implement namespace management and thus
has no notion of attaching/detaching namespaces, the controller should
by default choose an I/O Command Set Combination that indicates support
for all I/O command sets that are required to support the namespaces
configured.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9sjREACgkQTeGvMW1P
DenvHgf+J/Ao3Ir2iWKvH7JFI02/cKsaSuamIpmF6UlXwKFtdc9QzXZTOscnmsh5
vmnLRA1NpTOk0bFZShlUP3zCJyMf1goT6CCMEkVLA3g1dIDpul/tWnahXG0agj7l
57bvhfhJBKFaThAAMKJyIYygI1SZgFvBmLn/7dxUKmD10FrLL+mptZ0Urh5VxNKg
b3V6WEdhj7Vm+LjXEkOnV/RS8PxaCpgCmS3ay1cL/4Rp5vwICFypFXc2Y6obCAvq
d/KUYF5/JRrclsYFqNOZ7h1M9SzGwrVd3YoJgetF9Zx8Yse/D0LTr5vOxCpnZokS
uUfExFm2TpKUYWpaSfFXlvHT89xf7Q==
=rePr
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

