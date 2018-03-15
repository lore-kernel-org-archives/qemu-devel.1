Received: from eggs.gnu.org ([2001:4830:134:3::10]:45404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1ewSpY-0004DQ-9R
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1ewSpX-0000X2-FN
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:22:04 -0400
From: Andreas Schwab <schwab@suse.de>
References: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
	<1516279431-30424-6-git-send-email-pbonzini@redhat.com>
Date: Thu, 15 Mar 2018 14:21:55 +0100
In-Reply-To: <1516279431-30424-6-git-send-email-pbonzini@redhat.com> (Paolo
	Bonzini's message of "Thu, 18 Jan 2018 13:43:49 +0100")
Message-ID: <mvmd105lbik.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/7] block: convert bdrv_invalidate_cache
 callback to coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

block/iscsi.c:2247:6: error: 'BlockDriver {aka struct BlockDriver}' has no member named 'bdrv_invalidate_cache'; did you mean 'bdrv_co_invalidate_cache'?
     .bdrv_invalidate_cache  = iscsi_invalidate_cache,
      ^~~~~~~~~~~~~~~~~~~~~
      bdrv_co_invalidate_cache
block/iscsi.c:2247:31: error: 'iscsi_invalidate_cache' undeclared here (not in a function); did you mean 'iscsi_co_invalidate_cache'?
     .bdrv_invalidate_cache  = iscsi_invalidate_cache,
                               ^~~~~~~~~~~~~~~~~~~~~~
                               iscsi_co_invalidate_cache

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
