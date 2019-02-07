Received: from eggs.gnu.org ([209.51.188.92]:54195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grnhR-0002je-0W
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grnhP-0003cg-CG
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:42:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1grnhP-0003ZZ-1G
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:42:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64D2AC05001B
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 17:42:50 +0000 (UTC)
References: <20190207165449.6125-1-marcandre.lureau@redhat.com>
	<20190207165449.6125-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a89d56aa-2f16-093f-a406-35db0e0c69f8@redhat.com>
Date: Thu, 7 Feb 2019 11:42:39 -0600
MIME-Version: 1.0
In-Reply-To: <20190207165449.6125-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F5tFVE70sgrejplwy1QB5himMQwYoT8sQ"
Subject: Re: [Qemu-devel] [PATCH v2 01/12] vhost-user: define conventions
 for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F5tFVE70sgrejplwy1QB5himMQwYoT8sQ
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <a89d56aa-2f16-093f-a406-35db0e0c69f8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/12] vhost-user: define conventions for
 vhost-user backends
References: <20190207165449.6125-1-marcandre.lureau@redhat.com>
 <20190207165449.6125-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190207165449.6125-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 10:54 AM, Marc-Andr=C3=A9 Lureau wrote:
> As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
> review, let's define a common set of backend conventions to help with
> management layer implementation, and interoperability.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  MAINTAINERS                  |   1 +
>  docs/interop/vhost-user.json | 219 +++++++++++++++++++++++++++++++++++=

>  docs/interop/vhost-user.txt  | 101 +++++++++++++++-
>  3 files changed, 319 insertions(+), 2 deletions(-)
>  create mode 100644 docs/interop/vhost-user.json

> +##
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

s/3.2/4.0/g in your patch series

> +##
> +{
> +  'enum': 'VHostUserBackendType',
> +  'data': [ 'net', 'block', 'console', 'rng', 'balloon', 'rpmsg',
> +            'scsi', '9p', 'rproc-serial', 'caif', 'gpu', 'input', 'vso=
ck',
> +            'crypto' ]
> +}

Worth alphabetizing? Not a strong requirement, though, if this order
makes more sense.


> +#
> +# Top-down, the list of directories goes from general to specific.
> +#
> +# Management software should build a list of files from all three
> +# locations, then sort the list by filename (i.e., last pathname

perhaps s/filename/basename/

> +# component). Management software should choose the first JSON file on=

> +# the sorted list that matches the search criteria. If a more specific=

> +# directory has a file with same name as a less specific directory, th=
en
> +# the file in the more specific directory takes effect. If the more
> +# specific file is zero length, it hides the less specific one.
> +#

> +++ b/docs/interop/vhost-user.txt
> @@ -17,8 +17,13 @@ The protocol defines 2 sides of the communication, m=
aster and slave. Master is
>  the application that shares its virtqueues, in our case QEMU. Slave is=
 the
>  consumer of the virtqueues.
> =20
> -In the current implementation QEMU is the Master, and the Slave is int=
ended to
> -be a software Ethernet switch running in user space, such as Snabbswit=
ch.
> +In the current implementation QEMU is the Master, and the Slave is the=

> +external process consuming the virtio queues, for example a software
> +Ethernet switch running in user space, such as Snabbswitch, or a block=


Is 'slirp' any better than 'Snabbswitch' as a demonstration of
user-space networking?

> +device backend processing read & write to a virtual disk. In order to
> +facilitate interoperability between various backend implementations,
> +it is recommended to follow the "Backend program conventions"
> +described in this document.
> =20

> +
> +The backend program must end (as quickly and cleanly as possible) when=

> +the SIGTERM signal is received. Eventually, it may be SIGKILL by the

s/be/receive/

> +management layer after a few seconds.
> +
> +The following command line options have an expected behaviour. They
> +are mandatory, unless explicitly said differently:
> +
> +* --socket-path=3DPATH
> +
> +This option specify the location of the vhost-user Unix domain socket.=

> +It is incompatible with --fd.
> +
> +* --fd=3DFDNUM
> +
> +When this argument is given, the backend program is started with the
> +vhost-user socket as file descriptor FDNUM. It is incompatible with
> +--socket-path.

Do we also want to require support for systemd-style
LISTEN_PID/LISTEN_FDS socket activation?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--F5tFVE70sgrejplwy1QB5himMQwYoT8sQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcbhAACgkQp6FrSiUn
Q2qQZQgAl8REdQqfmrTh4w/IWO2KERIqVTGx5P7+InlXqk5MGaJnEgqJHjKP9H9x
Yhsyk6yrfBXEpXwQB5xDrynY7JiaZVXn35TZbidDI8HNJNvejVG3YzOz3hBd1kpl
/SLg8Wtlp0izb1lqYVhnV/ig4ebnXttz11tUsYbmAijclkzXldKctOLpuMQuWb4X
EZvBbqrTVEdgvlv2ARKbrvs1516wrRBuRGWGH51vz4wCY15MSTvOLvrcExYrz095
CjGtFB7zyT/3MVw3K0S1xBKX7MA3Js5g+WDI1hCnUVsLj6gScFZ4pmTE8pTd46/O
0z+Clk2QII6ZfQSz+jbcrJvVRgaBcg==
=zTEA
-----END PGP SIGNATURE-----

--F5tFVE70sgrejplwy1QB5himMQwYoT8sQ--
