Received: from eggs.gnu.org ([2001:4830:134:3::10]:38551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZZjo-0001kg-Hd
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZZjn-0008Qa-SS
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:33:16 -0400
Date: Mon, 24 Jul 2017 11:33:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170724093309.GE4630@noname.str.redhat.com>
References: <1500649820-30450-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500649820-30450-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Avoid unnecessary sleeps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

Am 21.07.2017 um 17:10 hat Kevin Wolf geschrieben:
> Test cases 030, 041 and 055 used to sleep for a second after calling
> block-job-pause to make sure that the block job had time to actually
> get into paused state. We can instead poll its status and use that one
> second only as a timeout.
> 
> The tests also slept a second for checking that the block jobs don't
> make progress while being paused. Half a second is more than enough for
> this.
> 
> These changes reduce the total time for the three tests by 25 seconds on
> my laptop (from 155 seconds to 130).
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Applied to the block branch.

Kevin
