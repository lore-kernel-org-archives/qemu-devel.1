Received: from eggs.gnu.org ([2001:4830:134:3::10]:58143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1enne0-000705-Co
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1enndw-0001wh-EK
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:46:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1enndw-0001w6-8m
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:46:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58C308182D2F
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 15:46:15 +0000 (UTC)
Date: Mon, 19 Feb 2018 15:46:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180219154612.GX11516@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180219154333.20810-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180219154333.20810-1-kchamart@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: pcie: Spell out machine type needs
 for PCIe features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com

On Mon, Feb 19, 2018 at 04:43:33PM +0100, Kashyap Chamarthy wrote:
> PCIe features are available only via the Q35 machine for x86, or the
> 'virt' machine type for AArch64 architecture.
>=20
> Mention that explicitly.
>=20
> Thanks: Daniel Berrang=C3=A9
>=20
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  docs/pcie.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/pcie.txt b/docs/pcie.txt
> index 8d3694970e..3e5bf52e0b 100644
> --- a/docs/pcie.txt
> +++ b/docs/pcie.txt
> @@ -3,8 +3,14 @@ PCI EXPRESS GUIDELINES
> =20
>  1. Introduction
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -The doc proposes best practices on how to use PCI Express/PCI device
> -in PCI Express based machines and explains the reasoning behind them.
> +The doc proposes best practices on how to use PCI Express (PCIe) / PCI
> +device in PCI Express based machines and explains the reasoning behind
> +them.

Pre-existing bug  s/device/devices/

> +This applies to the Q35 machine type on x86 and the 'virt' machine typ=
e

For consistency I'd suggest  'q35' rather than Q35.

> +on AArch64 (in other words, PCIe features are available only when usin=
g
> +the Q35 and 'virt' machine types for the said architectures). Other

And again, though I feel the stuff in (...) is just repeating what's
said in the stuff either side of the brackets.

> +machine types do not use PCI Express at this time.
> =20
>  The following presentations accompany this document:
>   (1) Q35 overview.
> --=20
> 2.13.6
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
