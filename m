Received: from eggs.gnu.org ([209.51.188.92]:34917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ggagO-0003yT-7Q
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ggagM-0006DO-7U
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:35:32 -0500
MIME-Version: 1.0
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-2-ehabkost@redhat.com>
In-Reply-To: <20190107193020.21744-2-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 7 Jan 2019 23:35:12 +0400
Message-ID: <CAJ+F1C+wFDYWJczpmuW9c+Up0H5+zJ+J1PZfZJEUXhnNe_n0Yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] spapr: Eliminate
 SPAPR_PCI_2_7_MMIO_WIN_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Mon, Jan 7, 2019 at 11:34 PM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> The macro is only used in one place, where the purpose of the
> value is obvious.  Eliminate the macro so we don't need to rely
> on stringify().
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/hw/pci-host/spapr.h | 1 -
>  hw/ppc/spapr.c              | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 7c66c3872f..a85a995b6c 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -99,7 +99,6 @@ struct sPAPRPHBState {
>  #define SPAPR_PCI_BASE               (1ULL << 45) /* 32 TiB */
>  #define SPAPR_PCI_LIMIT              (1ULL << 46) /* 64 TiB */
>
> -#define SPAPR_PCI_2_7_MMIO_WIN_SIZE  0xf80000000
>  #define SPAPR_PCI_IO_WIN_SIZE        0x10000
>
>  #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5671608cea..bff42f0adb 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4225,7 +4225,7 @@ static void spapr_machine_2_7_class_options(Machine=
Class *mc)
>          {
>              .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
>              .property =3D "mem_win_size",
> -            .value    =3D stringify(SPAPR_PCI_2_7_MMIO_WIN_SIZE),
> +            .value    =3D "0xf80000000",
>          },
>          {
>              .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
> --
> 2.18.0.rc1.1.g3f1ff2140
>
>


--=20
Marc-Andr=C3=A9 Lureau
