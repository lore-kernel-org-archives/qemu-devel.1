Received: from eggs.gnu.org ([2001:4830:134:3::10]:57404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cT6mV-0006iv-2f
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cT6mR-00065Y-Vh
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:53:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cT6mR-00065K-PR
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:52:59 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA39BC0467F5
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 12:52:59 +0000 (UTC)
Date: Mon, 16 Jan 2017 12:52:53 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170116125253.GF13096@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/16] io: add methods to set I/O handlers
 on AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com

On Fri, Jan 13, 2017 at 02:17:19PM +0100, Paolo Bonzini wrote:
> This is in preparation for making qio_channel_yield work on
> AioContexts other than the main one.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

> diff --git a/io/channel-command.c b/io/channel-command.c
> index ad25313..4000b61 100644
> --- a/io/channel-command.c
> +++ b/io/channel-command.c
> @@ -328,6 +328,18 @@ static int qio_channel_command_close(QIOChannel *ioc,
>  }
>  
>  
> +static void qio_channel_command_set_aio_fd_handler(QIOChannel *ioc,
> +                                                AioContext *ctx,
> +                                                IOHandler *io_read,
> +                                                IOHandler *io_write,
> +                                                void *opaque)

nitpick alignment


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
