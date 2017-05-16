Received: from eggs.gnu.org ([2001:4830:134:3::10]:49236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAdaK-0007uV-JP
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAdaG-0005dr-4V
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:36:24 -0400
Date: Tue, 16 May 2017 10:35:59 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170516143559.GJ19824@localhost.localdomain>
References: <20170515100059.15795-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170515100059.15795-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] curl: locking cleanups/fixes,
 coroutine conversion, remove aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, qemu-block@nongnu.org

On Mon, May 15, 2017 at 12:00:52PM +0200, Paolo Bonzini wrote:
> Compared to v2, this silences checkpatch and correctly destroy the mutex on
> exiting from curl_open with an error.
> 
> Paolo
> 
> Paolo Bonzini (7):
>   curl: strengthen assertion in curl_clean_state
>   curl: never invoke callbacks with s->mutex held
>   curl: avoid recursive locking of BDRVCURLState mutex
>   curl: split curl_find_state/curl_init_state
>   curl: convert CURLAIOCB to byte values
>   curl: convert readv to coroutines
>   curl: do not do aio_poll when waiting for a free CURLState
> 
>  block/curl.c | 217 +++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 121 insertions(+), 96 deletions(-)
> 
> -- 
> 2.12.2
> 

Thanks,

I fixed up the coding styling issues in patch 1 and 4.

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
