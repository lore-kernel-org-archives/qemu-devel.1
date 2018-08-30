Received: from eggs.gnu.org ([2001:4830:134:3::10]:56173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fvRzJ-0000CM-03
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fvRzD-0008MJ-QT
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fvRzD-0008M5-KE
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:48:07 -0400
Date: Thu, 30 Aug 2018 15:47:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180830184758.GM8359@habkost.net>
References: <20180830105757.10577-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180830105757.10577-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386: clarify that the Q35 machine type
 implements a P35 chipset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Aug 30, 2018 at 11:57:57AM +0100, Daniel P. Berrang=E9 wrote:
[...]
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 63acc722a9..eeb33018ad 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -255,7 +255,7 @@
>  #define PCI_DEVICE_ID_INTEL_82801I_EHCI2 0x293c
>  #define PCI_DEVICE_ID_INTEL_82599_SFP_VF 0x10ed
> =20
> -#define PCI_DEVICE_ID_INTEL_Q35_MCH      0x29c0
> +#define PCI_DEVICE_ID_INTEL_P35_MCH      0x29c0

I took a while to notice that this patch isn't actually changing
the PCI ID, but just renaming the constant.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> =20
>  #define PCI_VENDOR_ID_XEN                0x5853
>  #define PCI_DEVICE_ID_XEN_PLATFORM       0x0001
> --=20
> 2.17.1
>=20

--=20
Eduardo
