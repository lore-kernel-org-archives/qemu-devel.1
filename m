Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C3DECE58F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 01:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE1A2086A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 01:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE1A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKYWV-0002dN-4Y
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 21:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iKYVi-0001mI-J7
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 21:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iKYVg-0003dv-Ef
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 21:53:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iKYVg-0003db-8E
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 21:53:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32ED4315C005;
 Wed, 16 Oct 2019 01:53:55 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAF9860852;
 Wed, 16 Oct 2019 01:53:47 +0000 (UTC)
Date: Tue, 15 Oct 2019 19:53:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v3 02/10] pci: mark devices partially unplugged
Message-ID: <20191015195347.45c597c4@x1.home>
In-Reply-To: <20191011112015.11785-3-jfreimann@redhat.com>
References: <20191011112015.11785-1-jfreimann@redhat.com>
 <20191011112015.11785-3-jfreimann@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 16 Oct 2019 01:53:55 +0000 (UTC)
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
Cc: ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 13:20:07 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> Only the guest unplug request was triggered. This is needed for
> the failover feature. In case of a failed migration we need to
> plug the device back to the guest.
> 
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  hw/pci/pci.c         | 2 ++
>  hw/pci/pcie.c        | 3 +++
>  include/hw/pci/pci.h | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index aa05c2b9b2..c140b37765 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2078,6 +2078,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>      Error *local_err = NULL;
>      bool is_default_rom;
>  
> +    pci_dev->partially_hotplugged = false;

This is redundant though since the object is zero initialized on
allocation, right?  Thanks,

Alex

> +
>      /* initialize cap_present for pci_is_express() and pci_config_size(),
>       * Note that hybrid PCIs are not set automatically and need to manage
>       * QEMU_PCI_CAP_EXPRESS manually */
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index a6beb567bd..19363ff8ce 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -456,6 +456,9 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
>  {
>      HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(dev));
>  
> +    if (dev->partially_hotplugged) {
> +        return;
> +    }
>      hotplug_handler_unplug(hotplug_ctrl, DEVICE(dev), &error_abort);
>      object_unparent(OBJECT(dev));
>  }
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index f3f0ffd5fb..f3a39c9bbd 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -265,6 +265,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
>  
>  struct PCIDevice {
>      DeviceState qdev;
> +    bool partially_hotplugged;
>  
>      /* PCI config space */
>      uint8_t *config;


