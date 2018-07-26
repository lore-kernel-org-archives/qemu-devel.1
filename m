Received: from eggs.gnu.org ([2001:4830:134:3::10]:40669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1fijXB-0006hO-19
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1fijX6-0006YH-69
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:54:37 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1fijX6-0006Xf-06
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:54:32 -0400
Received: by mail-vk0-f66.google.com with SMTP id y70-v6so1128919vkc.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 09:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180726113337.23144-1-kwolf@redhat.com>
	<CAMRbyyt-+ncsJzNbtF6dVNVHGiykORE-edF4z=nXepW9U=-RZg@mail.gmail.com>
	<20180726164143.GI4215@localhost.localdomain>
In-Reply-To: <20180726164143.GI4215@localhost.localdomain>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 26 Jul 2018 19:54:19 +0300
Message-ID: <CAMRbyyvVm7_Hqgjqbh-YVNx6s_h745yRsHhXq6F9zvV5pNriRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-3.0] file-posix: Fix
 write_zeroes with unmap on block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Thu, Jul 26, 2018 at 7:41 PM Kevin Wolf <kwolf@redhat.com> wrote:
...

> > > +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> > > +    ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE |
> FALLOC_FL_KEEP_SIZE,
> > > +                       aiocb->aio_offset, aiocb->aio_nbytes);
> > > +    if (ret != -ENOTSUP) {
> > >
> >
> > This fails with ENODEV on RHEL 7.5 when fd is a block device.
> >
> > The manual says:
> >
> >        ENODEV fd does not refer to a regular file or a directory.  (If fd
> > is a pipe or FIFO, a different error results.)
>
> do_fallocate() is a wrapper around fallocate() that handles EINTR and
> translates a few errno values (including ENODEV) into a -ENOTSUP return
> code.
>

I missed that, so this looks correct.

Nir
