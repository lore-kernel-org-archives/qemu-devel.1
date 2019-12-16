Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A6C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 08:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 777FB206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 08:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCEhto4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777FB206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igm5p-00006X-Lx
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 03:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1igm5C-00083N-M8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 03:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1igm5A-00082o-0L
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 03:50:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1igm59-0007yJ-GU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 03:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576486221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTu6mi5o2jXTwaZdakb4a7k8BJOtyWjP3nmmofJJOcY=;
 b=TCEhto4bnSSJ+D/Agtv2Ya/xrdNOX5ic3IrfZGvvHKKMowN1U0sug00jDb6tLUhSr4Av99
 /9o07nobFX95W5uXL+iW5Xs2c4H73Unco6huw/1oGRcKxljZg/zXZ+viQJ7IFG8sdnmVvg
 3oZdDh+2K3ZtuPocLER0Hd62mkVxvvY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-pWJ6nNFqNcOAmysR1CeUIg-1; Mon, 16 Dec 2019 03:50:18 -0500
Received: by mail-wr1-f71.google.com with SMTP id w6so3381211wrm.16
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 00:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9pXwsgDJAsqYku0OdmAsmCeZQhEx7VgkvTmfjAWVcWs=;
 b=Cv1A/l4djRyBH79tRKm2rfXGV1RisjHX3HB9j401ag4ZATZ4kYp6VOxwd5lMniXebI
 w3zWL8ZDzpUVzTtJAKiF+wXpRXzFQ/q5TnPfXUpeCSlXZVmISVLKVkWm901ZsLyXEZkF
 aH1CYb5OrM6ox4vaCtKC3i3oXbTm9leElxu/vPZNtIBZyVsXVRc0jTULpot33y+CrgCW
 Qk8LZIG0nDhEDUcvPP8SI+W5IdpXA4MoSaR0kGdBBlZApARvIr6VqYNr/+4jIjidkvNt
 8a37J9Pa9llH4csfDgBDXoEH+bSEb+1CJAv6eiCxhg1Vw6+IrALNzm6TdI/Bzq5wCuT5
 m64g==
X-Gm-Message-State: APjAAAXwSRqS5JnZvCAqnZU+985wSkPrcSXLUYXOowu3MaoAl5cSHNHZ
 LzitS5crG/CchGqLUihIJ4yZOZIHnw7n4qSc68AGxvcTSjKqxhjRuwQ818uw6YJvL3wJ+1RK9Yr
 eeH9oa6HC7dZQG9M=
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr29903733wrx.288.1576486216831; 
 Mon, 16 Dec 2019 00:50:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqygSCF1gZJ7VOlvTRU0nweRambZcreJ0rJo6V+c1YZx6TiZpakbR8h34uGHw9C7GcqNPoQiCw==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr29903715wrx.288.1576486216632; 
 Mon, 16 Dec 2019 00:50:16 -0800 (PST)
Received: from steredhat ([95.235.120.92])
 by smtp.gmail.com with ESMTPSA id w8sm21040436wmm.0.2019.12.16.00.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 00:50:16 -0800 (PST)
Date: Mon, 16 Dec 2019 09:50:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: update queue size on guest write
Message-ID: <20191216085013.q7tgbesniil3nmbq@steredhat>
References: <20191213142358.345301-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191213142358.345301-1-mst@redhat.com>
X-MC-Unique: pWJ6nNFqNcOAmysR1CeUIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 13, 2019 at 09:24:03AM -0500, Michael S. Tsirkin wrote:
> Some guests read back queue size after writing it.
> Update the size immediatly upon write otherwise
> they get confused.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


Just a question, should we do the same in virtio-mmio?

Maybe doing virtio_queue_set_num() in any case (legacy and non-legacy)
during VIRTIO_MMIO_QUEUE_NUM writing.

Thanks,
Stefano

>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c6b47a9c73..e5c759e19e 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1256,6 +1256,8 @@ static void virtio_pci_common_write(void *opaque, h=
waddr addr,
>          break;
>      case VIRTIO_PCI_COMMON_Q_SIZE:
>          proxy->vqs[vdev->queue_sel].num =3D val;
> +        virtio_queue_set_num(vdev, vdev->queue_sel,
> +                             proxy->vqs[vdev->queue_sel].num);
>          break;
>      case VIRTIO_PCI_COMMON_Q_MSIX:
>          msix_vector_unuse(&proxy->pci_dev,
> --=20
> MST
>=20
>=20

--=20


