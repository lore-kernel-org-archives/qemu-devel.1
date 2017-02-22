Received: from eggs.gnu.org ([2001:4830:134:3::10]:54638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgVBD-0000Ja-1B
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgVB7-0000R7-7M
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:33:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgVB7-0000Qx-0s
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:33:49 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F8E4C05AA72
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 11:33:49 +0000 (UTC)
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-22-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf7fea2d-7e9d-e761-2b62-6ad2e495e81f@redhat.com>
Date: Wed, 22 Feb 2017 12:33:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-22-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 21/30] tests: fix virtio-scsi-test leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 21/02/2017 15:14, Marc-Andr=C3=A9 Lureau wrote:
> Spotted by ASAN.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
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
>      qvirtio_pci_device_disable(container_of(vs->dev, QVirtioPCIDevice,=
 vdev));
> -    g_free(vs->dev);
> +    qvirtio_pci_device_free((QVirtioPCIDevice *)vs->dev);
>      qvirtio_scsi_stop(vs->qs);
>      g_free(vs);
>  }
>=20

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
