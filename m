Received: from eggs.gnu.org ([2001:4830:134:3::10]:58584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtvDs-000839-8s
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtvDp-0007if-43
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:32:24 -0400
Date: Mon, 18 Sep 2017 20:32:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170918123212.GO15551@lemon.lan>
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170918075107.GK15551@lemon.lan>
	<20170918081103.GD31915@localhost.localdomain>
	<20170918115303.GL15551@lemon.lan>
	<20170918121123.GH31915@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918121123.GH31915@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/6] block: Fix permissions after ro/rw
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On Mon, 09/18 14:11, Kevin Wolf wrote:
> But how does it determine the desired new perms? Either you duplicate
> the logic of the .bdrv_child_perm implementation into a new set of
> functions that does the same thing, but based on the new state; or you
> extend the existing function with a BlockReopenQueue parameter. The
> latter is basically this series, except with an additional unnecessary
> detour through the driver code instead of doing it in common code.
> 
> Also note that storing it in BDRVReopenState would have to involve a new
> list of an additional data structure because permissions are per
> BdrvChild, not per BlockDriverState.

Indeed, this is not going to remove any complexity. :(

Fam
