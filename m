Received: from eggs.gnu.org ([2001:4830:134:3::10]:57172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cuzmw-0005o1-EG
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cuzmt-0005Gv-OV
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:04:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cuzmt-0005Gm-Iq
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:04:43 -0400
Date: Mon, 3 Apr 2017 12:04:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170403110435.GM2768@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1490317489-3544-1-git-send-email-wang.guang55@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490317489-3544-1-git-send-email-wang.guang55@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH v2] migration: Fix colo hang in
 socket_accept_incoming_migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guang Wang <wang.guang55@zte.com.cn>
Cc: zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, eblake@redhat.com, qemu-devel@nongnu.org

On Fri, Mar 24, 2017 at 09:04:49AM +0800, Guang Wang wrote:
> From: Wang guang <wang.guang55@zte.com.cn>
> 
> The channel socket was initialized manually, 
> but forgot to set QIO_CHANNEL_FEATURE_SHUTDOWN.
> Thus, the colo_process_incoming_thread would hang at recvmsg.
> This patch just call qio_channel_socket_new to get channel,
> Which set QIO_CHANNEL_FEATURE_SHUTDOWN already.
> 
> Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  io/channel-socket.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Looks good to me - I'll try to get this into 2.9


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
