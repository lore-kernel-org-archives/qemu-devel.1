Received: from eggs.gnu.org ([2001:4830:134:3::10]:43937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fPrYt-0000sL-8V
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fPrYq-0006LZ-MB
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:38:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fPrYq-0006LM-Gg
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:38:20 -0400
References: <20180602085259.17853-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f18ef207-1540-baad-5554-f4a7bb3a34df@redhat.com>
Date: Mon, 4 Jun 2018 17:38:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180602085259.17853-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] main-loop: document IOCanReadHandler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: jusual@mail.ru, Peter Maydell <peter.maydell@linaro.org>

On 02/06/2018 10:52, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/qemu/main-loop.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index 6b4b60bf6d..721aa2416a 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -168,6 +168,20 @@ void qemu_del_wait_object(HANDLE handle, WaitObjectFunc *func, void *opaque);
>  /* async I/O support */
>  
>  typedef void IOReadHandler(void *opaque, const uint8_t *buf, int size);
> +
> +/**
> + * IOCanReadHandler: Return the number of bytes that #IOReadHandler can accept
> + *
> + * This function reports how many bytes #IOReadHandler is prepared to accept.
> + * #IOReadHandler may be invoked with up to this number of bytes.  If this
> + * function returns 0 then #IOReadHandler is not invoked.
> + *
> + * This function is typically called from an event loop.  If the number of
> + * bytes changes outside the event loop (e.g. because a vcpu thread drained the
> + * buffer), then it is necessary to kick the event loop so that this function
> + * is called again.  aio_notify() or qemu_notify_event() can be used to kick
> + * the event loop.
> + */
>  typedef int IOCanReadHandler(void *opaque);
>  
>  /**
> 

Queued, thanks.

Paolo
