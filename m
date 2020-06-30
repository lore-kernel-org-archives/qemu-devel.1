Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA48C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 01:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02ABB2078A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 01:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02ABB2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq57h-0008SO-AM
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 21:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jq56l-0007v2-7r; Mon, 29 Jun 2020 21:30:47 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:20981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jq56i-0007dV-H0; Mon, 29 Jun 2020 21:30:46 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4B8C974594E;
 Tue, 30 Jun 2020 03:30:40 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1BD3D745712; Tue, 30 Jun 2020 03:30:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1876D7456F8;
 Tue, 30 Jun 2020 03:30:40 +0200 (CEST)
Date: Tue, 30 Jun 2020 03:30:40 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/4] smbus: Fix spd_data_generate() error API violation
In-Reply-To: <87lfk5n9vp.fsf@dusky.pond.sub.org>
Message-ID: <alpine.BSF.2.22.395.2006300310570.32453@zero.eik.bme.hu>
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004221622140.19234@zero.eik.bme.hu>
 <0af0e0f0-8127-da83-d9d2-89a3fe28f778@redhat.com>
 <alpine.BSF.2.22.395.2004222053070.22480@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006261315070.94870@zero.eik.bme.hu>
 <87k0ztrn9m.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2006271320590.53209@zero.eik.bme.hu>
 <87lfk5n9vp.fsf@dusky.pond.sub.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 21:30:40
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020, Markus Armbruster wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> On Sat, 27 Jun 2020, Markus Armbruster wrote:
>>> Quick reply without having thought through the issues at all: I'm not
>>
>> Does that mean you'll reply later with more detail or this is all you
>> had to say about this? (Just to know if I should wait for another
>> reply.)
>
> Not sure I can find the time before the soft freeze.  Best not to wait
> for me.

OK I'm not sure my mac_oldworld patches can be finished or would be merged 
before the freeze anyway and this was already broken in 5.0 so it's not 
that urgent now but I'll need this in the future so eventually should 
find some way to come to an agreement.

>>> opposed to you doing work to enable additional or even arbitrary memory
>>> sizes where these actually work.  I'm first and foremost opposed to me
>>> wasting time on "improving" code that is not used for anything.  That's
>>> why I dumbed down spd_data_generate().
>>
>> It was used by sam460ex until moving ram allocation to memdev broke it.
>>
>>> Secondly, I'm opposed to QEMU "correcting" user configuration.  I want
>>> QEMU do exactly what it's told, and fail with a clear error message when
>>> that is not possible.  The error message may include hints for the user
>>> on how to correct the configuration.
>>
>> I don't agree with that. It's already hard enough for non-expert users
>> to figure out the needed command line switches, making that even
>> harder by throwing back an error for everything that could work just
>> not exactly specified is needlessly annoying them further. To the
>> point of chasing them away from using QEMU. A lot of people prefer
>> VMWare or VirtualBox for this reason and only try QEMU if there's no
>> other way.
>
> We don't have to agree on everything.  I'm not the QEMU CLI dictator.
> The status quo is pretty clear, though:
>
>    $ qemu-system-ppc64 -help
>    [...]
>    -m [size=]megs[,slots=n,maxmem=size]
>                    configure guest RAM
>                    size: initial amount of guest memory
>    [...]
>
> It says "Initial amount of guest memory", not "Approximate amount of
> guest memory" or something like that.
>
> If we decide we want to change it from "Initial amount of guest memory"
> to some "do what I mean" behavior, then that behavior needs to be
> documented.

This is sufficiently vague that it says "initial" which to me means it's 
not absolute and can change while the VM is running so a change due to fix 
up fits in that in my opinion :-)

> Moreover, if DWIM is appropriate for one machine, it's probably
> appropriate for all of them.  The CLI should be as consistent as we can
> make it across machines.

That's the point. Rummimg e.g. qemu-system-x86_64 -m 1000 does not abort 
but runs the VM with an odd RAM size even though that's not possible on 
real hardware. Other machines should behave the same, within their limits: 
for sam460ex that means we need to truncate memory size to largest valid 
value becuause of SoC limits, for mac_oldworld that means with OpenBIOS it 
will see all RAM and with firmware ROM somewhat less. I've implemented 
that originally both for consistency and user convenience but this was 
"cleaned up" afterwrds and also made impossible to implement again without 
duplicating code in boards or reverting to some previous state and fixing 
the problems in a way that allows my use case as well.

Regards,
BALATON Zoltan

