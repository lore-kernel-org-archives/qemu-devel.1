Received: from eggs.gnu.org ([2001:4830:134:3::10]:48436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evQt9-0007Js-1L
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evQt8-0005hh-85
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:05:31 -0400
Date: Tue, 13 Mar 2018 01:05:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180312170519.GB8326@lemon.usersys.redhat.com>
References: <20180312132204.23683-1-stefanha@redhat.com>
	<d47e7441-0166-07c6-20fd-6020e553903a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47e7441-0166-07c6-20fd-6020e553903a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add include/block/aio-wait.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, 03/12 09:05, Eric Blake wrote:
> On 03/12/2018 08:22 AM, Stefan Hajnoczi wrote:
> > The include/block/aio-wait.h header file was added by commit
> > 7719f3c968c59e1bcda7e177679dc765b59e578f ("block: extract
> > AIO_WAIT_WHILE() from BlockDriverState") without updating MAINTAINERS.
> 
> A shame checkpatch.pl and/or patchew still doesn't flag this, even though
> it's been proposed as a syntax check.

Re checkpatch.pl vs patchew, IMO this check fits better in the former.

Fam
