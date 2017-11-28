Received: from eggs.gnu.org ([2001:4830:134:3::10]:37861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJVbs-0003oy-39
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 21:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJVbn-0008P9-4y
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 21:26:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eJVbm-0008OS-V3
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 21:26:51 -0500
Date: Tue, 28 Nov 2017 10:26:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171128022647.GA24694@lemon>
References: <20171124085351.26386-1-famz@redhat.com>
	<20171124085351.26386-3-famz@redhat.com>
	<20171124152439.GB4010@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171124152439.GB4010@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qemu-options: Mention locking
 option of file driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Philipp Hahn <hahn@univention.de>, mreitz@redhat.com

On Fri, 11/24 16:24, Kevin Wolf wrote:
> > @@ -693,6 +693,10 @@ This is the protocol-level block driver for accessing regular files.
> >  The path to the image file in the local filesystem
> >  @item aio
> >  Specifies the AIO backend (threads/native, default: threads)
> > +@item locking
> > +Specifies whether the image file is protected with Linux OFD / POSIX locks. The
> > +default is to use the Linux Open File Descriptor API if avaiable, otherwise no
> 
> s/avaiable/available/
> 
> I'll fix this while applying.
> 

Thanks!

Fam
