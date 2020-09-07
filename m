Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F9C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FE020738
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHZSimkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FE020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEXC-0006GM-PR
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFEWa-0005Wm-Oe
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFEWY-0004Cm-9G
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599475040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/NvMeuIYFsYSD0dhPB6h8zbGw/Y7DzQLJ3NNRtZjbI=;
 b=IHZSimklF6Atu6fWX1tLW5tXlEz4qNJnqtHEBH234I0bfxcX4QB3Ch6/QIqK1MWuskdszY
 SjYJoSJN4ed/bFN7SK1kF4HS9CeJXAgWVUWwhNJy1qQ7lUJy2NiBf8MAOAhNJvZNx+iEGv
 Tc1kMN2vqqE0LcdglcGQ/DtygNTP3GM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-k5uqhwQMM3KAfs7bRF82mA-1; Mon, 07 Sep 2020 06:37:18 -0400
X-MC-Unique: k5uqhwQMM3KAfs7bRF82mA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77DD9802B5E;
 Mon,  7 Sep 2020 10:37:17 +0000 (UTC)
Received: from work-vm (ovpn-114-180.ams2.redhat.com [10.36.114.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F40060BE2;
 Mon,  7 Sep 2020 10:37:11 +0000 (UTC)
Date: Mon, 7 Sep 2020 11:37:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 17/17] hw/block/nvme: change controller pci id
Message-ID: <20200907103708.GG2682@work-vm>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-18-its@irrelevant.dk>
 <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
MIME-Version: 1.0
In-Reply-To: <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:52:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
> +David in case
> 
> On 9/4/20 4:19 PM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > There are two reasons for changing this:
> > 
> >   1. The nvme device currently uses an internal Intel device id.
> > 
> >   2. Since commits "nvme: fix write zeroes offset and count" and "nvme:
> >      support multiple namespaces" the controller device no longer has
> >      the quirks that the Linux kernel think it has.
> > 
> >      As the quirks are applied based on pci vendor and device id, change
> >      them to get rid of the quirks.
> > 
> > To keep backward compatibility, add a new 'x-use-intel-id' parameter to
> > the nvme device to force use of the Intel vendor and device id. This is
> > off by default but add a compat property to set this for 5.1 machines
> > and older.
> 
> So now what happens if you start a 5.1 machine with a recent kernel?
> Simply the kernel will use unnecessary quirks, or are there more
> changes in behavior?

Seems reasonable to me...but...

> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  hw/block/nvme.c   | 12 ++++++++++--
> >  hw/block/nvme.h   |  1 +
> >  hw/core/machine.c |  1 +
> >  3 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 453d3a89d475..8018f8679366 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -2749,6 +2749,15 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
> >  
> >      pci_conf[PCI_INTERRUPT_PIN] = 1;
> >      pci_config_set_prog_interface(pci_conf, 0x2);
> > +
> > +    if (n->params.use_intel_id) {
> > +        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
> > +        pci_config_set_device_id(pci_conf, 0x5846);

Wasn't that magic number 5845 down there ?

Dave

> > +    } else {
> > +        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
> > +        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
> > +    }
> > +
> >      pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
> >      pcie_endpoint_cap_init(pci_dev, 0x80);
> >  
> > @@ -2903,6 +2912,7 @@ static Property nvme_props[] = {
> >      DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
> >      DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
> >      DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
> > +    DEFINE_PROP_BOOL("x-use-intel-id", NvmeCtrl, params.use_intel_id, false),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > @@ -2919,8 +2929,6 @@ static void nvme_class_init(ObjectClass *oc, void *data)
> >      pc->realize = nvme_realize;
> >      pc->exit = nvme_exit;
> >      pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
> > -    pc->vendor_id = PCI_VENDOR_ID_INTEL;
> > -    pc->device_id = 0x5845;
> >      pc->revision = 2;
> >  
> >      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > index 72260f2e8ea9..a734a5e1370d 100644
> > --- a/hw/block/nvme.h
> > +++ b/hw/block/nvme.h
> > @@ -15,6 +15,7 @@ typedef struct NvmeParams {
> >      uint8_t  aerl;
> >      uint32_t aer_max_queued;
> >      uint8_t  mdts;
> > +    bool     use_intel_id;
> >  } NvmeParams;
> >  
> >  typedef struct NvmeAsyncEvent {
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index ea26d612374d..67990232528c 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -34,6 +34,7 @@ GlobalProperty hw_compat_5_1[] = {
> >      { "vhost-user-scsi", "num_queues", "1"},
> >      { "virtio-blk-device", "num-queues", "1"},
> >      { "virtio-scsi-device", "num_queues", "1"},
> > +    { "nvme", "x-use-intel-id", "on"},
> >  };
> >  const size_t hw_compat_5_1_len = G_N_ELEMENTS(hw_compat_5_1);
> >  
> > 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


