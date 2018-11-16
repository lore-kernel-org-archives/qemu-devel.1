Received: from eggs.gnu.org ([2001:4830:134:3::10]:34183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNlrx-0005Yo-SR
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNlrv-0005ov-V7
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:41:41 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <abec84f9-d5c2-9488-3c1b-ca3c9b7df89f@redhat.com>
Date: Fri, 16 Nov 2018 15:41:15 -0600
MIME-Version: 1.0
In-Reply-To: <20181116155325.22428-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] tests: pull qemu-nbd iotest helpers
 into common.nbd file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> The helpers for starting/stopping qemu-nbd in 058 will be useful in
> other test cases, so move them into a common.nbd file.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tests/qemu-iotests/058        | 47 +++++------------------------
>   tests/qemu-iotests/common.nbd | 56 ++++++++++++++++++++++++++++++++++=
+
>   2 files changed, 64 insertions(+), 39 deletions(-)
>   create mode 100644 tests/qemu-iotests/common.nbd
>=20

> -
> -_cleanup_nbd()
> -{

> -_wait_for_nbd()
> -{

> +++ b/tests/qemu-iotests/common.nbd
> @@ -0,0 +1,56 @@
> +#!/bin/bash

I know we're using bash,

> +
> +function nbd_server_stop()
> +{

> +function nbd_server_wait_for_unix_socket()

and bash supports 'function', but it is an obsolete syntactic sugar=20
thing that I don't recommend using.  (In ksh, it actually makes a=20
difference in behavior whether you use 'function' or not, and using it=20
in 'bash' makes it harder to port code over to 'ksh' - and hence in bash=20
it is obsolete because here it does NOT cause the change in behavior=20
that ksh users expect)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
