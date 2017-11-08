Received: from eggs.gnu.org ([2001:4830:134:3::10]:57240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMNn-0005wQ-Vf
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMNm-0001l3-SG
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:10:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCMNm-0001kB-M3
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:10:50 -0500
Date: Wed, 8 Nov 2017 09:10:37 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171108091037.GG12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171108022828.7242-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] generic way to deprecate machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, Nov 07, 2017 at 11:28:22PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi,
>=20
> This series intends to provide a simple and common way to deprecate
> machines between releases. It may be extended to deprecate devices.
>=20
> I started with the machines list from:
>=20
>   https://wiki.qemu.org/Features/LegacyRemoval#Deprecated_machines
>=20
> Comment welcomed :)
>=20
> Regards,
>=20
> Phil.
>=20
> Alistair Francis (1):
>   hw/arm: deprecate the EP108 board
>=20
> Philippe Mathieu-Daud=C3=A9 (5):
>   machine: add a deprecated_reason property
>   hw/arm: deprecate the Gumstix boards
>   hw/ppc: deprecate the PReP machine
>   hw/i386: deprecate the pc-0.10 and pc-0.11 machines
>   hw/i386: deprecate the "isapc" machine
>=20
>  include/hw/boards.h  | 1 +
>  hw/arm/gumstix.c     | 2 ++
>  hw/arm/xlnx-zcu102.c | 6 +++++-
>  hw/i386/pc_piix.c    | 3 +++
>  hw/ppc/prep.c        | 1 +
>  vl.c                 | 7 +++++++
>  6 files changed, 19 insertions(+), 1 deletion(-)

Unless listed in the qemu-doc.texi "Deprecated features" appendix,
things are not considered deprecated...

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
