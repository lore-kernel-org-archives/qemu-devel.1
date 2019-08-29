Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B28C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480B72166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480B72166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Mgs-0007SW-A2
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i3MfV-0006XO-Jc
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i3MfU-0006JN-Cv
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:49:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i3MfQ-0006HM-Jc
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:48:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8ACDA10576E1;
 Thu, 29 Aug 2019 15:48:55 +0000 (UTC)
Received: from localhost (ovpn-117-104.ams2.redhat.com [10.36.117.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E28F419C4F;
 Thu, 29 Aug 2019 15:48:52 +0000 (UTC)
Date: Thu, 29 Aug 2019 16:48:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeff Cody <jeff@codyprime.org>
Message-ID: <20190829154851.GA26717@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 29 Aug 2019 15:48:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] git.qemu.org gitweb misrenders on git/ URLs
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jeff,
Philippe noticed that the git HTTPS clone URL
https://git.qemu.org/git/libslirp.git renders a gitweb page that looks
right but has broken links.  The correct gitweb URL listed on
https://git.qemu.org/ is https://git.qemu.org/?p=libslirp.git;a=summary,
but there's a chance that people will open the HTTPS clone URL in their
browser and expect to see gitweb working.

Is it possible to tweak the Apache configuration so that
https://git.qemu.org/git/libslirp.git[/] redirects to the working gitweb
URL?

The tricky part is not breaking HTTPS git clone, which accesses URLs
below https://git.qemu.org/git/libslirp.git/ :).

Thanks,
Stefan

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1n8+MACgkQnKSrs4Gr
c8ghzgf8D11e5ydU2+vwGu8A44StWDW+5iTBkWYZ2DGvGwVscZ/oqyLZCaemnrnO
/iAeTbMB0Tl/X7piYbKcwSDk2uNX6frlxTl80uzR/OeDq6aHkZg/gBAY8EtuKwqk
oFCtzn9mWpPRUFGAZHqYbqkr5LbXbEktxZZ6ggotW72dZTYmAzZDf+jqgM+KXQZ1
Vsj17qcW51y3yCgEn9geFrIs6tj23pgnyQy1lrv4kTNWKFjWXWCWbG8wGiEStQ7w
7cG/2NcHhrxLoOmBPfE14SRqu4gN3MNgihtX1EbsAcSfEfyD69s1hQI42kOz1svc
6N0MDpr5EnbrAzSKa0POPgypEUD/EQ==
=ke1z
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

