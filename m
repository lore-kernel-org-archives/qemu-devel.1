Received: from eggs.gnu.org ([2001:4830:134:3::10]:46095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fL5DB-0003NZ-TV
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fL5DA-0001bD-Uc
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:12:13 -0400
Date: Tue, 22 May 2018 13:12:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180522111205.GD6233@localhost.localdomain>
References: <20180518181717.6700-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518181717.6700-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] sheepdog: Remove unnecessary NULL check in
 sd_prealloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, sheepdog@lists.wpkg.org

Am 18.05.2018 um 20:17 hat Peter Maydell geschrieben:
> In commit 8b9ad56e9cbfd852a, we removed the code that could result
> in our getting to sd_prealloc()'s out_with_err_set label with a
> NULL blk pointer. That makes the NULL check in the error-handling
> path unnecessary, and Coverity gripes about it (CID 1390636).
> Delete the redundant check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

In fact, it was unnecessary even before that, because blk_unref(NULL)
is valid (it does nothing).

Thanks, applied to the block branch.

Kevin
