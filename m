Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2152CC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA89F20815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA89F20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54240 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFip-0003q7-7c
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:42:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRFUV-000056-SE
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRFUS-0008VE-R9
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:28:07 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:59154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRFUS-0008TS-Lw
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:28:04 -0400
Received: from player158.ha.ovh.net (unknown [10.109.143.223])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id B1B43126A3A
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 14:28:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player158.ha.ovh.net (Postfix) with ESMTPSA id 816F95BA6C5B;
	Thu, 16 May 2019 12:27:55 +0000 (UTC)
Date: Thu, 16 May 2019 14:27:54 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190516142754.54e2a656@bahia.lan>
In-Reply-To: <20190516114601.GG3207@umbus.fritz.box>
References: <155793986451.464434.12887933000007255549.stgit@bahia.lan>
	<20190516063957.GA25414@sathnaga86>
	<20190516085814.022ef4b1@bahia.lan>
	<20190516114601.GG3207@umbus.fritz.box>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/xKYH_akNmZXic4qrZYfmByy";
	protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 6291810158273337830
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddttddgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.149
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: Sanity checks of OV5 during CAS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	=?UTF-8?B?Q8OpZHJp?= =?UTF-8?B?Yw==?= Le Goater <clg@kaod.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/xKYH_akNmZXic4qrZYfmByy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 16 May 2019 21:46:01 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:
[...]
>=20
> I won't be sending a pull request for a little while yet, so if you
> want to send a followup improving the messages I can fold it into the
> original patch in my tree.
>=20

Done.

https://patchwork.ozlabs.org/patch/1100396/


--Sig_/xKYH_akNmZXic4qrZYfmByy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlzdV0oACgkQcdTV5YIv
c9ZW4w//Qq5d5ePp/1GApVl7G3vXuyOROehiQZaBJcNBNkjNbCyoK/J+7cqM+f/X
jmZLUeqNjKmx+wLgAoeqm5rT4YWN7s5WKCVQxroNZEoeRGCBIhJTP0zmrte/9Fyl
QlW3RZPzgZQ06+v/06Ieyi5ci8def5tZnc/nTuYS2XmbkFw+0ecWiRp9wkJ05+rf
O4xQP4oOr5475/48w3WtnXvwdUtLoG3bB2wsWtivfGvCcZhyAQF1q5gV6TJLVlXd
O1SspML3y1981UynSoRF0uVvbL9rTeXAJZkBMMN89rc/s19/D0BlmROCbd8KPX15
F0DTrgZw618vlvgpsOU1lamzFyn2ZOhsv4YcE0lqtqrcWC7AAFXvuXIsmRZH6Nhd
y206h8l1pFfm8pxyoqQZM7N/RNM9/nbj+szT2H0pT5JUwsDEegnF3lecCG/xtUT+
10OPfWn4gfo3+mHpzC8oiTa6YyHFpf9sQDxHW1u+ZFb9ddTTslauJjdMQaeCAXDH
xUFd+11cQ64iw6cxfd77bIPJrASvppEWE7XM4yXUPIbvfwiarLWIztL/le3cm/sG
Z0UVbvtP2odBsmk5nlFHLsCdXFJFFIQkVQt7fKW1izKD3xxUNo6M0PHGptxfU9ak
yA7mic+zzogOfg3MyCX0sH62XGk3b/GeAa/6/2XJ72poRPN7i4o=
=fEse
-----END PGP SIGNATURE-----

--Sig_/xKYH_akNmZXic4qrZYfmByy--

