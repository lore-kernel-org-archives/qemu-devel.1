Received: from eggs.gnu.org ([2001:4830:134:3::10]:48232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1co6Y6-0001Ev-BF
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1co6Y5-0003gm-KX
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:52:58 -0400
Date: Wed, 15 Mar 2017 11:52:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170315105248.GF4030@noname.str.redhat.com>
References: <20170314023050.32756-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314023050.32756-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Always call bdrv_child_check_perm
 first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 14.03.2017 um 03:30 hat Fam Zheng geschrieben:
> bdrv_child_set_perm alone is not very usable because the caller must
> call bdrv_child_check_perm first.

Well, you can imagine use cases where you want to check multiple
children first and then set or abort all of them, but apparently we
haven't found such a case yet, so I'm fine with making the functions
private for now.  If we ever need it, making them public again is
trivial.

> This is already encapsulated
> conveniently in bdrv_child_try_set_perm, so remove the other prototypes
> from the header and fix the one wrong caller, block/mirror.c.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
