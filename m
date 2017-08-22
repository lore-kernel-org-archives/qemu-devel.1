Received: from eggs.gnu.org ([2001:4830:134:3::10]:59984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dk7jH-00076g-9a
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dk7jE-0007EK-6y
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:52:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dk7jD-0007DG-Sk
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:52:16 -0400
References: <1503013010-11500-1-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <fafa3ece-f7f7-99d5-adfb-b56e890cf03b@redhat.com>
Date: Tue, 22 Aug 2017 14:43:39 +0300
MIME-Version: 1.0
In-Reply-To: <1503013010-11500-1-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 0/4] Generic PCIE-PCI Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org, mst@redhat.com
Cc: lersek@redhat.com, seabios@seabios.org

On 18/08/2017 2:36, Aleksandr Bezzubikov wrote:
> This series introduces a new device - Generic PCI Express to PCI bridge=
,
> and also makes all necessary changes to enable hotplug of the bridge it=
self
> and any device into the bridge.
>=20

Hi,

Series
    Tested-by: Marcel Apfelbaum <marcel@redhat.com>
(focused on changes from v6)


Michael, will Alecsandr need to re-send it after freeze?
I am asking because the GSOC project is ending in a week or so.


Thanks,
Marcel

> Changes v6->v7:
> Change IO/MEM/PREF reservation properties type to SIZE.
>=20
> Changes v5->v6:
> 1. Fix indentation in the cap creation function (addresses Marcel's com=
ment)
> 2. Simplify capability pref_mem_* fields assignment (addresses Marcel's=
 comment)
> 3. Documentation fixes:
> 	- fix mutually exclusive fields definition (addresses Laszlo's comment=
)
> 	- fix pcie-pci-bridge usage example (addresses Marcel's comment)
>=20
> Changes v4->v5:
> 1. Change PCIE-PCI Bridge license (addresses Marcel's comment)
> 2. The capability layout changes (adress Laszlo' comments):
>      - separate pref_mem into pref_mem_32 and pref_mem_64 fields (SeaBI=
OS side has the same changes)
>      - accordingly change the Generic Root Port's properties
> 3. Do not add the capability to the root port if no valid values are pr=
ovided (adresses Michael's comment)
> 4. Rename the capability type to 'RESOURCE_RESERVE' (addresses Marcel's=
 comment)
> 5. Remove shpc_present check function (addresses Marcel's comment)
> 6. Fix the 4th patch message (adresses Michael's comment)
> 7. Patch for SHPC enabling in _OSC method has been already merged
>=20
> Changes v3->v4:
> 1. PCIE-PCI Bridge device: "msi_enable"->"msi", "shpc"->"shpc_bar", rem=
ove local_err,
>     make "msi" property OnOffAuto, shpc_present() is still here
>     to avoid SHPC_VMSTATE refactoring (address Marcel's comments).
> 2. Change QEMU PCI capability layout (SeaBIOS side has the same changes=
):
>    - change reservation fields types: bus_res - uint32_t, others - uint=
64_t
>    - rename 'non_pref' and 'pref' fields
>    - interpret -1 value as 'ignore'
> 3. Use parent_realize in Generic PCI Express Root Port properly.
> 4. Fix documentation: fully replace the DMI-PCI bridge references with =
the new PCIE-PCI bridge,
> "PCIE"->"PCI Express", small mistakes and typos - address Laszlo's and =
Marcel's comments.
> 5. Rename QEMU PCI cap creation fucntion - addresses Marcel's comment.
>=20
> Changes v2->v3:
> (0). 'do_not_use' capability field flag is still _not_ in here since we=
 haven't come to consesus on it yet.
> 1. Merge commits 5 (bus_reserve property creation) and 6 (property usag=
e) together - addresses Michael's comment.
> 2. Add 'bus_reserve' property and QEMU PCI capability only to Generic P=
CIE Root Port - addresses Michael's and Marcel's comments.
> 3. Change 'bus_reserve' property's default value to 0 - addresses Micha=
el's comment.
> 4. Rename QEMU bridge-specific PCI capability creation function - addre=
sses Michael's comment.
> 5. Init the whole QEMU PCI capability with zeroes - addresses Michael's=
 and Laszlo's comments.
> 6. Change QEMU PCI capability layout (SeaBIOS side has the same changes=
)
>    - add 'type' field to distinguish multiple
>      RedHat-specific capabilities - addresses Michael's comment
>    - do not mimi=D1=81 PCI Config space register layout, but use mutual=
ly exclusive differently
>      sized fields for IO and prefetchable memory limits - addresses Las=
zlo's comment
> 7. Correct error handling in PCIE-PCI bridge realize function.
> 8. Replace a '2' constant with PCI_CAP_FLAGS in the capability creation=
 function - addresses Michael's comment.
> 9. Remove a comment on _OSC which isn't correct anymore - address Marce=
l's comment.
> 10. Add documentation for the Generic PCIE-PCI Bridge and QEMU PCI capa=
bility - addresses Michael's comment.
>=20
> Changes v1->v2:
> 1. Enable SHPC for the bridge.
> 2. Enable SHPC support for the Q35 machine (ACPI stuff).
> 3. Introduce PCI capability to help firmware on the system init.
>     This allows the bridge to be hotpluggable. Now it's supported
>     only for pcie-root-port. Now it's supposed to used with
>     SeaBIOS only, look at the SeaBIOS corresponding series
>     "Allow RedHat PCI bridges reserve more buses than necessary during =
init".
>=20
> Aleksandr Bezzubikov (4):
>    hw/pci: introduce pcie-pci-bridge device
>    hw/pci: introduce bridge-only vendor-specific capability to provide
>      some hints to firmware
>    hw/pci: add QEMU-specific PCI capability to the Generic PCI Express
>      Root Port
>    docs: update documentation considering PCIE-PCI bridge
>=20
>   docs/pcie.txt                      |  49 +++++-----
>   docs/pcie_pci_bridge.txt           | 114 ++++++++++++++++++++++
>   hw/pci-bridge/Makefile.objs        |   2 +-
>   hw/pci-bridge/gen_pcie_root_port.c |  36 +++++++
>   hw/pci-bridge/pcie_pci_bridge.c    | 192 ++++++++++++++++++++++++++++=
+++++++++
>   hw/pci/pci_bridge.c                |  46 +++++++++
>   include/hw/pci/pci.h               |   1 +
>   include/hw/pci/pci_bridge.h        |  25 +++++
>   include/hw/pci/pcie_port.h         |   1 +
>   9 files changed, 442 insertions(+), 24 deletions(-)
>   create mode 100644 docs/pcie_pci_bridge.txt
>   create mode 100644 hw/pci-bridge/pcie_pci_bridge.c
>=20
