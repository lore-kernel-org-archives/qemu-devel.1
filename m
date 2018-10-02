Received: from eggs.gnu.org ([2001:4830:134:3::10]:39935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7GAG-0000qt-A9
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7GAA-0002Ok-Jx
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:36:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g7GAA-0002OF-7f
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:36:14 -0400
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-16-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c10f8c0e-39ea-e89e-b569-9ea276f5d598@redhat.com>
Date: Tue, 2 Oct 2018 10:36:10 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-16-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 15/15] hw/mips/malta: Remove unuseful
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On 2018-10-02 00:09, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/mips_malta.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 4ccfa87c35..b6633fa141 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1422,23 +1422,10 @@ void mips_malta_init(MachineState *machine)
>      pci_vga_init(pci_bus);
>  }
> =20
> -static int mips_malta_sysbus_device_init(SysBusDevice *sysbusdev)
> -{
> -    return 0;
> -}
> -
> -static void mips_malta_class_init(ObjectClass *klass, void *data)
> -{
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> -
> -    k->init =3D mips_malta_sysbus_device_init;
> -}
> -
>  static const TypeInfo mips_malta_device =3D {
>      .name          =3D TYPE_MIPS_MALTA,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(MaltaState),
> -    .class_init    =3D mips_malta_class_init,
>  };
> =20
>  static void mips_malta_machine_init(MachineClass *mc)

Reviewed-by: Thomas Huth <thuth@redhat.com>
