Received: from eggs.gnu.org ([2001:4830:134:3::10]:42019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb0Er-0008Pt-0b
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb0Eq-0000iv-3o
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:07:44 -0400
Date: Thu, 5 Jul 2018 11:07:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705090736.GC3309@localhost.localdomain>
References: <1530716376-2235-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530716376-2235-1-git-send-email-ari@tuxera.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] blklogwrites improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 04.07.2018 um 16:59 hat Ari Sundholm geschrieben:
> This patch set contains a trivial printf format fix, followed by two
> new features for the blklogwrites driver.
> 
> The first feature is an option to append to an existing log, adopting
> its sector size and other metadata in its superblock. This can be
> useful, and was suggested by Kevin Wolf.
> 
> The second feature is an option for specifying how often the log
> superblock is updated, in terms of number of total write entries
> logged. This ensures that the log superblock is relatively up-to-date
> even in the face of abnormal QEMU shutdown.
> 
> v2:
>   - Fix error path of log superblock update interval set to 0

Thanks, applied to the block branch.

Kevin
