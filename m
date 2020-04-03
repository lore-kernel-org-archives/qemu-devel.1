Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A15C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 05:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7751E206F5
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 05:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7751E206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKF01-00059N-Jp
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 01:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jKEzR-0004ii-Gq
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 01:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jKEzP-00081W-Id
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 01:35:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:50644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jKEzP-00080i-DD
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 01:35:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jKEzO-0000z1-21
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 05:35:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E1FB12E8107
 for <qemu-devel@nongnu.org>; Fri,  3 Apr 2020 05:35:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Apr 2020 05:28:59 -0000
From: Donghun Kwak <1870477@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kionias
X-Launchpad-Bug-Reporter: Donghun Kwak (kionias)
X-Launchpad-Bug-Modifier: Donghun Kwak (kionias)
References: <158589020097.22925.10247032490435356173.malonedeb@wampee.canonical.com>
Message-Id: <158589173927.21498.1306052969649668445.malone@gac.canonical.com>
Subject: [Bug 1870477] Re: qemu-arm hangs when golang running test
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8afd6b218165bdfcb92cd8142dc0eed3257a16cf
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
Reply-To: Bug 1870477 <1870477@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Attachment added: "success case log"
   https://bugs.launchpad.net/qemu/+bug/1870477/+attachment/5345419/+files/=
qemu_success.log

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1870477

Title:
  qemu-arm hangs when golang running test

Status in QEMU:
  New

Bug description:
  =

  1. Environment:
  Ubuntu 16.04.5 X86_64
  qemu-arm version 4.2.0
  go version go 1.14.1 linux/arm

  2. Summary:
  Sometimes "go run test.go" command hang

  =

  3. Reproduction Method (Attempts: 500 Occurred: 1 ): Frequency: 1/500

  =

  test.go
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  package main
  import "fmt"
  func main(){
          for i:=3D0; i<1000; i++ {
                  fmt.Printf("[%d] Hello world\n", i)
          }
  }
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  i tested "go run test.go" command called  500 times at qemu arm env.
  qemu hangs about 200~300.

  attached strace log.

  please check.
  thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1870477/+subscriptions

