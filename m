Received: from eggs.gnu.org ([2001:4830:134:3::10]:60812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb8rM-0001Lj-6n
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb8rH-0006fx-5D
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:43:16 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:41621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cb8rG-0006e4-Un
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:43:11 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2EBA621A4D
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 17:43:09 +0100 (CET)
Date: Tue, 7 Feb 2017 17:43:05 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170207174305.4fdd37ef@bahia.lan>
In-Reply-To: <20170207135211.15870-22-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
	<20170207135211.15870-22-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 21/28] tests: fix virtio-9p-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On Tue,  7 Feb 2017 17:52:04 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Spotted by ASAN.
>=20
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Greg Kurz <groug@kaod.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

I was a bit confused at first but hopefully I could find the definition of
qvirtio_pci_device_free() in patch 08/28 :)

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/virtio-9p-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
> index 9556291567..43a1ad813f 100644
> --- a/tests/virtio-9p-test.c
> +++ b/tests/virtio-9p-test.c
> @@ -80,7 +80,7 @@ static void qvirtio_9p_pci_stop(QVirtIO9P *v9p)
>  {
>      qvirtqueue_cleanup(v9p->dev->bus, v9p->vq, v9p->qs->alloc);
>      qvirtio_pci_device_disable(container_of(v9p->dev, QVirtioPCIDevice, =
vdev));
> -    g_free(v9p->dev);
> +    qvirtio_pci_device_free((QVirtioPCIDevice *)v9p->dev);
>      qvirtio_9p_stop(v9p);
>  }
> =20
