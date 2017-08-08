Received: from eggs.gnu.org ([2001:4830:134:3::10]:48954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df3Az-0002nc-B8
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df3Ay-0000TZ-D8
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:59:57 -0400
Date: Tue, 8 Aug 2017 13:59:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170808115944.GI4850@dhcp-200-186.str.redhat.com>
References: <ebdf772d1a48ccec999866f9c5cb209b2fcedf48.1502144886.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebdf772d1a48ccec999866f9c5cb209b2fcedf48.1502144886.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] block/nfs: fix mutex assertion in
 nfs_file_close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pl@kamp.de

Am 08.08.2017 um 00:29 hat Jeff Cody geschrieben:
> Commit c096358e747e88fc7364e40e3c354ee0bb683960 introduced assertion
> checks for when qemu_mutex() functions are called without the
> corresponding qemu_mutex_init() having initialized the mutex.
> 
> This uncovered a latent bug in qemu's nfs driver - in
> nfs_client_close(), the NFSClient structure is overwritten with zeros,
> prior to the mutex being destroyed.
> 
> Go ahead and destroy the mutex in nfs_client_close(), and change where
> we call qemu_mutex_init() so that it is correctly balanced.
> 
> There are also a couple of memory leaks obscured by the memset, so this
> fixes those as well.
> 
> Finally, we should be able to get rid of the memset(), as it isn't
> necessary.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>

Thanks, applied to the block branch.

Kevin
