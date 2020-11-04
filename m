Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAD9C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CAF20735
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CAF20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaS1b-0005KB-DU
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 18:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaS0f-000478-8G
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 18:16:09 -0500
Received: from indium.canonical.com ([91.189.90.7]:41044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaS0d-0002ZA-BB
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 18:16:08 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaS0a-0001E5-9B
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 23:16:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DBC0E2E8148
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 23:16:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 23:04:47 -0000
From: John Snow <1817239@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow laurent-vivier umarcor
X-Launchpad-Bug-Reporter: umarcor (umarcor)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <155080581544.22842.8774442486795126526.malonedeb@wampee.canonical.com>
Message-Id: <160453108787.29032.15755295759980829067.malone@chaenomeles.canonical.com>
Subject: [Bug 1817239] Re: add '--targets' option to qemu-binfmt-conf.sh
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 079c6c75521c295d6bf78baf8c12da14a85e2221
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 17:35:34
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
Reply-To: Bug 1817239 <1817239@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series appears to have stalled as of v7:
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04241.html --
moving back to 'New' status.


** Changed in: qemu
       Status: In Progress =3D> New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1817239

Title:
  add '--targets' option to qemu-binfmt-conf.sh

Status in QEMU:
  New

Bug description:
  I'd like to ask for the addition of option '--targets' to scripts
  /qemu-binfmt-conf.sh, in order to allow registering the interpreters
  for the given list of architectures only, instead of using all of the
  ones defined in qemu_target_list. The following is a possible patch
  that implements it:

   qemu-binfmt-conf.sh | 9 ++++++++-
   1 file changed, 8 insertions(+), 1 deletion(-)

  diff --git a/qemu-binfmt-conf.sh b/qemu-binfmt-conf.sh
  index b5a1674..be4a19b 100644
  --- a/qemu-binfmt-conf.sh
  +++ b/qemu-binfmt-conf.sh
  @@ -170,6 +170,7 @@ usage() {
   Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                              [--help][--credential yes|no][--exportdir PAT=
H]
                              [--persistent yes|no][--qemu-suffix SUFFIX]
  +                           [--targets TARGETS]

          Configure binfmt_misc to use qemu interpreter

  @@ -189,6 +190,8 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debia=
n][--systemd CPU]
          --persistent:  if yes, the interpreter is loaded when binfmt is
                         configured and remains in memory. All future uses
                         are cloned from the open file.
  +       --targets:     comma-separated list of targets. If provided, only
  +                      the targets in the list are registered.

       To import templates with update-binfmts, use :

  @@ -324,7 +327,7 @@ CREDENTIAL=3Dno
   PERSISTENT=3Dno
   QEMU_SUFFIX=3D""

  -options=3D$(getopt -o ds:Q:S:e:hc:p: -l debian,systemd:,qemu-path:,qemu-=
suffix:,exportdir:,help,credential:,persistent: -- "$@")
  +options=3D$(getopt -o ds:Q:S:e:hc:p:t: -l debian,systemd:,qemu-path:,qem=
u-suffix:,exportdir:,help,credential:,persistent:,targets: -- "$@")
   eval set -- "$options"

   while true ; do
  @@ -380,6 +383,10 @@ while true ; do
           shift
           PERSISTENT=3D"$1"
           ;;
  +    -t|--targets)
  +        shift
  +        qemu_target_list=3D"$(echo "$1" | tr ',' ' ')"
  +        ;;
       *)
           break
           ;;
  --
  2.20.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1817239/+subscriptions

