Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BA8C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88D5208B3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88D5208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEZc0-0007SE-M1
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 10:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kEZbQ-0006tF-23
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 10:55:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:44560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kEZbN-0007L0-Gl
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 10:55:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kEZbL-0001iJ-8J
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 14:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 39FDD2E80DC
 for <qemu-devel@nongnu.org>; Sat,  5 Sep 2020 14:55:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2020 14:46:53 -0000
From: kallisti5 <1715203@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kallisti5 pmaydell th-huth
X-Launchpad-Bug-Reporter: kallisti5 (kallisti5)
X-Launchpad-Bug-Modifier: kallisti5 (kallisti5)
References: <150463414707.19543.9931062189110648888.malonedeb@chaenomeles.canonical.com>
Message-Id: <159931721389.11910.4787938131952045464.malone@chaenomeles.canonical.com>
Subject: [Bug 1715203] Re: Maintain Haiku support
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="90a5703803d95539bdb5c0b289b1675630569e1e"; Instance="production"
X-Launchpad-Hash: ec0ccb05ecc8d0576a1e9bb375bdc8877ba47b32
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 10:55:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1715203 <1715203@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ok..  a Haiku vm for QEMU is WIP here:

https://github.com/kallisti5/qemu/tree/haiku-test-vm


```
$ ./haiku.x86_64 --build-image --image /tmp/haiku.img
### Downloading disk image ...
### Preparing disk image ...
./box.img
100% repochecksum-1 [65 bytes]
Validating checksum for Haiku...done.
100% repocache-2 [4.25 KiB]
Validating checksum for Haiku...done.
100% repochecksum-1 [64 bytes]
Validating checksum for HaikuPorts...done.
100% repocache-2 [1.26 MiB]
Validating checksum for HaikuPorts...done.
The following changes will be made:
  in system:
    install package bzip2_devel-1.0.8-1 from repository HaikuPorts
    install package libgpg_error_devel-1.36-1 from repository HaikuPorts
    install package gettext-0.19.8.1-7 from repository HaikuPorts
    install package ncurses6_devel-6.2-1 from repository HaikuPorts
    install package libtasn1_devel-4.15.0-1 from repository HaikuPorts
    install package capstone-4.0.2-1 from repository HaikuPorts
    install package dtc-1.4.7-2 from repository HaikuPorts
    install package libffi_devel-3.2.1-6 from repository HaikuPorts
    install package libpcre_devel-8.44-1 from repository HaikuPorts
    install package libiconv_devel-1.16-1 from repository HaikuPorts
    install package lzo-2.10-2 from repository HaikuPorts
    install package nettle-3.5.1-1 from repository HaikuPorts
    install package pixman-0.38.4-1 from repository HaikuPorts
    install package snappy-1.1.7-2 from repository HaikuPorts
    install package libssh2-1.9.0-2 from repository HaikuPorts
    install package libusb-1.0.23-1 from repository HaikuPorts
    install package p11_kit-0.23.18.1-1 from repository HaikuPorts
    install package libunistring-0.9.10-1 from repository HaikuPorts
    install package libidn2-2.0.5-1 from repository HaikuPorts
    install package libtool_libltdl-2.4.6-2 from repository HaikuPorts
    install package file_data-5.38-1 from repository HaikuPorts
    install package libgcrypt_devel-1.8.5-1 from repository HaikuPorts
    install package glib2-2.62.0-3 from repository HaikuPorts
    install package capstone_devel-4.0.2-1 from repository HaikuPorts
    install package dtc_devel-1.4.7-2 from repository HaikuPorts
    install package lzo_devel-2.10-2 from repository HaikuPorts
    install package nettle_devel-3.5.1-1 from repository HaikuPorts
    install package pixman_devel-0.38.4-1 from repository HaikuPorts
    install package snappy_devel-1.1.7-2 from repository HaikuPorts
    install package libssh2_devel-1.9.0-2 from repository HaikuPorts
    install package libusb_devel-1.0.23-1 from repository HaikuPorts
    install package p11_kit_devel-0.23.18.1-1 from repository HaikuPorts
    install package gnutls-3.6.10-2 from repository HaikuPorts
    install package libsdl2-2.0.10-1 from repository HaikuPorts
    install package file-5.38-1 from repository HaikuPorts
    install package gnutls_devel-3.6.10-2 from repository HaikuPorts
    install package libsdl2_devel-2.0.10-1 from repository HaikuPorts
    install package python3-3.7.7-2 from repository HaikuPorts
    install package glib2_devel-2.62.0-3 from repository HaikuPorts
Continue? [yes/no] (yes) : yes
100% bzip2_devel-1.0.8-1-x86_64.hpkg [119.14 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/bzip2_devel-1.0.8-1-x86_64.hpkg...done.
100% libgpg_error_devel-1.36-1-x86_64.hpkg [57.73 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libgpg_error_devel-1.36-1-x86_64.hpkg...done.
100% gettext-0.19.8.1-7-x86_64.hpkg [12.16 MiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/gettext-0.19.8.1-7-x86_64.hpkg...done.
100% ncurses6_devel-6.2-1-x86_64.hpkg [844.82 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/ncurses6_devel-6.2-1-x86_64.hpkg...done.
100% libtasn1_devel-4.15.0-1-x86_64.hpkg [166.87 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libtasn1_devel-4.15.0-1-x86_64.hpkg...done.
100% capstone-4.0.2-1-x86_64.hpkg [1.80 MiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/capstone-4.0.2-1-x86_64.hpkg...done.
100% dtc-1.4.7-2-x86_64.hpkg [142.38 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/dtc-1.4.7-2-x86_64.hpkg...done.
100% libffi_devel-3.2.1-6-x86_64.hpkg [31.88 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libffi_devel-3.2.1-6-x86_64.hpkg...done.
100% libpcre_devel-8.44-1-x86_64.hpkg [1.26 MiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libpcre_devel-8.44-1-x86_64.hpkg...done.
100% libiconv_devel-1.16-1-x86_64.hpkg [901.83 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libiconv_devel-1.16-1-x86_64.hpkg...done.
100% lzo-2.10-2-x86_64.hpkg [166.74 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/lzo-2.10-2-x86_64.hpkg...done.
100% nettle-3.5.1-1-x86_64.hpkg [890.41 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/nettle-3.5.1-1-x86_64.hpkg...done.
100% pixman-0.38.4-1-x86_64.hpkg [1.43 MiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/pixman-0.38.4-1-x86_64.hpkg...done.
100% snappy-1.1.7-2-x86_64.hpkg [34.08 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/snappy-1.1.7-2-x86_64.hpkg...done.
100% libssh2-1.9.0-2-x86_64.hpkg [423.77 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libssh2-1.9.0-2-x86_64.hpkg...done.
100% libusb-1.0.23-1-x86_64.hpkg [50.38 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libusb-1.0.23-1-x86_64.hpkg...done.
100% p11_kit-0.23.18.1-1-x86_64.hpkg [987.54 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/p11_kit-0.23.18.1-1-x86_64.hpkg...done.
100% libunistring-0.9.10-1-x86_64.hpkg [610.86 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libunistring-0.9.10-1-x86_64.hpkg...done.
100% libidn2-2.0.5-1-x86_64.hpkg [196.76 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libidn2-2.0.5-1-x86_64.hpkg...done.
100% libtool_libltdl-2.4.6-2-x86_64.hpkg [64.24 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libtool_libltdl-2.4.6-2-x86_64.hpkg...done.
100% file_data-5.38-1-any.hpkg [300.96 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/file_data-5.38-1-any.hpkg...done.
100% libgcrypt_devel-1.8.5-1-x86_64.hpkg [158.77 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libgcrypt_devel-1.8.5-1-x86_64.hpkg...done.
100% glib2-2.62.0-3-x86_64.hpkg [4.10 MiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/glib2-2.62.0-3-x86_64.hpkg...done.
100% capstone_devel-4.0.2-1-x86_64.hpkg [1.03 MiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/capstone_devel-4.0.2-1-x86_64.hpkg...done.
100% dtc_devel-1.4.7-2-x86_64.hpkg [88.46 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/dtc_devel-1.4.7-2-x86_64.hpkg...done.
100% lzo_devel-2.10-2-x86_64.hpkg [314.15 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/lzo_devel-2.10-2-x86_64.hpkg...done.
100% nettle_devel-3.5.1-1-x86_64.hpkg [39.87 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/nettle_devel-3.5.1-1-x86_64.hpkg...done.
100% pixman_devel-0.38.4-1-x86_64.hpkg [1.81 MiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/pixman_devel-0.38.4-1-x86_64.hpkg...done.
100% snappy_devel-1.1.7-2-x86_64.hpkg [8.90 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/snappy_devel-1.1.7-2-x86_64.hpkg...done.
100% libssh2_devel-1.9.0-2-x86_64.hpkg [51.70 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libssh2_devel-1.9.0-2-x86_64.hpkg...done.
100% libusb_devel-1.0.23-1-x86_64.hpkg [378.12 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libusb_devel-1.0.23-1-x86_64.hpkg...done.
100% p11_kit_devel-0.23.18.1-1-x86_64.hpkg [19.07 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/p11_kit_devel-0.23.18.1-1-x86_64.hpkg...done.
100% gnutls-3.6.10-2-x86_64.hpkg [1.52 MiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/gnutls-3.6.10-2-x86_64.hpkg...done.
100% libsdl2-2.0.10-1-x86_64.hpkg [2.29 MiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libsdl2-2.0.10-1-x86_64.hpkg...done.
100% file-5.38-1-x86_64.hpkg [103.26 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/file-5.38-1-x86_64.hpkg...done.
100% gnutls_devel-3.6.10-2-x86_64.hpkg [285.23 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/gnutls_devel-3.6.10-2-x86_64.hpkg...done.
100% libsdl2_devel-2.0.10-1-x86_64.hpkg [294.06 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/libsdl2_devel-2.0.10-1-x86_64.hpkg...done.
100% python3-3.7.7-2-x86_64.hpkg [9.85 MiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/python3-3.7.7-2-x86_64.hpkg...done.
100% glib2_devel-2.62.0-3-x86_64.hpkg [395.96 KiB]
Validating checksum for https://eu.hpkg.haiku-os.org/haikuports/r1beta2/x86=
_64/current/packages/glib2_devel-2.62.0-3-x86_64.hpkg...done.
[system] Applying changes ...
[system] Changes applied. Old activation state backed up in "state_2020-09-=
05_14:46:23"
[system] Cleaning up ...
[system] Done.
### All done ...
```

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715203

Title:
  Maintain Haiku support

Status in QEMU:
  Incomplete

Bug description:
  It was pointed out that the 2.10 release notes are pushing to drop
  Haiku support.  The qemu port is currently working as-is under Haiku.

  Was there a reason this was recommended? Is there anything Haiku can
  do to keep it from being dropped?

  We're working on a docker container to cross-compile rust-lang for
  Haiku, could this be of some use to qemu when complete?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715203/+subscriptions

