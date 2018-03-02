Received: from eggs.gnu.org ([2001:4830:134:3::10]:41107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ernDE-0005fP-47
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ernDB-0001pC-04
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42514 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ernDA-0001p4-Rg
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:08 -0500
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f06bee8b-646d-e9e8-d2e6-78cdddb76ab1@redhat.com>
Date: Fri, 2 Mar 2018 17:06:56 +0100
MIME-Version: 1.0
In-Reply-To: <1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 08/12] hw/pci: introduce
 pci_device_notify_iommu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On 01/03/2018 11:33, Liu, Yi L wrote:
> +    pci_device_notify_iommu(pdev, PCI_NTY_DEV_ADD);
> +
>      pci_setup_sva_ops(pdev, &vfio_pci_sva_ops);
> =20
>      return;
> @@ -3134,6 +3136,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>  {
>      VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> =20
> +    pci_device_notify_iommu(pdev, PCI_NTY_DEV_DEL);

Please make the names longer: PCI_IOMMU_NOTIFY_DEVICE_ADDED and
PCI_IOMMU_NOTIFY_DEVICE_REMOVED.  (This is independent of my other
remark, about doing this in generic PCI code for all devices that
register SVA ops).

Thanks,

Paolo
