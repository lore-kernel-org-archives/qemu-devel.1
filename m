Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C5FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A65C20659
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A65C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXOh-0000jO-H7
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMXKF-0004OX-C1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMXKE-0008C5-A0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:02:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMXKE-0008Be-2a
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:02:18 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D71A368B1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 13:02:17 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v7so5360916wrf.4
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 06:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z8GcT0G80piGybTHEWmexoq7HZ9/lvaFndC+nb8gqI8=;
 b=LL6ayG08IHGxMExHm7HZRxBp8U96PEb8M0tiFahzj3rYOfjXPysn8FGKkRtt6Wrelf
 r00Lt3iY79LaQFnaz+AxbCezPLtIkMv3hCOwvkDbDXTIJ9W3sgMxbN5sqzJ9+8HOC+6K
 Wwgh9PGF596Bw4CRziQVbqW0+jRAyIplgmMFF9EWtkJxA/FGb9BnVDo0PxLyBClXlLV6
 /1u7utmwX8+Fms4wr92wnMJansXQoiuUWIIqCvYMfkADiziEpRgAAw920814BDXHJJPl
 PeRckOf7Gmir56gAWX4XjAz0Ez6yIhRdTERIS2hIMyl5zfJjIUCIq5I6iSZyJl25cDfs
 0zKQ==
X-Gm-Message-State: APjAAAXvnl9BeKQrwu+QJDEOHWEOFXRzHqmGum5QXKK1ycG0j0g3su+C
 YHjugcl7R8wn4DrtoNIGKWZrrtAf6MT6Z9bqLJtFV97rqOkc220VyF24VQ5SKia+BZh1amkyM0K
 i/o3MCk4Tid7hJIY=
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr19738841wrn.29.1571662935831; 
 Mon, 21 Oct 2019 06:02:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzaj9icj85/63rrQPXa4LGyjlDtr3dUFFpEYzt5cQZ1/bzxdLmUz9I8fV6PKdU1KXtzVqpraw==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr19738808wrn.29.1571662935552; 
 Mon, 21 Oct 2019 06:02:15 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id s9sm16947488wme.36.2019.10.21.06.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 06:02:14 -0700 (PDT)
Subject: Re: [PATCH v3 14/16] libqos: make the virtio-pci BAR index
 configurable
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191019063810.6944-1-stefanha@redhat.com>
 <20191019063810.6944-15-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7f2d07fb-b139-51f4-09ea-5420f2a5dbcc@redhat.com>
Date: Mon, 21 Oct 2019 15:02:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191019063810.6944-15-stefanha@redhat.com>
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
> The Legacy virtio-pci interface always uses BAR 0.  VIRTIO 1.0 may need
> to use a different BAR index, so make it configurable.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v3:
>   * Change uint8_t bar_idx to int [Thomas]
> ---
>   tests/libqos/virtio-pci.h | 2 ++
>   tests/libqos/virtio-pci.c | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
> index 0e4a8b7b00..78a1c15c2a 100644
> --- a/tests/libqos/virtio-pci.h
> +++ b/tests/libqos/virtio-pci.h
> @@ -25,6 +25,8 @@ typedef struct QVirtioPCIDevice {
>       uint16_t config_msix_entry;
>       uint64_t config_msix_addr;
>       uint32_t config_msix_data;
> +
> +    int bar_idx;
>   } QVirtioPCIDevice;
>  =20
>   struct QVirtioPCIMSIXOps {
> diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
> index c900742f96..e9595603f5 100644
> --- a/tests/libqos/virtio-pci.c
> +++ b/tests/libqos/virtio-pci.c
> @@ -310,7 +310,7 @@ static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops=
_legacy =3D {
>   void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
>   {
>       qpci_device_enable(d->pdev);
> -    d->bar =3D qpci_iomap(d->pdev, 0, NULL);
> +    d->bar =3D qpci_iomap(d->pdev, d->bar_idx, NULL);
>   }
>  =20
>   void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
> @@ -400,6 +400,7 @@ static void qvirtio_pci_init_from_pcidev(QVirtioPCI=
Device *dev, QPCIDevice *pci_
>   {
>       dev->pdev =3D pci_dev;
>       dev->vdev.device_type =3D qpci_config_readw(pci_dev, PCI_SUBSYSTE=
M_ID);
> +    dev->bar_idx =3D 0;
>  =20
>       dev->config_msix_entry =3D -1;
>       dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

