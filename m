Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E51C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECFF206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECFF206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mQ3-0002is-2h
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mNC-0000ug-LL
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:21:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:53170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mN9-0008B2-5B
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:21:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k8mN5-0001mE-NY
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:20:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6B1292E8109
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:20:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2020 15:11:25 -0000
From: Thomas Huth <1882065@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: r1ng0hacking th-huth
X-Launchpad-Bug-Reporter: r1ng0hacking (r1ng0hacking)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <159126616614.13200.9922024695272390145.malonedeb@soybean.canonical.com>
Message-Id: <159793628655.5496.7676848055759559678.launchpad@gac.canonical.com>
Subject: [Bug 1882065] Re: Could this cause OOB bug ?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 8fcf0e5bc1b96791bc70a3870b902e75a35d27e7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 10:50:55
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
Reply-To: Bug 1882065 <1882065@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882065

Title:
  Could this cause OOB bug ?

Status in QEMU:
  Fix Released

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

