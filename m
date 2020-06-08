Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D074BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 07:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3652206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 07:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3652206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiCKu-0007Dq-SY
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 03:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jiCJi-0006HT-6V
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 03:35:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:45340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jiCJg-0007d1-Qk
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 03:35:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jiCJe-00056Z-Kh
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 07:35:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 771112E80E7
 for <qemu-devel@nongnu.org>; Mon,  8 Jun 2020 07:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2020 07:30:10 -0000
From: Laurent Vivier <1882497@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier voltagex
X-Launchpad-Bug-Reporter: Adam Baxter (voltagex)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <159159970619.31789.307920822254818587.malonedeb@gac.canonical.com>
Message-Id: <159160141097.32347.17667526010393254030.malone@gac.canonical.com>
Subject: [Bug 1882497] Re: Missing 'cmp' utility makes build take 10 times as
 long
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2fa4e1dcf0a2435e9172cfdb44bffeea1b04f075
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 02:30:56
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
Reply-To: Bug 1882497 <1882497@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cmp is used in the makefiles.

And there is some kind of warning during build if it is missing:

/bin/sh: cmp: command not found

But perhaps it should abort the build in this case.

Something like that helps:

diff --git a/Makefile b/Makefile
index 40e4f7677bde..05e029bd99db 100644
--- a/Makefile
+++ b/Makefile
@@ -482,6 +482,7 @@ include $(SRC_PATH)/tests/Makefile.include
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-=
all modules $(vhost-user-json-y)
 =

 qemu-version.h: FORCE
+       @type cmp
        $(call quiet-command, \
                 (printf '#define QEMU_PKGVERSION "$(QEMU_PKGVERSION)"\n'; \
                printf '#define QEMU_FULL_VERSION "$(FULL_VERSION)"\n'; \

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882497

Title:
  Missing 'cmp' utility makes build take 10 times as long

Status in QEMU:
  New

Bug description:
  I have been doing some work cross compiling qemu for Windows using a
  minimal Fedora container. Recently I started hitting some timeouts on
  the CI service and noticed a build of all targets was going over 1
  hour.

  It seems like the 'cmp' utility from diffutils is used somewhere in
  the process and if it's missing, either a configure or a make gets run
  way too many times - I'll try to pull logs from the CI system at some
  stage soon.

  Could a warning or error be added if cmp is missing?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1882497/+subscriptions

