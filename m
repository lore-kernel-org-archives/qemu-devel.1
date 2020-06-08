Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E3DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A99F206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A99F206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJkh-000747-Il
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jiJjZ-0006XJ-Ul
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:30:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:40368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jiJjY-0001c0-Lh
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:30:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jiJjW-0001kr-Fk
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 15:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7626C2E80BA
 for <qemu-devel@nongnu.org>; Mon,  8 Jun 2020 15:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2020 15:23:10 -0000
From: Eric Blake <1882350@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ide-hd
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: eblake winndows
X-Launchpad-Bug-Reporter: marshell (winndows)
X-Launchpad-Bug-Modifier: Eric Blake (eblake)
References: <159144063074.3735.15991486640962003601.malonedeb@soybean.canonical.com>
Message-ID: <c04b7074-85f5-d0c7-818c-69019d513192@redhat.com>
Subject: Re: [Bug 1882350] [NEW] it always create sdx device when I configure
 ide device with hdx name
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 763e82637a94104e2e628cb48bccce6b8ce69614
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 11:30:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1882350 <1882350@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200608152310.jkC0aGFcMnyeDMN7Z6QXbr74jFdQatZ-nAMgvoqgHHg@z>

On 6/6/20 5:50 AM, marshell wrote:
> Public bug reported:
> =

> I have configured 2 ide disks with name starting with hd, but when the
> vm boots up, it shows disks whose name starting with sd.

This looks more like a libvirt question than a qemu one.

> =

> 1. ide disks in vm xml:
> =

>      <disk type=3D'file' device=3D'disk'>
>        <driver name=3D'qemu' type=3D'raw'/>
>        <source file=3D'/data3_raw.qcow2'/>
>        <target dev=3D'hdc' bus=3D'ide'/>
>      </disk>
>      <disk type=3D'file' device=3D'disk'>
>        <driver name=3D'qemu' type=3D'qcow2'/>
>        <source file=3D'/data2.qcow2'/>
>        <target dev=3D'hdb' bus=3D'ide'/>
>      </disk>

The name that libvirt chooses to identify disks from the host =

perspective is independent...

> =

> =

> 2. in VM:
> =

> sda            8:0    0    2G  0 disk
> sdb            8:16   0    1G  0 disk

...from what the guest OS chooses to use.  Although there are many =

situations where a Linux guest will pick the same names as libvirt chose =

on the host side based on the transport (such as SCSI or virtio), there =

is no guarantee that this is always the case, nor that your guest is =

always running Linux as its OS.

-- =

Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882350

Title:
  it always create sdx device when I configure ide device with hdx name

Status in QEMU:
  New

Bug description:
  I have configured 2 ide disks with name starting with hd, but when the
  vm boots up, it shows disks whose name starting with sd.

  1. ide disks in vm xml:

      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'raw'/>
        <source file=3D'/data3_raw.qcow2'/>
        <target dev=3D'hdc' bus=3D'ide'/>
      </disk>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2'/>
        <source file=3D'/data2.qcow2'/>
        <target dev=3D'hdb' bus=3D'ide'/>
      </disk>

  =

  2. in VM:

  sda            8:0    0    2G  0 disk
  sdb            8:16   0    1G  0 disk

  =

  3. from vm.log:

  le=3D/data2.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-ide0-0-1 -device id=
e-
  hd,bus=3Dide.0,unit=3D1,drive=3Ddrive-ide0-0-1,id=3Dide0-0-1 -drive
  file=3D/data3_raw.qcow2,format=3Draw,if=3Dnone,id=3Ddrive-ide0-1-0 -device
  ide-hd,bus=3Dide.1,unit=3D0,drive=3Ddrive-ide0-1-0,id=3Dide0-1-0 -netdev t

  =

  4. rpm info: (I got the same issue on 2 diff envs)
  (1) env1
  qemu-kvm-1.5.3-105
  libvirt-3.2.0-14.el7
  (2) env2
  libvirt-5.9.0-1.el8
  qemu-4.1.0-1.el8

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1882350/+subscriptions

