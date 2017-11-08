Received: from eggs.gnu.org ([2001:4830:134:3::10]:33535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCQa9-0000Lx-Qq
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCQa5-0003TH-LI
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:39:53 -0500
MIME-Version: 1.0
In-Reply-To: <20171107223708.17935-1-eblake@redhat.com>
References: <20171107223708.17935-1-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 Nov 2017 14:39:40 +0100
Message-ID: <CAJ+F1CLthEcYFgTn4N-=LP=piFy7ubZjr8xyJWQQBG=gHHZ53Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] coroutine: Fix documentation of
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
Cc: QEMU <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hi

On Tue, Nov 7, 2017 at 11:37 PM, Eric Blake <eblake@redhat.com> wrote:
> co_sleep_ns() was removed in commit 0b9caf9b, leaving behind a
> stale comment.  Update the documentation to match the current
> usage of this function.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/qemu/coroutine.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 9aff9a735e..01ae415767 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -262,8 +262,11 @@ void qemu_co_rwlock_unlock(CoRwlock *lock);
>  /**
>   * Yield the coroutine for a given duration
>   *
> - * Behaves similarly to co_sleep_ns(), but the sleeping coroutine will b=
e
> - * resumed when using aio_poll().
> + * This function uses timers and hence needs to know the event loop
> + * (#AioContext) to place the timer on.  In any case, co_aio_sleep_ns()
> + * does not affect the #AioContext where the current coroutine is runnin=
g,
> + * as the coroutine will restart on the same #AioContext that it is
> + * running on.
>   */

comment seems correct to me,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>  void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
>                                    int64_t ns);
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
