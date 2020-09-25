Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C4C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD7A21D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMNPYUd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD7A21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLl8b-0006iA-1f
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kLl7r-0006Gq-Tu
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kLl7q-0001j4-4b
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:38:51 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601030329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJZnhTSiJCAjK1hn2wyJvSMcxhV2vcZsuIrcwhF0X6k=;
 b=VMNPYUd1KRR2h+azjjizXaZ81GYvA995y0L+j59HVgaN/DqyiR4cTF/DDnUwxFk6WtSVPY
 NXY/1JLNDcTCi2KgY8CqCTzJcXJwkzzvpS46H6npEd3HQ/0brjoPQOVPhP0j7zthlLBc0f
 1Gc4SxF1wBJtYnLVL8jYoN2oFpeKOPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-NDG2PWu-OY-XD_mRGlZsjg-1; Fri, 25 Sep 2020 06:38:47 -0400
X-MC-Unique: NDG2PWu-OY-XD_mRGlZsjg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC95B8030A2;
 Fri, 25 Sep 2020 10:38:46 +0000 (UTC)
Received: from gondolin (ovpn-112-192.ams2.redhat.com [10.36.112.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C539A7368F;
 Fri, 25 Sep 2020 10:38:39 +0000 (UTC)
Date: Fri, 25 Sep 2020 12:38:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH] virtio-pmem-pci: force virtio version 1
Message-ID: <20200925123837.1733dcdc.cohuck@redhat.com>
In-Reply-To: <20200925102251.7216-1-pankaj.gupta.linux@gmail.com>
References: <20200925102251.7216-1-pankaj.gupta.linux@gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: david@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Sep 2020 12:22:51 +0200
Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:

>  Qemu fails with below error when trying to run with virtio pmem:
> 
>  (qemu) qemu-system-x86_64: -device virtio-pmem-pci,memdev=mem1,id=nv1:
>   device is modern-only, use disable-legacy=on

Oh, another one :(

>  
>  This patch fixes this by forcing virtio 1 with virtio-pmem.
> 
> fixes: adf0748a49 ("virtio-pci: Proxy for virtio-pmem")
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> ---
>  hw/virtio/virtio-pmem-pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
> index 21a457d151..2b2a0b1eae 100644
> --- a/hw/virtio/virtio-pmem-pci.c
> +++ b/hw/virtio/virtio-pmem-pci.c
> @@ -22,6 +22,7 @@ static void virtio_pmem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      VirtIOPMEMPCI *pmem_pci = VIRTIO_PMEM_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&pmem_pci->vdev);
>  
> +    virtio_pci_force_virtio_1(vpci_dev);
>      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>  }
>  

The alternative would be to force virtio 1 only for 5.1 and later (see
https://lore.kernel.org/qemu-devel/20200921122506.82515-1-sgarzare@redhat.com/).


