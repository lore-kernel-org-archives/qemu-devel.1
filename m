Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523B2C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 11:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6DA206ED
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 11:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6DA206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbjFm-0000bE-7j
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 06:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbjDm-0008SB-3H
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 06:50:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:40614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbjDe-0003Of-Qh
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 06:50:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbjDc-0001Yy-Ja
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 11:50:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8A8DF2E8133
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 11:50:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 11:42:26 -0000
From: Christian Schoenebeck <1673957@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ekleog schoenebeck th-huth
X-Launchpad-Bug-Reporter: Leo Gaspard (ekleog)
X-Launchpad-Bug-Modifier: Christian Schoenebeck (schoenebeck)
References: <20170318123502.30244.36321.malonedeb@wampee.canonical.com>
Message-Id: <160483574654.29032.16971345686501809571.malone@chaenomeles.canonical.com>
Subject: [Bug 1673957] Re: virtfs: mapped-xattr on mount point
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 478eb5bab5782b68f780c7ac965e7bcdfc039a23
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 04:10:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-To: Bug 1673957 <1673957@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Independent of the planned tracker transition: this issue would require
more information by original reporter anyway.

>From the information provided so far, I cannot reproduce this problem,
and the error messages don't look like common misconfigurations on host
side like wrong permissions, AppArmor policies or something like that.
Especially the error message "Cannnot allocate memory" looks weird to
me. So I think there should at least be more details about the host
system this was deployed on.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673957

Title:
  virtfs: mapped-xattr on mount point

Status in QEMU:
  Incomplete

Bug description:
  With
    -virtfs local,path=3D"/tmp",security_model=3Dmapped-xattr,mount_tag=3D"=
shared2"
  in the qemu command line,
    shared2 on /mnt/testbis type 9p (rw,sync,dirsync,relatime,trans=3Dvirti=
o,version=3D9p2000.L,msize=3D262144)
  in the guest mount points, and
    tmpfs on /tmp type tmpfs (rw,nosuid,nodev)
  in the host mount points (with CONFIG_TMPFS_XATTR=3Dy according to zgrep =
/proc/config.gz), running qemu as user "vm-test", trying to "touch a" in /m=
nt/testbis on the VM fails with "Operation not supported". In addition, no =
file or directory actually present in the host's /tmp can be seen in the gu=
est's /mnt/testbis.

  When trying to replace "/tmp" with "/tmp/aaa" on the host, with
  /tmp/aaa owned by root:root, still running qemu as vm-test, trying to
  run "ls" in the guest's /mnt/testbis fails with the weird "ls: reading
  directory '.': Cannot allocate memory", while the directory is empty.

  After a "chown vm-test /tmp/aaa", the guest can list the files
  (despite the permissions already allowing it to do so before), but
  still not write new files: "cannot touch 'b': Operation not
  supported".

  Do you have a pointer as to what is happening?

  PS: complete setup is running all this inside a qemu VM that I use for
  testing, I guess it shouldn't matter but saying it just in case

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1673957/+subscriptions

