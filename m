Received: from eggs.gnu.org ([2001:4830:134:3::10]:46988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fcYOm-0005LI-49
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fcYOj-0007eq-1c
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:48:24 -0400
Received: from mail-bl2nam02on060d.outbound.protection.outlook.com
	([2a01:111:f400:fe46::60d]:63488
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fcYOi-0007eV-KX
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:48:20 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 9 Jul 2018 15:48:18 +0000
Message-ID: <DM5PR12MB2471C8BD48775D9FF0D3A2CF95440@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20180703011026.18650-1-ehabkost@redhat.com>
In-Reply-To: <20180703011026.18650-1-ehabkost@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] pc: Fix typo on PC_COMPAT_2_12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Looks good. thanks

> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Monday, July 2, 2018 8:10 PM
> To: qemu-devel@nongnu.org
> Cc: Eduardo Habkost <ehabkost@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Moger, Babu <Babu.Moger@amd.com>; Michael
> S. Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>
> Subject: [PATCH] pc: Fix typo on PC_COMPAT_2_12
>=20
> I forgot a hyphen when amending the compat code on commit
> e0051647 ("i386: Enable TOPOEXT feature on AMD EPYC CPU").
>=20
> Fixes: e00516475c270dcb6705753da96063f95699abf2
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Bug detected by compat_checker:
> https://github.com/ehabkost/gdb-qemu
> ---
>  include/hw/i386/pc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 4d99d69681..654003f44c 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -309,7 +309,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *,
> uint64_t *);
>          .property =3D "xlevel",\
>          .value    =3D stringify(0x8000000a),\
>      },{\
> -        .driver   =3D "EPYC-IBPB" TYPE_X86_CPU,\
> +        .driver   =3D "EPYC-IBPB-" TYPE_X86_CPU,\
>          .property =3D "xlevel",\
>          .value    =3D stringify(0x8000000a),\
>      },
> --
> 2.18.0.rc1.1.g3f1ff2140
