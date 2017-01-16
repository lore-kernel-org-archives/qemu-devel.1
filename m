Received: from eggs.gnu.org ([2001:4830:134:3::10]:58006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cT6nn-0007OP-H0
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:54:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cT6nk-0006Wv-Dl
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:54:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cT6nk-0006Wm-88
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:54:20 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BC1C8553D
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 12:54:20 +0000 (UTC)
Date: Mon, 16 Jan 2017 12:54:14 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170116125414.GG13096@redhat.com>
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
> ---
>  include/io/channel.h | 30 ++++++++++++++++++++++++++++++
>  io/channel-command.c | 13 +++++++++++++
>  io/channel-file.c    | 11 +++++++++++
>  io/channel-socket.c  | 16 +++++++++++-----
>  io/channel-tls.c     | 12 ++++++++++++
>  io/channel-watch.c   |  6 ++++++
>  io/channel.c         | 11 +++++++++++
>  7 files changed, 94 insertions(+), 5 deletions(-)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 32a9470..665edd7 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h

> @@ -80,6 +83,9 @@ struct QIOChannel {
>      Object parent;
>      unsigned int features; /* bitmask of QIOChannelFeatures */
>      char *name;
> +    AioContext *ctx;
> +    QIOChannelRestart *read_coroutine;
> +    QIOChannelRestart *write_coroutine;

This hunk belongs in the next patch since its not used here and you also
change the data types in the next patch.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
