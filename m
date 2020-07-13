Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC928C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844A5206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844A5206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvkR-0001U7-OQ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1juvjc-0000tM-J2
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:30:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:39772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1juvja-0007zi-Dh
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:30:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1juvjX-0007Ek-Kx
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9C1612E8105
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2020 10:25:26 -0000
From: John Arbuckle <1887318@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Won't Fix; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: audioprof2002 programmingkidx th-huth
X-Launchpad-Bug-Reporter: JuanPabloCuervo (audioprof2002)
X-Launchpad-Bug-Modifier: John Arbuckle (programmingkidx)
References: <159459945016.20204.12821765315233915598.malonedeb@chaenomeles.canonical.com>
Message-ID: <1435E68C-6844-455C-9A86-62835A7A1E2E@gmail.com>
Subject: Re: [Bug 1887318] [NEW] impossible to install in OSX Yosemite 10.10.5
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b7db6a06e0c03f5749a3e90e34a2ebaf2678be6c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 06:30:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1887318 <1887318@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200713102526.JnuQFskUF84YMhLiuNY_cIsSS_nKDL-AxT3W5KJ7o2A@z>

On Jul 12, 2020, at 10:02 PM, qemu-devel-request@nongnu.org wrote:

> Message: 6
> Date: Mon, 13 Jul 2020 00:17:30 -0000
> From: JuanPabloCuervo <1887318@bugs.launchpad.net>
> To: qemu-devel@nongnu.org
> Subject: [Bug 1887318] [NEW] impossible to install in OSX Yosemite
> 	10.10.5
> Message-ID:
> 	 =

> <159459945016.20204.12821765315233915598.malonedeb@chaenomeles.canonic =

> al.com>
> 	=

> Content-Type: text/plain; charset=3D"utf-8"
>
> Public bug reported:
>
> the Brew method has glib problems, glib is impossible to install.
> the MacPorts method has a very long .log file.
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> ** Attachment added: "main.log"
>    https://bugs.launchpad.net/bugs/1887318/+attachment/5392136/ =

> +files/main.log
>
> -- =

> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1887318
>
> Title:
>   impossible to install in OSX Yosemite 10.10.5
>
> Status in QEMU:
>   New
>
> Bug description:
>   the Brew method has glib problems, glib is impossible to install.
>   the MacPorts method has a very long .log file.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1887318/+subscriptions

This is why we need installer files for QEMU. They make life so much  =

easier than building from source.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1887318

Title:
  impossible to install in OSX Yosemite 10.10.5

Status in QEMU:
  Won't Fix

Bug description:
  the Brew method has glib problems, glib is impossible to install.
  the MacPorts method has a very long .log file.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1887318/+subscriptions

