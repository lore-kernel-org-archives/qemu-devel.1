Received: from eggs.gnu.org ([2001:4830:134:3::10]:41369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzJB7-0002lL-OD
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 06:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzIxA-0002cO-D1
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:57:57 -0400
Date: Mon, 10 Sep 2018 11:57:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180910095748.GD4901@dhcp-200-186.str.redhat.com>
References: <20180910092924.23403-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910092924.23403-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Test snapshot=on with
 nonexistent TMPDIR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 10.09.2018 um 11:29 hat Alberto Garcia geschrieben:
> We just fixed a bug that was causing a use-after-free when QEMU was
> unable to create a temporary snapshot. This is a test case for this
> scenario.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Hm, it actually doesn't crash for me even without the fix. Anyway, I
don't have a good idea to make it more likely to crash and it's
certainly better than nothing.

Thanks, applied to the block branch.

Kevin
