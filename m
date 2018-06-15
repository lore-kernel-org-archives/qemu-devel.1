Received: from eggs.gnu.org ([2001:4830:134:3::10]:55606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTeaf-0000IX-JN
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTeac-0000zW-FS
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:35:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36146 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fTeac-0000yq-Aj
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:35:50 -0400
References: <20180612022445.5192-1-linzhecheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <28e11eba-366e-37a4-710f-5afb37fb0c96@redhat.com>
Date: Fri, 15 Jun 2018 10:35:37 +0800
MIME-Version: 1.0
In-Reply-To: <20180612022445.5192-1-linzhecheng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: delete net client if
 necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, wangxinxin.wang@huawei.com, liujunjie23@huawei.com



On 2018=E5=B9=B406=E6=9C=8812=E6=97=A5 10:24, linzhecheng wrote:
> As qemu_new_net_client create new ncs but error happens later,
> ncs will be left in global net_clients list and we can't use them any
> more, so we need to cleanup them.
>
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
>
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 608b837175..a39f9c9974 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -345,6 +345,9 @@ err:
>               s->vhost_user =3D NULL;
>           }
>       }
> +    if (nc0) {
> +        qemu_del_net_client(nc0);
> +    }
>  =20
>       return -1;
>   }

Applied and queued for -stable.

Please cc stable next time.

Btw, do we have similar issues for tap?

Thanks
