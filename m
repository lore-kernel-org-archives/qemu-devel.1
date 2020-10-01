Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709FFC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E439C20759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E439C20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2iy-0006Q5-Op
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kO2Tu-0006dy-49; Thu, 01 Oct 2020 13:35:02 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kO2Tr-0005Jn-R3; Thu, 01 Oct 2020 13:35:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 74F74580195;
 Thu,  1 Oct 2020 13:34:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 13:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=QTGNeeeaP4RT7A2XHXbgT2geVsC
 cXEG3ugOOVsTuYKs=; b=IJA2KZBpOO0TY664d8hGM5+LY1mmnUihjexvcemaFG5
 ko5g7XPVjZHw7MDdzNAccqshiOkxKpcrasYo7y7Ud/EZVmqzeX7I9A1ieIlmGphT
 2zXk7SRjP71VtcxyW0OmuRAFfW2kihUfr46Thc0BBJMw1OnY4Q38EiCzevFo3MOu
 mwfMXCthlb8tGOf9dyhNvi9kZT7xSEPTyl1qtuku+e59+ojQWfkOfpHqvUplCS5v
 MzEtaT253b6DcYSLh7MlKgkMOdXuqX+r5iwzuQJidOh0pbSgxZD3NUnVjLIWwn5o
 Fmf5My7L1MvylptL1JtuYQJzP/TzjhU8Jb4vMIy/eCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QTGNee
 eaP4RT7A2XHXbgT2geVsCcXEG3ugOOVsTuYKs=; b=H9x0BFAQ1ft19RkSxaYzyn
 IQo4Txg+xZohT5aUz+QMCVU5k1M5nKkxFIjHLcvf9V8gj1aQCgLn604yA41NQy7b
 709dseCjPXY41Hdvo46H6LenL2w5k/toVE0cuIHZDwZPS103DuV3sXwMPUlmEgOU
 tXzLNH9qCJgO4m+DgrLE8f5v37pNOssqN4/0ku/+dNcMnMAv1i3g4K7pi2h4NnCQ
 ScSJwgbKgXwuNa/QJZQ0pm/x6cTWl6W02DmNwc9Chi29GxjPSI6C6ATqppsv4AZn
 hDgtpRBf/ATVTnQl21/ysnApvQtsDBE8VdXsxE500nddOi+LP9IDC1hwHb85HDuw
 ==
X-ME-Sender: <xms:QBN2X5VqEbUIElpalEnAO4JxqvlG-H-ajG4ieqancWMOnDr40RD00g>
 <xme:QBN2X5lbfn3eSGztEQTpDLoYSeLkgEl5nDSpSa46YHCag9Biu_rimFssrHAEr62_b
 zHpxk_mMf4ylOB4Cr4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggdduudeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:QBN2X1bOhAuXrBg92ruykiGWv8Di4iX3cyCHuISudERQt_J0sAvrYA>
 <xmx:QBN2X8WKGEn7TvGZMFtcMjAcvjIwvnz0_yu0lx7Zun20S8-6VDfQ7Q>
 <xmx:QBN2XznY_yvzecrvu2gZcLcmFrbXu_t2lWUkSv2B4zJzRN3yRZ1VLA>
 <xmx:QRN2X-sQIluxHzK__QeqgRaWAxPCKmPUOFzb8GS0Vywn6DM2J2JiUQ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 940BE306467E;
 Thu,  1 Oct 2020 13:34:54 -0400 (EDT)
Date: Thu, 1 Oct 2020 19:34:52 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/9] hw/block/nvme: support per-namespace smart log
Message-ID: <20201001173452.GB792691@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-4-kbusch@kernel.org>
 <20201001041057.GC681387@apples.localdomain>
 <20201001152055.GA3343@C02WT3WMHTD6>
 <20201001171837.GA792691@apples.localdomain>
 <20201001173043.GA564827@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20201001173043.GA564827@dhcp-10-100-145-180.wdl.wdc.com>
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 13:18:43
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct  1 10:30, Keith Busch wrote:
> On Thu, Oct 01, 2020 at 07:18:37PM +0200, Klaus Jensen wrote:
> > OK, so I agree that it makes sense for it to be supported on a per
> > namespace basis, but I think the spec is just keeping the door open for
> > future namespace specific stuff in the log page - currently there is
> > none.
> >=20
> > Figure 94 (the actual SMART log page) says that the Data Units
> > Read/Written are controller wide, so there really is no namespace
> > specific information. Maybe this could be in the context of shared
> > namespaces? How would a controller know how much data has been
> > read/written from it without asking the other controllers? What if a
> > controller is detached from the namespace - you'd lose those numbers.
>=20
> That text is wrong. There is no "controller" scope to the smart log.
> Figure 191 says the smart scope is to the subsystem or the namespace. It
> doesn't matter which controller performed an IO to a particular
> namespace; the log needs to report the same information regardless of
> which controller you query. How that is coordinated within the subsystem
> is a detail not defined by spec.
>=20

Oh! Thats new in v1.4. So they updated that, but forgot figure 194. In
v1.3 it is controller and namespace scope.

Anyway, fair enough. In that case,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl92EzoACgkQTeGvMW1P
DekweAgAkdjYb1R8hcdZW9G/5O4aNtEqs+B1H2Kgv+yHCoIR6jF4Wf8Wwkd52NIb
RdAJDVKdY4LB356v4QQsb2XMivIaVdl58aEJIMieozqoro+dsOq20AFYJW38BRuf
dAqShAUSDkZJXyS3epiCe+Cbjel1eNqk1kuy9sCHEEUl+zjEn4+Z+HioX2KxKKbR
+tDeujRHU3GgbA6i7MGdB37iDK8xQ9SnAwkSrnajXR6VJ42DGQIal2nBzS65WALe
t4o38bGtYnk0Wb0yxkCUU2/Gn0ZfdjA33S8ELUbCK9+uD0RN01LRMStIU2HfqqKv
qf7AVaI69XfbiN8QBGzTNLWcKQPV5Q==
=kuBK
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--

