Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7247BC433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 16:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C3B20791
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 16:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C3B20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC44O-0004w6-Eb
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 12:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kC43p-0004Sh-3T
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 12:50:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:37428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kC43m-0001KQ-MI
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 12:50:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kC43k-0002gg-KB
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 16:50:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 946382E805D
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 16:50:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2020 16:45:06 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1892540@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: sparc testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gson laurent-vivier philmd
X-Launchpad-Bug-Reporter: Andreas Gustafsson (gson)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <159803735569.2614.10182276398047269277.malonedeb@chaenomeles.canonical.com>
Message-ID: <CAAdtpL4Pi3w+5awNrohmSpySsZhmmPFQeby+a1-=TT8mJ7ZQVw@mail.gmail.com>
Subject: [Bug 1892540] Re: [RFC PATCH v2] hw/display/tcx: Allow 64-bit
 accesses to framebuffer stippler and blitter
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="195cbfa84cb75815472f69dd83d46f006869050b"; Instance="production"
X-Launchpad-Hash: 634eab59090ee4bb3730d257a9b6a762cd3792c4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/29 12:50:32
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
Reply-To: Bug 1892540 <1892540@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200829164506.5kk3QCu7-WBjYlSB6Kgyvy4xuBRpcyO0Q5OBbR7YQVc@z>

Le sam. 29 ao=C3=BBt 2020 18:14, Michael <macallan1888@gmail.com> a =C3=A9c=
rit :

> Hello,
>
> since I wrote the NetBSD code in question, here are my 2 cent:
>
> On Sat, 29 Aug 2020 08:41:43 -0700
> Richard Henderson <richard.henderson@linaro.org> wrote:
>
> > On 8/22/20 7:21 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > The S24/TCX datasheet is listed as "Unable to locate" on [1].
>
> I don't have it either, but someone did a lot of reverse engineering
> and gave me his notes. The hardware isn't that complicated, but quite
> weird.
>
> > > However the NetBSD revision 1.32 of the driver introduced
> > > 64-bit accesses to the stippler and blitter [2]. It is safe
> > > to assume these memory regions are 64-bit accessible.
> > > QEMU implementation is 32-bit, so fill the 'impl' fields.
>
> IIRC the real hardware *requires* 64bit accesses for stipple and
> blitter operations to work. For stipples you write a 64bit word into
> STIP space, the address defines where in the framebuffer you want to
> draw, the data contain a 32bit bitmask, foreground colour and a ROP.
> BLIT space works similarly, the 64bit word contains an offset were to
> read pixels from, and how many you want to copy.
>

Thanks Michael for this information!
If you don't mind I'll amend it to the commit description so there is a
reference for posterity.

I'm waiting for *Andreas Gustafsson to test it then will repost.*


> have fun
> Michael
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1892540

Title:
  qemu can no longer boot NetBSD/sparc

Status in QEMU:
  New

Bug description:
  Booting NetBSD/sparc in qemu no longer works.  It broke between qemu
  version 5.0.0 and 5.1.0, and a bisection identified the following as
  the offending commit:

    [5d971f9e672507210e77d020d89e0e89165c8fc9] memory: Revert "memory:
  accept mismatching sizes in memory_region_access_valid"

  It's still broken as of 7fd51e68c34fcefdb4d6fd646ed3346f780f89f4.

  To reproduce, run

    wget http://ftp.netbsd.org/pub/NetBSD/NetBSD-9.0/images/NetBSD-9.0-spar=
c.iso
    qemu-system-sparc -nographic -cdrom NetBSD-9.0-sparc.iso -boot d

  The expected behavior is that the guest boots to the prompt

    Installation medium to load the additional utilities from:

  The observed behavior is a panic:

    [   1.0000050] system[0]: trap 0x29: pc=3D0xf0046b14 sfsr=3D0xb6 sfva=
=3D0x54000000
    [   1.0000050] cpu0: data fault: pc=3D0xf0046b14 addr=3D0x54000000 sfsr=
=3D0xb6<PERR=3D0x0,LVL=3D0x0,AT=3D0x5,FT=3D0x5,FAV,OW>
    [   1.0000050] panic: kernel fault
    [   1.0000050] halted

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1892540/+subscriptions

