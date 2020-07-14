Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A340C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03FBC21D95
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fg+LCoA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FBC21D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvBMv-0008QS-95
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 23:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvBMA-0007w5-VT
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 23:11:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvBM8-0007Aa-9L
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 23:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594696303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rFjePLvNpp6qDNjy5v1o3d8AKVNJX44AoGxykxQctfI=;
 b=Fg+LCoA/QqAMljH2SeGmU2/vNJyoCBckL38Rf5GUQdy+zdxHy0PV0UmZPQryQ6/d9oZGgX
 71nAlWQvzVJ+YO+dsKlvCk/kdWOCzBA/4RM/sS4U9Ri7db8YqUQi/jikUpnSdSmKDGU4IG
 cVFPsoesT14RLuoIxMJfyCg+kfu6v14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-SKh3X4-kPpGPd6QQbYJcyQ-1; Mon, 13 Jul 2020 23:11:39 -0400
X-MC-Unique: SKh3X4-kPpGPd6QQbYJcyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B9CD8015F4;
 Tue, 14 Jul 2020 03:11:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C3C619C4F;
 Tue, 14 Jul 2020 03:11:33 +0000 (UTC)
Date: Mon, 13 Jul 2020 23:11:31 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 3/9] tests/acceptance/boot_linux: Tag tests using a SD
 card with 'device:sd'
Message-ID: <20200714031131.GD2983508@localhost.localdomain>
References: <20200713183209.26308-1-f4bug@amsat.org>
 <20200713183209.26308-4-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200713183209.26308-4-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2020 at 08:32:03PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Avocado tags are handy to automatically select tests matching
> the tags. Since these tests use a SD card, tag them.
>=20
> We can run all the tests using a SD card at once with:
>=20
>   $ avocado --show=3Dapp run -t u-boot tests/acceptance/
>   $ AVOCADO_ALLOW_LARGE_STORAGE=3Dok \
>     avocado --show=3Dapp \
>       run -t device:sd tests/acceptance/
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxCon=
sole.test_arm_orangepi_sd
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxCon=
sole.test_arm_orangepi_bionic
>   Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxCon=
sole.test_arm_orangepi_uboot_netbsd9
>    (1/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm=
_orangepi_sd: PASS (19.56 s)
>    (2/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm=
_orangepi_bionic: PASS (49.97 s)
>    (3/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm=
_orangepi_uboot_netbsd9: PASS (20.06 s)
>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
>   JOB TIME   : 90.02 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 3 +++
>  1 file changed, 3 insertions(+)
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8NImAACgkQZX6NM6Xy
CfOZdg/8DwP4f5Vj9+Ub0fTWrto+lW5jehuPTLud2HiFMnbgg4xR6D4xJrQyw+Ko
l8xVqTzdfNAdEuZoObCmR5Rw1EUA3eZ9aH4/bYUon8+xy1ghtHkhyIOP/MZABgnF
Jz//NYha8TXmQVb3atKBJLfR3N8wTzwnmsyfvku5ogcEp3PXkI6wWORuIRc193NB
ObKkLYmz8Rr3OjIl8gd05c4/GFKbyogBdHu3q359xCtTDhdgi/JtgDnyE807Spe7
kubP5cTkhprJOi5W7k739IiPg0nPuAEou5dKt8jEIprKAGIgN7wAAkQKx9QRwc8I
brP5x4TzJW0+mqOVqfJa5XzJtaoAhUkb0+w5BjdrF4t9PNdUGxCDF7By4A4EGGYy
riMhJ/R0mf+Vq7uR55QL+z4YuexsbuzOvQesmaUmz0UoKolsqoeV4A3ElOlPfIk2
OgoDxFmFXppllOl/JSCy2c2PuN/EbMKUlh7T592/lWFBKxkhUU9rRnsYS/BxKB/X
chOw08XTXXPDnD1XHxhKKMgC1DEKcfXfPvDYtTRYOfWJeeroDSlklWmIecK1VOQm
us3KQeBdnmFwvI1zW8Wla5YqLUZ0t+Jt7722yK9Kdg2aNo1Er2KVdpcomBXxRK+9
X42w+2nM4P2dsF2/qNnBpPbHrlXlvf+qkJbHSpBE76ki6awMngA=
=eU7j
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--


