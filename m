Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E38C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC5621548
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC5621548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpoU-0000rd-Jh
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jnpne-0008Je-KI
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:45:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:51958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jnpnc-0008Rs-5r
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:45:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jnpna-0002Es-65
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 20:45:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 10A0A2E810A
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 20:45:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2020 20:38:49 -0000
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
Message-ID: <18e784cc-82ec-0b03-911b-72961cb722cd@redhat.com>
Subject: [Bug 1884831] Re: qemu-nbd fails to discard bigger chunks
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 720aabcb8b2aa4e3370e1358cbed5ce71ac577bd
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 16:25:36
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
Reply-To: Bug 1884831 <1884831@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200623203849.RTYVdh7-pokBl6YI2df7UO1sQZLDT54YWepBwwaXoKI@z>

On 6/23/20 3:19 PM, TobiasHunger wrote:
> Public bug reported:
> =

> This report is moved from systemd to here:
> https://github.com/systemd/systemd/issues/16242
> =

> A qemu-nbd device reports that it can discard a lot of bytes:
> =

> cat /sys/block/nbd0/queue/discard_max_bytes
> 2199023255040

That smells fishy.  It is 0xffffffff * 512.  But in reality, the NBD =

protocol is (currently) capped at 32 bits, so it cannot handle any =

request 4G or larger.

It is not qemu-nbd that populates =

/sys/block/nbd0/queue/discard_max_bytes, but the kernel.  Are you sure =

this is not a bug in the kernel's nbd.ko module, where it may be the =

case that it is reporting -1 as a 32-bit value which then gets =

mistakenly turned into a faulty advertisement?  Can you tweak your =

software to behave as if /dev/nbd0 had a discard_max_bytes of 0xfffff000 =

instead?

In fact, to prove the bug is in the kernel's nbd.ko and not in qemu-nbd, =

I created an NBD server using nbdkit:

# modprobe nbd
# nbdkit memory 5G
# nbd-client -b 512 localhost /dev/nbd0
# cat /sys/block/nbd0/queue/discard_max_bytes
2199023255040

Same answer, different nbd server.  So it's not qemu's fault.

> =

> And indeed, discard works with small images:
> =

> $ qemu-img create -f qcow2 /tmp/image.img 2M
> $ sudo qemu-nbd --connect=3D/dev/nbd0 /tmp/image.img
> $ sudo blkdiscard /dev/nbd0
> =

> but not for bigger ones (still smaller than discard_max_bytes):
> =

> $ qemu-img create -f qcow2 /tmp/image.img 5G
> $ sudo qemu-nbd --connect=3D/dev/nbd0 /tmp/image.img
> $ sudo blkdiscard /dev/nbd0
> =

> ** Affects: qemu
>       Importance: Undecided
>           Status: New
> =


-- =

Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


** Bug watch added: github.com/systemd/systemd/issues #16242
   https://github.com/systemd/systemd/issues/16242

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

