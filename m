Received: from eggs.gnu.org ([2001:4830:134:3::10]:48040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e01g0-0006v0-Dq
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e01fw-0000UX-Gn
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:38:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60565)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e01fw-0000Tm-BR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:38:36 -0400
Date: Thu, 5 Oct 2017 10:38:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171005103812.3c0d3cfa@nial.brq.redhat.com>
In-Reply-To: <01e129b3-cd06-0a6b-59a1-7a01b95de879@amsat.org>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<ce8c6fc807907f6e7cce7bfefd8326de64635af6.1507059418.git.alistair.francis@xilinx.com>
	<20171004130258.0a977151@nial.brq.redhat.com>
	<CAKmqyKPMJn92F1c+K8Wy_Ka6us0p1ver_0YQUcRdyr-TRoW_ew@mail.gmail.com>
	<01e129b3-cd06-0a6b-59a1-7a01b95de879@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/5] netduino2: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org
	Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Wed, 4 Oct 2017 19:21:09 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> >>> +const char *netduino_valid_cpus[] =3D { ARM_CPU_TYPE_NAME("cortex-m3=
"), =20
> >> style nit,                               ^^^ put entries on new line w=
ith typical 4 space alignment =20
> >=20
> > Do you mean like this?
> >=20
> > const char *netduino_valid_cpus[] =3D {
> >                                     ARM_CPU_TYPE_NAME("cortex-m3"),
> >                                     ARM_CPU_TYPE_NAME("cortex-m4"),
> >                                     NULL }; =20
>=20
> I suppose he meant:
>=20
> static const char *netduino_valid_cpus[] =3D {
>     ARM_CPU_TYPE_NAME("cortex-m3"),
>     ARM_CPU_TYPE_NAME("cortex-m4"),
>     NULL
> };

Thanks,
that's exactly what I've meant.
