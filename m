Received: from eggs.gnu.org ([2001:4830:134:3::10]:53430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOiVe-00044a-Uq
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOiVb-0008E5-6k
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:46:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41946 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fOiVb-0008Ay-2f
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:46:15 -0400
Date: Fri, 1 Jun 2018 12:46:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601114608.GP3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180529025240.520-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180529025240.520-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] socket: dont't free msgfds if error equals
 EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wangxinxin.wang@huawei.com

On Tue, May 29, 2018 at 10:52:40AM +0800, linzhecheng wrote:
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 159e69c3b1..17519ec589 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -134,8 +134,8 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
>                                          s->write_msgfds,
>                                          s->write_msgfds_num);
>  
> -        /* free the written msgfds, no matter what */
> -        if (s->write_msgfds_num) {
> +        /* free the written msgfds in any cases other than errno==EAGAIN */
> +        if (EAGAIN != errno && s->write_msgfds_num) {
>              g_free(s->write_msgfds);
>              s->write_msgfds = 0;
>              s->write_msgfds_num = 0;

Thanks, queued with an updated commit message

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
