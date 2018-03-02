Received: from eggs.gnu.org ([2001:4830:134:3::10]:40002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erdtD-0005It-I2
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erdt9-0007Lw-I7
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:09:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52638 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erdt9-0007Le-Ch
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:09:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF8EDEAEA6
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 06:09:40 +0000 (UTC)
Date: Fri, 2 Mar 2018 14:09:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302060923.GE27381@xz-mi>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-12-peterx@redhat.com>
	<9f7e7e3d-01a9-e73e-48e5-9aa8d86b561d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f7e7e3d-01a9-e73e-48e5-9aa8d86b561d@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 06:22:40PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 09:44, Peter Xu wrote:
> > +/**
> > + * qio_channel_tls_handshake_full:
> > + * @ioc: the TLS channel object
> > + * @func: the callback to invoke when completed
> > + * @opaque: opaque data to pass to @func
> > + * @destroy: optional callback to free @opaque
> > + * @context: the context that TLS handshake will run with
> > + *
> > + * Similar to qio_channel_tls_handshake(), but allows the task to be
> > + * run on a specific context.
> > + */
> > +void qio_channel_tls_handshake_full(QIOChannelTLS *ioc,
> > +                                    QIOTaskFunc func,
> > +                                    gpointer opaque,
> > +                                    GDestroyNotify destroy,
> > +                                    GMainContext *context);
> > +
> 
> You're not consistent in introducing "_full" functions.  I would
> add the argument directly to the qio_channel_tls_handshake() function.

Will take your advise.  Thanks,

-- 
Peter Xu
