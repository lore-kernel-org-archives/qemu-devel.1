Received: from eggs.gnu.org ([2001:4830:134:3::10]:46406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdvpH-00019O-J9
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 04:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdvpG-00052D-2M
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 04:24:39 -0500
Date: Wed, 15 Feb 2017 17:24:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170215092429.GD26331@lemon.lan>
References: <20170213181244.16297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170213181244.16297-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] Make CoMutex/CoQueue/CoRwlock
 thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org

On Mon, 02/13 19:12, Paolo Bonzini wrote:
> This is yet another tiny bit of the multiqueue work, this time affecting
> the synchronization infrastructure for coroutines.  Currently, coroutines
> synchronize between the main I/O thread and the dataplane iothread through
> the AioContext lock.  However, for multiqueue a single BDS will be used
> by multiple iothreads and hence multiple AioContexts.  This calls for
> a different approach to coroutine synchronization, and this series is my
> attempt.

Looks good to me!

Reviewed-by: Fam Zheng <famz@redhat.com>

Fam
