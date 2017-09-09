Received: from eggs.gnu.org ([2001:4830:134:3::10]:52660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqTJ1-00054Q-Pq
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 20:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqTIx-0006DV-AX
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 20:07:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqTIx-0006Cd-4T
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 20:07:23 -0400
Date: Sat, 9 Sep 2017 08:07:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170909000718.GE18677@lemon.lan>
References: <20170908095506.13594-1-famz@redhat.com>
	<CAFEAcA8XcsV0tULC4M3h5E-Jo0CKpLmWECi7QFp0DMV-aSy5Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8XcsV0tULC4M3h5E-Jo0CKpLmWECi7QFp0DMV-aSy5Rw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/38] Test and build system patches
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

On Fri, 09/08 14:44, Peter Maydell wrote:
> On 8 September 2017 at 10:54, Fam Zheng <famz@redhat.com> wrote:
> > Hi Peter,
> >
> > The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc76:
> >
> >   tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/famz/qemu.git tags/staging-pull-request
> >
> > for you to fetch changes up to d0fba2165aa69ee5cb6a368ad611f3d54950fe4e:
> >
> >   buildsys: Move rdma libs to per object (2017-09-08 17:47:11 +0800)
> >
> > ----------------------------------------------------------------
> >
> > This includes:
> >
> > - Alex's improvements of docker tests
> > - VM test
> > - test-block for docker tests
> > - test-full improvements
> > - cflags / libs cleanup
> >
> > ----------------------------------------------------------------
> 
> Hi. This failed to build on OpenBSD:
>   CC      qmp.o
> In file included from /home/qemu/ui/vnc.h:33:0,
>                  from /home/qemu/qmp.c:26:
> /home/qemu/include/ui/console.h:13:23: fatal error: epoxy/gl.h: No
> such file or directory
>  # include <epoxy/gl.h>
>                        ^
> 
> Looks like the opengl_cflags are not being applied everywhere
> they should be. (OpenBSD is a bit odd in that it doesn't put
> epoxy/ in /usr/include, so you must get the -I options right
> for the gl.h header to be found.)

Yeah, fixing that is not trivial, I'll drop that patch and rework it. With that,
OpenBSD compiles fine for me (my fault a selftest wasn't done with this series).

Fam
