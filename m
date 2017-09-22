Received: from eggs.gnu.org ([2001:4830:134:3::10]:39898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dvImv-0005D9-Uk
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dvImr-0003nr-Ol
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:54:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dvImr-0003n5-Id
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:54:13 -0400
Date: Fri, 22 Sep 2017 09:54:01 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20170922075401.GA2933@vader>
References: <20170920083647.14599-1-famz@redhat.com>
	<df117864-4533-9527-d051-62a126e60794@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df117864-4533-9527-d051-62a126e60794@siemens.com>
Subject: Re: [Qemu-devel] [PATCH] seccomp: Don't include libseccomp from
 QEMU header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Fri, Sep 22, 2017 at 09:09:27AM +0200, Jan Kiszka wrote:
> On 2017-09-20 10:36, Fam Zheng wrote:
> > The only prototype doesn't need anything from the lib header, and not
> > including it here allows files that include this header, for example
> > vl.c, to compile without the libseccomp cflags.
> > 
> > The breakage is since c3883e1f93 for environments where `pkg-config
> > --cflags libseccomp" is non-empty.
> > 
> > Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>

Acked-by: Eduardo Otubo <otubo@redhat.com>

> > 
> > ---
> > 
> > This is an alternative for
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04470.html
> > ([Qemu-devel] [PATCH] seccomp: Fix build)
> > ---
> >  include/sysemu/seccomp.h | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
> > index e67c2dc840..9b092aa23f 100644
> > --- a/include/sysemu/seccomp.h
> > +++ b/include/sysemu/seccomp.h
> > @@ -21,7 +21,5 @@
> >  #define QEMU_SECCOMP_SET_SPAWN       (1 << 3)
> >  #define QEMU_SECCOMP_SET_RESOURCECTL (1 << 4)
> >  
> > -#include <seccomp.h>
> > -
> >  int seccomp_start(uint32_t seccomp_opts);
> >  #endif
> > 
> 
> Works fine for me as well and is indeed cleaner.
> 
> Jan
> 
> -- 
> Siemens AG, Corporate Technology, CT RDA ITP SES-DE
> Corporate Competence Center Embedded Linux

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
