Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09796C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 18:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05E9206F0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 18:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05E9206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVJYn-0002Rb-UT
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 14:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jVJY1-0001kl-Qc
 for qemu-devel@nongnu.org; Sun, 03 May 2020 14:41:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:54496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jVJY0-00088Z-K7
 for qemu-devel@nongnu.org; Sun, 03 May 2020 14:41:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jVJXy-0002i9-6B
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 18:41:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E4D242E810C
 for <qemu-devel@nongnu.org>; Sun,  3 May 2020 18:41:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2020 18:32:19 -0000
From: Heiko Sieger <1856335@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: babumoger djdatte h-sieger
X-Launchpad-Bug-Reporter: Damir (djdatte)
X-Launchpad-Bug-Modifier: Heiko Sieger (h-sieger)
References: <157625616239.22064.10423897892496347105.malonedeb@gac.canonical.com>
Message-Id: <158853073981.4932.1299728933981092236.malone@soybean.canonical.com>
Subject: [Bug 1856335] Re: Cache Layout wrong on many Zen Arch CPUs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 10cb95f287c130c88f7fb534ac527bf9e1556e2f
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/03 14:10:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1856335 <1856335@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finally installed QEMU 5.0.0.154 - still the same. QEMU doesn't
recognize the L3 caches and still lists 3 L3 caches instead of 4 with 3
cores/6 threads.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856335

Title:
  Cache Layout wrong on many Zen Arch CPUs

Status in QEMU:
  New

Bug description:
  AMD CPUs have L3 cache per 2, 3 or 4 cores. Currently, TOPOEXT seems
  to always map Cache ass if it was an 4-Core per CCX CPU, which is
  incorrect, and costs upwards 30% performance (more realistically 10%)
  in L3 Cache Layout aware applications.

  Example on a 4-CCX CPU (1950X /w 8 Cores and no SMT):

  =C2=A0=C2=A0<cpu mode=3D'custom' match=3D'exact' check=3D'full'>
  =C2=A0=C2=A0=C2=A0=C2=A0<model fallback=3D'forbid'>EPYC-IBPB</model>
  =C2=A0=C2=A0=C2=A0=C2=A0<vendor>AMD</vendor>
  =C2=A0=C2=A0=C2=A0=C2=A0<topology sockets=3D'1' cores=3D'8' threads=3D'1'=
/>

  In windows, coreinfo reports correctly:

  ****----  Unified Cache 1, Level 3,    8 MB, Assoc  16, LineSize  64
  ----****  Unified Cache 6, Level 3,    8 MB, Assoc  16, LineSize  64

  On a 3-CCX CPU (3960X /w 6 cores and no SMT):

  =C2=A0<cpu mode=3D'custom' match=3D'exact' check=3D'full'>
  =C2=A0=C2=A0=C2=A0=C2=A0<model fallback=3D'forbid'>EPYC-IBPB</model>
  =C2=A0=C2=A0=C2=A0=C2=A0<vendor>AMD</vendor>
  =C2=A0=C2=A0=C2=A0=C2=A0<topology sockets=3D'1' cores=3D'6' threads=3D'1'=
/>

  in windows, coreinfo reports incorrectly:

  ****--  Unified Cache  1, Level 3,    8 MB, Assoc  16, LineSize  64
  ----**  Unified Cache  6, Level 3,    8 MB, Assoc  16, LineSize  64

  Validated against 3.0, 3.1, 4.1 and 4.2 versions of qemu-kvm.

  With newer Qemu there is a fix (that does behave correctly) in using the =
dies parameter:
  =C2=A0<qemu:arg value=3D'cores=3D3,threads=3D1,dies=3D2,sockets=3D1'/>

  The problem is that the dies are exposed differently than how AMD does
  it natively, they are exposed to Windows as sockets, which means, that
  if you are nto a business user, you can't ever have a machine with
  more than two CCX (6 cores) as consumer versions of Windows only
  supports two sockets. (Should this be reported as a separate bug?)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856335/+subscriptions

