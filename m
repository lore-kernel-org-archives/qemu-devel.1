Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57540C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA1220639
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqlg+VxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA1220639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96BO-0006Jg-AT
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k96Ap-0005sl-Ku
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:29:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51505
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k96Al-0000fF-Sz
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598012970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ayHUNR7FkNNbjRHsCxZF+El/W0YLZ6yb/2lIIcCjfiU=;
 b=cqlg+VxB4EU3fnyVDXeJepajodozhxdfTSBKv21Wr+H7nZaxnM6Sye6ZsenaSp1NJ6SCt0
 DqHoA487HcVjQWb2uYUBUHs5arFUS7LEyxOhAW5SAgOpdlZu3VSYDj//oQcF/48qcedEp4
 wtWbT8nOxm1aocO9iGhpnlt9R+QUv9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-7Oyf0-RoNpyZQP_B5CezUw-1; Fri, 21 Aug 2020 08:29:28 -0400
X-MC-Unique: 7Oyf0-RoNpyZQP_B5CezUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C56C1074654
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:29:27 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A3F019D6C;
 Fri, 21 Aug 2020 12:29:16 +0000 (UTC)
Date: Fri, 21 Aug 2020 14:29:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH v2 0/4] Use ACPI PCI hot-plug for q35
Message-ID: <20200821142915.22da7f24@redhat.com>
In-Reply-To: <20200821123007.3d390d51@redhat.com>
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200821123007.3d390d51@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 12:30:07 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 18 Aug 2020 23:52:23 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
> 
> > PCIe native hot-plug has numerous problems with racing events and unpredictable
> > guest behaviour (Windows).  
> Documenting these misterious problems I've asked for  in previous review
> hasn't been addressed.
> Pls see v1 for comments and add requested info into cover letter at least
> or in a commit message.
> 
> 
> > Switching to ACPI hot-plug for now.
in addition to above it looks like the way it's implemented,
it's either all on or all off.
Don't we want to have it per bridge?
What about per port that's possible with native.

We also should document (other than in C) expectations
toward this feature.

> > 
> > Tested on RHEL 8 and Windows 2019.
> > pxb-pcie is not yet supported.
> > 
> > v2:
> >     * new ioport range for acpiphp [Gerd]
> >     * drop find_pci_host() [Igor]
> >     * explain magic numbers in _OSC [Igor]
> >     * drop build_q35_pci_hotplug() wrapper [Igor]
> > 
> > Julia Suvorova (4):
> >   hw/acpi/ich9: Trace ich9_gpe_readb()/writeb()
> >   hw/i386/acpi-build: Add ACPI PCI hot-plug methods to q35
> >   hw/i386/acpi-build: Turn off support of PCIe native hot-plug and SHPC
> >     in _OSC
> >   hw/acpi/ich9: Enable ACPI PCI hot-plug
> > 
> >  hw/i386/acpi-build.h    | 12 ++++++++++
> >  include/hw/acpi/ich9.h  |  3 +++
> >  include/hw/acpi/pcihp.h |  3 ++-
> >  hw/acpi/ich9.c          | 52 ++++++++++++++++++++++++++++++++++++++++-
> >  hw/acpi/pcihp.c         | 15 ++++++++----
> >  hw/acpi/piix4.c         |  2 +-
> >  hw/i386/acpi-build.c    | 48 +++++++++++++++++++++++--------------
> >  hw/i386/pc.c            |  1 +
> >  hw/acpi/trace-events    |  4 ++++
> >  9 files changed, 114 insertions(+), 26 deletions(-)
> >   
> 
> 


