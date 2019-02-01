Received: from eggs.gnu.org ([209.51.188.92]:37239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gpTcu-00009z-SN
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gpTcu-0004Po-4w
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:52:40 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:44524
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gpTcr-0004Ma-M1
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:52:38 -0500
References: <20190129113921.21599-1-berrange@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <90a3688e-12f9-3209-e0b5-618b1029e1a1@weilnetz.de>
Date: Fri, 1 Feb 2019 08:52:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190129113921.21599-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] misc fixes to deal with icon location
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Adam Baxter <voltagex@voltagex.org>, Peter Maydell <peter.maydell@linaro.org>

On 29.01.19 12:39, Daniel P. Berrang=C3=A9 wrote:
> This is a few misc fixes identified after the icon location changes
> were merged. Most importantly it deals with the nsis installer file
> manifest.
>=20
> Daniel P. Berrang=C3=A9 (5):
>   nsis: don't install files into /tmp
>   make: don't insert a '/' after $(DESTDIR)
>   nsis: ensure we always pass -W64 flag to nsis installer script
>   nsis: fix location of icons to be bundled in the installer
>   configure: stop trying to link non-existant bmp file from bios dir
>=20
>  Makefile  | 23 +++++++++++++----------
>  configure |  1 -
>  qemu.nsi  |  4 ++--
>  3 files changed, 15 insertions(+), 13 deletions(-)
>=20

There was also a file rename which needs to be handled,
otherwise NSIS still fails:

File: "/tmp/qemu-nsis\qemu_logo_no_text.svg" -> no files found.

The new qemu.svg still includes the old file name. That could be fixed, t=
oo.

Regards,
Stefan
