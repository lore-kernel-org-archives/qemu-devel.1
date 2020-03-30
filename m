Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B960C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0141F2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0141F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwTB-0006yn-4h
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jIwSD-0005xr-Pe
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jIwSC-0000ZI-LL
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:35:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:33056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jIwSC-0000Wl-Fu
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:35:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jIwSA-0006q1-RX
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 15:35:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A24082E80CB
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 15:35:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Mar 2020 15:28:12 -0000
From: elmarco <marcandre.lureau@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h marcandre-lureau
X-Launchpad-Bug-Reporter: Dr. David Alan Gilbert (dgilbert-h)
X-Launchpad-Bug-Modifier: elmarco (marcandre-lureau)
References: <158533956244.22377.11770713570863953031.malonedeb@wampee.canonical.com>
Message-Id: <158558209224.22570.4525716907220960334.malone@wampee.canonical.com>
Subject: [Bug 1869426] Re: 5.0rc0->4.2 serial migraiton
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 314a77a5d8c8787e3a1e959ae9facd7ae507ea86
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1869426 <1869426@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I thought backward migration wasn't supported.

Isn't it this commit?

commit 4cc017e505df7e5344e4dfe7fc17711117c5f11f
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Tue Oct 22 00:32:41 2019 +0200

    serial: register vmsd with DeviceClass
    =

    Migration from old to new code works, however the other way fails for
    devices that use serial_init/serial_mm_init with "base", used as
    instance_id previously.
    =

    (with qdev_set_legacy_instance_id, the alias_id is only used in
    savevm.c:find_se(), and thus can only be used to match against
    "legacy" instance id values. On new code, instance_id is generated
    incrementally from 0 with calculate_new_instance_id(), based on
    "qdev-path/vmsd-name")
    =

    Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Reviewed-by: xiaoqiang zhao <zxq_yx_007@163.com>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1869426

Title:
  5.0rc0->4.2 serial migraiton

Status in QEMU:
  New

Bug description:
  Migrating from 5.0rc0->4.2 with pc-q35-4.2 we get an error:

  Unknown savevm section or instance 'serial' 1

  dumping the migration streams it looks like 5.0 is duplicating the
  serial migration data:

      "serial (26)": {
          "divider": "0x000c",
          "rbr": "0x00",
          "ier": "0x00",
          "iir": "0x01",
          "lcr": "0x00",
          "mcr": "0x00",
          "lsr": "0x60",
          "msr": "0xb0",
          "scr": "0x00",
          "fcr_vmstate": "0x00"
      },
      "serial (27)": {
          "state": {
              "divider": "0x000c",
              "rbr": "0x00",
              "ier": "0x00",
              "iir": "0x01",
              "lcr": "0x00",
              "mcr": "0x00",
              "lsr": "0x60",
              "msr": "0xb0",
              "scr": "0x00",
              "fcr_vmstate": "0x00"
          }
      },

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1869426/+subscriptions

