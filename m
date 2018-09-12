Received: from eggs.gnu.org ([2001:4830:134:3::10]:38722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fzzoR-00089m-Li
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fzzoO-0006iX-Vq
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:43:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58568 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fzzoO-0006iI-QM
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:43:44 -0400
References: <20180903043900.28592-1-zhangckid@gmail.com>
	<20180903043900.28592-20-zhangckid@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3701c6f3-add9-8ab8-221b-d6fa1da7e2d6@redhat.com>
Date: Wed, 12 Sep 2018 15:43:35 +0800
MIME-Version: 1.0
In-Reply-To: <20180903043900.28592-20-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V12 19/19] docs: Add COLO status diagram to
 COLO-FT.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <chen.zhang@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2018=E5=B9=B409=E6=9C=8803=E6=97=A5 12:39, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>
> This diagram make user better understand COLO.
> Suggested by Markus Armbruster.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   docs/COLO-FT.txt | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
> index d7c7dcda8f..d5007895d1 100644
> --- a/docs/COLO-FT.txt
> +++ b/docs/COLO-FT.txt
> @@ -110,6 +110,40 @@ Note:
>   HeartBeat has not been implemented yet, so you need to trigger failov=
er process
>   by using 'x-colo-lost-heartbeat' command.
>  =20
> +=3D=3D COLO operation status =3D=3D
> +
> ++-----------------+
> +|                 |
> +|    Start COLO   |
> +|                 |
> ++--------+--------+
> +         |
> +         |  Main qmp command:
> +         |  migrate-set-capabilities with x-colo
> +         |  migrate
> +         |
> +         v
> ++--------+--------+
> +|                 |
> +|  COLO running   |
> +|                 |
> ++--------+--------+
> +         |
> +         |  Main qmp command:
> +         |  x-colo-lost-heartbeat
> +         |  or
> +         |  some error happened
> +         v
> ++--------+--------+
> +|                 |  send qmp event:
> +|  COLO failover  |  COLO_EXIT
> +|                 |
> ++-----------------+
> +
> +COLO use the qmp command switching and report operation status.

It looks to me that "to switch" is better.

> +The diagram just write the main qmp command, you can get the detail
> +in test procedure.

s/write/shows/

I will fix this patch directly.

Thanks

> +
>   =3D=3D Test procedure =3D=3D
>   1. Startup qemu
>   Primary:
