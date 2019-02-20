Received: from eggs.gnu.org ([209.51.188.92]:50982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwPVT-0003h5-9i
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwPVS-0008Qn-Fx
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:53:39 -0500
Date: Wed, 20 Feb 2019 11:53:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190220115316.3e471bff.cohuck@redhat.com>
In-Reply-To: <20190220010232.18731-21-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-21-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 20/25] s390x/sclp: Use a const variable
 to improve readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S.
	Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On Wed, 20 Feb 2019 02:02:27 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> We will reuse this variable in the next patch.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/char/sclpconsole-lm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> index dbc91a1e5b..49543e2c83 100644
> --- a/hw/char/sclpconsole-lm.c
> +++ b/hw/char/sclpconsole-lm.c
> @@ -210,13 +210,14 @@ static int process_mdb(SCLPEvent *event, MDBO *mdbo)
>      int rc;
>      int len;
>      uint8_t buffer[SIZE_BUFFER];
> -
> -    len =3D be16_to_cpu(mdbo->length);
> -    len -=3D sizeof(mdbo->length) + sizeof(mdbo->type)
> +    const size_t hlen =3D sizeof(mdbo->length)
> +            + sizeof(mdbo->type)
>              + sizeof(mdbo->mto.line_type_flags)
>              + sizeof(mdbo->mto.alarm_control)
>              + sizeof(mdbo->mto._reserved);
> =20
> +    len =3D be16_to_cpu(mdbo->length);
> +    len -=3D hlen;
>      assert(len <=3D SIZE_BUFFER);
> =20
>      /* convert EBCDIC SCLP contents to ASCII console message */

I'd probably merge this with the next patch, though.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
