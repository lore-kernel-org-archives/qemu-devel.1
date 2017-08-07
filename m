Received: from eggs.gnu.org ([2001:4830:134:3::10]:53919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1defav-00059h-4m
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1defau-0001q8-6d
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:49:09 -0400
Date: Mon, 7 Aug 2017 12:48:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170807104859.GC6578@localhost.localdomain>
References: <cover.1502075213.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1502075213.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] VHDX cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org

Am 07.08.2017 um 05:08 hat Jeff Cody geschrieben:
> Two VHDX items cleaned up:
> 
> 1. Check for error when calling bdrv_getlength() [Markus]
> 
> 2. Check for overflow in offset prior to calling bdrv_truncate().

This doesn't look like cleanups to me, but like proper fixes. I think it
would still qualify for 2.10.

Kevin
