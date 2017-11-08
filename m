Received: from eggs.gnu.org ([2001:4830:134:3::10]:53968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eCMAw-0001Hv-35
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eCMAt-0004M9-0R
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:57:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eCMAs-0004Lq-Qk
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:57:30 -0500
References: <CAJ+F1CKWdxAwuZ-QAvT=AhGMrXd+7c8=eBCMMuKPdbK75NDtiQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <2ec5f251-30d9-bc4b-e3cd-3e31272cfc95@redhat.com>
Date: Wed, 8 Nov 2017 10:57:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKWdxAwuZ-QAvT=AhGMrXd+7c8=eBCMMuKPdbK75NDtiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] i440/piix and dynamic sysbus check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 07/11/2017 18:40, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> I am working on a TPM CRB device (last sent version:
> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02014.html).
> It's a sysbus device, and when starting qemu with i440, I get "Option
> '-device tpm-crb' cannot be handled by this machine".
>=20
> The check comes from machine_init_notify(), checking that the machine
> has_dynamic_sysbus.
>=20
>   Apparently, q35 supports it. But not i440. If I declare
> has_dynamic_sysbus in piix, the device works fine.
>=20
> Marcel, could we do something similar to piix to what you did for q35?:
>=20

Yes, as long as we check all sysbus devices that can't be created
with '-device' have their "cannot_be_insta...yet" flag set.

If Eduardo's series achieves the above is OK.

Thanks,
Marcel

> commit bf8d492405feaee2c1685b3b9d5e03228ed3e47f
> Author: Marcel Apfelbaum <marcel@redhat.com>
> Date:   Mon Jun 27 18:38:33 2016 +0300
>=20
>      q35: allow dynamic sysbus
>=20
> thanks
>=20
