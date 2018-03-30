Received: from eggs.gnu.org ([2001:4830:134:3::10]:46649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1nqC-0005gz-Dt
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 02:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1nqB-0006FQ-Ne
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 02:48:48 -0400
Date: Fri, 30 Mar 2018 14:48:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180330064840.GC14869@lemon.usersys.redhat.com>
References: <20180322172053.7343-1-dionbosschieter@gmail.com>
	<20180322173925.GA4079@localhost.localdomain>
	<C80D8201-0296-4232-8987-185EF5B8BC8B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C80D8201-0296-4232-8987-185EF5B8BC8B@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block/file-posix.c: fix not reopened
 lock file descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dion Bosschieter <dionbosschieter@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org

On Thu, 03/22 19:08, Dion Bosschieter wrote:
> Yeah I have a use case, before a last sync on a storage migration we suspend a
> VM -> send the last diffs -> mount the new storage server and after that we
> change a symlink -> call reopen -> check if all file descriptors are changed
> before resuming the VM.

What is the point of changing the symlink and checking if FDs are changed?

Fam
