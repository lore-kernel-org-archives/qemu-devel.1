Received: from eggs.gnu.org ([209.51.188.92]:41638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2Fep-00058d-3A
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2Fel-0001uZ-8B
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:35:24 -0500
Date: Fri, 8 Mar 2019 14:35:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190308133510.GC31583@localhost.localdomain>
References: <20190308062455.29755-1-armbru@redhat.com>
	<481d398a-e26c-6c0a-20b7-7466ae1ebf1f@redhat.com>
	<875zsteeih.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zsteeih.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v7] pflash: Require backend size to match
 device, improve errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, philmd@redhat.com, alex.bennee@linaro.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 08.03.2019 um 13:28 hat Markus Armbruster geschrieben:
> Laszlo Ersek <lersek@redhat.com> writes:
> > This one has got to be one of the longest bike-shedding sessions! :)
> >
> > I'm fine with this patch, but I could suggest two improvements.
> >
> > (1) When blk_getlength() fails, we could format the negative error code
> > returned by it into the error message.
> 
> I can do that.

By using error_setg_errno(), I assume. Not throwing away error details
is always good.

> > (2) We could extract the common code to a new function in
> > "hw/block/block.c". (It says "Common code for block device models" on
> > the tin.)
> 
> There's so much common code in these two files even before this patch...

My understanding is that hw/block/block.c contains code that is
potentially useful to all kinds of block devices, not random code that
two specific similar devices happen to share.

If we want to deduplicate some code in the flash devices, without any
expectation that other devices will use it at some point, I'd rather
create a new source file hw/block/pflash_common.c or something like
that.

Kevin
