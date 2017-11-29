Received: from eggs.gnu.org ([2001:4830:134:3::10]:43948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK2CJ-0006Vs-4H
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK2CI-0000JR-B0
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:14:43 -0500
Date: Wed, 29 Nov 2017 21:14:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171129131437.GD12220@lemon>
References: <20171129102513.9153-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129102513.9153-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] blockjob: reinstate
 busy=false/busy=true in block_job_sleep_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, jcody@redhat.com

On Wed, 11/29 11:25, Paolo Bonzini wrote:
> In order to avoid reentering a scheduled coroutine this series uses
> a QEMUTimer outside co_aio_sleep_ns.  The timer callback just calls
> block_job_enter, and can be easily cancelled with timer_del.
> 
> This fixes the outstanding issues with block jobs, without reverting
> the new checks that Jeff added.

Reviewed-by: Fam Zheng <famz@redhat.com>
