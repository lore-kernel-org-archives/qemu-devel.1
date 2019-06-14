Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FFAC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C30C2183F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C30C2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbq8O-0003oA-DX
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hbpnl-0004FW-Sz
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hbpnk-00085a-KC
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:15:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:33732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hbpnj-0007yc-Am
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:15:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hbpnf-0007Gu-KH
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 17:15:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 958A42E80D7
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 17:15:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Jun 2019 17:07:04 -0000
From: Michal Suchanek <hramrach@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hramrach
X-Launchpad-Bug-Reporter: Michal Suchanek (hramrach)
X-Launchpad-Bug-Modifier: Michal Suchanek (hramrach)
Message-Id: <156053202418.26991.16452462538743379773.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18981";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 7b926ad54eb0cfa633602bbb2cc70ae84f2a6ea4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1832877] [NEW] qemu-bridge-helper undocumented
 and broken
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
Reply-To: Bug 1832877 <1832877@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

qemu output:

access denied by acl file
qemu-system-ppc64: bridge helper failed

Option description:

      -netdev bridge,id=3Did[,br=3Dbridge][,helper=3Dhelper]
           Connect a host TAP network interface to a host bridge device.

           Use the network helper helper to configure the TAP interface and=
 attach it to the bridge. The default network
           helper executable is /path/to/qemu-bridge-helper and the default=
 bridge device is br0.

           Examples:

                   #launch a QEMU instance with the default network helper =
to
                   #connect a TAP device to bridge br0
                   qemu-system-i386 linux.img -netdev bridge,id=3Dn1 -devic=
e virtio-net,netdev=3Dn1


                   #launch a QEMU instance with the default network helper =
to
                   #connect a TAP device to bridge qemubr0
                   qemu-system-i386 linux.img -netdev bridge,br=3Dqemubr0,i=
d=3Dn1 -device virtio-net,netdev=3Dn1


What is the acl file? What is the interface to qemu-bridge-helper?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1832877

Title:
  qemu-bridge-helper undocumented and broken

Status in QEMU:
  New

Bug description:
  qemu output:

  access denied by acl file
  qemu-system-ppc64: bridge helper failed

  Option description:

        -netdev bridge,id=3Did[,br=3Dbridge][,helper=3Dhelper]
             Connect a host TAP network interface to a host bridge device.

             Use the network helper helper to configure the TAP interface a=
nd attach it to the bridge. The default network
             helper executable is /path/to/qemu-bridge-helper and the defau=
lt bridge device is br0.

             Examples:

                     #launch a QEMU instance with the default network helpe=
r to
                     #connect a TAP device to bridge br0
                     qemu-system-i386 linux.img -netdev bridge,id=3Dn1 -dev=
ice virtio-net,netdev=3Dn1


                     #launch a QEMU instance with the default network helpe=
r to
                     #connect a TAP device to bridge qemubr0
                     qemu-system-i386 linux.img -netdev bridge,br=3Dqemubr0=
,id=3Dn1 -device virtio-net,netdev=3Dn1

  =

  What is the acl file? What is the interface to qemu-bridge-helper?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1832877/+subscriptions

