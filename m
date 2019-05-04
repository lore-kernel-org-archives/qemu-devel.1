Received: from eggs.gnu.org ([209.51.188.92]:49448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMvM8-0001tt-6L
	for qemu-devel@nongnu.org; Sat, 04 May 2019 10:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMvM7-00078b-C0
	for qemu-devel@nongnu.org; Sat, 04 May 2019 10:09:36 -0400
References: <20190504123538.14952-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ffe3d73d-b9a2-a0e3-6dee-222a3d87cc28@redhat.com>
Date: Sat, 4 May 2019 16:09:27 +0200
MIME-Version: 1.0
In-Reply-To: <20190504123538.14952-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/net/ne2000: Extract the PCI device from
 the chipset common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 04/05/2019 14.35, Philippe Mathieu-Daud=C3=A9 wrote:
> The ne2000.c file contains functions common the the ISA and PCI
> devices. To allow to build with one or another, extract the PCI
> specific part into a new file.
>=20
> This fix an issue where the NE2000_ISA Kconfig had to pull the
> full PCI core objects.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/net/Kconfig       |   7 ++-
>  hw/net/Makefile.objs |   3 +-
>  hw/net/ne2000-pci.c  | 132 +++++++++++++++++++++++++++++++++++++++++++
>  hw/net/ne2000.c      | 105 ----------------------------------
>  4 files changed, 139 insertions(+), 108 deletions(-)
>  create mode 100644 hw/net/ne2000-pci.c
>=20
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 7d7bbc5d7c9..4ef86dc3a53 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -1,10 +1,14 @@
>  config DP8393X
>      bool
> =20
> +config NE2000_COMMON
> +    bool

I'd maybe rather simply name it "NE2000" instead of "NE2000_COMMON", but
that's just a matter of taste.

Reviewed-by: Thomas Huth <thuth@redhat.com>
