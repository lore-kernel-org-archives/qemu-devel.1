Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686F6C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 06:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39480218DA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 06:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39480218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJBIV-0000lS-Cl
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 02:22:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBGz-0008Gs-2Y
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBGx-00013t-N6
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:44040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJBGx-000131-Gm
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJBGw-0007lo-Ic
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B4BE2E80CC
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:05:56 -0000
From: Thomas Huth <1813305@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: christophe-lyon pmaydell stefanha
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <154842501977.29408.13715859935418850955.malonedeb@soybean.canonical.com>
Message-Id:
 <155608595742.14092.14169597212291980221.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 347f0fc57f9c9999351c7d575ea51c6d8702f969
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1813305] Re: trace-root.h is not regerenerated
 after re-configure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1813305 <1813305@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424060556.5e-NUIsEhftur_p0B03BT_gbcphALD0SmI_Jy3N2wvA@z>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813305

Title:
  trace-root.h is not regerenerated after re-configure

Status in QEMU:
  Fix Released

Bug description:
  Hi,

  I've just realized that after I reconfigured my qemu with
  ../configure --target-list=3Darm-softmmu,arm-linux-user,aarch64-softmmu,a=
arch64-linux-user --enable-trace-backends=3Dsimple

  $ make
  did rebuild some stuff for the 'simple' trace, but it did not update trac=
e-root.h until after I
  $ make clean

  =

  I took me while to understand why I didn't get the traces I wanted (my tr=
ace-root.h still thought it was configured for the default 'log').

  I didn't check how easy it is to fix this in the build system.

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813305/+subscriptions

