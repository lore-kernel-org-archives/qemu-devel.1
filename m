Received: from eggs.gnu.org ([2001:4830:134:3::10]:38516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRum-0001S5-2R
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRul-0001t6-Ay
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:22:44 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:54077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1erRul-0001s7-46
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:22:43 -0500
Received: by mail-wm0-x22f.google.com with SMTP id t74so13656261wme.3
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:22:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-12-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f7e7e3d-01a9-e73e-48e5-9aa8d86b561d@redhat.com>
Date: Thu, 1 Mar 2018 18:22:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180301084438.13594-12-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/15] qio: non-default context for TLS
 handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 01/03/2018 09:44, Peter Xu wrote:
> +/**
> + * qio_channel_tls_handshake_full:
> + * @ioc: the TLS channel object
> + * @func: the callback to invoke when completed
> + * @opaque: opaque data to pass to @func
> + * @destroy: optional callback to free @opaque
> + * @context: the context that TLS handshake will run with
> + *
> + * Similar to qio_channel_tls_handshake(), but allows the task to be
> + * run on a specific context.
> + */
> +void qio_channel_tls_handshake_full(QIOChannelTLS *ioc,
> +                                    QIOTaskFunc func,
> +                                    gpointer opaque,
> +                                    GDestroyNotify destroy,
> +                                    GMainContext *context);
> +

You're not consistent in introducing "_full" functions.  I would
add the argument directly to the qio_channel_tls_handshake() function.

Paolo
