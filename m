Received: from eggs.gnu.org ([2001:4830:134:3::10]:57486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl6m-0006cZ-NV
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl6j-0008Sv-M6
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:22:56 -0500
References: <1488427170-28050-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0266affa-397d-41ca-f14b-ba08b7b31398@redhat.com>
Date: Mon, 6 Mar 2017 13:22:46 +0800
MIME-Version: 1.0
In-Reply-To: <1488427170-28050-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net/filter-mirror: Follow CODING_STYLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>



On 2017=E5=B9=B403=E6=9C=8802=E6=97=A5 11:59, Zhang Chen wrote:
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/filter-mirror.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index aa0aa98..72fa7c2 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -49,7 +49,7 @@ static int filter_mirror_send(CharBackend *chr_out,
>   {
>       int ret =3D 0;
>       ssize_t size =3D 0;
> -    uint32_t len =3D  0;
> +    uint32_t len =3D 0;
>       char *buf;
>  =20
>       size =3D iov_size(iov, iovcnt);
> @@ -77,8 +77,9 @@ err:
>       return ret < 0 ? ret : -EIO;
>   }
>  =20
> -static void
> -redirector_to_filter(NetFilterState *nf, const uint8_t *buf, int len)
> +static void redirector_to_filter(NetFilterState *nf,
> +                                 const uint8_t *buf,
> +                                 int len)
>   {
>       struct iovec iov =3D {
>           .iov_base =3D (void *)buf,

Applied, thanks.
