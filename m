Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23C6204EA
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ8TmtEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23C6204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj28g-0007cE-2I
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 10:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jj27i-0006l4-Cj
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 10:54:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jj27g-0004KP-2m
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 10:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591800873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLvYu9oaecgm6Jt4z0aNArWvZ/BaFtIzBNLg848yg1w=;
 b=eQ8TmtEOQBxFZjeFcsda/mJ2f/GkQ9jH3r45kjsxhiyJtEzuMnAFxQu/4PSvX31bSNr7h6
 PJKfwZ6TS6Bb+iz1u5bDJKGUzx72WwV5qZS4yWbvtWmao7b9E456frvNcc5lcY7GKC1AXl
 vzt3HkTb5LQgPtvhwxifxR3t0QKHD5E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-E9V14MJkNRW6GbfFVQ7NsA-1; Wed, 10 Jun 2020 10:54:32 -0400
X-MC-Unique: E9V14MJkNRW6GbfFVQ7NsA-1
Received: by mail-wr1-f72.google.com with SMTP id l18so1209044wrm.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 07:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZLvYu9oaecgm6Jt4z0aNArWvZ/BaFtIzBNLg848yg1w=;
 b=grcE91AJDk+oM0PcwuyMqRzsqjJtasQonHPhGZgNzdgaBjDbUjSauze1KnDEwml+xm
 MEu9/GUfyD55hvlznnZSwtDUFj6aigyGaoxQOy7J14HQ+KGKU8Onr4eN0yl8RKYtnujT
 ipY+iShyfsS864dYp1hujwDie2pHb1hgRKWeMCNs6S1GBXEgs/BXjBZhW1m7Ra+NMIAm
 fsLhjxBiV7q6zsAJfNw+otxS4TTEPKcMqd9H4gBwBvi1hEHbZYcnUSs6jq59/4LZNDIg
 nEA291GsBI3toazDmQBbAaIzqxbtV7YXFEJrnr8XLWsr1lPOA0mp44Ldu+Xpn9rUhXOO
 OVWw==
X-Gm-Message-State: AOAM531OO8Ze9QWk90sPgNHESSnpIE2ieCj9y9TKBWQYz79+6/9CDX3P
 7H6vyZ+vj2AThK0BLrX3+fJTHdDnhEBjrOuPnXe5DSobx5qOaScnBrqncnWk3m40YkuWl/6blKK
 i+brjPJiI5p2XtI0=
X-Received: by 2002:adf:9507:: with SMTP id 7mr4167659wrs.63.1591800870950;
 Wed, 10 Jun 2020 07:54:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6emzvCHe6nlVFXnhQfhyZp5fWS8zgms1FGzBN+9gHGm39kIXcLPL3UVo0cP2/l5e0PTTQCg==
X-Received: by 2002:adf:9507:: with SMTP id 7mr4167632wrs.63.1591800870718;
 Wed, 10 Jun 2020 07:54:30 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
 by smtp.gmail.com with ESMTPSA id q13sm30025wrn.84.2020.06.10.07.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 07:54:30 -0700 (PDT)
Date: Wed, 10 Jun 2020 10:54:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v7 0/9] acpi: i386 tweaks
Message-ID: <20200610105405-mutt-send-email-mst@kernel.org>
References: <20200610094131.13346-1-kraxel@redhat.com>
 <20200610134002.6461b40a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610134002.6461b40a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 01:40:02PM +0200, Igor Mammedov wrote:
> On Wed, 10 Jun 2020 11:41:22 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > First batch of microvm patches, some generic acpi stuff.
> > Split the acpi-build.c monster, specifically split the
> > pc and q35 and pci bits into a separate file which we
> > can skip building at some point in the future.
> > 
> It looks like series is missing patch to whitelist changed ACPI tables in
> bios-table-test.

Right. Does it pass make check?

> Do we already have test case for microvm in bios-table-test,
> if not it's probably time to add it.

Separately :)

> > v2 changes: leave acpi-build.c largely as-is, move useful
> > bits to other places to allow them being reused, specifically:
> > 
> >  * move isa device generator functions to individual isa devices.
> >  * move fw_cfg generator function to fw_cfg.c
> > 
> > v3 changes: fix rtc, support multiple lpt devices.
> > 
> > v4 changes:
> >  * drop merged patches.
> >  * split rtc crs change to separata patch.
> >  * added two cleanup patches.
> >  * picked up ack & review tags.
> > 
> > v5 changes:
> >  * add comment for rtc crs update.
> >  * add even more cleanup patches.
> >  * picked up ack & review tags.
> > 
> > v6 changes:
> >  * floppy: move cmos_get_fd_drive_type.
> >  * picked up ack & review tags.
> > 
> > v7 changes:
> >  * rebased to mst/pci branch, resolved stubs conflict.
> >  * dropped patches already queued up in mst/pci.
> >  * added missing sign-off.
> >  * picked up ack & review tags.
> > 
> > take care,
> >   Gerd
> > 
> > Gerd Hoffmann (9):
> >   acpi: move aml builder code for floppy device
> >   floppy: make isa_fdc_get_drive_max_chs static
> >   floppy: move cmos_get_fd_drive_type() from pc
> >   acpi: move aml builder code for i8042 (kbd+mouse) device
> >   acpi: factor out fw_cfg_add_acpi_dsdt()
> >   acpi: simplify build_isa_devices_aml()
> >   acpi: drop serial/parallel enable bits from dsdt
> >   acpi: drop build_piix4_pm()
> >   acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
> > 
> >  hw/i386/fw_cfg.h       |   1 +
> >  include/hw/block/fdc.h |   3 +-
> >  include/hw/i386/pc.h   |   1 -
> >  hw/block/fdc.c         | 111 +++++++++++++++++++++-
> >  hw/i386/acpi-build.c   | 211 ++---------------------------------------
> >  hw/i386/fw_cfg.c       |  28 ++++++
> >  hw/i386/pc.c           |  25 -----
> >  hw/input/pckbd.c       |  31 ++++++
> >  stubs/cmos.c           |   7 ++
> >  stubs/Makefile.objs    |   1 +
> >  10 files changed, 184 insertions(+), 235 deletions(-)
> >  create mode 100644 stubs/cmos.c
> > 


