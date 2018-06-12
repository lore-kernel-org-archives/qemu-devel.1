Received: from eggs.gnu.org ([2001:4830:134:3::10]:44919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fSYmB-0003o5-6T
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fSYm7-00078c-79
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:11:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fSYm7-00078K-2K
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:11:11 -0400
References: <20180611073151.16956-1-linzhecheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8a44ec3c-516d-0ebc-ab15-97967b02d68a@redhat.com>
Date: Tue, 12 Jun 2018 10:11:02 +0800
MIME-Version: 1.0
In-Reply-To: <20180611073151.16956-1-linzhecheng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user: delete net client if necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, qemu-devel@nongnu.org
Cc: wangxinxin.wang@huawei.com, liujunjie23@huawei.com, mst@redhat.com



On 2018=E5=B9=B406=E6=9C=8811=E6=97=A5 15:31, linzhecheng wrote:
> As qemu_new_net_client create new ncs but error happens later,
> ncs will be left in global net_clients list, so we need to cleanup them=
.
>
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
>
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 608b837175..1c7ee48b60 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -345,6 +345,7 @@ err:
>               s->vhost_user =3D NULL;
>           }
>       }
> +    qemu_del_net_client(nc0);
>  =20
>       return -1;
>   }

Can nc0 be NULL here?

And please try to use "Fixes:" tag to ease stable maintenance.

Thanks
