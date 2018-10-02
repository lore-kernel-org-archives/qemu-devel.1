Received: from eggs.gnu.org ([2001:4830:134:3::10]:39783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7G9e-0000Tq-8G
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7G9b-0002DZ-3u
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:35:42 -0400
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-15-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ba9e6666-fe49-5bed-2b67-b8672314d5d9@redhat.com>
Date: Tue, 2 Oct 2018 10:35:35 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-15-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 14/15] hw/hppa/dino: Remove unuseful
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>

On 2018-10-02 00:09, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/hppa/dino.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
> index 564b938e3a..31e09942b5 100644
> --- a/hw/hppa/dino.c
> +++ b/hw/hppa/dino.c
> @@ -488,17 +488,10 @@ PCIBus *dino_init(MemoryRegion *addr_space,
>      return b;
>  }
> =20
> -static int dino_pcihost_init(SysBusDevice *dev)
> -{
> -    return 0;
> -}
> -
>  static void dino_pcihost_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    k->init =3D dino_pcihost_init;
>      dc->vmsd =3D &vmstate_dino;
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>
