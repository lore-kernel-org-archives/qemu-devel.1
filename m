Received: from eggs.gnu.org ([2001:4830:134:3::10]:59347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cwQEK-0000Dv-J3
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cwQEG-0002n5-T1
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cwQEG-0002kF-MO
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:30:52 -0400
Date: Fri, 7 Apr 2017 10:30:45 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170407093045.GC26896@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491614183-4580-1-git-send-email-wang.guang55@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1491614183-4580-1-git-send-email-wang.guang55@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH] Set QIO_CHANNEL_FEATURE_SHUTDOWN in
 colo_process_incoming_thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang guang <wang.guang55@zte.com.cn>
Cc: mst@redhat.com, qemu-devel@nongnu.org

On Sat, Apr 08, 2017 at 09:16:22AM +0800, Wang guang wrote:
> From: Guang Wang <wang.guang55@zte.com.cn>
> 
> Due to
> 
> Signed-off-by: Wang guang <wang.guang55@zte.com.cn>
> ---
>  migration/socket.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/socket.c b/migration/socket.c
> index 13966f1..193ed22 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -149,6 +149,7 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
>      trace_migration_socket_incoming_accepted();
>  
>      qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
> +    qio_channel_set_feature(QIO_CHANNEL(sioc), QIO_CHANNEL_FEATURE_SHUTDOWN);

Nothing outside the io/ directory should be calling set_feature. The
shutdown feature is set by the channel-socket.c code when required.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
