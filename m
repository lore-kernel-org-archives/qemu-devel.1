Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D08EC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853CA2078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853CA2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDnx-0006Mj-JY
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kFDnQ-0005xO-VE
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:50:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:42532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kFDnO-0006R4-K3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:50:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kFDnM-0003lj-DJ
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 09:50:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 637492E8053
 for <qemu-devel@nongnu.org>; Mon,  7 Sep 2020 09:50:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2020 09:42:42 -0000
From: "Tony.LI" <1894617@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bigboy0822
X-Launchpad-Bug-Reporter: Tony.LI (bigboy0822)
X-Launchpad-Bug-Modifier: Tony.LI (bigboy0822)
Message-Id: <159947176304.11179.15547014994707599381.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1894617] [NEW] qemu-i386 mmap but offset greater than 32 bits
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="90a5703803d95539bdb5c0b289b1675630569e1e"; Instance="production"
X-Launchpad-Hash: f557d9c23c0dff9b5d20ce2b5b0960529aa8fc3e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:50:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-To: Bug 1894617 <1894617@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I don't know if it's a problem, but I did, and it bothered me for a long ti=
me.
When I use qemu-i386 and interact with the video card device,an error has o=
ccurred:

18534 ioctl(4,DRM_IOCTL_MODE_GETENCODER,{39,0,0,0,0}) =3D 0 ({39,4,34,3,0})
18534 ioctl(4,DRM_IOCTL_MODE_CREATE_DUMB,{1080,1920,32,0,0,0,0}) =3D 0 ({10=
80,1920,32,0,1,7680,8294400})
18534 ioctl(4,DRM_IOCTL_MODE_ADDFB,{0,1920,1080,7680,32,24,1}) =3D 0 ({66,1=
920,1080,7680,32,24,1})
18534 ioctl(4,DRM_IOCTL_MODE_MAP_DUMB,{1,0,0}) =3D 0 ({1,0,5543018496})
18534 mmap2(NULL,8294400,PROT_READ|PROT_WRITE,MAP_SHARED,4,0x14a63c) =3D -1=
 errno=3D22 (Invalid argument)

"5543018496" is the offset through ioctl() and it is "0x14a63c000".
In qemu=EF=BC=9A
ret =3D target_mmap(arg1, arg2, arg3,
      target_to_host_bitmask(arg4, mmap_flags_tbl),
      arg5, arg6 << MMAP_SHIFT);

The type of "arg6" is ulong.When use qemu-i386, arg6 can't be set to
"0x14a63c000".So it's wrong for my program.

I want to find a good way to deal with this kind of problem, but I'm not ve=
ry familiar with QEMU=EF=BC=8C
so I came to ask how to deal with this problem.

Thank you=EF=BC=81

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1894617

Title:
  qemu-i386 mmap but offset greater than 32 bits

Status in QEMU:
  New

Bug description:
  I don't know if it's a problem, but I did, and it bothered me for a long =
time.
  When I use qemu-i386 and interact with the video card device,an error has=
 occurred:

  18534 ioctl(4,DRM_IOCTL_MODE_GETENCODER,{39,0,0,0,0}) =3D 0 ({39,4,34,3,0=
})
  18534 ioctl(4,DRM_IOCTL_MODE_CREATE_DUMB,{1080,1920,32,0,0,0,0}) =3D 0 ({=
1080,1920,32,0,1,7680,8294400})
  18534 ioctl(4,DRM_IOCTL_MODE_ADDFB,{0,1920,1080,7680,32,24,1}) =3D 0 ({66=
,1920,1080,7680,32,24,1})
  18534 ioctl(4,DRM_IOCTL_MODE_MAP_DUMB,{1,0,0}) =3D 0 ({1,0,5543018496})
  18534 mmap2(NULL,8294400,PROT_READ|PROT_WRITE,MAP_SHARED,4,0x14a63c) =3D =
-1 errno=3D22 (Invalid argument)

  "5543018496" is the offset through ioctl() and it is "0x14a63c000".
  In qemu=EF=BC=9A
  ret =3D target_mmap(arg1, arg2, arg3,
        target_to_host_bitmask(arg4, mmap_flags_tbl),
        arg5, arg6 << MMAP_SHIFT);

  The type of "arg6" is ulong.When use qemu-i386, arg6 can't be set to
  "0x14a63c000".So it's wrong for my program.

  I want to find a good way to deal with this kind of problem, but I'm not =
very familiar with QEMU=EF=BC=8C
  so I came to ask how to deal with this problem.

  Thank you=EF=BC=81

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1894617/+subscriptions

