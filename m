Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBA7C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8042067D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8042067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWlu-0007pG-Es
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kYWkk-0006nR-EZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:55:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:46604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kYWke-0004S9-Ck
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:55:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kYWkW-0003B2-1m
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 15:55:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DC47D2E813A
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 15:55:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2020 15:47:33 -0000
From: Jingtao <1902262@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jl939612
X-Launchpad-Bug-Reporter: Jingtao (jl939612)
X-Launchpad-Bug-Modifier: Jingtao (jl939612)
Message-Id: <160407285408.8291.17235632998408436942.malonedeb@soybean.canonical.com>
Subject: [Bug 1902262] [NEW] vmstate_load_state return error into virtio_load
 function
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: 6b1aad2093087b537c039d003cb721d71d40ee93
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 11:55:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1902262 <1902262@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Qemu version 4.2.1

In the function of virtio_load, the vmstate_load_state will return error
in the following case.

The virtio is legacy mode(disable-modern=3Don,disable-legacy=3Doff),
virtio_device is in reset state.

In the the function of "vmstate_load_state", it will load all subsection. F=
or the vmstate_virtio_extra_state subsection. =

It will execute:
vmstate_load_state   -->
          ret =3D field->info->get(f, curr_elem, size, field);    line 143 =
 vmstate.c.
           -->virtio_pci_load_extra_state
                        -->  vmstate_load_state
                                 -->qemu_peek_byte
But if the f->buf_index is same with buf_size, qemu_peek_byte function will=
 set "-EIO" error. =

the field->info->get will return 0, then it will get the error "ret =3D qem=
u_file_get_error(f);". then the vmstate_load_state will return error.

It output is "Failed to load virtio/extra_state:extra_state"

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1902262

Title:
  vmstate_load_state return error into virtio_load function

Status in QEMU:
  New

Bug description:
  Qemu version 4.2.1

  In the function of virtio_load, the vmstate_load_state will return
  error in the following case.

  The virtio is legacy mode(disable-modern=3Don,disable-legacy=3Doff),
  virtio_device is in reset state.

  In the the function of "vmstate_load_state", it will load all subsection.=
 For the vmstate_virtio_extra_state subsection. =

  It will execute:
  vmstate_load_state   -->
            ret =3D field->info->get(f, curr_elem, size, field);    line 14=
3  vmstate.c.
             -->virtio_pci_load_extra_state
                          -->  vmstate_load_state
                                   -->qemu_peek_byte
  But if the f->buf_index is same with buf_size, qemu_peek_byte function wi=
ll set "-EIO" error. =

  the field->info->get will return 0, then it will get the error "ret =3D q=
emu_file_get_error(f);". then the vmstate_load_state will return error.

  It output is "Failed to load virtio/extra_state:extra_state"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1902262/+subscriptions

