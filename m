Received: from eggs.gnu.org ([2001:4830:134:3::10]:57642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcZkw-0001Gn-Hl
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcZkv-0001a5-Kk
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:10:50 -0400
Date: Tue, 1 Aug 2017 18:10:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170801161036.GF4257@localhost.localdomain>
References: <20170801144632.3831-1-kwolf@redhat.com>
	<CAFEAcA94hi=gCos0DjHM0Op8ALBONmHhObEV_MZqz_+roXhzDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA94hi=gCos0DjHM0Op8ALBONmHhObEV_MZqz_+roXhzDg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/15] Block layer patches for 2.10.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Am 01.08.2017 um 18:01 hat Peter Maydell geschrieben:
> On 1 August 2017 at 15:46, Kevin Wolf <kwolf@redhat.com> wrote:
> > The following changes since commit 5619c179057e24195ff19c8fe6d6a6cbcb16ed28:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170731' into staging (2017-07-31 14:45:42 +0100)
> >
> > are available in the git repository at:
> >
> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to 9ae03670701fea9124f4f1a6d4b6d1badbf9e485:
> >
> >   block/qapi: Remove redundant NULL check to silence Coverity (2017-08-01 15:26:04 +0200)
> >
> > ----------------------------------------------------------------
> > Block layer patches for 2.10.0-rc1
> >
> > ----------------------------------------------------------------
> 
> Hi; I'm afraid the docs changes in this pull upset some of
> my test machines:
> 
> NetBSD, OpenBSD, OSX:
> 
>   GEN     docs/qemu-block-drivers.html
> /root/qemu/docs/qemu-block-drivers.texi:800: Unmatched `@end'.
> makeinfo: Removing output file `docs/qemu-block-drivers.html' due to
> errors; use --force to preserve.
> Makefile:692: recipe for target 'docs/qemu-block-drivers.html' failed
> 
> (and same error again trying to build the .txt file)
> 
> S390x, PPC64 Linux give a warning:
>   GEN     docs/qemu-block-drivers.html
> /home/linux1/qemu/docs/qemu-block-drivers.texi: warning: must specify
> a title with a title command or @top
> 
> (Other hosts still running the build job.)

I'm dropping the patch and sending v2.

Kevin
