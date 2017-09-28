Received: from eggs.gnu.org ([2001:4830:134:3::10]:50186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dxUGp-0003KD-3I
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dxUGo-0008JV-CH
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:34:11 -0400
Message-Id: <59CCD0150200007800180507@prv-mh.provo.novell.com>
Date: Thu, 28 Sep 2017 02:33:57 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <20170927195635.16014-1-ehabkost@redhat.com>
	<20170927195635.16014-5-ehabkost@redhat.com>
In-Reply-To: <20170927195635.16014-5-ehabkost@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v2 4/5] pci: Add
 INTERFACE_CONVENTIONAL_PCI_DEVICE to Conventional PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Anthony Perard <anthony.perard@citrix.com>, David Gibson <david@gibson.dropbear.id.au>, Alistair Francis <alistair23@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Alberto Garcia <berto@igalia.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Yongbok Kim <yongbok.kim@imgtec.com>, Stefano Stabellini <sstabellini@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, xen-devel@lists.xenproject.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?Q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <dgibson@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laine Stump <laine@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Hannes Reinecke <hare@suse.com>, Jiri Slaby <jslaby@suse.cz>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

>>> On 27.09.17 at 21:56, <ehabkost@redhat.com> wrote:
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -964,6 +964,10 @@ static const TypeInfo xen_pci_passthrough_info =3D =
{
>      .instance_size =3D sizeof(XenPCIPassthroughState),
>      .instance_finalize =3D xen_pci_passthrough_finalize,
>      .class_init =3D xen_pci_passthrough_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
>  };

Passed through devices can be both PCI and PCIe, so following
the description of the patch I don't think these can be statically
given either property. Granted quite a bit of PCIe specific
functionality may be missing in the Xen code ...

Jan
