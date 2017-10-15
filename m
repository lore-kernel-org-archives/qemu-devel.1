Received: from eggs.gnu.org ([2001:4830:134:3::10]:51023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3Ze3-0000ny-Mx
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3Zdz-0002W1-Kw
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:31:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3Zdz-0002Vp-Ev
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:31:15 -0400
Date: Sun, 15 Oct 2017 06:31:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171015063012-mutt-send-email-mst@kernel.org>
References: <20170915063552.33868-1-aik@ozlabs.ru>
	<2e1b8655-5d47-965c-3d54-1ac1a531afe8@ozlabs.ru>
	<03c58335-8ca2-a812-5259-a5a41b9e0a87@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <03c58335-8ca2-a812-5259-a5a41b9e0a87@ozlabs.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v2] pci: Initialize pci_dev->name
 before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Sun, Oct 15, 2017 at 02:24:17PM +1100, Alexey Kardashevskiy wrote:
> On 03/10/17 13:10, Alexey Kardashevskiy wrote:
> > On 15/09/17 16:35, Alexey Kardashevskiy wrote:
> >> This moves pci_dev->name initialization earlier so
> >> pci_dev->bus_master_as could get a name instead of an empty string.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >=20
> > Ping?
>=20
> Ping?

I can't find v2 in either qemu or my personal mailbox.

>=20
> >=20
> >=20
> >> ---
> >> Changes:
> >> v2:
> >> * fixed mistype in the commit log
> >> * added "rb"
> >> ---
> >>  hw/pci/pci.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index 21e203b056..353195d154 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -1020,6 +1020,7 @@ static PCIDevice *do_pci_register_device(PCIDe=
vice *pci_dev, PCIBus *bus,
> >> =20
> >>      pci_dev->devfn =3D devfn;
> >>      pci_dev->requester_id_cache =3D pci_req_id_cache_get(pci_dev);
> >> +    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
> >> =20
> >>      memory_region_init(&pci_dev->bus_master_container_region, OBJEC=
T(pci_dev),
> >>                         "bus master container", UINT64_MAX);
> >> @@ -1029,7 +1030,6 @@ static PCIDevice *do_pci_register_device(PCIDe=
vice *pci_dev, PCIBus *bus,
> >>      if (qdev_hotplug) {
> >>          pci_init_bus_master(pci_dev);
> >>      }
> >> -    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
> >>      pci_dev->irq_state =3D 0;
> >>      pci_config_alloc(pci_dev);
> >> =20
> >>
> >=20
> >=20
>=20
>=20
> --=20
> Alexey
