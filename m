Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9318CC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653692084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653692084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHQXv-00017A-JE
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 06:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iHQWd-0000dp-Q5
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iHQWc-0006yy-MQ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:45:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:42882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iHQWc-0006wl-H6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:45:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iHQWb-0002CO-AN
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 10:45:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 421EF2E8025
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 10:45:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Oct 2019 10:30:24 -0000
From: John Arbuckle <programmingkidx@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: programmingkidx th-huth
X-Launchpad-Bug-Reporter: John Arbuckle (programmingkidx)
X-Launchpad-Bug-Modifier: John Arbuckle (programmingkidx)
References: <20160915151441.12160.56338.malonedeb@gac.canonical.com>
 <157043427479.9599.2536129012233487125.malone@wampee.canonical.com>
Message-Id: <4DA13DF4-DBAF-4C5C-B024-50886D2B9F5F@gmail.com>
Subject: Re: [Bug 1623998] Re: pulseaudio Invalid argument error
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d3487b2ca8f78d3ed5116a631a384e0c2cb56c8d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1623998 <1623998@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here is the output. I assumed you meant qemu-system-ppc.

$ ./ppc-softmmu/qemu-system-ppc -audio-help
Environment variable based configuration deprecated.
Please use the new -audiodev option.

Equivalent -audiodev to your current environment variables:
(Since you didn't specify QEMU_AUDIO_DRV, I'll list all possibilities)
-audiodev id=3Doss,driver=3Doss
-audiodev id=3Dnone,driver=3Dnone

> On Oct 7, 2019, at 3:44 AM, Thomas Huth <1623998@bugs.launchpad.net> wrot=
e:
> =

> What output do you get when you run "qemu-system-x86_64 -audio-help" ?
> Could you provide your full command line, please?
> =

> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1623998
> =

> Title:
>  pulseaudio Invalid argument error
> =

> Status in QEMU:
>  Incomplete
> =

> Bug description:
>  When using qemu-system-ppc on Ubuntu Mate 15 with the usb audio card,
>  I see these error messages:
> =

>  pulseaudio: set_sink_input_volume() failed
>  pulseaudio: Reason: Invalid argument
>  pulseaudio: set_sink_input_mute() failed
>  pulseaudio: Reason: Invalid argument
> =

>  No audio plays. When an attempt is made, QEMU seems to freeze for a
>  moment.
> =

>  I use "-device usb-audio" to add the usb sound card. This issue is
>  present in both emulation and KVM mode.
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1623998/+subscriptions

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1623998

Title:
  pulseaudio Invalid argument error

Status in QEMU:
  Incomplete

Bug description:
  When using qemu-system-ppc on Ubuntu Mate 15 with the usb audio card,
  I see these error messages:

  pulseaudio: set_sink_input_volume() failed
  pulseaudio: Reason: Invalid argument
  pulseaudio: set_sink_input_mute() failed
  pulseaudio: Reason: Invalid argument

  No audio plays. When an attempt is made, QEMU seems to freeze for a
  moment.

  I use "-device usb-audio" to add the usb sound card. This issue is
  present in both emulation and KVM mode.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1623998/+subscriptions

