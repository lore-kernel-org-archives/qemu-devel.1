Received: from eggs.gnu.org ([209.51.188.92]:39951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw7lX-0003OR-Cn
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw7lW-0002WN-Co
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:57:03 -0500
References: <20190219125044.5416-1-berrange@redhat.com>
	<20190219125044.5416-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <45b0eda6-c8a5-e180-2458-b5f498227501@redhat.com>
Date: Tue, 19 Feb 2019 09:56:46 -0600
MIME-Version: 1.0
In-Reply-To: <20190219125044.5416-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: fail if encryption opts are
 provided to non-encrypted image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 2/19/19 6:50 AM, Daniel P. Berrang=C3=A9 wrote:
> If the qcow2 image does not have any encryption method specified in its
> header, the user should not be providing any encryption options when
> opening it. We already detect this if the user had set "encrypt.format"
> but this field is optional so must consider any "encrypt.*" option to b=
e
> an error.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  block/qcow2.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
