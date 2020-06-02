Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3E6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D78206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D78206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6vQ-00039x-UC
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jg6uc-0002An-FI; Tue, 02 Jun 2020 09:25:02 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jg6ua-0003DP-27; Tue, 02 Jun 2020 09:25:01 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 50B5C74633E;
 Tue,  2 Jun 2020 15:24:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 29BA8746335; Tue,  2 Jun 2020 15:24:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 27F8B74632B;
 Tue,  2 Jun 2020 15:24:45 +0200 (CEST)
Date: Tue, 2 Jun 2020 15:24:45 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: Sam460Ex screen mode, audio and network
In-Reply-To: <4d64c939-3431-b637-488e-676a5f9171e5@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2006021510140.40694@zero.eik.bme.hu>
References: <CAD+yzTSr2edTNmzkGOH7todx7uVPbL_BSNSJPb62mJWCUSa8NA@mail.gmail.com>
 <4d64c939-3431-b637-488e-676a5f9171e5@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-367729106-1591104285=:40694"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 =?ISO-8859-15?Q?Andrea_Palmat=E8?= <andrea.palmate@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-367729106-1591104285=:40694
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hello,

On Tue, 2 Jun 2020, Philippe Mathieu-Daudé wrote:
> Cc'ing the sam460ex maintainer.
> On 6/1/20 8:01 PM, Andrea Palmatè wrote:
>> Hello, i've successfully configured AmigaOS4 on Qemu 5 and i've
>> installed it without any problem.

I assume you're aware of this page where you may find info and answers to 
some of your questions (see also the Comments section for tips):

http://zero.eik.bme.hu/~balaton/qemu/amiga/

>> It is working on an i5 laptop. I've tried to use the native screen mode
>> 1366x768 but it has some problems. It seems a stride problem and so is
>> not usable

I'm not sure if it's a problem on AmigaOS side or in emulation. How to 
reproduce this? Such resolution does not show up for me in ScreenMode 
prefs so cannot be simply selected.

>> Also the audio over sm502 is not working. (is it implemented?)

No, the sound part of sm502 is not yet implemented but you can add a PCI 
soundcard that works with AmigaOS with -device ES1370 command line option 
although sound may not be perfect and I don't know what causes that.

>> And also. OS4 has a support for RTL8139 but it seems not supported by
>> sam460ex. Is there a way to (try to) add it via source code in any way?

Similarly you can add the card with -device rtl8139 then also see the docs 
about different network options in QEMU:

https://wiki.qemu.org/Documentation/Networking

In particular, with the default user/slirp network the guest has outbound 
access but cannot be contacted and ping does not work so if you need those 
some other network option such as tap may be needed. Otherwise just for 
simple internet access from guest the default should be enough and 
simplest to set up.

Regards,
BALATON Zoltan
--3866299591-367729106-1591104285=:40694--

