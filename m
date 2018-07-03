Received: from eggs.gnu.org ([2001:4830:134:3::10]:46411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faO67-0007y4-44
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faO62-00082K-ED
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:24:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41028 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faO62-000821-8Y
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:24:06 -0400
References: <0b2c142da5d44a4b645dee47b7c50dae87a90a05.1530606672.git.tgolembi@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f6cb6496-48c1-cbb2-e33e-a3c32cb6dd18@redhat.com>
Date: Tue, 3 Jul 2018 11:24:03 -0500
MIME-Version: 1.0
In-Reply-To: <0b2c142da5d44a4b645dee47b7c50dae87a90a05.1530606672.git.tgolembi@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga: report disk size and free space
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

On 07/03/2018 03:31 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> Report total file system size and free space in output of command
> "guest-get-fsinfo". Values are optional and it is not an error if they =
cannot
> be retrieved for some reason.
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>   qga/commands-posix.c | 18 ++++++++++++++++++
>   qga/commands-win32.c | 16 ++++++++++++++++
>   qga/qapi-schema.json |  5 ++++-
>   3 files changed, 38 insertions(+), 1 deletion(-)

> +++ b/qga/qapi-schema.json
> @@ -848,12 +848,15 @@
>   # @type: file system type string
>   # @disk: an array of disk hardware information that the volume lies o=
n,
>   #        which may be empty if the disk type is not supported
> +# @size: total number of bytes on the file system (Since 2.13)
> +# @free: number of bytes available on the file system (Since 2.13)

s/2.13/3.0/ (if it makes it into today's soft freeze, or 3.1 if not)

>   #
>   # Since: 2.2
>   ##
>   { 'struct': 'GuestFilesystemInfo',
>     'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
> -           'disk': ['GuestDiskAddress']} }
> +           'disk': ['GuestDiskAddress'], '*size': 'uint64',
> +           '*free': 'uint64'} }
>  =20
>   ##
>   # @guest-get-fsinfo:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
