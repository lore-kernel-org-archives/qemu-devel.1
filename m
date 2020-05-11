Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D61C38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DD520746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZoU/FHOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DD520746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXxWs-0004a1-Bg
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUx-00011G-2D; Sun, 10 May 2020 21:44:51 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59963 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUw-0000hu-7I; Sun, 10 May 2020 21:44:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49L3dh35scz9sT8; Mon, 11 May 2020 11:44:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589161480;
 bh=/7FsHhkawjvfdMokDx3DZ7Cgr6EHPs5i4fUjg30RaPc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZoU/FHOtHzNIgU7ce04m0HPG48EQPTVSfB8Ku14/FSu+yH9TD2XqCdF58+pwoHjKx
 L27RFbzN2RjxINo7NDkkcRYwpGaxZQtWcVNRFE2eYgkP5dRBDM9cuCmxPeoXLq2Q9h
 zQD36rQ3YdULKr+en2kpMskJTW8KUc2xpM4tQjSg=
Date: Mon, 11 May 2020 11:44:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/6] target/ppc: Various clean-up and fixes for radix64
Message-ID: <20200511014426.GO2183@umbus.fritz.box>
References: <158887239173.1564424.16721638327458334129.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V7BlxAaPrdhzdIM1"
Content-Disposition: inline
In-Reply-To: <158887239173.1564424.16721638327458334129.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--V7BlxAaPrdhzdIM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 07:26:32PM +0200, Greg Kurz wrote:
> First three patches of this series are simple cleanups. The other
> ones fix some regressions introduced by Cedric's recent addition
> of partition-scoped translation.

1-5/6 applied to ppc-for-5.1.  I have some comments on 6/6.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V7BlxAaPrdhzdIM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl64rfoACgkQbDjKyiDZ
s5K1JQ//cLhnHEUENptW8ZLFvbJBMpfmGdnETLEaqkKBQYuz/Ig4ubnnfCV/bVeX
/MldAuQSxCKaNqGSq3sDeN8PdkAopK+JWRQlI+2yHVB2Ns5prytEStrz61BIk87o
ARswTUqpL8jr6vZkeBICSSkBYaYMgRfM27HqTMrABfFnJ2AwwP2JsRX/unOR3yji
F07RDRDNsAtSg9ctfYdWpdiLwA0I2eUx/T5ZbX1CvJOvVGuSVqclt5WCjRefnc2o
vadg5UvSmykriNLmo1iOsgzqHuUZoMdihLRfS7hACrYrdB9d0gC5WYhq3mIiC1lU
WedfGnh2y/oPMGf0pxTA3XE37kNoVI9H4ULdrHIR2X7N/HXYPe8kEd1IhoEfhObF
APp4Sipj0r10kQDE5KArAl7Cz2Mbw3CPZ6c1Wez/CCNSCh+8Te5AFis0zYJLfV4H
KhKsAfqVfP/Dr/vuPHDAG7D2T+BtjivRQjKX8CTk1WVYLY7uZWcBQTYfZSJmU6Ab
V15k3ZQgLJeqpo3rOMVs5dBCcTE6PRAgTgiu8tMnyAVUOiA9NnK+aElm9j7EDDt5
+QjGHaSWwwpdFaUiJnc3cDulQNttzmWRM329ZKidl4gge9c9c4GbfvYI6RcZe106
ezmOttAZDtEWOPMrHwcHdUQP5p2dG6iIfUpGIaBdPAvTgkMJ9pU=
=K6qW
-----END PGP SIGNATURE-----

--V7BlxAaPrdhzdIM1--

