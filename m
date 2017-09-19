Received: from eggs.gnu.org ([2001:4830:134:3::10]:55064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duDUO-0003Ov-K3
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duDUI-00011u-Tw
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:02:40 -0400
Date: Tue, 19 Sep 2017 10:02:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170919080221.GC3789@localhost.localdomain>
References: <1505298088-10878-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505298088-10878-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Clean up some bad code in the vvfat
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

Am 13.09.2017 um 12:21 hat Thomas Huth geschrieben:
> Remove the unnecessary home-grown redefinition of the assert() macro here,
> and remove the unusable debug code at the end of the checkpoint() function.
> The code there uses assert() with side-effects (assignment to the "mapping"
> variable), which should be avoided. Looking more closely, it seems as it is
> apparently also only usable for one certain directory layout (with a file
> named USB.H in it) and thus is of no use for the rest of the world.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to the block branch.

Kevin
