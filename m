Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E86C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 07:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2154220757
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 07:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2154220757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFBXf-0005g3-VJ
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 03:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFBVB-00050X-4x; Mon, 07 Sep 2020 03:23:45 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:49541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFBV8-0001YX-Gt; Mon, 07 Sep 2020 03:23:44 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id E2B256F4;
 Mon,  7 Sep 2020 03:23:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 07 Sep 2020 03:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=G5RVN7jpJT02uEtmP4hVK4y/szi
 lTL+RyQqfr/kj69k=; b=DJ9+h3Y58JoNGtKQS1euURlT5pRw2+E9WyyRn7INUMw
 fkAuy5vsA8WMWUUUxZPFLaBXohiBm+QRzKHyk215dU7SVcroMcSEWs2JNC5nr3GC
 SNdUHHT/vfnbiC2Xkjx8wUROxwnG/UHu9BdKjCxg4IIXajCvSYW1/TUohZ7K+HDM
 1MsG/SsPWJ2/GB+ZOjR9bb83AlP8M6xkTQE0tcLVgFewO2y6844T6xjZPcWZEAXc
 bdXBhiH49YnSZBhuFl4ibQiJPiI6SPSksG5N+UJKXnt0U1+eFFPFepDTTkAoCNU6
 UhiDAB8Kfg1Kp5GKrNj0pDTzGGCOyVJgi6yvXbXCjgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=G5RVN7
 jpJT02uEtmP4hVK4y/szilTL+RyQqfr/kj69k=; b=Hzg7jIfFbG7+Xe2svtko78
 jrvH+nHd5YMu/GXN2upB95eB+rogaDLvaqteB8/3CLCqHtVh7M4nRK7GcKziKODj
 fDjQYS9gNUGN1P1trQATjAaqFwSN9Yh///y4cfr9+ZSh2dx1v2pjsEVqTV9gvPjR
 byohXhn8lghyiI+ZjrTKbFBf80TF5plOWrVv17gEA2fUT4j/rvQABTZeFAhmyXf+
 0s3NpRdQDh8rw1yaYR7m8E5dMv92adq6m5/UV9QJzsqiALdiIrmMQu+Rv0xYla6v
 XCYkSXLDXNO0qRU1yBPUK34F4YPQGMahfjk2/QRJlhCoa2m7Hung06QUsZnF2d2Q
 ==
X-ME-Sender: <xms:-N9VXx7g5asUq2FiOLknlfi1UHFiisKNlmMy1RMuuX079HWcoZdotA>
 <xme:-N9VX-582Z9G2qkz0hvkEsElgIzHe3KjkYjtLQ5yJ6jiynUURHmmRlVrWiUiUFSon
 4eAViaUtwL_d-vctRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegledgieeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:-N9VX4ddoPyw-f5SOuxtnyannQ_PlExmN_Jf9uDKFTczJBYGim03TA>
 <xmx:-N9VX6KIpjOMVoufThnRMVSsN5LUD6fz_TYDS2qh4_od0PFbS7CiGQ>
 <xmx:-N9VX1J9RUrJRHzzXnFmLSxBmAx2jE4PTGdrqOQFofOlA0vxall_rQ>
 <xmx:-N9VX8-1TZ41rkZoF5N59uxNQL6mq8qAxmLo7vWsXEPLzAYFNaplo9KxZNeEbxoJaHNrSg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9F3883064610;
 Mon,  7 Sep 2020 03:23:34 -0400 (EDT)
Date: Mon, 7 Sep 2020 09:23:32 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 17/17] hw/block/nvme: change controller pci id
Message-ID: <20200907072332.GA690013@apples.localdomain>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-18-its@irrelevant.dk>
 <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
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


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  7 04:28, Philippe Mathieu-Daud=C3=A9 wrote:
> +David in case
>=20
> On 9/4/20 4:19 PM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > There are two reasons for changing this:
> >=20
> >   1. The nvme device currently uses an internal Intel device id.
> >=20
> >   2. Since commits "nvme: fix write zeroes offset and count" and "nvme:
> >      support multiple namespaces" the controller device no longer has
> >      the quirks that the Linux kernel think it has.
> >=20
> >      As the quirks are applied based on pci vendor and device id, change
> >      them to get rid of the quirks.
> >=20
> > To keep backward compatibility, add a new 'x-use-intel-id' parameter to
> > the nvme device to force use of the Intel vendor and device id. This is
> > off by default but add a compat property to set this for 5.1 machines
> > and older.
>=20
> So now what happens if you start a 5.1 machine with a recent kernel?
> Simply the kernel will use unnecessary quirks, or are there more
> changes in behavior?
>=20

Yes, the kernel will then just apply unneccesary quirks, these are:

  1. NVME_QUIRK_IDENTIFY_CNS which says that the device does not support
     anything else than values 0x0 and 0x1 for CNS (Identify Namespace and
     Identify Namespace). With multiple namespace support, this just
     means that the kernel will "scan" namespaces instead of using
     "Active Namespace ID list" (CNS 0x2).

  2. NVME_QUIRK_DISABLE_WRITE_ZEROES. The nvme device started out with a
     broken Write Zeroes implementation which has since been fixed in
     commit 9d6459d21a6e ("nvme: fix write zeroes offset and count").



--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9V3/IACgkQTeGvMW1P
DekAhAgAkDpLzNRz2IZSUpr/EEb7scqxl+ubvf6uVSwMxgn5pqnM2bvcrvBcTZvX
aRIyxWdlcZ8gCmNTloXsFxCIXloXtMGZrswPIuIV3kOTwFRhaqLNvAk/UcYJKwDD
nKKeIwKR2cCYaOUPgWXcMaAjaSw7i4OJWm5+ZPz5bqN7SKT5X2rndBk2JZ7ZrZh3
jfh1WOq1z+ehVJXUN3i9lytRvOozjZ3CMQiyLvN6oNxdwaobf9jbCDxvniXrEM1E
fJL0aOoZGTp+/wJ8yIp1OCMTBEkRDCUcvl2IZk6O0yVNa1ECA4MoJhM9UwkVBYRf
xWIE6bLBUxdVlE93bMwGvCs4gqAJSg==
=Yjd9
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

