Received: from eggs.gnu.org ([209.51.188.92]:57322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMBoC-00045P-0F
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMBoB-0003zT-0s
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:31:31 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:46453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMBoA-0003vX-Sb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:31:30 -0400
Received: by mail-ot1-x32e.google.com with SMTP id 77so2009860otu.13
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 06:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190502073543.4391-1-kraxel@redhat.com>
	<CAFEAcA-OyrwAqp1Kwt-sFJY3xj=0mUszGtF3RewwLs25vOhNLg@mail.gmail.com>
	<20190502132105.qkudeunhcueadka7@sirius.home.kraxel.org>
In-Reply-To: <20190502132105.qkudeunhcueadka7@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 14:31:18 +0100
Message-ID: <CAFEAcA-85EsCJGOPZ1ugZwa9GHQBYoGVi-im8kt2yjrSY+HJow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] Usb 20190502 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, 2 May 2019 at 14:21, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > Hi -- I'm afraid this failed to compile on one of my systems:
> >
> >   CC      hw/usb/hcd-xhci.o
> > /home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c: In function
> > =E2=80=98usb_xhci_realize=E2=80=99:
> > /home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:3340:66:
> > error: =E2=80=98%d=E2=80=99 directive output may be truncated writing b=
etween 1 and 11
> > bytes into a region of size 5 [-Werror=3Dformat-truncation=3D]
> >              snprintf(port->name, sizeof(port->name), "usb2 port #%d", =
i+1);
>
> Which system/compiler is this?

x86-64 Linux, gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0,
non-debug build.

thanks
-- PMM
