Received: from eggs.gnu.org ([2001:4830:134:3::10]:43986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fwfTy-0005ux-48
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 23:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fwfTr-0004ft-Sp
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 23:24:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fwfTr-0004eN-E3
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 23:24:47 -0400
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-4-sameeh@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <76fd34e6-3055-1832-0b6c-4728d583a284@redhat.com>
Date: Mon, 3 Sep 2018 11:24:39 +0800
MIME-Version: 1.0
In-Reply-To: <20180830142708.14311-4-sameeh@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 3/6] vhost-net: Expose vhost_net_get_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>



On 2018=E5=B9=B408=E6=9C=8830=E6=97=A5 22:27, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
>
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>

Better explain the motivation in the commit log.

Thanks

> ---
>   hw/net/vhost_net.c             | 2 +-
>   include/hw/virtio/virtio-net.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e037db63a3..c0bff725c9 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -129,7 +129,7 @@ uint64_t vhost_net_get_acked_features(VHostNetState=
 *net)
>       return net->dev.acked_features;
>   }
>  =20
> -static int vhost_net_get_fd(NetClientState *backend)
> +int vhost_net_get_fd(NetClientState *backend)
>   {
>       switch (backend->info->type) {
>       case NET_CLIENT_DRIVER_TAP:
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> index 02484dc94c..a7b53edc96 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -107,4 +107,6 @@ typedef struct VirtIONet {
>   void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
>                                      const char *type);
>  =20
> +int vhost_net_get_fd(NetClientState *backend);
> +
>   #endif
