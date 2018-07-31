Received: from eggs.gnu.org ([2001:4830:134:3::10]:50247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkVp3-0003PN-CD
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkVoy-0004Rp-Jk
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:40:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fkVoy-0004Re-Ed
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:40:20 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1533031278-5615-1-git-send-email-wei.w.wang@intel.com> (Wei
	Wang's message of "Tue, 31 Jul 2018 18:01:18 +0800")
References: <1533031278-5615-1-git-send-email-wei.w.wang@intel.com>
Reply-To: quintela@redhat.com
Date: Tue, 31 Jul 2018 16:44:12 +0200
Message-ID: <87sh3zqxc3.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] bitmap: fix BITMAP_LAST_WORD_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, mst@redhat.com

Wei Wang <wei.w.wang@intel.com> wrote:
> When "nbits = 0", which means no bits to mask, this macro is expected to
> return 0, instead of 0xffffffff. This patch changes the macro to return
> 0 when there is no bit needs to be masked.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
