Received: from eggs.gnu.org ([2001:4830:134:3::10]:60711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e4sL9-0005xR-TZ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 13:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e4sL6-000212-0Q
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 13:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e4sL5-00020M-Qp
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 13:41:07 -0400
Date: Wed, 18 Oct 2017 20:41:00 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171018204045-mutt-send-email-mst@kernel.org>
References: <20171015042452.31714-1-aik@ozlabs.ru>
	<20171015080123.GB22780@pxdev.xzpeter.org>
	<34e55f83-211c-2c08-2b56-1a1f936e5992@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <34e55f83-211c-2c08-2b56-1a1f936e5992@ozlabs.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v2 REPOST] pci: Initialize
 pci_dev->name before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org

On Tue, Oct 17, 2017 at 04:00:05PM +1100, Alexey Kardashevskiy wrote:
> On 15/10/17 19:01, Peter Xu wrote:
> > On Sun, Oct 15, 2017 at 03:24:52PM +1100, Alexey Kardashevskiy wrote:
> >> This moves pci_dev->name initialization earlier so
> >> pci_dev->bus_master_as could get a name instead of an empty string.
> >=20
> > Or use "name" instead of "pci_dev->name" when do address_space_init()=
?
> > But I think this one works too.
> >=20
> >>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >=20
> > Maybe "Philippe Mathieu-Daud=E9"?
>=20
>=20
> Definitely. Repost?


Yes pls.

>=20
> >=20
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >=20
> >> ---
> >>
> >> Changes:
> >> v2:
> >> * fixed mistype in the commit log
> >> * added "rb"
> >> ---
> >>  hw/pci/pci.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index 1e6fb88eba..05c5f75ef0 100644
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
> >> --=20
> >> 2.11.0
> >>
> >>
> >=20
>=20
>=20
> --=20
> Alexey
