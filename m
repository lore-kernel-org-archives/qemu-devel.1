Received: from eggs.gnu.org ([2001:4830:134:3::10]:39074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gAbe4-0004d8-St
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gAbdz-0005aI-Uh
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:08:56 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181011131413.22208-1-philmd@redhat.com>
References: <20181011131413.22208-1-philmd@redhat.com>
Date: Thu, 11 Oct 2018 16:08:48 +0200
Message-ID: <w514ldsmv7z.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: Convert IOReadHandler to read an
 unsigned number of bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Prasad J Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:PXA2XX" <qemu-arm@nongnu.org>, "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Thu 11 Oct 2018 03:14:13 PM CEST, Philippe Mathieu-Daud=C3=A9 wrote:
> diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
> index 5e09caf851..ba3f3408a2 100644
> --- a/hw/char/ipoctal232.c
> +++ b/hw/char/ipoctal232.c
> @@ -461,14 +461,14 @@ static void mem_write8(IPackDevice *ip, uint32_t ad=
dr, uint8_t val)
>      }
>  }
>=20=20
> -static int hostdev_can_receive(void *opaque)
> +static size_t hostdev_can_receive(void *opaque)
>  {
>      SCC2698Channel *ch =3D opaque;
>      int available_bytes =3D RX_FIFO_SIZE - ch->rx_pending;
>      return ch->rx_enabled ? available_bytes : 0;
>  }
>=20=20
> -static void hostdev_receive(void *opaque, const uint8_t *buf, int size)
> +static void hostdev_receive(void *opaque, const uint8_t *buf, size_t siz=
e)
>  {
>      SCC2698Channel *ch =3D opaque;
>      IPOctalState *dev =3D ch->ipoctal;

Acked-by: Alberto Garcia <berto@igalia.com>

Berto
