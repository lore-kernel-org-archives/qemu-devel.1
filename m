Received: from eggs.gnu.org ([2001:4830:134:3::10]:49282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVcSN-0000UE-LX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVcSM-00085w-HQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:38:55 -0400
References: <20170707203049.534-1-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74fcb147-eaf3-c6f7-6faa-e07e5ac5e69e@redhat.com>
Date: Thu, 13 Jul 2017 13:38:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170707203049.534-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/9] Implement NBD_OPT_GO,
 block size advertisement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org

On 07/07/2017 22:30, Eric Blake wrote:
> The NBD protocol has now finalized the extension that fixes
> several shortcomings with NBD_OPT_EXPORT_NAME (namely, no error
> reporting, no way for the server to advertise block sizes to the
> client):
> https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md
> 
> This sort of overlaps with the work Vladimir is proposing for
> implementing NBD_CMD_BLOCK_STATUS, but initial versions of these
> patches have been on the list for over a year now (see patches 37-44):
> https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg03526.html
> 
> v4 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04528.html
> Differences since then (if it is even worth comparing) include
> rebasing on top of Vladimir's cleanups and final tweaks to match
> the upstream NBD protocol that was finally promoted from experimental.
> 
> Depends on my NBD staging tree (currently Vladimir's v3 nbd refactoring):
> http://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/nbd
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01805.html
> 
> 001/9:[0047] [FC] 'nbd: Create struct for tracking export info'
> 002/9:[down] 'nbd: Don't bother tracing an NBD_OPT_ABORT response failure'
> 003/9:[0108] [FC] 'nbd: Expose and debug more NBD constants'
> 004/9:[down] 'nbd: Simplify trace of client flags in negotiation'
> 005/9:[down] 'nbd: Refactor reply to NBD_OPT_EXPORT_NAME'
> 006/9:[0146] [FC] 'nbd: Implement NBD_OPT_GO on server'
> 007/9:[0041] [FC] 'nbd: Implement NBD_OPT_GO on client'
> 008/9:[0014] [FC] 'nbd: Implement NBD_INFO_BLOCK_SIZE on server'
> 009/9:[0050] [FC] 'nbd: Implement NBD_INFO_BLOCK_SIZE on client'
> 
> Eric Blake (9):
>   nbd: Create struct for tracking export info
>   nbd: Don't bother tracing an NBD_OPT_ABORT response failure
>   nbd: Expose and debug more NBD constants
>   nbd: Simplify trace of client flags in negotiation
>   nbd: Refactor reply to NBD_OPT_EXPORT_NAME
>   nbd: Implement NBD_OPT_GO on server
>   nbd: Implement NBD_OPT_GO on client
>   nbd: Implement NBD_INFO_BLOCK_SIZE on server
>   nbd: Implement NBD_INFO_BLOCK_SIZE on client
> 
>  block/nbd-client.h  |   3 +-
>  include/block/nbd.h |  56 +++++++---
>  nbd/nbd-internal.h  |  13 +--
>  block/nbd-client.c  |  22 ++--
>  block/nbd.c         |  16 ++-
>  nbd/client.c        | 283 ++++++++++++++++++++++++++++++++++++++++--------
>  nbd/common.c        |  92 ++++++++++++++++
>  nbd/server.c        | 304 ++++++++++++++++++++++++++++++++++++++++++++--------
>  qemu-nbd.c          |  10 +-
>  nbd/trace-events    |  24 +++--
>  10 files changed, 685 insertions(+), 138 deletions(-)
> 

Queued, thanks.

Paolo
