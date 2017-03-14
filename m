Received: from eggs.gnu.org ([2001:4830:134:3::10]:33901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnp2q-0006QC-Ll
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnp2p-0003am-Sl
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:11:32 -0400
Date: Wed, 15 Mar 2017 00:11:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170314161124.GA19001@lemon.lan>
References: <20170314154315.17869-1-famz@redhat.com>
	<20170314155046.GL3952@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314155046.GL3952@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Don't leak fd in
 hdev_get_max_segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Tue, 03/14 16:50, Kevin Wolf wrote:
> Am 14.03.2017 um 16:43 hat Fam Zheng geschrieben:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/file-posix.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index c4c0663..e6170f4 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -703,6 +703,7 @@ static int hdev_get_max_segments(const struct stat *st)
> >      }
> >  
> >  out:
> > +    close(fd);
> 
> Should we make this conditional on fd != -1?

OK, that is cleaner.

Fam

> 
> >      g_free(sysfspath);
> >      return ret;
> >  #else
> 
> Kevin
