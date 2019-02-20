Received: from eggs.gnu.org ([209.51.188.92]:36047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwONJ-0001xo-7O
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwONI-0008Re-CQ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:41:09 -0500
Date: Wed, 20 Feb 2019 10:40:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190220104051.72f1aca0.cohuck@redhat.com>
In-Reply-To: <20190220010232.18731-20-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-20-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 19/25] s390/ebcdic: Use size_t to
 iterate over arrays
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

On Wed, 20 Feb 2019 02:02:26 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/s390x/ebcdic.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/s390x/ebcdic.h b/include/hw/s390x/ebcdic.h
> index 69a04cab62..d89174e113 100644
> --- a/include/hw/s390x/ebcdic.h
> +++ b/include/hw/s390x/ebcdic.h
> @@ -83,18 +83,18 @@ static const uint8_t ascii2ebcdic[] =3D {
>      0x90, 0x3F, 0x3F, 0x3F, 0x3F, 0xEA, 0x3F, 0xFF
>  };
> =20
> -static inline void ebcdic_put(uint8_t *p, const char *ascii, int len)
> +static inline void ebcdic_put(uint8_t *p, const char *ascii, size_t len)
>  {
> -    int i;
> +    size_t i;
> =20
>      for (i =3D 0; i < len; i++) {
>          p[i] =3D ascii2ebcdic[(uint8_t)ascii[i]];
>      }
>  }
> =20
> -static inline void ascii_put(uint8_t *p, const char *ebcdic, int len)
> +static inline void ascii_put(uint8_t *p, const char *ebcdic, size_t len)
>  {
> -    int i;
> +    size_t i;
> =20
>      for (i =3D 0; i < len; i++) {
>          p[i] =3D ebcdic2ascii[(uint8_t)ebcdic[i]];

Making the passed len parameter a size_t makes sense; but using a
size_t as an array iterator looks a bit unidiomatic... it's not wrong,
though.

Acked-by: Cornelia Huck <cohuck@redhat.com>
