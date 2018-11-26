Received: from eggs.gnu.org ([2001:4830:134:3::10]:42375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRNwv-0000yb-OP
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRNwr-0002mZ-NJ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:57:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gRNwr-0002l3-FJ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:57:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1C75307DAAE
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 20:57:38 +0000 (UTC)
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
	<20181126124250.29985-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d69a1f4-f70f-f614-88a2-41ef99909db1@redhat.com>
Date: Mon, 26 Nov 2018 14:57:31 -0600
MIME-Version: 1.0
In-Reply-To: <20181126124250.29985-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On 11/26/18 6:42 AM, Marc-Andr=C3=A9 Lureau wrote:
> As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
> review, let's define a common set of backend conventions to help with
> management layer implementation, and interoperability.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   MAINTAINERS                  |   1 +
>   docs/interop/vhost-user.json | 219 ++++++++++++++++++++++++++++++++++=
+
>   docs/interop/vhost-user.txt  | 101 +++++++++++++++-
>   3 files changed, 319 insertions(+), 2 deletions(-)
>   create mode 100644 docs/interop/vhost-user.json

> +++ b/docs/interop/vhost-user.json

> +# @VHostUserBackendType:
> +#
> +# List the various vhost user backend types.
> +#
> +# @net: virtio net
> +# @block: virtio block
> +# @console: virtio console
> +# @rng: virtio rng
> +# @balloon: virtio balloon
> +# @rpmsg: virtio remote processor messaging
> +# @scsi: virtio scsi
> +# @9p: 9p virtio console
> +# @rproc-serial: virtio remoteproc serial link
> +# @caif: virtio caif
> +# @gpu: virtio gpu
> +# @input: virtio input
> +# @vsock: virtio vsock transport
> +# @crypto: virtio crypto
> +#
> +# Since: 3.2

The next release will be 4.0, not 3.2. (We'll probably have to do a=20
global search-and-replace in January, as you're not the only one=20
proposing a patch with this version number).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
