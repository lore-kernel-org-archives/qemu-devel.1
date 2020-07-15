Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13734C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 06:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16CA2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 06:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WI5aFNED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16CA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvbNH-0007A4-6A
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 02:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jvbMi-0006kL-Vl
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 02:58:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58423
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jvbMh-0005Pb-Aa
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 02:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594796282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A/X9q745X4TZJyqgFsAm+a3nodpMUKQ2tPxpbSsJwLg=;
 b=WI5aFNEDyEN60NTmGRVXx/3O1W9SJ+9MlySe+hPIfHEnH5EJNwi0oO8Qchhfil8sWkhsdN
 BllD1IqmIDXKERvMs9S2xnKAXFAiwxQnW3JCU5Niz1EGvOF8E9I+Sd54YVs0j6Y7nvvdZQ
 nVVL4orZ9cLowE/pGht1yKRsrqxE8ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-qgwG0tVrMRO-PwwdMRw_2w-1; Wed, 15 Jul 2020 02:58:00 -0400
X-MC-Unique: qgwG0tVrMRO-PwwdMRw_2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71F24800C64;
 Wed, 15 Jul 2020 06:57:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E79219C4F;
 Wed, 15 Jul 2020 06:57:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D62454911; Wed, 15 Jul 2020 08:57:51 +0200 (CEST)
Date: Wed, 15 Jul 2020 08:57:51 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC PATCH 3/5] hw/i386/acpi-build: Add ACPI PCI hot-plug
 methods to q35
Message-ID: <20200715065751.ogchtdqmnn7cxsyi@sirius.home.kraxel.org>
References: <20200708224615.114077-1-jusual@redhat.com>
 <20200708224615.114077-4-jusual@redhat.com>
 <20200713163954.565722a5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200713163954.565722a5@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 04:39:54PM +0200, Igor Mammedov wrote:
> On Thu,  9 Jul 2020 00:46:13 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
> 
> > Implement notifications and gpe to support q35 ACPI PCI hot-plug.
> > The addresses specified in [1] remain the same to make fewer changes.
> > 
> > [1] docs/spec/acpi_pci_hotplug.txt
> 
> CCing Gerd his opinion on reusing piix4 IO port range for q35

Oh no, please don't.  Grabbing random io ports is asking for trouble,
especially on q35 where you only need enough pcie devices to have the
port range 0xae00 -> 0xae0f actually overlap with a pci bridge window.


Ideally we'll find some unused spot in the hidden pci bar of the ich9
pm device.  At least the qemu implementation has some room:

    0000000000000600-000000000000067f (prio 0, i/o): ich9-pm
      0000000000000600-0000000000000603 (prio 0, i/o): acpi-evt
      0000000000000604-0000000000000605 (prio 0, i/o): acpi-cnt
      0000000000000608-000000000000060b (prio 0, i/o): acpi-tmr
      0000000000000620-000000000000062f (prio 0, i/o): acpi-gpe0
      0000000000000630-0000000000000637 (prio 0, i/o): acpi-smi
      0000000000000660-000000000000067f (prio 0, i/o): sm-tco

Offset 0x40 seems to be unused for example (but better check the chipset
specs to see if that is really unused or whenever the qemu emulation is
incomplete).


If that doesn't work out pick an io range which is unlikely to conflict
with something.  That excludes anything above > 0x1000 (pci bridge
windows) and anything below 0x3ff (legacy isa).  From the remaining
range 0x400 -> 0xfff the 0xc00 -> 0xcff block is the best candidate
I think.  Because of the pci config registers being there it is unlikely
that the firmware places something in that range.

Oh, I see the cpu hotplug registers are already there:

    [ ... ]
    0000000000000700-000000000000073f (prio 1, i/o): pm-smbus
    0000000000000cd8-0000000000000ce3 (prio 0, i/o): acpi-cpu-hotplug
    0000000000000cf8-0000000000000cfb (prio 0, i/o): pci-conf-idx
    0000000000000cf9-0000000000000cf9 (prio 1, i/o): lpc-reset-control
    0000000000000cfc-0000000000000cff (prio 0, i/o): pci-conf-data
    [ ... ]

So placing the pci hotplug registers next to them (say at 0xcc8) looks
like a good pick to me.


While being at it:  Shouldn't we reserve these port ranges somehow?
Using an acpi device for example, simliar to fw_cfg?  The guest OS
should better know there is something at those ports ...

take care,
  Gerd


