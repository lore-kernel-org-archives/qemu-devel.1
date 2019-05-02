Received: from eggs.gnu.org ([209.51.188.92]:52118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMBP2-00035I-0c
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMBP0-0003f5-Pk
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:05:31 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:41016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMBOz-0003e9-Kx
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:05:30 -0400
Received: by mail-oi1-x22b.google.com with SMTP id v23so1589066oif.8
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 06:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190502073543.4391-1-kraxel@redhat.com>
In-Reply-To: <20190502073543.4391-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 14:05:16 +0100
Message-ID: <CAFEAcA-OyrwAqp1Kwt-sFJY3xj=0mUszGtF3RewwLs25vOhNLg@mail.gmail.com>
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

On Thu, 2 May 2019 at 08:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit f75d15231e56cb0f2bafe19faf1229c459a607=
31:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-04-30 17:06:57 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190502-pull-request
>
> for you to fetch changes up to f3ea801df82991e852862bcaede23a4607859dd8:
>
>   hw/usb: avoid format truncation warning when formatting port name (2019=
-05-02 09:34:13 +0200)
>
> ----------------------------------------------------------------
> usb: bugfixes for mtp and xhci, split ohci-pci.
>
> ----------------------------------------------------------------


Hi -- I'm afraid this failed to compile on one of my systems:

  CC      hw/usb/hcd-xhci.o
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c: In function
=E2=80=98usb_xhci_realize=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:3340:66:
error: =E2=80=98%d=E2=80=99 directive output may be truncated writing betwe=
en 1 and 11
bytes into a region of size 5 [-Werror=3Dformat-truncation=3D]
             snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+1)=
;
                                                                  ^~
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:3340:54: note:
directive argument in the range [-2147483647, 30]
             snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+1)=
;
                                                      ^~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:862:0,
                 from
/home/petmay01/linaro/qemu-for-merges/include/qemu/osdep.h:99,
                 from
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:21:
/usr/include/x86_64-linux-gnu/bits/stdio2.h:64:10: note:
=E2=80=98__builtin___snprintf_chk=E2=80=99 output between 13 and 23 bytes i=
nto a
destination of size 16
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:3354:66:
error: =E2=80=98%d=E2=80=99 directive output may be truncated writing betwe=
en 1 and 11
bytes into a region of size 5 [-Werror=3Dformat-truncation=3D]
             snprintf(port->name, sizeof(port->name), "usb3 port #%d", i+1)=
;
                                                                  ^~
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:3354:54: note:
directive argument in the range [-2147483647, 30]
             snprintf(port->name, sizeof(port->name), "usb3 port #%d", i+1)=
;
                                                      ^~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:862:0,
                 from
/home/petmay01/linaro/qemu-for-merges/include/qemu/osdep.h:99,
                 from
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:21:
/usr/include/x86_64-linux-gnu/bits/stdio2.h:64:10: note:
=E2=80=98__builtin___snprintf_chk=E2=80=99 output between 13 and 23 bytes i=
nto a
destination of size 16
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

It looks like this compiler isn't able to decide that i is definitely not
negative, so it thinks the resulting string might not fit.

thanks
-- PMM
