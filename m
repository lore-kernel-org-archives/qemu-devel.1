Received: from eggs.gnu.org ([209.51.188.92]:53057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gtsVn-0001V1-0Y
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gtsKA-0005hh-P2
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:03:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:33799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gtsK4-0005Sv-9U
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:03:27 -0500
Received: by mail-wm1-x32d.google.com with SMTP id y185so1600363wmd.1
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 03:03:21 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 13 Feb 2019 12:03:07 +0100
Message-ID: <CAJ+F1CKBRNdLPb_wOLhURdUJd-j1RHY2toKSTEhCBt_zs4Xk1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Clearing slirp/ license
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

Hi,

As we are trying to move slirp/ in a standalone project, which
eventually could be installed as a shared library, we need to clear
the license.

slirp is supposed to be 3-Clause BSD license (according to
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2f5f89963186d42a7ded253bc=
6cf5b32abb45cec)
but it seems to be effectively a 2-Clause BSD (the third clause is not
in COPYRIGHT)

However, there are two units that are GPL-2:

- dhcpv6.c, dhcpv6.h:
  The code was contributed by Thomas Huth <thuth@redhat.com>

$ git shortlog -nes slirp/dhcpv6.{c,h}
     6  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
     1  Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
     1  Thomas Huth <thuth@redhat.com>
     1  Yuval Shaia <yuval.shaia@oracle.com>

- ncsi.c, ncsi-pkt.h:
  The code was contributed by C=C3=A9dric Le Goater <clg@kaod.org>

$ git shortlog -nes slirp/ncsi.c slirp/ncsi-pkt.h
     5  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
     4  C=C3=A9dric Le Goater <clg@kaod.org>

Could you reply that you have no objection in relicensing those files
are 3-Clause BSD?

After "[Qemu-devel] [PATCH 0/7] slirp: make it a standalone project",
the vmstate subset that I adapted would also need to be relicensed.
There are more contributors here, I am not sure how it should be
handled. Any idea?

thanks

--=20
Marc-Andr=C3=A9 Lureau
