Received: from eggs.gnu.org ([2001:4830:134:3::10]:36574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1I7i-0008LJ-Do
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 15:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1I7h-00068y-Kb
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 15:52:14 -0400
Date: Thu, 20 Apr 2017 21:51:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170420195156.GH4747@noname.redhat.com>
References: <1488288927-4607-1-git-send-email-pl@kamp.de>
	<20170420140514.GM24486@lemon.lan>
	<a5a4fb7e-8e2f-2031-bbdd-0abb15fdba10@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a4fb7e-8e2f-2031-bbdd-0abb15fdba10@kamp.de>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: simplify img_convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@gmail.com, mreitz@redhat.com, eblake@redhat.com

Am 20.04.2017 um 16:08 hat Peter Lieven geschrieben:
> Am 20.04.2017 um 16:05 schrieb Fam Zheng:
> >On Tue, 02/28 14:35, Peter Lieven wrote:
> >>img_convert has been around before there was an ImgConvertState or
> >>a block backend, but it has never been modified to directly use
> >>these structs. Change this by parsing parameters directly into
> >>the ImgConvertState and directly use BlockBackend where possible.
> >>Futhermore variable initalization has been reworked and sorted.
> >>
> >>Signed-off-by: Peter Lieven <pl@kamp.de>
> >I see an iotest failure with this patch, in Kevin's block-next tree:
> >
> >019 1s ... - output mismatch (see 019.out.bad)
> >--- /stor/work/qemu/tests/qemu-iotests/019.out	2017-04-17 16:19:56.523968474 +0800
> >+++ 019.out.bad	2017-04-20 22:03:29.868216955 +0800
> >@@ -1086,8 +1086,8 @@
> >  Checking if backing clusters are allocated when they shouldn't
> >-0/128 sectors allocated at offset 1 MiB
> >-0/128 sectors allocated at offset 4.001 GiB
> >+128/128 sectors allocated at offset 1 MiB
> >+128/128 sectors allocated at offset 4.001 GiB
> >  Reading
> >  === IO: pattern 42
> >Failures: 019
> >Failed 1 of 1 tests
> 
> Thanks for notifying, Fam.
> 
> @Kevin: Can you drop the patch again? I will send a V2 addressing this
> issue and the other comments I have got.

I could, but if it doesn't take too long, I'd prefer to only do so when
v2 is there. There are already a few conflicting patches and I asked
their authors to rebase onto yours, so it wouldn't be nice if they
wouldn't apply again because I removed your patch...

Kevin
