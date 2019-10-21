Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951ADCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AA620679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AA620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXMq-0006hZ-Iz
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMXLU-0005gt-R7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMXLS-0000G4-Hf
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMXLS-0000FQ-96
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:03:34 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42BCC51EE4
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 13:03:33 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id r8so24319wrx.8
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 06:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oCfX4ZbLl/VpPe3SOuBn44okEfk1S7DeI/N6cBUnuT4=;
 b=dGc+4EKwufNYh/+FpOxz6fNnLwaQBi6ixRa/FpVCIwowXpo2QGbxKzCjs0ZL9cEqiu
 oD5b/jRvLPN3xqwZT/4O09b9JDjyaGwiu7e9Oh0apk9v+GFhOpfKC9CU3NyZyJ1vYczF
 GAMrtGOrzbReCibe2xabs/3VzSyHCirtdWi+KUu2C1Tc5PLPXfG34S46goHr+Q5ukmZd
 Vma7qz04PJZ5meCD+7gnMajjTI4Lg6u73vuLlRzPdBAhPXQ2mbt/cT9P7inQ6yeCOfGM
 fN790VB3ObHVIWjZY4VgxiwpXMjtXn0o9p+oEmOTLf3LfygR4ce5YubBnwvLLRG72rZW
 9Uxw==
X-Gm-Message-State: APjAAAW0Lip32xPjkJ2TnMfWA/uy4ZXE8lHSn1kFvDHE5canR6p74J9+
 1qlFdCMoXNl2LqlrJqq/p2ZbCzAFL8L1WeIbA4PR8SCFTxQAHel+1LHVx3nRoFXnnmhMGmTeaje
 mXBq3TS0lLhvhNNQ=
X-Received: by 2002:a1c:a546:: with SMTP id o67mr19378845wme.57.1571663011767; 
 Mon, 21 Oct 2019 06:03:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyB6OBiHsdkX7JE/2z2kgjIcjJzFoMlZwG/SwlCfthWkeGk8FXRIfN70z2c0bOa7ChQBAglpg==
X-Received: by 2002:a1c:a546:: with SMTP id o67mr19378824wme.57.1571663011533; 
 Mon, 21 Oct 2019 06:03:31 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id h18sm13539835wrr.78.2019.10.21.06.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 06:03:30 -0700 (PDT)
Subject: Re: [PATCH v3 15/16] libqos: extract Legacy virtio-pci.c code
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191019063810.6944-1-stefanha@redhat.com>
 <20191019063810.6944-16-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d1969941-bb1f-b34e-d86e-ecaf811df377@redhat.com>
Date: Mon, 21 Oct 2019 15:03:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191019063810.6944-16-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/19/19 8:38 AM, Stefan Hajnoczi wrote:
> The current libqos virtio-pci.c code implements the VIRTIO Legacy
> interface.  Extract existing code in preparation for VIRTIO 1.0 support=
.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/libqos/virtio-pci.h |  2 --
>   tests/libqos/virtio-pci.c | 29 ++++++++++++-----------------
>   2 files changed, 12 insertions(+), 19 deletions(-)
>=20
> diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
> index 78a1c15c2a..6b3a385b06 100644
> --- a/tests/libqos/virtio-pci.h
> +++ b/tests/libqos/virtio-pci.h
> @@ -45,8 +45,6 @@ typedef struct QVirtQueuePCI {
>       uint32_t msix_data;
>   } QVirtQueuePCI;
>  =20
> -extern const QVirtioBus qvirtio_pci;
> -
>   void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress=
 * addr);
>   QVirtioPCIDevice *virtio_pci_new(QPCIBus *bus, QPCIAddress * addr);
>  =20
> diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
> index e9595603f5..11866f7772 100644
> --- a/tests/libqos/virtio-pci.c
> +++ b/tests/libqos/virtio-pci.c
> @@ -35,14 +35,6 @@
>    * original qvirtio_pci_destructor and qvirtio_pci_start_hw.
>    */
>  =20
> -static inline bool qvirtio_pci_is_big_endian(QVirtioPCIDevice *dev)
> -{
> -    QPCIBus *bus =3D dev->pdev->bus;
> -
> -    /* FIXME: virtio 1.0 is always little-endian */
> -    return qtest_big_endian(bus->qts);
> -}
> -
>   #define CONFIG_BASE(dev) (VIRTIO_PCI_CONFIG_OFF((dev)->pdev->msix_ena=
bled))
>  =20
>   static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d, uint64_t of=
f)
> @@ -55,8 +47,7 @@ static uint8_t qvirtio_pci_config_readb(QVirtioDevice=
 *d, uint64_t off)
>    * but virtio ( < 1.0) is in guest order
>    * so with a big-endian guest the order has been reversed,
>    * reverse it again
> - * virtio-1.0 is always little-endian, like PCI, but this
> - * case will be managed inside qvirtio_pci_is_big_endian()
> + * virtio-1.0 is always little-endian, like PCI
>    */
>  =20
>   static uint16_t qvirtio_pci_config_readw(QVirtioDevice *d, uint64_t o=
ff)
> @@ -262,7 +253,7 @@ static void qvirtio_pci_virtqueue_kick(QVirtioDevic=
e *d, QVirtQueue *vq)
>       qpci_io_writew(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NOTIFY, vq->=
index);
>   }
>  =20
> -const QVirtioBus qvirtio_pci =3D {
> +static const QVirtioBus qvirtio_pci_legacy =3D {
>       .config_readb =3D qvirtio_pci_config_readb,
>       .config_readw =3D qvirtio_pci_config_readw,
>       .config_readl =3D qvirtio_pci_config_readl,
> @@ -396,17 +387,21 @@ void qvirtio_pci_start_hw(QOSGraphObject *obj)
>       qvirtio_start_device(&dev->vdev);
>   }
>  =20
> +static void qvirtio_pci_init_legacy(QVirtioPCIDevice *dev)
> +{
> +    dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSYST=
EM_ID);
> +    dev->bar_idx =3D 0;
> +    dev->vdev.bus =3D &qvirtio_pci_legacy;
> +    dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
> +    dev->vdev.big_endian =3D qtest_big_endian(dev->pdev->bus->qts);
> +}
> +
>   static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCID=
evice *pci_dev)
>   {
>       dev->pdev =3D pci_dev;
> -    dev->vdev.device_type =3D qpci_config_readw(pci_dev, PCI_SUBSYSTEM=
_ID);
> -    dev->bar_idx =3D 0;
> -
>       dev->config_msix_entry =3D -1;
> -    dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
>  =20
> -    dev->vdev.bus =3D &qvirtio_pci;
> -    dev->vdev.big_endian =3D qvirtio_pci_is_big_endian(dev);
> +    qvirtio_pci_init_legacy(dev);
>  =20
>       /* each virtio-xxx-pci device should override at least this funct=
ion */
>       dev->obj.get_driver =3D NULL;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

