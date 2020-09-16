Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE389C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206EF22209
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206EF22209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVwH-0000Fs-9U
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIVo1-0000KF-Td
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:40:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:47048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIVnz-0007EP-Er
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:40:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kIVny-00008x-9I
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 11:40:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 44FDD2E80DC
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 11:40:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2020 11:34:20 -0000
From: Stefan Hajnoczi <1895399@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hcoin stefanha
X-Launchpad-Bug-Reporter: Harry Coin (hcoin)
X-Launchpad-Bug-Modifier: Stefan Hajnoczi (stefanha)
References: <159992963448.16886.7579356964954187024.malonedeb@soybean.canonical.com>
 <20200914100806.GC579094@stefanha-x1.localdomain>
 <5d7c2982-4282-d521-82d7-196468b45fee@gmail.com>
Message-ID: <20200916113420.GE756728@stefanha-x1.localdomain>
Subject: Re: [Bug 1895399] [NEW] Docfix: add missing virtiofsd cache default
 'auto'
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: de72e8cc2a7b4620abd2f9dcade4b716570d5c9b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 05:50:35
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
Reply-To: Bug 1895399 <1895399@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200916113420.xC1Dpqsa6883wEX-U-sLeuQrNQtetp0m-cv-6UbMgh0@z>

On Mon, Sep 14, 2020 at 02:53:57PM -0000, Harry Coin wrote:
> OK.=C2=A0 First time for everything:
> =

> Signed-off-by: Harry G. Coin <hgcoin@gmail.com>

Thank you. I posted your patch to the QEMU mailing list with your
authorship information:
https://patchew.org/QEMU/20200916112250.760245-1-stefanha@redhat.com/

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1895399

Title:
  Docfix: add missing virtiofsd cache default 'auto'

Status in QEMU:
  New

Bug description:
  The usage command line for virtiofsd has:

  void fuse_cmdline_help(void)
  {
      printf("    -h   --help                print help\n"
  ...
             "    -o cache=3D<mode>            cache mode. could be one of =
\"auto, "
             "always, none\"\n"
             "                               default: auto\n"

  =

  But the default: auto info is missing from the man page.  I suggest this =
patch:

  --- docs/tools/virtiofsd.rst    2020-09-10 18:07:45.380430677 -0500
  +++ /tmp/virtiofsd.rst  2020-09-12 11:48:10.440815204 -0500
  @@ -106,6 +106,7 @@
     forbids the FUSE client from caching to achieve best coherency at the =
cost of
     performance.  ``auto`` acts similar to NFS with a 1 second metadata ca=
che
     timeout.  ``always`` sets a long cache lifetime at the expense of cohe=
rency.
  +  The default is ``auto``.
   =

   Examples
   --------

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1895399/+subscriptions

