Received: from eggs.gnu.org ([2001:4830:134:3::10]:34133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fazcz-0003zW-9f
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fazcy-0007VS-Cx
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:28:37 -0400
Date: Thu, 5 Jul 2018 10:28:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705082829.GA3309@localhost.localdomain>
References: <20180703145915.32607-1-kwolf@redhat.com>
	<CAFEAcA-xXYTcGJFtC90AvtFReRbFeAWuQNk2uobFCsioLHCikg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-xXYTcGJFtC90AvtFReRbFeAWuQNk2uobFCsioLHCikg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/5] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vsementsov@virtuozzo.com
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Am 04.07.2018 um 20:30 hat Peter Maydell geschrieben:
> On 3 July 2018 at 15:59, Kevin Wolf <kwolf@redhat.com> wrote:
> > The following changes since commit a395717cbd26e7593d3c3fe81faca121ec6d13e8:
> >
> >   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-07-03 11:49:51 +0100)
> >
> > are available in the git repository at:
> >
> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to 59738025a1674bb7e07713c3c93ff4fb9c5079f5:
> >
> >   block: Add blklogwrites (2018-07-03 16:09:48 +0200)
> >
> > ----------------------------------------------------------------
> > Block layer patches:
> >
> > - qcow2: Use worker threads for compression to improve performance of
> >   'qemu-img convert -W' and compressed backup jobs
> > - blklogwrites: New filter driver to log write requests to an image in
> >   the dm-log-writes format
> >
> > ----------------------------------------------------------------
> 
> Hi; this gives some a warning on OpenBSD and NetBSD:
> 
> /home/qemu/block/qcow2.c: In function 'qcow2_compress':
> /home/qemu/block/qcow2.c:3684:18: warning: assignment discards 'const'
> qualifier from pointer target type
>      strm.next_in = src;

Hm, looks like they use a really old version of the zlib header, which
doesn't care about const correctness. I'll add a cast to work around it.

Kevin
