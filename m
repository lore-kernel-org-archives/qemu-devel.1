Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF94C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76203221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUZD3nZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76203221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bij-0004HX-Ut
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3bi9-0003mN-TN
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:57:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42253
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3bi5-000393-Mj
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596704231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rygDcFkPh9b5lp96EJXFEnfH08ddcfG6TXX8jNBtxCs=;
 b=fUZD3nZjlQGP17kl4T4RERvkyYZJs8JgP2zXtunA+/BCQGsqr0l9of/ORwBcZgxsxU9cDm
 YNMZI7g4/9+b2poJfnw+dhMiF5hOb1uH2//20O21Y8UE/RPe+XNLXpWVIPf/Y+CRBA/ZMG
 18htpoxH5Ticr/F4rpN2pFE17g1J1h8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-LO_1xVg1M6KvW2YyL8-q9Q-1; Thu, 06 Aug 2020 04:57:10 -0400
X-MC-Unique: LO_1xVg1M6KvW2YyL8-q9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F3B810CE782;
 Thu,  6 Aug 2020 08:57:09 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-19.ams2.redhat.com [10.36.114.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDA6C87A44;
 Thu,  6 Aug 2020 08:57:07 +0000 (UTC)
Date: Thu, 6 Aug 2020 10:57:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.2 7/7] hw/block/fdc: Add ASCII art schema of QOM
 relations
Message-ID: <20200806085706.GB17753@linux.fritz.box>
References: <20200806080824.21567-1-f4bug@amsat.org>
 <20200806080824.21567-8-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200806080824.21567-8-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.08.2020 um 10:08 hat Philippe Mathieu-Daudé geschrieben:
> Without knowing the QEMU history, it is hard to relate QEMU objects
> with the hardware datasheet.
> 
> For example, one naively expects:
> 
> * a floppy disk is plugged / unplugged on the bus
> 
>   Wrong! QEMU floppy disks always sit on the bus. The block drives
>   are plugged / unplugged on the disks, and the disks magically
>   re-adapt their proprieties to match the block drive.

This is because what sits on the bus is not a floppy disk, but a floppy
drive. FloppyDrive is also what the type is called.

The disk is represented by the BlockDriverState (the actual image file)
that is inserted in the BlockBackend (which is logically part of the
drive).

> * a floppy controller has a fixed number of disks pluggable on the bus
> 
>   Wrong! QEMU floppy controllers have as much slots as the number of
>   floppy drive provided when a machine is created. Then the ACPI table
>   are generated and the number of slots can not be modified. So if you
>   expect a dual slot controller being created with slot A and B, if
>   the machine is created with a single drive attached, the controller
>   will only have slot A created, and you will never be able to plug
>   drive B without risking a mismatch in the ACPI tables.

Hm... I guess hotplugging floppy drives might actually have worked,
though I have never tried it on real hardware. I'm pretty sure it wasn't
an official feature, though, and ACPI tables certainly won't magically
change if you do this because (apart from polling, I guess) software has
no way to detect that you tinkered with the floppy cable. :-)

> * a floppy controller supporting 4 disks uses 2 buses
> 
>   Wrong! QEMU uses a single bus to plug the 4 disks.

But we don't even emulate floppy controllers that can have more than two
floppy drives:

    $ x86_64-softmmu/qemu-system-x86_64 -device floppy -device floppy -device floppy
    qemu-system-x86_64: -device floppy: Can't create floppy unit 2, bus supports only 2 units

This is checked in floppy_drive_realize(), so it applies to all
variants of the controller.

If you want more floppy drives, you have to create a second controller
(with a different iobase). Though I don't think I actually got this
working when I tried. I wasn't sure if the problem was the emulation or
the guest OSes (or SeaBIOS actually for DOS).

> As all these false assumptions are not obvious (we don't plug a disk,
> we plug a block drive into a disk, etc...), start documenting the QOM
> relationships with a simple ASCII schema.

Maybe be more specific to have: "floppy (drive)" and "blk (disk)".
Because the ASCII schema is actually true, though you seem to have
misunderstood what each item in it is supposed to represent.

Actually "blk (disk)" is not 100% accurate either because the drive
always has a BlockBackend present. It's really the BlockDriverState
inserted into the BlockBackend that is the disk.

In summary, to be honest, I believe since its qdevification, floppy is
one of the block devices that is modelled the best on the QOM + block
backend level. Only SCSI might be comparable, but IDE, virtio-blk and
usb-storage are a mess in comparison.

Kevin

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/block/fdc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 6944b06e4b..b109f37050 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -47,6 +47,28 @@
>  #include "qemu/module.h"
>  #include "trace.h"
>  
> +/*
> + * QOM relationship:
> + * =================
> + *
> + *                  +-------------------+
> + *                  |                   |
> + * isa/sysbus  <--->|                   |
> + *                  |                   |
> + *  irq/dma    <----|        fdc        |
> + *                  |
> + *      clk    ---->|                   |        +-+------+-+    +-+------+-+
> + *                  |                   |        | | blk  | |    | | blk  | |
> + *                  +--------+----------+        | |      | |    | |      | |
> + *                           |                   | +------+ |    | +------+ |
> + *                           |                   |          |    |          |
> + *                           |                   |  floppy  |    |  floppy  |
> + *                           |                   +----+-----+    +----+-----+
> + *                           |   floppy-bus           |               |
> + *                           +------------------------v---------------v---
> + *
> + */
> +
>  /********************************************************/
>  /* debug Floppy devices */
>  
> -- 
> 2.21.3
> 


