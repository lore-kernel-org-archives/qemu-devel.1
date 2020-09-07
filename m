Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1160C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E4821481
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bn2wluYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E4821481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEmZ-0005ZJ-NW
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFEls-0004wy-Pd
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:53:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46328
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFElr-0005zl-4Y
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599475990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tGSHg8ExEMek6b/EWxPLiHK7yKKYXuYbP6MlemyvaI=;
 b=Bn2wluYa4sl/Svwpf8hSA0GZCWarJvg4K3XApkX6W+NWNCcB7DBsIC5Ifzqe0SutgtrOY3
 Vzo7F7qlqrd3Jisf3emw808juW4MdxXk2YlOuxhMIjd0eqZpzMxJM0IL05vwU74+z5Npel
 JVb8qs+HW76F2OeE17OXMA5ZMpYmVrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-ynI6DphlMcOLfTQlZJZxcg-1; Mon, 07 Sep 2020 06:53:07 -0400
X-MC-Unique: ynI6DphlMcOLfTQlZJZxcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFAC218C9F45;
 Mon,  7 Sep 2020 10:53:05 +0000 (UTC)
Received: from work-vm (ovpn-114-180.ams2.redhat.com [10.36.114.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73DCA5C1BB;
 Mon,  7 Sep 2020 10:53:00 +0000 (UTC)
Date: Mon, 7 Sep 2020 11:52:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 17/17] hw/block/nvme: change controller pci id
Message-ID: <20200907105257.GH2682@work-vm>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-18-its@irrelevant.dk>
 <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
 <20200907103708.GG2682@work-vm>
 <20200907105024.GA732668@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200907105024.GA732668@apples.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Klaus Jensen (its@irrelevant.dk) wrote:
> On Sep  7 11:37, Dr. David Alan Gilbert wrote:
> > * Philippe Mathieu-DaudÃ© (philmd@redhat.com) wrote:
> > > +David in case
> > > 
> > > On 9/4/20 4:19 PM, Klaus Jensen wrote:
> > > > From: Klaus Jensen <k.jensen@samsung.com>
> > > > 
> > > > There are two reasons for changing this:
> > > > 
> > > >   1. The nvme device currently uses an internal Intel device id.
> > > > 
> > > >   2. Since commits "nvme: fix write zeroes offset and count" and "nvme:
> > > >      support multiple namespaces" the controller device no longer has
> > > >      the quirks that the Linux kernel think it has.
> > > > 
> > > >      As the quirks are applied based on pci vendor and device id, change
> > > >      them to get rid of the quirks.
> > > > 
> > > > To keep backward compatibility, add a new 'x-use-intel-id' parameter to
> > > > the nvme device to force use of the Intel vendor and device id. This is
> > > > off by default but add a compat property to set this for 5.1 machines
> > > > and older.
> > > 
> > > So now what happens if you start a 5.1 machine with a recent kernel?
> > > Simply the kernel will use unnecessary quirks, or are there more
> > > changes in behavior?
> > 
> > Seems reasonable to me...but...
> > 
> > > > 
> > > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > > > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  hw/block/nvme.c   | 12 ++++++++++--
> > > >  hw/block/nvme.h   |  1 +
> > > >  hw/core/machine.c |  1 +
> > > >  3 files changed, 12 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > > index 453d3a89d475..8018f8679366 100644
> > > > --- a/hw/block/nvme.c
> > > > +++ b/hw/block/nvme.c
> > > > @@ -2749,6 +2749,15 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
> > > >  
> > > >      pci_conf[PCI_INTERRUPT_PIN] = 1;
> > > >      pci_config_set_prog_interface(pci_conf, 0x2);
> > > > +
> > > > +    if (n->params.use_intel_id) {
> > > > +        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
> > > > +        pci_config_set_device_id(pci_conf, 0x5846);
> > 
> > Wasn't that magic number 5845 down there ?
> > 
> 
> Argh! My first version of this just bumbed the intel device id and it
> got left there.
> 
> Good find! Thank you!

It may be best to turn it into a constant in include/hw/pci/pci_ids.h if
it corresponds to some real Intel device.

Dave

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


