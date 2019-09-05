Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C252C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C9620870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C9620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5n4j-0005ON-5X
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 04:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5n3t-0004jz-KG
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5n3s-0002P2-N6
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i5n3q-0002N9-EJ; Thu, 05 Sep 2019 04:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D58D31752AF;
 Thu,  5 Sep 2019 08:24:09 +0000 (UTC)
Received: from localhost (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3E975D713;
 Thu,  5 Sep 2019 08:24:05 +0000 (UTC)
Date: Thu, 5 Sep 2019 09:24:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190905082404.GB32415@stefanha-x1.localdomain>
References: <20190902162638.28142-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <20190902162638.28142-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 05 Sep 2019 08:24:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/misc: Mark most objects as "common"
 code to speed up compilation a litte bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>,
 qemu-arm@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2019 at 06:26:38PM +0200, Thomas Huth wrote:
> Most of the code in hw/misc/ does not directly depend on CPU-specific
> code. Mark it as "common" so that the code can be shared between e.g.
> qemu-system-arm and qemu-system-aarch64, or between the various mips
> flavours, instead of recompiling it for each and every target again
> and again.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/misc/Makefile.objs | 90 +++++++++++++++++++++----------------------
>  1 file changed, 45 insertions(+), 45 deletions(-)

Nice.  My understanding is that we poison symbols so target-specific
code accidentally added to common-obj-y should fail to compile.
Therefore I didn't audit the affected code to see if it has
target-specific dependencies.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1wxiQACgkQnKSrs4Gr
c8jsgAf+PLcRF26MLfCuoYo6XtPaE8O7I0bcEteytjnW4Om5TppDwvKNeCoaOXlV
LyIQuQDOOSwUw1ySaWfy1nZyWwWJ2u7tFhqOyEVUwKWMSMCpSh1O0PWU6Ae4woO/
I6mUA6dXANTP/aIaC1wiWDHcsCIYrNoJoMR6utGKUI8fSrb5Idfysb+cIdkiKHNW
0ewuMUAhllLqDa0WO3xbWOli7fKBiPXXIf6mS4Y5z4m2Cws2Wl3Azany8eenMtiz
tOFoe3rXoV3g/M9hWqaKgyKO7nWgXS8hOjuiB4GU6thnN15wTi30V9T3WFeVJHY4
i6ha15VFNDcBMMHUhQt6j8LOyyyABg==
=9eJI
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

