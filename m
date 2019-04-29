Received: from eggs.gnu.org ([209.51.188.92]:37129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL2SK-0003Mq-NZ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL2SJ-0001Ct-Nx
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:20:12 -0400
Date: Mon, 29 Apr 2019 11:20:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190429092005.GB8492@localhost.localdomain>
References: <20190413152037.6817-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413152037.6817-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-next 0/2] qemu-img: Make create hint at
 protocol options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Am 13.04.2019 um 17:20 hat Max Reitz geschrieben:
> https://bugzilla.redhat.com/show_bug.cgi?id=1698863 reports that while
> "qemu-img create -f raw" supports the "preallocation" option, it is not
> listed under "-o help".
> 
> It turns out it is, but only if you specify a target filename.  Users
> may not realize this, but a note should help.

Thanks, applied to the block branch.

Kevin
