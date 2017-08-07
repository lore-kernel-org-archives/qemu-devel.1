Received: from eggs.gnu.org ([2001:4830:134:3::10]:49859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dersg-0000ki-57
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dersb-0007vW-Ga
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:56:18 -0400
References: <ebdf772d1a48ccec999866f9c5cb209b2fcedf48.1502144886.git.jcody@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8c9d0a1a-e877-cdbe-d45f-c0ba68f055c0@redhat.com>
Date: Mon, 7 Aug 2017 19:55:58 -0400
MIME-Version: 1.0
In-Reply-To: <ebdf772d1a48ccec999866f9c5cb209b2fcedf48.1502144886.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10] block/nfs: fix mutex
 assertion in nfs_file_close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pl@kamp.de, qemu-block@nongnu.org



On 08/07/2017 06:29 PM, Jeff Cody wrote:
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


Looks sane to me.

Reviewed-by: John Snow <jsnow@redhat.com>
