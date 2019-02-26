Received: from eggs.gnu.org ([209.51.188.92]:49997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyikO-0003rx-EO
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyikK-0006bk-KQ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:50:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gyikG-0006Ok-ET
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:50:30 -0500
Date: Tue, 26 Feb 2019 19:50:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190226195016.GM2721@work-vm>
References: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA_Q5oHYOabG5rOcZY16BadrypW6MUg1im4CxeDXdeqTpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Q5oHYOabG5rOcZY16BadrypW6MUg1im4CxeDXdeqTpA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/13] Netpatches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Fri, 22 Feb 2019 at 14:55, Jason Wang <jasowang@redhat.com> wrote:
> >
> > The following changes since commit 7817ea16c1bb91ba3849e704d5f3e3c5775087bf:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190221' into staging (2019-02-22 13:04:42 +0000)
> >
> > are available in the git repository at:
> >
> >   https://github.com/jasowang/qemu.git tags/net-pull-request
> >
> > for you to fetch changes up to eb4702b3ffcf11ec62f0c401f77f49219594e95c:
> >
> >   net: netmap: improve netmap_receive_iov() (2019-02-22 22:39:24 +0800)
> >
> > ----------------------------------------------------------------
> >
> > ----------------------------------------------------------------
> 
> Fails to build on at least some hosts:
> 
> cc -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g   -Wl,--warn-common -g
>   /home/pm215/qemu/tests/test-announce-self.c tests/libqtest.o
> libqemuutil.a   -o tests/test-announce-self
> /home/pm215/qemu/tests/test-announce-self.c:11:24: fatal error:
> qemu/osdep.h: No such file or directory
>  #include "qemu/osdep.h"
>                         ^
> 
> 
> Something looks to be wrong with the command line here -- it is
> not adding the usual/expected set of QEMU cflags (and in particular
> is missing the option that adds the QEMU source tree to the
> include path).

OK, I see it, I was missing a :
+tests/test-announce-self$(EXESUF): tests/test-announce-self.o

line

Curious that it worked on some platforms; I guess maybe there's an
implicit rule somewhere.

Dave

> thanks
> -- PMM
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
