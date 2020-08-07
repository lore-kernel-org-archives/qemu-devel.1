Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA180C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 20:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78247214F1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 20:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78247214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k48wd-00008R-OB
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 16:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k48vt-0007u3-VG
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 16:25:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:51116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k48vr-0003Ax-NM
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 16:25:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k48vq-0000MF-69
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 20:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 001F42E808D
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 20:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 20:15:20 -0000
From: =?utf-8?q?Sebasti=C3=A1n_Lacuesta?= <1415181@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sebastianlacuesta th-huth ubuntu-weilnetz
X-Launchpad-Bug-Reporter: =?utf-8?q?Sebasti=C3=A1n_Lacuesta_=28sebastianlac?=
 =?utf-8?q?uesta=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Sebasti=C3=A1n_Lacuesta_=28sebastianlac?=
 =?utf-8?q?uesta=29?=
References: <20150127194148.12487.20751.malonedeb@soybean.canonical.com>
 <159682290589.9587.15452218650313573549.malone@wampee.canonical.com>
Message-Id: <CAKKr7JQSBxNiwVqEdu-vRRvmvw_QNLcHbxgFnr=9QP9-8q_7Ow@mail.gmail.com>
Subject: Re: [Bug 1415181] Re: Access raw partitions from Windows
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ac537c1886adb088b6727e142ad612c68b8faa25
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
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
Reply-To: Bug 1415181 <1415181@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Well, it's not an issue for me, but is a nice to have feature. I don't use
the tablet in question anymore. The tablet had an uefi that didn't allow
pendrive boot, but if it could be done what I proposed with qemu, a linux
distro could be booted with qemu and this installed manually in a
partition. The Uefi of the tablet did allow a grub install and also I could
install another bootloader, but any of them recognized pendrives.
So, personally I don't care anymore for now. But would allow a beautiful
method to override insane manufacturers setups.
Thanks, regards!
Sebasti=C3=A1n

El vie., 7 ago. 2020 a las 15:05, Thomas Huth (<1415181@bugs.launchpad.net>)
escribi=C3=B3:

> Looking through old bug tickets... is this still an issue with the
> latest version of QEMU? Or could we close this ticket nowadays?
>
>
> ** Changed in: qemu
>        Status: New =3D> Incomplete
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1415181
>
> Title:
>   Access raw partitions from Windows
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1415181/+subscriptions
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1415181

Title:
  Access raw partitions from Windows

Status in QEMU:
  Incomplete

Bug description:
  I'm using a windows tablet that makes imposible usb booting. It would be =
nice to have access to raw partitions in order to run linux installers usin=
g qemu. I can successfully install several boot loaders using uefi, so I gu=
es this feature would be very helpful.
  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1415181/+subscriptions

