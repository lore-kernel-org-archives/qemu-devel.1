Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37ECC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77DC20748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77DC20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ys9-0006wu-06
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3yrA-0005m8-Fp
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:40:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:45062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3yr8-0003pu-FU
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:40:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k3yr7-0007gm-1n
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 09:40:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C901B2E8072
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 09:40:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 09:27:56 -0000
From: Thomas Huth <1196145@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: usb
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sascha-v th-huth
X-Launchpad-Bug-Reporter: Sascha Krissler (sascha-v)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20130629221252.20061.54827.malonedeb@chaenomeles.canonical.com>
Message-Id: <159679247659.2438.16403141290102906180.malone@gac.canonical.com>
Subject: [Bug 1196145] Re: usb-host: hostaddr=0XX is parsed as octal number
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 58c90fed98ad6854bc6e65874aa76c658ec2052b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1196145 <1196145@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looking through old bug tickets... is this still an issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1196145

Title:
  usb-host: hostaddr=3D0XX is parsed as octal number

Status in QEMU:
  Incomplete

Bug description:
  when doing

  device_add usb-host,hostaddr=3D010

  taking 010 in the format of both lsusb or udev, qemu parses an octal numb=
er and assumes hostaddr=3D8.
  (i used a 2.0 device on the ehci.0 bus)
  at least to me that is confusing.

  also:

  when adding a non-existent usb device (bogus hostaddr), the following
  is created according to 'usb info':

    Device 1.0, Port 1, Speed 1.5 Mb/s, Product USB Host Device

  in usb_qdev_init():
  usb_claim_port is called but usb_device_init does not report an error and=
 thus usb_release_port is not called.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1196145/+subscriptions

