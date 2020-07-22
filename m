Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68340C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 21:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2012086A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 21:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2012086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyMe3-0002P5-Hn
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 17:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jyMdJ-0001fB-EG
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 17:50:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:48718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jyMdH-0008Rq-5Q
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 17:50:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jyMdE-0005k8-SF
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 21:50:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A77632E80EF
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 21:50:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2020 21:41:26 -0000
From: Eric Blake <1884831@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: eblake tobias-hunger
X-Launchpad-Bug-Reporter: TobiasHunger (tobias-hunger)
X-Launchpad-Bug-Modifier: Eric Blake (eblake)
References: <159294358125.13789.3860026407311199131.malonedeb@wampee.canonical.com>
 <159294814773.16548.4367549975584519679.malone@chaenomeles.canonical.com>
Message-ID: <2be4be2c-bf5b-439c-a436-b6cb61fb13eb@redhat.com>
Subject: Re: [Bug 1884831] Re: qemu-nbd fails to discard bigger chunks
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f877c5162b568393e2d07ce948459ba0abc456fe";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1386001f6dadc705e5f536922aabfe67be200537
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 17:50:33
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
Reply-To: Bug 1884831 <1884831@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200722214126.8tiuf3TZpSJltqVLjD8FrBpdio0Kb4hg133P1957h-c@z>

On 6/23/20 4:35 PM, Eric Blake wrote:
> Let's get nbd.ko out of the picture.  The problem can be reproduced in
> user space (here, where I built qemu-nbd to log trace messages to
> stderr):
> =

> $ truncate --size=3D3G file
> $ qemu-nbd -f raw file --trace=3Dnbd_\*
> $ nbdsh -u nbd://localhost:10810 -c 'h.trim(3*1024*1024*1024,0)'

> nbd.Error: nbd_trim: trim: command failed: Input/output error (EIO)
> =


> =

> so this is definitely a case of qemu as NBD server NOT honoring requests
> between 2G and 4G.  I'll have a patch posted soon.

https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg06592.html

-- =

Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884831

Title:
  qemu-nbd fails to discard bigger chunks

Status in QEMU:
  New

Bug description:
  This report is moved from systemd to here:
  https://github.com/systemd/systemd/issues/16242

  A qemu-nbd device reports that it can discard a lot of bytes:

  cat /sys/block/nbd0/queue/discard_max_bytes
  2199023255040

  And indeed, discard works with small images:

  $ qemu-img create -f qcow2 /tmp/image.img 2M
  $ sudo qemu-nbd --connect=3D/dev/nbd0 /tmp/image.img
  $ sudo blkdiscard /dev/nbd0

  but not for bigger ones (still smaller than discard_max_bytes):

  $ qemu-img create -f qcow2 /tmp/image.img 5G
  $ sudo qemu-nbd --connect=3D/dev/nbd0 /tmp/image.img
  $ sudo blkdiscard /dev/nbd0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1884831/+subscriptions

