Received: from eggs.gnu.org ([2001:4830:134:3::10]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTVm4-0007pD-8a
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTVlz-0003Xy-7l
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:06:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dTVly-0003Xd-Ua
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:06:27 -0400
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b1660d6-5329-7578-3f00-ac22b7552c91@redhat.com>
Date: Fri, 7 Jul 2017 18:06:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170707152918.23086-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/10] nbd refactoring part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, berrange@redhat.com, den@openvz.org



On 07/07/2017 17:29, Vladimir Sementsov-Ogievskiy wrote:
> This is last part of "nbd errors and traces refactoring".
> 
> Patches 01-10 from "nbd errors and traces refactoring" are already merged.
> Patches 11-13 from it are rejected - do not regret them.
> So, these series is update of 14-19 patches from "nbd errors and traces
> refactoring"

Looks good---Eric, want to send a pull request yourself?

Paolo

> v3:
> 01: reword commit message
>     add Eric's r-b
>     s/legal/value/
> 02: new patch (proposed by Eric)
> 03: rebased on 02
> 04,05: add Eric's r-b
> 06: do not remove extra empty line
>     do not add additional var nbd_magic (reuse existent magic)
>     use ldq_be_p to reduce memory copying
> 07,08: new patches
> 09: new patch, split out 'behavior changing' part of 09, apply most of 
>     comments by Eric and Max, some other changes
> 10: rebased on 08, now more 'mechanical', may be some changes in text 
>     messages of traces are left here.
> 
> 
> v2:
> 01: EPIPE not handled
>     imporve comments
> 02: rebased on absence of old patch 13, errors are not saved into
>     separate ret variable
>     TRACE on fail of sending NBD_REP_ACK reply to NBD_OPT_ABORT
>     instead of error propagating and EPIPE handling
> 03: fix error_prepend
> 04: just remove this TRACE
> 05: just trace nbd magic as 64bit number
> 06: improve commit message
>     simplify trace_nbd_receive_negotiate_server_flags - do not trace
>     separate flags
>     add trace_nbd_opt_abort_reply_failed
>     remove tail periods from traces
> 
> 
> Vladimir Sementsov-Ogievskiy (10):
>   nbd/server: nbd_negotiate: return 1 on NBD_OPT_ABORT
>   nbd/server: refactor nbd_negotiate
>   nbd/server: use errp instead of LOG
>   nbd/server: add errp to nbd_send_reply()
>   nbd/common: nbd_tls_handshake: remove extra TRACE
>   nbd/client: refactor TRACE of NBD_MAGIC
>   nbd/server: fix TRACE in nbd_negotiate_send_rep_len
>   nbd/server: rename clientflags var in nbd_negotiate_options
>   nbd: refactor tracing
>   nbd: use generic trace subsystem instead of TRACE macro
> 
>  Makefile.objs      |   1 +
>  nbd/client.c       |  82 +++++------
>  nbd/common.c       |   4 +-
>  nbd/nbd-internal.h |  19 ---
>  nbd/server.c       | 398 +++++++++++++++++++++++++++++------------------------
>  nbd/trace-events   |  58 ++++++++
>  6 files changed, 312 insertions(+), 250 deletions(-)
>  create mode 100644 nbd/trace-events
> 
