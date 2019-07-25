Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BB7C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119CE2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119CE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqeIQ-0001YT-Mg
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56362)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hqeIF-00015v-2J
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hqeIE-0007oE-4v
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:00:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hqeID-0007nx-Vc
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:00:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B102EC057F88;
 Thu, 25 Jul 2019 14:00:24 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E48705C22F;
 Thu, 25 Jul 2019 14:00:23 +0000 (UTC)
Date: Thu, 25 Jul 2019 08:00:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190725080023.24de0d82@x1.home>
In-Reply-To: <20190725064244-mutt-send-email-mst@kernel.org>
References: <155364082689.15803.7062874513041742278.stgit@gimli.home>
 <20190329104904.450fefef@x1.home>
 <dbe614f5-47c8-b05d-dd73-2fbcd1579ae3@amd.com>
 <20190723112618.0efafa8d@x1.home> <20190724071439.GB18771@xz-x1>
 <20190724040837-mutt-send-email-mst@kernel.org>
 <20190724100331.GA14454@xz-x1> <20190724084355.627d44cf@x1.home>
 <20190725063733.GH14454@xz-x1>
 <20190725064244-mutt-send-email-mst@kernel.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 25 Jul 2019 14:00:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] pci: Use PCI aliases when determining
 device IOMMU address space
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
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <zhexu@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 06:43:04 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jul 25, 2019 at 02:37:33PM +0800, Peter Xu wrote:
> > After re-read Michael's reply, I feel like what Michael suggested is
> > that we can simply ignore the bus-number-change case by the guest OS
> > for now, but I might be wrong.  
> That's what I suggested, yes.

"by the guest OS", yes, that's the part that's beyond the scope of this
effort.  If we deem it necessary to support IVHD DMA alias though, it's
the guest firmware that determines the initial bus numbers, which is
part of the DeviceID used to defined IVHD entries and we would not be
able to ignore that initial programming.  Everything related to the
guest OS renumber PCI buses is out of scope, the guest firmware
programming initial bus numbers is not.  Thanks,

Alex

