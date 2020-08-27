Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCEAC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41863206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41863206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDdg-0002yg-Dm
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kBDd1-00029v-98
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:51:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:53074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kBDcy-0007mX-N1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:51:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kBDcw-0006e5-Qz
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 08:51:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CA4412E80EC
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 08:51:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2020 08:40:59 -0000
From: Mike Gelfand <1893003@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user ppc s390x
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mike.dld
X-Launchpad-Bug-Reporter: Mike Gelfand (mike.dld)
X-Launchpad-Bug-Modifier: Mike Gelfand (mike.dld)
References: <159842808665.2865.2216413646645324343.malonedeb@chaenomeles.canonical.com>
Message-Id: <159851765924.5796.7987398138944264389.malone@gac.canonical.com>
Subject: [Bug 1893003] Re: qemu linux-user doesn't translate host/target data
 for iovec I/O
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 706958fe38d73a08bb2684d62462af0b00e150fe
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 04:51:23
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
Reply-To: Bug 1893003 <1893003@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The attached patch fixes the issue for me, but is incomplete (and not
thoroughly tested) as I've only implemented inotify data translation for
readv syscall.

** Patch added: "qemu-5.0.0-inotify-readv.patch"
   https://bugs.launchpad.net/qemu/+bug/1893003/+attachment/5405134/+files/=
qemu-5.0.0-inotify-readv.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1893003

Title:
  qemu linux-user doesn't translate host/target data for iovec I/O

Status in QEMU:
  New

Bug description:
  When using iovec I/O functions (like `readv`), no data translation
  happens. I'm hitting this issue with libevent upon constructing a
  bufferevent over an inotify descriptor, and then building for either
  ppc64 or s390x (both big-endian) on x86_64 (little-endian) and running
  resulting code with qemu-ppc64 or qemu-s390x on Gentoo using latest
  QEMU version available (5.0.0-r2).

  The code in question is in
  https://github.com/transmission/transmission/blob/master/libtransmission
  /watchdir-inotify.c (`tr_watchdir_inotify_new`,
  `tr_watchdir_inotify_on_event`).

  While `read` syscall is handled properly, `readv` (which libevent is
  using in my case) doesn't have any logic to call
  `host_to_target_data_inotify` or any other translation function,
  leaving inotify data unchanged (with values in little-endian), which
  then leads to unit test failures. Quoting `do_syscall1` implementation
  bits for the reference:

  ---8<---begin---
      case TARGET_NR_read:
          if (arg2 =3D=3D 0 && arg3 =3D=3D 0) {
              return get_errno(safe_read(arg1, 0, 0));
          } else {
              if (!(p =3D lock_user(VERIFY_WRITE, arg2, arg3, 0)))
                  return -TARGET_EFAULT;
              ret =3D get_errno(safe_read(arg1, p, arg3));
              if (ret >=3D 0 &&
                  fd_trans_host_to_target_data(arg1)) {
                  ret =3D fd_trans_host_to_target_data(arg1)(p, ret);
              }
              unlock_user(p, arg2, ret);
          }
          return ret;
  ...
      case TARGET_NR_readv:
          {
              struct iovec *vec =3D lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
              if (vec !=3D NULL) {
                  ret =3D get_errno(safe_readv(arg1, vec, arg3));
                  unlock_iovec(vec, arg2, arg3, 1);
              } else {
                  ret =3D -host_to_target_errno(errno);
              }
          }
          return ret;
  ---8<---end---

  To reiterate, the issue is not only with `readv` but with other iovec
  functions as well.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1893003/+subscriptions

