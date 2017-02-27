Received: from eggs.gnu.org ([2001:4830:134:3::10]:40647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciPCw-0000XI-8e
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciPCv-0008Qf-FM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:35:34 -0500
Date: Mon, 27 Feb 2017 18:35:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170227173525.GG6356@noname.redhat.com>
References: <20170131115728.5244.21690.stgit@PASHA-ISP>
	<20170131115734.5244.64846.stgit@PASHA-ISP>
	<20170222100543.GC4112@noname.str.redhat.com>
	<002701d290f2$1541b9c0$3fc52d40$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002701d290f2$1541b9c0$3fc52d40$@ru>
Subject: Re: [Qemu-devel] [PATCH 1/3] block: implement bdrv_snapshot_goto
 for blkreplay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Am 27.02.2017 um 13:07 hat Pavel Dovgalyuk geschrieben:
> > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > Am 31.01.2017 um 12:57 hat Pavel Dovgalyuk geschrieben:
> > > This patch enables making snapshots with blkreplay used in
> > > block devices.
> > >
> > > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > 
> > Specifically, I think it avoids the blkreplay_open/close sequence. Is
> > this what is needed to make it work?
> 
> Then I'll need to implement bdrv_open, because there is only bdrv_file_open
> for blkreplay now.
> 
> Which way is better?

I was just checking whether I understood the reason for this correctly.

If I did, then I think your solution is fine and we should just make the
commit message a bit more explicit.

Kevin

> > We should probably mention in the commit message the exact reason why
> > implementing .bdrv_snapshot_goto, but not the other snapshot related
> > callbacks, fixes things. If you confirm my assumption, I can add that
> > while applying.
> 
> Pavel Dovgalyuk
> 
