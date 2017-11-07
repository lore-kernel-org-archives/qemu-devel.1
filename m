Received: from eggs.gnu.org ([2001:4830:134:3::10]:50650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBy39-00048I-TF
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBy34-00073c-Vw
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:11:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eBy34-00072w-RF
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:11:50 -0500
Date: Tue, 7 Nov 2017 15:11:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171107071131.GN16355@lemon>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106094643.14881-11-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 10/27] monitor: create monitor dedicate
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 11/06 17:46, Peter Xu wrote:
> +static GMainContext *monitor_io_context_get(void)
> +{
> +    return iothread_get_g_main_context(mon_global.mon_iothread);
> +}
> +
> +static void monitor_iothread_init(void)
> +{
> +    mon_global.mon_iothread = iothread_create("monitor_iothread",
> +                                              &error_abort);
> +    /*
> +     * GContext in iothread is using lazy init - the first time we
> +     * fetch the context we'll have that initialized.
> +     */
> +    monitor_io_context_get();

Why do you need an eager init here?

Fam
