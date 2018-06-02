Received: from eggs.gnu.org ([2001:4830:134:3::10]:50619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPF0s-0001JX-MM
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 18:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPF0n-00025p-NR
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 18:28:42 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:41263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPF0n-00025e-J8
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 18:28:37 -0400
Received: by mail-qk0-x242.google.com with SMTP id w23-v6so7296713qkb.8
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 15:28:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180602085259.17853-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3748fe8d-a50b-e21e-bd05-35f6eb7f1f53@amsat.org>
Date: Sat, 2 Jun 2018 19:28:32 -0300
MIME-Version: 1.0
In-Reply-To: <20180602085259.17853-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jusual@mail.ru, Peter Maydell <peter.maydell@linaro.org>

On 06/02/2018 05:52 AM, Stefan Hajnoczi wrote:
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

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
