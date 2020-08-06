Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36095C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F6C22D07
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpHIFTEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F6C22D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3eeO-0006Lc-Ny
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 08:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3eda-0005rj-BM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:04:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3edY-0000Um-1D
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596715482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePPErK4KkLJ7QnlYemhHC6Vh8jk9w7U7JN9A+acR+/s=;
 b=BpHIFTEEmqS0avrulfqm0llI2ltxhNw6oaFS+861Se2IphmvsAJ5bMAghnYC07WV1p4CqZ
 UVOHJ+k5UB7QA3t/pH1f0kjyoUWis3aGQBDQLeI2gR762enZ3W2WBZmhw0GIHeXiIvFEhs
 CZbcAakBXjS4RJf8n3NepdUy/0jRcEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-Ns9V2IMmNH6pgkmcVYKcKw-1; Thu, 06 Aug 2020 08:04:41 -0400
X-MC-Unique: Ns9V2IMmNH6pgkmcVYKcKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22454801E6A;
 Thu,  6 Aug 2020 12:04:40 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-19.ams2.redhat.com [10.36.114.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E05DA7B904;
 Thu,  6 Aug 2020 12:04:38 +0000 (UTC)
Date: Thu, 6 Aug 2020 14:04:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.2 7/7] hw/block/fdc: Add ASCII art schema of QOM
 relations
Message-ID: <20200806120437.GE17753@linux.fritz.box>
References: <20200806080824.21567-1-f4bug@amsat.org>
 <20200806080824.21567-8-f4bug@amsat.org>
 <20200806085706.GB17753@linux.fritz.box>
 <71fc8f3f-97fb-a1de-a85c-fa6ef4b420bb@amsat.org>
MIME-Version: 1.0
In-Reply-To: <71fc8f3f-97fb-a1de-a85c-fa6ef4b420bb@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.08.2020 um 12:33 hat Philippe Mathieu-Daudé geschrieben:
> On 8/6/20 10:57 AM, Kevin Wolf wrote:
> > Am 06.08.2020 um 10:08 hat Philippe Mathieu-DaudÃƒÆ’Ã‚Â© geschrieben:
> >> Without knowing the QEMU history, it is hard to relate QEMU objects
> >> with the hardware datasheet.
> >>
> >> For example, one naively expects:
> >>
> >> * a floppy disk is plugged / unplugged on the bus
> >>
> >>   Wrong! QEMU floppy disks always sit on the bus. The block drives
> >>   are plugged / unplugged on the disks, and the disks magically
> >>   re-adapt their proprieties to match the block drive.
> > 
> > This is because what sits on the bus is not a floppy disk, but a floppy
> > drive. FloppyDrive is also what the type is called.
> > 
> > The disk is represented by the BlockDriverState (the actual image file)
> > that is inserted in the BlockBackend (which is logically part of the
> > drive).
> > 
> >> * a floppy controller has a fixed number of disks pluggable on the bus
> >>
> >>   Wrong! QEMU floppy controllers have as much slots as the number of
> >>   floppy drive provided when a machine is created. Then the ACPI table
> >>   are generated and the number of slots can not be modified. So if you
> >>   expect a dual slot controller being created with slot A and B, if
> >>   the machine is created with a single drive attached, the controller
> >>   will only have slot A created, and you will never be able to plug
> >>   drive B without risking a mismatch in the ACPI tables.
> > 
> > Hm... I guess hotplugging floppy drives might actually have worked,
> > though I have never tried it on real hardware. I'm pretty sure it wasn't
> > an official feature, though, and ACPI tables certainly won't magically
> > change if you do this because (apart from polling, I guess) software has
> > no way to detect that you tinkered with the floppy cable. :-)
> > 
> >> * a floppy controller supporting 4 disks uses 2 buses
> >>
> >>   Wrong! QEMU uses a single bus to plug the 4 disks.
> > 
> > But we don't even emulate floppy controllers that can have more than two
> > floppy drives:
> > 
> >     $ x86_64-softmmu/qemu-system-x86_64 -device floppy -device floppy -device floppy
> >     qemu-system-x86_64: -device floppy: Can't create floppy unit 2, bus supports only 2 units
> 
> This comment is for developers, the warning is for user.
> 
> It comes from:
> 
>     if (dev->unit >= MAX_FD) {
>         error_setg(errp, "Can't create floppy unit %d, bus supports "
>                    "only %d units", dev->unit, MAX_FD);
>         return;
>     }
> 
> But you can compile QEMU with MAX_FD=4:
> [...]

Ah, I wasn't aware that this was supposed to be changed.

I don't even have the spec here for a floppy controller that supports
four drives. My copy has "reserved" for those bits that apparently refer
to the additional drives (if the QEMU code is right).

> > This is checked in floppy_drive_realize(), so it applies to all
> > variants of the controller.
> > 
> > If you want more floppy drives, you have to create a second controller
> > (with a different iobase). Though I don't think I actually got this
> > working when I tried. I wasn't sure if the problem was the emulation or
> > the guest OSes (or SeaBIOS actually for DOS).
> > 
> >> As all these false assumptions are not obvious (we don't plug a disk,
> >> we plug a block drive into a disk, etc...), start documenting the QOM
> >> relationships with a simple ASCII schema.
> > 
> > Maybe be more specific to have: "floppy (drive)" and "blk (disk)".
> > Because the ASCII schema is actually true, though you seem to have
> > misunderstood what each item in it is supposed to represent.
> > 
> > Actually "blk (disk)" is not 100% accurate either because the drive
> > always has a BlockBackend present. It's really the BlockDriverState
> > inserted into the BlockBackend that is the disk.
> > 
> > In summary, to be honest, I believe since its qdevification, floppy is
> > one of the block devices that is modelled the best on the QOM + block
> > backend level. Only SCSI might be comparable, but IDE, virtio-blk and
> > usb-storage are a mess in comparison.
> 
> I'm sorry I didn't want to criticize the model or hurt you, I just want
> to note the differences between how the controller is described in the
> Intel 82078 datasheet and how the QEMU model works. Maybe I'm wrong
> assuming there would be a 1:1 match.

Sorry for not being clear. This isn't about criticism at all. I just
wanted to suggest that if you're trying to find out how to model new
devices, looking at floppy is probably a better start than looking at
most other block devices.

I don't know the floppy emulation well enough to say much about the
MAX_FD == 4 case, but the basic separation into controller and drive,
and that removable media are not represented in qdev, but just as block
nodes inserted into the BlockBackend of the drive, feels like the right
approach.

> I'll repost with the name updated in the schema and removing my
> assumptions from the commit description that appears as simple
> critics.

I think the most important part to fix in the commit message would be
the confusion between drives and disks.

Kevin


