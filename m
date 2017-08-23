Received: from eggs.gnu.org ([2001:4830:134:3::10]:60745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWOE-0007kg-M8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWOA-0001BT-Dt
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:12:14 -0400
Date: Wed, 23 Aug 2017 15:11:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170823141155.GA16760@stefanha-x1.localdomain>
References: <20170823134242.12080-1-famz@redhat.com>
	<20170823134242.12080-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823134242.12080-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/4] block: Update open_flags
 after ->inactivate() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Wed, Aug 23, 2017 at 09:42:42PM +0800, Fam Zheng wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> In the ->inactivate() callbacks, permissions are updated, which
> typically involves a recursive check of the whole graph. Setting
> BDRV_O_INACTIVE right before doing that creates a state that
> bdrv_is_writable() returns false, which causes permission update
> failure.
> 
> Reorder them so the flag is updated after calling the function. Note
> that this doesn't break the assert in bdrv_child_cb_inactivate() because
> for any specific BDS, we still update its flags first before calling
> ->inactivate() on it one level deeper in the recursion.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
