Received: from eggs.gnu.org ([2001:4830:134:3::10]:50908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1diMYI-0005Go-Du
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1diMYD-0001Ab-Gy
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1diMYD-0001AR-AW
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:17:37 -0400
Date: Thu, 17 Aug 2017 17:17:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170817171732.1413fcaf@nial.brq.redhat.com>
In-Reply-To: <20170817043102.6322-7-f4bug@amsat.org>
References: <20170817043102.6322-1-f4bug@amsat.org>
	<20170817043102.6322-7-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 6/8] !fixup mips: now than MIPSCPU is
 QOMified, mark it abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, James Hogan <james.hogan@imgtec.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On Thu, 17 Aug 2017 01:31:00 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/mips/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

looks good, just squash it into previous patch

>=20
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index f99cfbde7e..84b6f8bf68 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -219,7 +219,7 @@ static const TypeInfo mips_cpu_type_info =3D {
>      .parent =3D TYPE_CPU,
>      .instance_size =3D sizeof(MIPSCPU),
>      .instance_init =3D mips_cpu_initfn,
> -    .abstract =3D false,
> +    .abstract =3D true,
>      .class_size =3D sizeof(MIPSCPUClass),
>      .class_init =3D mips_cpu_class_init,
>  };
