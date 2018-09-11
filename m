Received: from eggs.gnu.org ([2001:4830:134:3::10]:36210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzds1-0005yo-Fn
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzds0-0005EQ-Rd
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:18:01 -0400
Date: Tue, 11 Sep 2018 16:17:50 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911081750.GF19292@lemon.usersys.redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
	<20180907161520.26349-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907161520.26349-6-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/14] test-bdrv-drain: Test
 AIO_WAIT_WHILE() in completion callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

On Fri, 09/07 18:15, Kevin Wolf wrote:
> This is a regression test for a deadlock that occurred in block job
> completion callbacks (via job_defer_to_main_loop) because the AioContext
> lock was taken twice: once in job_finish_sync() and then again in
> job_defer_to_main_loop_bh(). This would cause AIO_WAIT_WHILE() to hang.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
