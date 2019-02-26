Received: from eggs.gnu.org ([209.51.188.92]:52087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyfGE-0003h4-QZ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyfGA-0002fb-QV
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:07:14 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:45089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyfG9-0002cB-5m
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:07:10 -0500
Received: by mail-oi1-x236.google.com with SMTP id t82so10706174oie.12
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 08:07:03 -0800 (PST)
MIME-Version: 1.0
References: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 16:06:51 +0000
Message-ID: <CAFEAcA_Q5oHYOabG5rOcZY16BadrypW6MUg1im4CxeDXdeqTpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] Netpatches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 22 Feb 2019 at 14:55, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 7817ea16c1bb91ba3849e704d5f3e3c5775087bf:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190221' into staging (2019-02-22 13:04:42 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to eb4702b3ffcf11ec62f0c401f77f49219594e95c:
>
>   net: netmap: improve netmap_receive_iov() (2019-02-22 22:39:24 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Fails to build on at least some hosts:

cc -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g   -Wl,--warn-common -g
  /home/pm215/qemu/tests/test-announce-self.c tests/libqtest.o
libqemuutil.a   -o tests/test-announce-self
/home/pm215/qemu/tests/test-announce-self.c:11:24: fatal error:
qemu/osdep.h: No such file or directory
 #include "qemu/osdep.h"
                        ^


Something looks to be wrong with the command line here -- it is
not adding the usual/expected set of QEMU cflags (and in particular
is missing the option that adds the QEMU source tree to the
include path).

thanks
-- PMM
