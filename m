Received: from eggs.gnu.org ([2001:4830:134:3::10]:46460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn448-0000Ih-FD
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn442-000331-Rf
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:34:00 -0400
Date: Wed, 30 Aug 2017 15:33:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830143350.GU24565@stefanha-x1.localdomain>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 07/10] io: add
 qio_channel_read/write_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, famz@redhat.com, qemu-block@nongnu.org

On Tue, Aug 22, 2017 at 03:18:29PM +0200, Paolo Bonzini wrote:
> @@ -315,6 +315,23 @@ ssize_t qio_channel_read(QIOChannel *ioc,
>                           Error **errp);
>  
>  /**
> + * qio_channel_read_all:
> + * @ioc: the channel object
> + * @buf: the memory region to read data into
> + * @buflen: the number of bytes to @buf
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Reads @buflen bytes into @buf, possibly blocking or (if the
> + * channel is non-blocking) yielding from the current coroutine
> + * multiple times until the entire content is read.  Otherwise
> + * behaves as qio_channel_read().
> + */
> +ssize_t coroutine_fn qio_channel_read_all(QIOChannel *ioc,

This function is not coroutine_fn.  It only assumes coroutine context
when called on a non-blocking socket.

> +                                          char *buf,
> +                                          size_t buflen,
> +                                          Error **errp);
> +
> +/**
>   * qio_channel_write:
>   * @ioc: the channel object
>   * @buf: the memory regions to send data from
> @@ -331,6 +348,23 @@ ssize_t qio_channel_write(QIOChannel *ioc,
>                            Error **errp);
>  
>  /**
> + * qio_channel_write_all:
> + * @ioc: the channel object
> + * @buf: the memory region to write data into
> + * @buflen: the number of bytes to @buf
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Writes @buflen bytes from @buf, possibly blocking or (if the
> + * channel is non-blocking) yielding from the current coroutine
> + * multiple times until the entire content is written.  Otherwise
> + * behaves as qio_channel_write().
> + */
> +ssize_t coroutine_fn qio_channel_write_all(QIOChannel *ioc,

This function is not coroutine_fn.  It only assumes coroutine context
when called on a non-blocking socket.
