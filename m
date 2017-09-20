Received: from eggs.gnu.org ([2001:4830:134:3::10]:51844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dufYm-0006yq-1D
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dufYk-0007np-TU
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:01:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dufYk-0007nT-O8
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:01:02 -0400
References: <1503013010-11500-1-git-send-email-zuban32s@gmail.com>
	<1503013010-11500-2-git-send-email-zuban32s@gmail.com>
	<20170919203449.GG21016@localhost.localdomain>
	<436365c9-43fc-95be-9bb2-7974f12e84df@redhat.com>
	<CAKSfGUAS8EfYF179pjQ=svmAL2x-VR_iMTh=cZZjQmz77mO8fQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <9c2e8b73-5dc0-ae78-05ff-3b9e307fe895@redhat.com>
Date: Wed, 20 Sep 2017 17:00:58 +0300
MIME-Version: 1.0
In-Reply-To: <CAKSfGUAS8EfYF179pjQ=svmAL2x-VR_iMTh=cZZjQmz77mO8fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 1/4] hw/pci: introduce pcie-pci-bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: lersek@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, seabios@seabios.org

On 20/09/2017 12:52, Aleksandr Bezzubikov wrote:
>=20
> =D1=81=D1=80, 20 =D1=81=D0=B5=D0=BD=D1=82. 2017 =D0=B3. =D0=B2 10:13, M=
arcel Apfelbaum <marcel@redhat.com=20
> <mailto:marcel@redhat.com>>:
>=20
>     On 19/09/2017 23:34, Eduardo Habkost wrote:
>      > On Fri, Aug 18, 2017 at 02:36:47AM +0300, Aleksandr Bezzubikov w=
rote:
>      >> Introduce a new PCIExpress-to-PCI Bridge device,
>      >> which is a hot-pluggable PCI Express device and
>      >> supports devices hot-plug with SHPC.
>      >>
>      >> This device is intended to replace the DMI-to-PCI Bridge.
>      >>
>      >> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com
>     <mailto:zuban32s@gmail.com>>
>      >> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com
>     <mailto:marcel@redhat.com>>
>      >
>      > It's possible to crash QEMU by instantiating this device, with;
>      >
>      >=C2=A0 =C2=A0 $ qemu-system-ppc64 -machine prep -device pcie-pci-=
bridge
>      >=C2=A0 =C2=A0 qemu-system-ppc64: qemu/memory.c:1533: memory_regio=
n_finalize:
>     Assertion `!mr->container' failed.
>      >=C2=A0 =C2=A0 Aborted
>=20
>     Hi Edurado,
>=20
>      >
>      > I didn't investigate the root cause.
>      >
>=20
>     Thanks for reporting it!
>     Aleksandr, can you have a look? Maybe we should not compile
>     the device for ppc arch. (x86 and arm is enough)
>=20
>=20
> I will see what can we do. Is x86 and arm really enough?
>=20

Well, I am being selfish, and it works for me lately :).

Seriously speaking, the new generic PCI Express
Port was restricted to x86 and arm for reasons I don't remember.
Since your work has the same scope, the restriction makes sense.

Please grep for CONFIG_PCIE_PORT to convince yourself
and to help coding it.

Thanks,
Marcel

>=20
>=20
>     Appreciated,
>     Marcel
>=20
> --=20
> Aleksandr Bezzubikov
