Received: from eggs.gnu.org ([2001:4830:134:3::10]:48457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct5YU-0004YA-HP
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct5YR-0000ES-Dt
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:49:58 -0400
References: <1490152052-9660-1-git-send-email-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <49268717-b1a3-5923-e163-d03af06d4a4c@redhat.com>
Date: Wed, 29 Mar 2017 12:49:46 +0800
MIME-Version: 1.0
In-Reply-To: <1490152052-9660-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] e1000: disable debug by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Leonid Bloch <leonid.bloch@ravellosystems.com>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>



On 2017=E5=B9=B403=E6=9C=8822=E6=97=A5 11:07, Jason Wang wrote:
> Disable debug output by default, the information were not needed for
> release.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>
> Cc: Leonid Bloch <leonid.bloch@ravellosystems.com>
> Cc: Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   hw/net/e1000.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 9324949..f2e5072 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -40,7 +40,7 @@
>  =20
>   static const uint8_t bcast[] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff}=
;
>  =20
> -#define E1000_DEBUG
> +/* #define E1000_DEBUG */
>  =20
>   #ifdef E1000_DEBUG
>   enum {

Applied, thanks.
