Received: from eggs.gnu.org ([2001:4830:134:3::10]:45268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddCeR-00019w-HX
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 05:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddCeO-0000ZH-7U
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 05:42:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ddCeO-0000Yf-21
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 05:42:40 -0400
Date: Thu, 3 Aug 2017 11:42:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170803114231.5674b185@gondolin>
In-Reply-To: <20170803090746.30532-1-marcandre.lureau@redhat.com>
References: <20170803090746.30532-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] build-sys: add --disable-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, philippe.mathieu.daude@gmail.com, mst@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On Thu,  3 Aug 2017 11:07:46 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Learn to compile out vhost-user (net, scsi & upcoming users). Keep it
> enabled by default on non-win32, that is assumed to be POSIX. Fail if
> trying to enable it on win32.
>=20
> When trying to make a vhost-user netdev, it gives the following error:
>=20
> -netdev vhost-user,id=3Dfoo,chardev=3Dchr-test: Parameter 'type' expects =
a netdev backend type
>=20
> And similar error with the HMP/QMP monitors.
>=20
> While at it, rename CONFIG_VHOST_NET_TEST CONFIG_VHOST_USER_NET_TEST
> since it's a vhost-user specific variable.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/virtio/virtio-pci.c            |  4 ++--
>  configure                         | 28 ++++++++++++++++++++++++++--
>  default-configs/pci.mak           |  2 +-
>  default-configs/s390x-softmmu.mak |  2 +-
>  tests/Makefile.include            |  6 +++---
>  5 files changed, 33 insertions(+), 9 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
