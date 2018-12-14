Received: from eggs.gnu.org ([2001:4830:134:3::10]:40294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXrHT-0008Te-Vs
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXrHT-0001yj-5C
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:29:43 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXrHS-0001yO-ML
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:29:43 -0500
Received: by mail-ot1-x343.google.com with SMTP id v23so6105049otk.9
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 09:29:42 -0800 (PST)
MIME-Version: 1.0
References: <20181213181402.24012-1-pbonzini@redhat.com>
In-Reply-To: <20181213181402.24012-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 17:29:29 +0000
Message-ID: <CAFEAcA-uqJgDOE7aFY7gCuq17WjsdH0CxAD-He0Ym0Dm-oR2cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/46] Misc patches for 2018-12-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 13 Dec 2018 at 18:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af4220=
86:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-12-11 19:18:58 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to d115ceb731fc09134fb0816c956ab0eb88fbfa7b:
>
>   vhost-user-test: create a temporary directory per TestServer (2018-12-1=
3 10:57:30 +0100)
>
> ----------------------------------------------------------------
> * HAX support for Linux hosts (Alejandro)
> * esp bugfixes (Guenter)
> * Windows build cleanup (Marc-Andr=C3=A9)
> * checkpatch logic improvements (Paolo)
> * coalesced range bugfix (Paolo)
> * switch testsuite to TAP (Paolo)
> * QTAILQ rewrite (Paolo)
> * enable vhost for TCG and clean up vhost-user-test (Paolo)
> * block/iscsi.c cancellation fixes (Stefan)
> * improve selection of the default accelerator (Thomas)
>
> ----------------------------------------------------------------

Compile issues, I'm afraid (and a monitor.c conflict, but that
was trivial so I fixed it up):

Compile failures on OpenBSD, NetBSD, FreeBSD, OSX trying to use a linux hea=
der:

hw/net/vhost_net.c:26:10: fatal error: 'linux/vhost.h' file not found
#include <linux/vhost.h>
         ^~~~~~~~~~~~~~~

and one on sparc Linux:
In file included from /home/pm215/qemu/hw/net/vhost_net.c:28:
/home/pm215/qemu/linux-headers/linux/kvm.h:14:10: fatal error:
asm/kvm.h: No such file or directory
 #include <asm/kvm.h>
          ^~~~~~~~~~~

trying to use our linux-headers headers on a host architecture
which isn't a KVM-supporting one (those are the only ones we
sync headers for).

thanks
-- PMM
