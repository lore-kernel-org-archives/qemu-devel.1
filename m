Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C233C5518E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF4B2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF4B2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRLNv-0005f6-BT
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 15:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRLLz-0004RY-GC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRLLx-0004JX-Px
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:48:14 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:15113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jRLLx-00049i-A6; Wed, 22 Apr 2020 15:48:13 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 715DC746333;
 Wed, 22 Apr 2020 21:48:09 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 37845746331; Wed, 22 Apr 2020 21:48:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3630774633E;
 Wed, 22 Apr 2020 21:48:09 +0200 (CEST)
Date: Wed, 22 Apr 2020 21:48:09 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: qemu 4.2.0 audiodev soundhw
In-Reply-To: <7a90dead-ff67-589c-81a9-826c4d0bd86e@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2004222132390.22480@zero.eik.bme.hu>
References: <CA+enFJ=UmKNam-7T5J6UM6JGY7wy492MNm-d_-qKf7rLa818TQ@mail.gmail.com>
 <CAFEAcA_GqNAS-5+081vhpvn=Zk4qbD-SJz5SmN8s5_1_zerpAA@mail.gmail.com>
 <20200420144433.upkagl3qi3nc2lsj@sirius.home.kraxel.org>
 <CA+enFJkFN7B=-6k44Sb8XC2yAy2EGWoLCDMW0tA=GwwaxaspyA@mail.gmail.com>
 <d6c04095-8ea7-30c2-29f1-61c26aed835a@wisemo.com>
 <7a90dead-ff67-589c-81a9-826c4d0bd86e@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1963249636-1587584889=:22480"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 15:32:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 152.66.115.2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jakob Bohm <jb-gnumlists@wisemo.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1963249636-1587584889=:22480
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 22 Apr 2020, Philippe Mathieu-Daudé wrote:
> Hi Jakob,
>
> On 4/21/20 12:06 AM, Jakob Bohm wrote:
> [...]
>> 
>> In fact, over the years, I have found it excruciatingly difficult to find
>> valid qemu documentation, as each feature effort tends to leave behind
>> half-updated pages and a bunch of uncoordinated messages about what may or
>> may not have been implemented in unspecified versions.
> I feel your pain and agree.
>
> How can this get improved?
>
> Keeping the command line backward compatible is not an easy task.
>
> There is a quite important effort in progress to improve the documentation.
>
> Users reporting bad/incomplete/outdated documentation would help and motivate 
> developers to fix it. That would reduce the gap between developers 
> implementing features and users.
>
> Do you other have suggestions about what should be improved?

Not related to audio but something as simple as adding a disk is almost 
impossible for a newbie. See this thread for example:

https://lists.nongnu.org/archive/html/qemu-ppc/2020-04/msg00324.html

or this forum post:

https://www.emaculation.com/forum/viewtopic.php?f=34&t=10598

This should be easy to do but even I don't know what's the preferred 
option now and how to use it correctly. Fortunately the -hda and -cdrom 
options still work for some machines, although they produce a warning 
which I tend to ignore as long as it works or go for the long way which is 
impossible to type so I have to save it in a script:

-drive if=none,id=hd,file=harddisk.img,format=raw \
-device ide-hd,drive=hd,bus=ide.0

Probably there should be some sensible way to use QEMU from the command 
line and have some options that work and won't change all the time.

The current situation may be because the CLI and monitor interface that 
are primarily human interfaces are abused by management software as an API 
although probably those should use some real API instead to control QEMU 
and leave the human interface to humans which then can be less arcane and 
have more convenience options. However splitting human and software 
interfaces would probably result in them diverging and human interface 
being neglected and bitrotting so these should be somehow still based on 
some common ground and any change in machine interface should make sure 
human interface is not broken by it.

Regards,
BALATON Zoltan
--3866299591-1963249636-1587584889=:22480--

