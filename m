Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CABC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF59B207DA
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF59B207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgnKF-0005Sw-5R
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 06:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jgnJ5-0004a5-MS
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:41:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:38772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jgnJ3-0007yn-Ew
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:41:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jgnJ0-0005gA-NY
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 10:41:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id ADD582E8033
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 10:41:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2020 10:22:46 -0000
From: r1ng0hacking <1882065@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: r1ng0hacking
X-Launchpad-Bug-Reporter: r1ng0hacking (r1ng0hacking)
X-Launchpad-Bug-Modifier: r1ng0hacking (r1ng0hacking)
Message-Id: <159126616614.13200.9922024695272390145.malonedeb@soybean.canonical.com>
Subject: [Bug 1882065] [NEW] Could this cause OOB bug ?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e4d9deb22067c616204ff30e43a67e40b88931d5
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 06:41:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1882065 <1882065@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

In function megasas_handle_scsi(hw/scsi/megasas.c):

```c
static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
                               int frame_cmd)
{
    .......................................................................=
.....
    cdb =3D cmd->frame->pass.cdb;
    target_id =3D cmd->frame->header.target_id;
    lun_id =3D cmd->frame->header.lun_id;
    cdb_len =3D cmd->frame->header.cdb_len;
    .......................................................................=
.....
    if (cdb_len > 16) {
        trace_megasas_scsi_invalid_cdb_len(
                mfi_frame_desc[frame_cmd], is_logical,
                target_id, lun_id, cdb_len);
        megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
        cmd->frame->header.scsi_status =3D CHECK_CONDITION;
        s->event_count++;
        return MFI_STAT_SCSI_DONE_WITH_ERROR;
    }
}
```

Two variables, frame_cmd and cdb_len, can be controlled by guest os. So
can mfi_frame_desc[frame_cmd] cause OOB bug ?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882065

Title:
  Could this cause OOB bug ?

Status in QEMU:
  New

Bug description:
  In function megasas_handle_scsi(hw/scsi/megasas.c):

  ```c
  static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
                                 int frame_cmd)
  {
      .....................................................................=
.......
      cdb =3D cmd->frame->pass.cdb;
      target_id =3D cmd->frame->header.target_id;
      lun_id =3D cmd->frame->header.lun_id;
      cdb_len =3D cmd->frame->header.cdb_len;
      .....................................................................=
.......
      if (cdb_len > 16) {
          trace_megasas_scsi_invalid_cdb_len(
                  mfi_frame_desc[frame_cmd], is_logical,
                  target_id, lun_id, cdb_len);
          megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
          cmd->frame->header.scsi_status =3D CHECK_CONDITION;
          s->event_count++;
          return MFI_STAT_SCSI_DONE_WITH_ERROR;
      }
  }
  ```

  Two variables, frame_cmd and cdb_len, can be controlled by guest os.
  So can mfi_frame_desc[frame_cmd] cause OOB bug ?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1882065/+subscriptions

