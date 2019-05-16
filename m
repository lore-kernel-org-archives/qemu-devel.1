Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C59C04E53
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A081B20843
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A081B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46911 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR5Yy-0002R2-W7
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 21:52:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hR5Xh-0001dK-8T
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hR5Xg-0000fE-1A
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:50:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:36284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hR5Xf-0000dg-Rp
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:50:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hR5Xc-00039A-Cz
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 01:50:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 37DFE2E80CB
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 01:50:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 May 2019 01:44:26 -0000
From: Jake Mikelson <1828508@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alpha76 stefanha
X-Launchpad-Bug-Reporter: Jake Mikelson (alpha76)
X-Launchpad-Bug-Modifier: Jake Mikelson (alpha76)
References: <155746839267.15002.8138674450166661929.malonedeb@wampee.canonical.com>
Message-Id: <155797106641.26747.10974187444352362382.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 7a245ff56aef212362961cfe6fae2b3878fc8263
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1828508] Re: qemu-img created VMDK files lead to
 "Unsupported or invalid disk type 7"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1828508 <1828508@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, I'm running 5.5.

I've been playing around with some of the options, and if I run the
below, I end up with 2 files.

qemu-img.exe convert "c:\test\AppD-VM01.vhd" -O vmdk -o
adapter_type=3Dlsilogic,subformat=3DmonolithicFlat -p "c:\test\AppD-
VM01.vmdk"

The files I get are:
AppD-VM01.vmdk (which is always 12kb)
AppD-VM01-flat.vmdk (which is the full size of the disk, eg 30GB).

If I then upload both of these files to the datastore, they somehow
merge into 1 and I can attach and power on the VM. If you dont upload
both files into the datastore, VMware does not recognise it.

This is the only method that seems to work for me.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1828508

Title:
  qemu-img created VMDK files lead to "Unsupported or invalid disk type
  7"

Status in QEMU:
  New

Bug description:
  Using qemu-img version 3.1.50 (v3.1.0-13607-geb2db0f7ba-dirty) on a
  Windows 10 machine.

  Converting a VHD to VMDK.
  qemu-img.exe convert "c:\test\AppD-VM01.vhd" -O vmdk -o adapter_type=3Dbu=
slogic -p "c:\test\AppD-VM01.vmdk"

  I have also tried:
  qemu-img.exe convert "c:\test\AppD-VM01.vhd" -O vmdk -o adapter_type=3Dbu=
slogic,hwversion=3D6 -p "c:\test\AppD-VM01.vmdk"

  Attaching the VMDK to a VM in VMware produces the following error when
  powering on.

  Power On virtual machine:Failed to open disk scsi0:1: Unsupported or inva=
lid disk type 7. Ensure that the disk has been imported.
  Target: MyVM1
  vCenter Server: VCENTER
  Error Stack
  An error was received from the ESX host while powering on VM MyVM1.
  Failed to start the virtual machine.
  Module DevicePowerOn power on failed. =

  Unable to create virtual SCSI device for scsi0:1, '/vmfs/volumes/5cca0155=
-bdddf31d-2714-00215acbeb1e/AppD-VM01/AppDdisk1-VM01.vmdk' =

  Failed to open disk scsi0:1: Unsupported or invalid disk type 7. Ensure t=
hat the disk has been imported.

  =

  If I do not specify the adapter type, it creates an IDE VMDK which works =
perfectly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1828508/+subscriptions

