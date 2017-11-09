Received: from eggs.gnu.org ([2001:4830:134:3::10]:39659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCg4S-0006sT-Go
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCg4P-0005W5-9b
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:12:12 -0500
Date: Thu, 9 Nov 2017 14:12:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171109061200.GC13786@lemon>
References: <20171108165519.8931-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171108165519.8931-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] coroutine: Fix documentation of
 co_aio_sleep_ns()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com

On Wed, 11/08 10:55, Eric Blake wrote:
> co_sleep_ns() was removed in commit 0b9caf9b, leaving behind a
> stale comment.  Update the documentation to match the current
> usage of this function.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: instead of just blindly cribbing from Paolo's email, try to incorporate
> the feedback given on the wording
> ---
>  include/qemu/coroutine.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 9aff9a735e..10ab50a98c 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -262,8 +262,11 @@ void qemu_co_rwlock_unlock(CoRwlock *lock);
>  /**
>   * Yield the coroutine for a given duration
>   *
> - * Behaves similarly to co_sleep_ns(), but the sleeping coroutine will be
> - * resumed when using aio_poll().
> + * This function uses timers and hence needs to know the event loop
> + * (#AioContext) to place the timer on.  After the time elapses, the
> + * current coroutine will restart with the same #AioContext it is
> + * currently running in, even if that is different than the timer
> + * context passed to co_aio_sleep_ns().
>   */
>  void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
>                                    int64_t ns);
> -- 
> 2.13.6
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
