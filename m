Received: from eggs.gnu.org ([2001:4830:134:3::10]:32784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb8s8-0001iT-Hl
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb8s3-0007PI-GR
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:44:04 -0500
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:33681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cb8s3-0007OZ-A7
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:43:59 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id BFE0621A49
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 17:43:57 +0100 (CET)
Date: Tue, 7 Feb 2017 17:43:54 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170207174354.65427c59@bahia.lan>
In-Reply-To: <20170207135211.15870-21-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
	<20170207135211.15870-21-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 20/28] tests: fix virtio-scsi-test leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue,  7 Feb 2017 17:52:03 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Spotted by ASAN.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/virtio-scsi-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
> index 69220ef07b..0eabd56fd9 100644
> --- a/tests/virtio-scsi-test.c
> +++ b/tests/virtio-scsi-test.c
> @@ -63,7 +63,7 @@ static void qvirtio_scsi_pci_free(QVirtIOSCSI *vs)
>          qvirtqueue_cleanup(vs->dev->bus, vs->vq[i], vs->qs->alloc);
>      }
>      qvirtio_pci_device_disable(container_of(vs->dev, QVirtioPCIDevice, v=
dev));
> -    g_free(vs->dev);
> +    qvirtio_pci_device_free((QVirtioPCIDevice *)vs->dev);
>      qvirtio_scsi_stop(vs->qs);
>      g_free(vs);
>  }
