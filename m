Received: from eggs.gnu.org ([2001:4830:134:3::10]:43081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5a3Q-0008J1-KD
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5a3P-0004bh-Ri
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:49:32 -0400
Date: Tue, 2 May 2017 23:49:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170502154920.GB28344@lemon.lan>
References: <20170502081832.9546-1-famz@redhat.com>
	<20170502081832.9546-16-famz@redhat.com>
	<20170502141520.GD5805@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502141520.GD5805@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v16 15/22] file-posix: Add 'locking' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Tue, 05/02 16:15, Kevin Wolf wrote:
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 1cf29a1..29d3040 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -2127,11 +2127,15 @@
> >  #
> >  # @filename:    path to the image file
> >  # @aio:         AIO backend (default: threads) (since: 2.8)
> > +# @locking:     whether to enable file locking. If set to 'auto', only enable
> > +#               when Open File Descriptor (OFD) locking API is available
> > +#               (default: auto, since 2.10)
> >  #
> >  # Since: 2.9
> >  ##
> >  { 'struct': 'BlockdevOptionsFile',
> >    'data': { 'filename': 'str',
> > +            '*locking': 'OnOffAuto',
> >              '*aio': 'BlockdevAioOptions' } }
> 
> It's unfortunate that file-posix and file-win32 share the same QAPI
> type. Should we add a file-win32 implementation that just errors out
> when locking=on is specified, or is it enough that block.c notices that
> there is an option that hasn't been processed? (Even locking=off would
> cause failure then.)

That will make it a bit more like an oversight, maybe only error out when
locking=on is better.

Fam
