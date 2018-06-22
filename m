Received: from eggs.gnu.org ([2001:4830:134:3::10]:51762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fWPbq-00014O-V4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fWPbn-0001Sg-Nn
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:12:30 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fWPbn-0001SY-HY
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:12:27 -0400
Received: by mail-pg0-x242.google.com with SMTP id r21-v6so3242389pgv.4
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 10:12:27 -0700 (PDT)
Date: Fri, 22 Jun 2018 10:12:24 -0700
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Message-ID: <20180622171224.GB20261@breakout>
References: <20180621222143.27266-1-naravamudan@digitalocean.com>
	<20180621222143.27266-3-naravamudan@digitalocean.com>
	<20180622022512.GB5449@lemon.usersys.redhat.com>
	<20180622090206.GD4366@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622090206.GD4366@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] block/file-posix: reconfigure aio
 on iothread start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On 22.06.2018 [11:02:06 +0200], Kevin Wolf wrote:
> Am 22.06.2018 um 04:25 hat Fam Zheng geschrieben:
> > On Thu, 06/21 15:21, Nishanth Aravamudan wrote:
> > > When the AioContext changes, we need to associate a LinuxAioState with
> > > the new AioContext. Use the bdrv_attach_aio_context callback and call
> > > the new aio_setup_linux_aio(), which will allocate a new AioContext if
> > > needed, and return errors on failures. If it fails for any reason,
> > > fallback to threaded AIO with an error message, as the device is already
> > > in-use by the guest.
> > > 
> > > Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
> > > ---
> > > Note this patch didn't exist in v2, but is a result of feedback to that
> > > posting.
> > 
> > This should be squashed into patch 1, no?
> 
> Yes, without it, patch 1 is incorrect. Specifically, at least the
> assertion in aio_get_linux_aio() won't hold true without it.

Yes, you are right! Sorry about that. I'll send a v4 today.

-Nish
