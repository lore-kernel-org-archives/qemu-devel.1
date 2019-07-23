Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE94C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 19:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58097218F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 19:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58097218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq0Zi-0002b2-Ej
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 15:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58281)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hq0ZX-0002C8-W8
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 15:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hq0ZW-0002i0-Oo
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 15:35:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:57604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hq0ZW-0002hY-IQ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 15:35:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hq0ZV-0003gp-0g
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 19:35:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EA0912E80CE
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 19:35:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jul 2019 19:28:46 -0000
From: Sven R <1776920@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: eblake jaywang0tw jnsnow mmoole paelzer wkozaczuk
X-Launchpad-Bug-Reporter: Waldemar Kozaczuk (wkozaczuk)
X-Launchpad-Bug-Modifier: Sven R (mmoole)
References: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
Message-Id: <156391012624.14933.15429937830412165143.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 8a4a5c44b8fc643d92ceaf0d71c873e55c71d715
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1776920] Re: qemu-img convert on Mac OSX creates
 corrupt images
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
Reply-To: Bug 1776920 <1776920@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I recently ran into problems and after a long time trying to find out the c=
ause landed here, I got in trouble using a CentOs Cloud image:
https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1905.=
qcow2.xz
which extracts to a .qcow2 image with sha256 of:
b376afdc0150601f15e53516327d9832216e01a300fecfc302066e36e2ac2b39

image: CentOS-7-x86_64-GenericCloud-1905.qcow2
file format: qcow2
virtual size: 8.0G (8589934592 bytes)
disk size: 898M
cluster_size: 65536
Format specific information:
    compat: 0.10
    refcount bits: 16

I use this command on a Mac, OS X 10.13.6 (17G7024), qemu installed via bre=
w:
qemu-img convert -f qcow2 -O vmdk -o adapter_type=3Dlsilogic,subformat=3Dst=
reamOptimized,compat6=3Don -p CentOS-7-x86_64-GenericCloud-1905.qcow2 -S 0 =
result.vmdk


941359104 21 Jul 17:11 CentOS-7-x86_64-GenericCloud-1905.qcow2 - original i=
mage

Converting this gives these results:
214551040 23 Jul 20:45 conv_mac_v3_1_mit_s_0.vmdk - doesnt work, made on Ma=
c (APFS) with -S 0 =

402303488 23 Jul 20:50 conv_mac_v3_1_auf_exfat.vmdk - works and is bootable=
, made on same Mac, on external drive, exFAT formatted.
149743104 23 Jul 21:21 conv_mac_v4_0.vmdk - doesnt work, made on Mac (APFS)=
 without -S 0 =

214551040 23 Jul 21:20 conv_mac_v4_0mit_S0.vmdk - doesnt work, made on Mac =
(APFS) with -S 0 =


converting on non-Mac also works fine:
402303488 23 Jul 18:48 conv_centos7_v1-5-3.vmdk - works and is bootable, ma=
de on Centos, qemu-img version 1.5.3

So it seems that '-S 0' didn't fix it for me, or is that only in the
development branch?

Best Regards

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776920

Title:
  qemu-img convert on Mac OSX creates corrupt images

Status in QEMU:
  New

Bug description:
  An image created by qemu-img create, then modified by another program
  is converted to bad/corrupt image when using convert sub command on
  Mac OSX. The same convert works on Linux. The version of qemu-img is
  2.12.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776920/+subscriptions

