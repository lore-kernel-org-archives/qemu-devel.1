Received: from eggs.gnu.org ([2001:4830:134:3::10]:59262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85L5-0004kF-HY
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85L2-0006LZ-8D
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85L1-0006Ku-Tt
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:10:20 -0400
Date: Fri, 27 Oct 2017 16:10:14 +0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171027141014.GB2971@localhost.localdomain>
References: <20171026140404.21948-1-ehabkost@redhat.com>
	<CAFEAcA8fu0PCd8snz3yqv+Oys=6zdD4XbyCtrezJQjZV4UO0Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8fu0PCd8snz3yqv+Oys=6zdD4XbyCtrezJQjZV4UO0Sw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/39] x86/cpu/numa queue, 2017-10-26
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

On Fri, Oct 27, 2017 at 02:42:11PM +0100, Peter Maydell wrote:
> On 26 October 2017 at 15:03, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > (Note that master is currently broken with --disable-tcg, but I
> > don't want to hold the queue until this is fixed.)
> >
> > The following changes since commit ae49fbbcd8e4e9d8bf7131add34773f579e1aff7:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20171025' into staging (2017-10-25 16:38:57 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
> >
> > for you to fetch changes up to ba2975aa134fdb0208f0a54c544402fed1890217:
> >
> >   x86: Skip check apic_id_limit for Xen (2017-10-26 15:29:38 +0200)
> >
> > ----------------------------------------------------------------
> > x86/machine/numa queue, 2017-10-26
> 
> Hi. I'm afraid this breaks the sh4 linux-user code:
> 
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sh4-linux-user/qemu-sh4
> -L ./gnemul/qemu-sh4 sh4/ls -l dummyfile
> unable to find CPU model 'sh7785-superh-cpu'

A fixup patch from Igor was missing, sorry.  v2 will be sent
soon.

BTW, is there a way we can include linux-user tests on travis-ci?

-- 
Eduardo
