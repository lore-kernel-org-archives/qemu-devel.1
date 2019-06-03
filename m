Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45CAC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAB2229FA
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAB2229FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39589 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXs9f-00039a-Qh
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:57:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hXs8n-0002hA-J4
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hXs8m-0000bt-Jf
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:57:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hXs8m-0000aR-EG; Mon, 03 Jun 2019 14:57:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A32D8300144F;
	Mon,  3 Jun 2019 18:57:01 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB07F5D9D2;
	Mon,  3 Jun 2019 18:56:48 +0000 (UTC)
Date: Mon, 3 Jun 2019 12:56:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190603125647.160a7a7c@x1.home>
In-Reply-To: <20190528164020.32250-10-philmd@redhat.com>
References: <20190528164020.32250-1-philmd@redhat.com>
	<20190528164020.32250-10-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 03 Jun 2019 18:57:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/10] hw/vfio/pci: Use the QOM DEVICE()
 macro to access DeviceState.qdev
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
	qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Michael Walle <michael@walle.cc>,
	Gerd Hoffmann <kraxel@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 18:40:19 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Rather than looking inside the definition of a DeviceState with
> "s->qdev", use the QOM prefered style: "DEVICE(s)".
>=20
> This patch was generated using the following Coccinelle script:
>=20
>     // Use DEVICE() macros to access DeviceState.qdev
>     @use_device_macro_to_access_qdev@
>     expression obj;
>     identifier dev;
>     @@
>     -&obj->dev.qdev
>     +DEVICE(obj)
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/vfio/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8e555db12e..2a4091d216 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2717,7 +2717,7 @@ static void vfio_req_notifier_handler(void *opaque)
>          return;
>      }
> =20
> -    qdev_unplug(&vdev->pdev.qdev, &err);
> +    qdev_unplug(DEVICE(vdev), &err);
>      if (err) {
>          warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>      }
> @@ -2839,7 +2839,7 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
>      vdev->vbasedev.name =3D g_path_get_basename(vdev->vbasedev.sysfsdev);
>      vdev->vbasedev.ops =3D &vfio_pci_ops;
>      vdev->vbasedev.type =3D VFIO_DEVICE_TYPE_PCI;
> -    vdev->vbasedev.dev =3D &vdev->pdev.qdev;
> +    vdev->vbasedev.dev =3D DEVICE(vdev);
> =20
>      tmp =3D g_strdup_printf("%s/iommu_group", vdev->vbasedev.sysfsdev);
>      len =3D readlink(tmp, group_path, sizeof(group_path));


