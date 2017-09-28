Received: from eggs.gnu.org ([2001:4830:134:3::10]:47022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dxW89-0001od-VY
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dxW85-0005PD-AO
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:33:22 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:44571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1dxW84-0005Ol-V5
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:33:17 -0400
Received: by mail-wm0-x242.google.com with SMTP id m127so1314906wmm.1
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 03:33:15 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.6\))
From: Dmitry Fleytman <dmitry@daynix.com>
In-Reply-To: <1506592361-26168-1-git-send-email-thuth@redhat.com>
Date: Thu, 28 Sep 2017 13:33:11 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <45088ED8-D6BD-4F66-AEF9-303AC9BBFFD0@daynix.com>
References: <1506592361-26168-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] default-configs: Enable CONFIG_VMXNET3_PCI
 only on x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org


> On 28 Sep 2017, at 12:52 PM, Thomas Huth <thuth@redhat.com> wrote:
>=20
> The device can not be instantiated on many non-x86 and just prints
> some error messages, e.g.:
>=20
> $ qemu-system-ppc64 -device vmxnet3 -M g3beige
> [vmxnet3][WR][vmxnet3_init_msix]: Failed to initialize MSI-X, error =
-95
> [vmxnet3][WR][vmxnet3_pci_realize]: Failed to initialize MSI-X, =
configuration is inconsistent.
>=20
> Since vmxnet3 is a para-virtualized device that is only useful on x86,
> it should also only be enabled on the x86 targets.
>=20

Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> default-configs/i386-softmmu.mak   | 1 +
> default-configs/pci.mak            | 1 -
> default-configs/x86_64-softmmu.mak | 1 +
> 3 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/i386-softmmu.mak =
b/default-configs/i386-softmmu.mak
> index d2ab2f6..a685c43 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -7,6 +7,7 @@ CONFIG_QXL=3D$(CONFIG_SPICE)
> CONFIG_VGA_ISA=3Dy
> CONFIG_VGA_CIRRUS=3Dy
> CONFIG_VMWARE_VGA=3Dy
> +CONFIG_VMXNET3_PCI=3Dy
> CONFIG_VIRTIO_VGA=3Dy
> CONFIG_VMMOUSE=3Dy
> CONFIG_IPMI=3Dy
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index 187e438..e514bde 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -22,7 +22,6 @@ CONFIG_MPTSAS_SCSI_PCI=3Dy
> CONFIG_RTL8139_PCI=3Dy
> CONFIG_E1000_PCI=3Dy
> CONFIG_E1000E_PCI=3Dy
> -CONFIG_VMXNET3_PCI=3Dy
> CONFIG_IDE_CORE=3Dy
> CONFIG_IDE_QDEV=3Dy
> CONFIG_IDE_PCI=3Dy
> diff --git a/default-configs/x86_64-softmmu.mak =
b/default-configs/x86_64-softmmu.mak
> index 9bde2f1..ea69e82 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -7,6 +7,7 @@ CONFIG_QXL=3D$(CONFIG_SPICE)
> CONFIG_VGA_ISA=3Dy
> CONFIG_VGA_CIRRUS=3Dy
> CONFIG_VMWARE_VGA=3Dy
> +CONFIG_VMXNET3_PCI=3Dy
> CONFIG_VIRTIO_VGA=3Dy
> CONFIG_VMMOUSE=3Dy
> CONFIG_IPMI=3Dy
> --=20
> 1.8.3.1
>=20
