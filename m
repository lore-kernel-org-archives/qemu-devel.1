Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB00AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A927A204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7TPhgvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A927A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiz9R-0001BN-W8
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 07:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jiz5r-0006SC-EF
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:40:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43757
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jiz5q-0007m9-6W
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591789229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vG98CKn2i9hHu4AEPLVFbPkB6Jo7xpLDzPyLpTgx4Mw=;
 b=P7TPhgvpPjUssObNNH33SP7wupRsJdSKBu3qgq7KxDJgZDICptZtx5jkM52m+4rTUBwF6M
 FgPEOo5bfXp+VIqKencMR9rah73D0dr7Ieta2OSbeZk10Tlkay3SFxJZuk6B43eZxnMn+7
 yaOxwt3BFT3Z5Q7XmW6zGd45Sfl8iRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-fZ_FfK6BOBqsxk44gXBlHQ-1; Wed, 10 Jun 2020 07:40:27 -0400
X-MC-Unique: fZ_FfK6BOBqsxk44gXBlHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CFC68018AB;
 Wed, 10 Jun 2020 11:40:26 +0000 (UTC)
Received: from localhost (unknown [10.40.208.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D759F19D82;
 Wed, 10 Jun 2020 11:40:06 +0000 (UTC)
Date: Wed, 10 Jun 2020 13:40:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v7 0/9] acpi: i386 tweaks
Message-ID: <20200610134002.6461b40a@redhat.com>
In-Reply-To: <20200610094131.13346-1-kraxel@redhat.com>
References: <20200610094131.13346-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
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
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jun 2020 11:41:22 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> First batch of microvm patches, some generic acpi stuff.
> Split the acpi-build.c monster, specifically split the
> pc and q35 and pci bits into a separate file which we
> can skip building at some point in the future.
> 
It looks like series is missing patch to whitelist changed ACPI tables in
bios-table-test.

Do we already have test case for microvm in bios-table-test,
if not it's probably time to add it.

> v2 changes: leave acpi-build.c largely as-is, move useful
> bits to other places to allow them being reused, specifically:
> 
>  * move isa device generator functions to individual isa devices.
>  * move fw_cfg generator function to fw_cfg.c
> 
> v3 changes: fix rtc, support multiple lpt devices.
> 
> v4 changes:
>  * drop merged patches.
>  * split rtc crs change to separata patch.
>  * added two cleanup patches.
>  * picked up ack & review tags.
> 
> v5 changes:
>  * add comment for rtc crs update.
>  * add even more cleanup patches.
>  * picked up ack & review tags.
> 
> v6 changes:
>  * floppy: move cmos_get_fd_drive_type.
>  * picked up ack & review tags.
> 
> v7 changes:
>  * rebased to mst/pci branch, resolved stubs conflict.
>  * dropped patches already queued up in mst/pci.
>  * added missing sign-off.
>  * picked up ack & review tags.
> 
> take care,
>   Gerd
> 
> Gerd Hoffmann (9):
>   acpi: move aml builder code for floppy device
>   floppy: make isa_fdc_get_drive_max_chs static
>   floppy: move cmos_get_fd_drive_type() from pc
>   acpi: move aml builder code for i8042 (kbd+mouse) device
>   acpi: factor out fw_cfg_add_acpi_dsdt()
>   acpi: simplify build_isa_devices_aml()
>   acpi: drop serial/parallel enable bits from dsdt
>   acpi: drop build_piix4_pm()
>   acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
> 
>  hw/i386/fw_cfg.h       |   1 +
>  include/hw/block/fdc.h |   3 +-
>  include/hw/i386/pc.h   |   1 -
>  hw/block/fdc.c         | 111 +++++++++++++++++++++-
>  hw/i386/acpi-build.c   | 211 ++---------------------------------------
>  hw/i386/fw_cfg.c       |  28 ++++++
>  hw/i386/pc.c           |  25 -----
>  hw/input/pckbd.c       |  31 ++++++
>  stubs/cmos.c           |   7 ++
>  stubs/Makefile.objs    |   1 +
>  10 files changed, 184 insertions(+), 235 deletions(-)
>  create mode 100644 stubs/cmos.c
> 


