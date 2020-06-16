Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BE5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7948E2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7948E2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlE6M-0007Ht-Np
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlE52-0005pn-6d
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:04:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:59580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlE4z-00042J-ND
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:04:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jlE4x-0004Hh-VS
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:04:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E68692E80BA
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:04:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2020 15:54:56 -0000
From: Bugs SysSec <1525123@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public Security
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: yes
X-Launchpad-Bug-Commenters: a1xndr bugs-syssec janitor joveler th-huth
X-Launchpad-Bug-Reporter: Hajin Jang (joveler)
X-Launchpad-Bug-Modifier: Bugs SysSec (bugs-syssec)
References: <20151211084346.25665.93589.malonedeb@gac.canonical.com>
Message-Id: <159232289697.28606.4346250006027651405.launchpad@soybean.canonical.com>
Subject: [Bug 1525123] Re: USB assert failure on hcd-uhci.c
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 3ac7f1ee2dcad0513d644b43cc30c8bfe71853e3
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 11:30:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1525123 <1525123@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Expired =3D> New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1525123

Title:
  USB assert failure on hcd-uhci.c

Status in QEMU:
  New

Bug description:
  When inserting the attached kernel moudle in the guest OS, QEMU quits
  with therse assert failure:

  [insert kernel module in guest root shell]
  root@qemu:~# insmod mymod.ko
  root@qemu:~#
  Connection closed by foreign host.

  [host message]
  qemu-system-x86_64: hw/usb/core.c:718: usb_ep_get: Assertion `pid =3D=3D =
0x69 || pid =3D=3D 0xe1' failed.
  Aborted

  The direct cause of this bug is due to misimplementation of UHCI.
  According to Intel's UHCI design guide, packet identification in transfer=
 descriptor must be one of these three values : IN (69h), OUT (E1h), and SE=
TUP (2Dh). Any other value in this field must cause the HALT of only HOST C=
ONTROLLER.

  However, due to misimplementation in uhci_handle_td, instead of host
  controller being halted, QEMU itself dies with assertion failure. The
  assertion code is in usb_ep_get():718, which is called during
  uhci_handle_td().

  Another issue resides in uhci_handle_td(). This function must check
  that transfer descriptor's pid is one of IN, OUT, SETUP before calling
  usb_ep_get() or other functions. If it does so, usb_ep_get() only
  needs to check if pid is not SETUP.

  This kind of assert failure can be misused by malwares to avoid being
  analyzed by terminating only in the virtual environments and still
  execute the malicious code in real machines.

  =

  [How to run exploit code]
  Prepare linux kernel's source header, then type these lines in root shell.
  # make
  # insmod mymod.ko

  It needs uhci-hcd.h from linux kernel source.
  I attached linux 3.18.24's uhci-hcd.h for tempory measure; You should get=
 proper version of uhci-hcd.h.
  In the following envrionment, this exploit worked, exiting whole QEMU, no=
t only USB.

  QEMU was running on these environment :
  [CPU model] Intel(R) Core(TM) i5-4590 CPU @ 3.30GHz
  [qemu version] QEMU 2.5.0-rc3 (compiled from source, gcc 4.8.4)
  [host info] Ubuntu 14.04.3, x86_64, 3.19.0-32-generic
  [guest info] Ubuntu 14.04.3, x86_64, 3.19.0-28-generic
  [QEMU argument]
  x86_64-softmmu/qemu-system-x86_64 -hda /media/hdd/img/ubuntu1404.qcow2 \
  =C2=A0-m 512 \
  =C2=A0--usbdevice disk:format=3Dqcow2:../usb.img \
  =C2=A0--enable-kvm

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1525123/+subscriptions

