Received: from eggs.gnu.org ([2001:4830:134:3::10]:58301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eroLS-00077S-Ef
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eroLP-0002cf-4U
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:19:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57656 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eroLO-0002bS-W5
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:19:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 457AA4022909
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 17:19:30 +0000 (UTC)
References: <20180302155110.5481-1-pbonzini@redhat.com>
	<20180302155110.5481-2-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bde2777c-3631-e445-e249-5c91677a3225@redhat.com>
Date: Fri, 2 Mar 2018 18:19:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180302155110.5481-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] net: add e1000e model to the "simple"
 -net/-nic options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com

On 02.03.2018 16:51, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e006b6ac71..af3c85a46f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1822,6 +1822,7 @@ static const char * const pci_nic_models[] =3D {
>      "i82559er",
>      "rtl8139",
>      "e1000",
> +    "e1000e",
>      "pcnet",
>      "virtio",
>      "sungem",
> @@ -1835,6 +1836,7 @@ static const char * const pci_nic_names[] =3D {
>      "i82559er",
>      "rtl8139",
>      "e1000",
> +    "e1000e",
>      "pcnet",
>      "virtio-net-pci",
>      "sungem",

I think it would be better and more consisten to finally fix this mess
and automatically allow all devices in the category
DEVICE_CATEGORY_NETWORK that are derived from TYPE_PCI_DEVICE, instead
of manually maintaining this list here...?

 Thomas
