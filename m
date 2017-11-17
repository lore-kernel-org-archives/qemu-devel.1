Received: from eggs.gnu.org ([2001:4830:134:3::10]:37204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFWUW-0008Gj-Cd
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 21:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFWUT-0005vW-8v
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 21:34:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eFWUT-0005t8-1Z
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 21:34:49 -0500
References: <20171116022832.24894-1-maozy.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9e7f9131-3f07-4688-2154-d1c7d3c33b29@redhat.com>
Date: Fri, 17 Nov 2017 10:34:42 +0800
MIME-Version: 1.0
In-Reply-To: <20171116022832.24894-1-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] colo-compare: fix the dangerous assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>



On 2017=E5=B9=B411=E6=9C=8816=E6=97=A5 10:28, Mao Zhongyi wrote:
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Fixes: 8ec14402029d783720f4312ed8a925548e1dad61
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index ccdcba2..1ce195f 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -179,7 +179,7 @@ static int packet_enqueue(CompareState *s, int mode=
, Connection **con)
>                            "drop packet");
>           }
>       }
> -    con =3D &conn;
> +    *con =3D conn;
>  =20
>       return 0;
>   }

Applied, thanks.
