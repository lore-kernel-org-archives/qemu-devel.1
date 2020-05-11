Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC6AC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4CA206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4CA206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBiy-0001a7-Lz
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jYBiI-0000m4-8O
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:55:34 -0400
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:42401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jYBiH-00064X-C8
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:55:33 -0400
Received: from player794.ha.ovh.net (unknown [10.108.42.239])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 4447620F10A
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 18:55:30 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player794.ha.ovh.net (Postfix) with ESMTPSA id 18B04F3C317A;
 Mon, 11 May 2020 16:55:22 +0000 (UTC)
Date: Mon, 11 May 2020 18:55:21 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/6] target/ppc: Various clean-up and fixes for radix64
Message-ID: <20200511185521.1601dbde@bahia.lan>
In-Reply-To: <20200511014426.GO2183@umbus.fritz.box>
References: <158887239173.1564424.16721638327458334129.stgit@bahia.lan>
 <20200511014426.GO2183@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V.tcl9KElve6YU94VniHosD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 9475855093603146214
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrledtgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgefgkeduvddutdfgkeekjeelgeejffehudeuhfeltdetfedthffftdfggeeihfdvnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.76.65; envelope-from=groug@kaod.org;
 helo=2.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 12:55:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/V.tcl9KElve6YU94VniHosD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2020 11:44:26 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, May 07, 2020 at 07:26:32PM +0200, Greg Kurz wrote:
> > First three patches of this series are simple cleanups. The other
> > ones fix some regressions introduced by Cedric's recent addition
> > of partition-scoped translation.
>=20
> 1-5/6 applied to ppc-for-5.1.  I have some comments on 6/6.
>=20

As said in another mail, since patch 3 breaks build with gcc-9.3.1, I
intend to send a v2 for the whole series later this week. I suggest
you simply drop the patches you've applied for now.

--Sig_/V.tcl9KElve6YU94VniHosD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl65g3kACgkQcdTV5YIv
c9aLQQ//S/gl6LgIFUdqGu6QCD0epl2C4sTkZU+nosDJHtdzZj18jjfu+C8K5ROB
7DCXctaX15OHsY6FN8sbGVn3I2893atGFVlfMmvQdVtrxAX4HvBycvNA0bbqZA/B
EyOQaPeGwgGQSRspR8BgVZeClFP5zWhe31nO2yPmZvBepbEv+aF4kKNtoDsGngL9
3y9yGyl4NkoHUfSeCZJKPw6nlhgBvjKGthH/SLtrpoayBUJCG+0D3dJazxLgWUdP
VREz8rCqP/Q294Z0S0D6HjQkJzsZnljRb2NjeV3ZSIH7YcaBRlWcZ5IuDr3u8aqn
dX2cBCWgjOf4tapbgN1UxeKwzNc4X1ucWQbKKIQRLbW/k15QY8ykojUY3s9NLine
2VSVsUtPuMmks79hJ7b6V2EDOEpSKUS4DNdR4/Tx0NBEyktZKM/iquTe2Eudq1zd
y0HtfhvXLdg6iEPIsS8Q+8Wn8Dffc9UBpYcIb4+PLGG98mA34IBjBxUQhs+xEJa8
o/xPaUTrJAHDuz4hCkBJFCDYw3ETuDhw5ZxrH42uuJkf5UeG0dmOMzfDlKrotUW1
WfHlaYa2PLaTAJEN6kdFGOnqEFlCR1Iq1oxuP5pVvKu0uEhXo7xsV1is/4KkJGcz
Z8i+kIUo2hCwUFiZJPnb+dePgAacbiROePf2xaSpX0ZcjyrT9ZU=
=XcVh
-----END PGP SIGNATURE-----

--Sig_/V.tcl9KElve6YU94VniHosD--

