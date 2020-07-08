Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F45C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7D120772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMPZh9WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7D120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIX9-0004Qq-Hf
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtI6p-0008Ot-G5
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:00:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtI6n-0006Jh-HU
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9YcfR3373Xl+BNKAzwdKIQ6DScKKiKbu+1oXSJaUt5k=;
 b=QMPZh9WNRc+tyn7p26ZvWI7cDOv1DqlsRWD5jP8l8fsR9q5k8CTcPVxyb6SOu/NQ9CQLmX
 Fr4rplu969JTtvkSVKJvsHQozppZEjp4rBQV3HWNC02HZlfPzkL8bzNxFjftixGO9UARLi
 LnBF2glX/xuaBRy0N9DlEicT1LdNpSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-UC8gPyD3OLyrvJh-QA1-Kw-1; Wed, 08 Jul 2020 10:58:40 -0400
X-MC-Unique: UC8gPyD3OLyrvJh-QA1-Kw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7573E88C798
 for <qemu-devel@nongnu.org>; Wed,  8 Jul 2020 14:58:39 +0000 (UTC)
Received: from gondolin (ovpn-112-239.ams2.redhat.com [10.36.112.239])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A1A278534;
 Wed,  8 Jul 2020 14:58:29 +0000 (UTC)
Date: Wed, 8 Jul 2020 16:58:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] virtio-mem-pci: force virtio version 1
Message-ID: <20200708165826.461d0ca0.cohuck@redhat.com>
In-Reply-To: <20200708143619.38743-1-david@redhat.com>
References: <20200708143619.38743-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 Jul 2020 16:36:19 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's force virtio version 1. While at it, use qdev_realize() to set
> the parent bus and realize - like most other virtio-*-pci
> implementations.

Yes, there's recently been a mass conversion to qdev_realize().

> 
> Fixes: 0b9a2443a48b ("virtio-pci: Proxy for virtio-mem")
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-mem-pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
> index 1a8e854123..831022aa86 100644
> --- a/hw/virtio/virtio-mem-pci.c
> +++ b/hw/virtio/virtio-mem-pci.c
> @@ -21,8 +21,8 @@ static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      VirtIOMEMPCI *mem_pci = VIRTIO_MEM_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&mem_pci->vdev);
>  
> -    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> -    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +    virtio_pci_force_virtio_1(vpci_dev);
> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>  }
>  
>  static void virtio_mem_pci_set_addr(MemoryDeviceState *md, uint64_t addr,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


