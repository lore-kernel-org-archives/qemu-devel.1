Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F636C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1850720674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1850720674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPk1m-00058U-WA
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kPk0f-0004Rx-Kh
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:15:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:48398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kPk0b-0006M8-S7
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:15:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kPk0Z-0002Df-9e
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 10:15:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 471192E80EE
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 10:15:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2020 10:06:17 -0000
From: Chris <1880066@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=fedora; sourcepackage=qemu; component=None;
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: csl-ubuntuone jrcichra
X-Launchpad-Bug-Reporter: Justin Cichra (jrcichra)
X-Launchpad-Bug-Modifier: Chris (csl-ubuntuone)
References: <159011868752.31342.14577516157927235828.malonedeb@wampee.canonical.com>
Message-Id: <160197877808.13013.13910393346854002225.launchpad@gac.canonical.com>
Subject: [Bug 1880066] Re: Microphone input dies in guest when switching evdev
 input
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: 21375d8470785ceb4b0841bd6345a17406baac65
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 03:50:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1880066 <1880066@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Also affects: qemu (Fedora)
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880066

Title:
  Microphone input dies in guest when switching evdev input

Status in QEMU:
  New
Status in qemu package in Fedora:
  New

Bug description:
  justin@justin-3900x:~$ lsb_release -a
  No LSB modules are available.
  Distributor ID:	Ubuntu
  Description:	Ubuntu 20.04 LTS
  Release:	20.04
  Codename:	focal


  justin@justin-3900x:~$ apt list --installed | egrep '*qemu*|*kvm*'

  WARNING: apt does not have a stable CLI interface. Use with caution in
  scripts.

  ipxe-qemu-256k-compat-efi-roms/focal,focal,now 1.0.0+git-20150424.a25a16d=
-0ubuntu4 all [installed,automatic]
  ipxe-qemu/focal,focal,now 1.0.0+git-20190109.133f4c4-0ubuntu3 all [instal=
led,automatic]
  libvirt-daemon-driver-qemu/focal,now 6.0.0-0ubuntu8 amd64 [installed,auto=
matic]
  qemu-block-extra/focal-updates,focal-security,now 1:4.2-3ubuntu6.1 amd64 =
[installed,automatic]
  qemu-kvm/focal-updates,focal-security,now 1:4.2-3ubuntu6.1 amd64 [install=
ed]
  qemu-system-common/focal-updates,focal-security,now 1:4.2-3ubuntu6.1 amd6=
4 [installed,automatic]
  qemu-system-data/focal-updates,focal-updates,focal-security,focal-securit=
y,now 1:4.2-3ubuntu6.1 all [installed,automatic]
  qemu-system-gui/focal-updates,focal-security,now 1:4.2-3ubuntu6.1 amd64 [=
installed,automatic]
  qemu-system-x86/focal-updates,focal-security,now 1:4.2-3ubuntu6.1 amd64 [=
installed]
  qemu-utils/focal-updates,focal-security,now 1:4.2-3ubuntu6.1 amd64 [insta=
lled,automatic]
  qemu/focal-updates,focal-security,now 1:4.2-3ubuntu6.1 amd64 [installed]
  justin@justin-3900x:~$ =


  This did not happen in Eoan (qemu 4.0.0). I was able to switch in/out
  of a VM with my audio coming through fine. I enabled Eoan in my
  sources.list, downgraded all my qemu packages, and the issue was
  resolved.

  This happens on the latest Windows 10 guest when a sound device is
  listening for the microphone.

  /var/log/libvirt/qemu/<vmname>.log spews this error out when I switch
  with evdev (which is just the keyboard and mouse, the audio is passed
  through I assume spice):

  =

  audio: live=3D228193 hw->conv_buf->size=3D1920
  A bug was just triggered in audio_get_avail
  Context:
  audio: live=3D228675 sw->hw->conv_buf->size=3D1920
  A bug was just triggered in audio_pcm_hw_get_live_in
  Context:
  audio: live=3D228675 hw->conv_buf->size=3D1920
  A bug was just triggered in audio_get_avail
  Context:
  audio: live=3D229156 sw->hw->conv_buf->size=3D1920
  A bug was just triggered in audio_pcm_hw_get_live_in
  Context:
  audio: live=3D229156 hw->conv_buf->size=3D1920
  A bug was just triggered in audio_get_avail
  Context:
  audio: live=3D229638 sw->hw->conv_buf->size=3D1920
  A bug was just triggered in audio_pcm_hw_get_live_in
  Context:
  audio: live=3D229638 hw->conv_buf->size=3D1920
  A bug was just triggered in audio_get_avail
  Context:
  audio: live=3D230119 sw->hw->conv_buf->size=3D1920
  A bug was just triggered in audio_pcm_hw_get_live_in
  Context:
  audio: live=3D230119 hw->conv_buf->size=3D1920
  A bug was just triggered in audio_get_avail
  Context:
  audio: live=3D230600 sw->hw->conv_buf->size=3D1920
  A bug was just triggered in audio_pcm_hw_get_live_in
  Context:
  audio: live=3D230600 hw->conv_buf->size=3D1920
  A bug was just triggered in audio_get_avail
  Context:
  audio: live=3D231081 sw->hw->conv_buf->size=3D1920

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880066/+subscriptions

