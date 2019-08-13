Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F374BC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BC820840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BC820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxVY7-00040x-Uu
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47795)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hxVXN-0003Uw-0Z
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hxVXL-0003U5-Pq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:04:24 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:57266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hxVXL-0003T7-Jm
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:04:23 -0400
Received: from player791.ha.ovh.net (unknown [10.108.54.52])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 248ED13F2D1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 14:04:20 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id 8FEC38B60102;
 Tue, 13 Aug 2019 12:04:13 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20190813065920.23203-1-david@gibson.dropbear.id.au>
 <CAFEAcA9-oo-LCrhUdCzV7MZvwyTeT6sxQFt9B0JEaT7FE4tidA@mail.gmail.com>
 <CAFEAcA_wpGVhZ4VG8kK=+Akonww5FHcy2C6ZQ+Sp6YDs7pYH3g@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e74a364d-2091-7667-f896-2ff173584614@kaod.org>
Date: Tue, 13 Aug 2019 14:04:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_wpGVhZ4VG8kK=+Akonww5FHcy2C6ZQ+Sp6YDs7pYH3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12052758505190034329
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddruddviedggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.41.146
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-4.1 queue 20190813
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/08/2019 13:45, Peter Maydell wrote:
> On Tue, 13 Aug 2019 at 10:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 13 Aug 2019 at 07:59, David Gibson <david@gibson.dropbear.id.au> wrote:
>>>
>>> The following changes since commit 5e7bcdcfe69ce0fad66012b2cfb2035003c37eef:
>>>
>>>   display/bochs: fix pcie support (2019-08-12 16:36:41 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190813
>>>
>>> for you to fetch changes up to 310cda5b5e9df642b19a0e9c504368ffba3b3ab9:
>>>
>>>   spapr/xive: Fix migration of hot-plugged CPUs (2019-08-13 16:50:30 +1000)
>>>
>>> ----------------------------------------------------------------
>>> ppc patch queue 2019-08-13 (last minute qemu-4.1 fixes)
>>>
>>> Here's a very, very last minute pull request for qemu-4.1.  This fixes
>>> two nasty bugs with the XIVE interrupt controller in "dual" mode
>>> (where the guest decides which interrupt controller it wants to use).
>>> One occurs when resetting the guest while I/O is active, and the other
>>> with migration of hotplugged CPUs.
>>>
>>> The timing here is very unfortunate.  Alas, we only spotted these bugs
>>> very late, and I was sick last week, delaying analysis and fix even
>>> further.
>>>
>>> This series hasn't had nearly as much testing as I'd really like, but
>>> I'd still like to squeeze it into qemu-4.1 if possible, since
>>> definitely fixing two bad bugs seems like an acceptable tradeoff for
>>> the risk of introducing different bugs.
>>
>> Are these regressions? Are they security issues?
>>
>> We are going to have an rc5 today, but my intention was to only put in
>> the security-fix bug in the bochs display device, and then have
>> a final release Thursday.
> 
> After thinking about this and reading the commit messages I've
> applied this pullreq, since it clearly only affects spapr and you're
> in a better position to judge the significance of the fixes than me,
> but it was really really borderline...

I was going to reply but you were faster to apply. Here is some more
context.

The XIVE interrupt mode is activated by default in 4.1. So these are 
regressions w.r.t to the previous mode spapr was using referred as 
XICS. Specially the first patch.

The second patch is a fix for the restoration of the hot-plugged CPUs.
The restoration of the spapr machine became more complex with the 
XIVE interrupt controller because when we need the machine state to be 
loaded to know which KVM IRQ device to activate, XICS or XIVE. From 
there we can restore the KVM states and HW contexts of the different 
models in use, sources, controllers and presenters. 

The post_load handler of the spapr machine relies on the fact that 
it is called last and does the work for all models. I realized last 
evening that this is not true for hot-plugged CPUs which state come 
after the machine. I was under the assumption/impression this was 
not the case but I might be mistaken. It took me while to get the 
save/restore sequences correct. 


Thanks,

C.


