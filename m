Received: from eggs.gnu.org ([2001:4830:134:3::10]:58804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIDWz-0007PU-Bz
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIDWv-0007ri-B4
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:24:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIDWv-0007qZ-2T
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:24:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C048142A78
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 12:24:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-32-marcandre.lureau@redhat.com>
Date: Tue, 06 Jun 2017 14:24:08 +0200
In-Reply-To: <20170531135709.345-32-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:55 +0400")
Message-ID: <87k24ptic7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 31/45] acpi: use get_uint() for
 "pci-hole*" properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Those properties use visit_type_uint*()
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/i386/acpi-build.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 8ae0373541..64a277b974 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -247,19 +247,19 @@ static void acpi_get_pci_holes(Range *hole, Range *=
hole64)
>      g_assert(pci_host);
>=20=20
>      range_set_bounds1(hole,
> -                      object_property_get_int(pci_host,
> -                                              PCI_HOST_PROP_PCI_HOLE_STA=
RT,
> -                                              NULL),
> -                      object_property_get_int(pci_host,
> -                                              PCI_HOST_PROP_PCI_HOLE_END,
> -                                              NULL));
> +                      object_property_get_uint(pci_host,
> +                                               PCI_HOST_PROP_PCI_HOLE_ST=
ART,
> +                                               NULL),
> +                      object_property_get_uint(pci_host,
> +                                               PCI_HOST_PROP_PCI_HOLE_EN=
D,
> +                                               NULL));
>      range_set_bounds1(hole64,
> -                      object_property_get_int(pci_host,
> -                                              PCI_HOST_PROP_PCI_HOLE64_S=
TART,
> -                                              NULL),
> -                      object_property_get_int(pci_host,
> -                                              PCI_HOST_PROP_PCI_HOLE64_E=
ND,
> -                                              NULL));
> +                      object_property_get_uint(pci_host,
> +                                               PCI_HOST_PROP_PCI_HOLE64_=
START,
> +                                               NULL),
> +                      object_property_get_uint(pci_host,
> +                                               PCI_HOST_PROP_PCI_HOLE64_=
END,
> +                                               NULL));
>  }
>=20=20
>  #define ACPI_PORT_SMI_CMD           0x00b2 /* TODO: this is APM_CNT_IOPO=
RT */

Related to the hw/pci-host/ part of PATCH 17.  Reshuffling stuff to ease
review is almost certainly not worth the trouble.

I like how PATCH 22-42 justify each change in the commit message.
