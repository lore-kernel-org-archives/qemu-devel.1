Received: from eggs.gnu.org ([2001:4830:134:3::10]:58459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn29L-0006Qx-17
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn28a-00066e-7m
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:35:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fn28Z-00066U-SZ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:35:00 -0400
References: <cover.1533638952.git.tgolembi@redhat.com>
	<f441eb31f52a03450884cdb2bd7cc39ab430943d.1533638952.git.tgolembi@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0aa4c09-b4c8-386f-5faf-e3c65731f348@redhat.com>
Date: Tue, 7 Aug 2018 08:34:58 -0500
MIME-Version: 1.0
In-Reply-To: <f441eb31f52a03450884cdb2bd7cc39ab430943d.1533638952.git.tgolembi@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] qga: report serial ID and device node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 08/07/2018 05:49 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> On Linux the functionality depends on libudev.
>=20
> Example from Linux:
>=20
>      {
>        "name": "dm-2",
>        "mountpoint": "/",
>        ...
>        "disk": [
>          {
>            "serial": "SAMSUNG_MZ7LN512HCHP-000L1_S1ZKNXAG822493",
>            "dev": "/dev/sda2",
>            ...
>          }
>        ],
>      }
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---

> +++ b/qga/qapi-schema.json
> @@ -834,13 +834,15 @@
>   # @bus: bus id
>   # @target: target id
>   # @unit: unit id
> +# @serial: serial number

Needs a '(since 3.1)' tag.

>   #
>   # Since: 2.2
>   ##
>   { 'struct': 'GuestDiskAddress',
>     'data': {'pci-controller': 'GuestPCIAddress',
>              'bus-type': 'GuestDiskBusType',
> -           'bus': 'int', 'target': 'int', 'unit': 'int'} }
> +           'bus': 'int', 'target': 'int', 'unit': 'int',
> +           '*serial': 'str', '*dev': 'str'} }
>  =20
>   ##
>   # @GuestFilesystemInfo:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
