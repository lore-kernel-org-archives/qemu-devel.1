Received: from eggs.gnu.org ([2001:4830:134:3::10]:39310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2aJ6-0008EO-Aa
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2aJ0-0006Tw-V1
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:01:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2aJ0-0006TO-QD
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:01:30 -0400
Message-ID: <1507802488.26812.15.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 12 Oct 2017 12:01:28 +0200
In-Reply-To: <CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
References: <20171011083604.11820-1-kraxel@redhat.com>
	<CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20171011 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> FreeBSD:
>=20
>=20
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap.o
> /root/qemu/ui/input-keymap.c:8:10: fatal error:
> 'ui/input-keymap-linux-to-qcode.c' file not found
> #include "ui/input-keymap-linux-to-qcode.c"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^

scripts/git-modules.sh has no bashims, a simple s/bash/sh/ fixes the
build on freebsd.

cheers,
  Gerd
