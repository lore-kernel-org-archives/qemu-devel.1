Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1722C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98F020658
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98F020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGQX-0006EE-UV
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jJGPv-0005oE-Kc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jJGPu-0004dc-6Z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:54:55 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:27140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jJGPt-0004b3-HA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:54:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id EF1F474637F;
 Tue, 31 Mar 2020 14:54:51 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C80DF7461AE; Tue, 31 Mar 2020 14:54:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C6BD7745953;
 Tue, 31 Mar 2020 14:54:51 +0200 (CEST)
Date: Tue, 31 Mar 2020 14:54:51 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: deprecation of in-tree builds
In-Reply-To: <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003311439130.73689@zero.eik.bme.hu>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com> <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020, Paolo Bonzini wrote:
> On 30/03/20 16:37, Kevin Wolf wrote:
>> If manually dealing with separate build directories is inconvenient
>> today, it will still be inconvenient with Meson, so this would mean
>> introducing the automatic directly creation together with the other
>> changes to enable Meson. Which is fine by me, as long as it is really
>> done when the external directory becomes mandatory, so that people won't
>> have to switch back and forth between directories.
>
> Serious question: why is automatic directly creation more convenient for
> developers?  Even if "./configure" generates a "build" directory for
> you, you would still have to invoke the QEMU binary as
> "build/x86_64-softmmu/qemu-system-x86_64".  That is less convenient than
> doing "mkdir build" in the first place.

I already have to put qemu commands in scripts due to insanely long 
options which cannot be conveniently typed so I'd just need to add 
automatically created build dir to that script once and be able to 
continue using ./configure and make from source dir. This is more 
convenient than having to manage the build dir by hand and add it to every 
make command as well. If it can be automated then why should I do it?

> I can see why it's more convenient for packaging, as they just invoke
> "make" and "make install", but as far as developers are concerned it
> seems to add complexity for little or no gain.

It's not much complexity and makes life easier for those who do not want 
to know about separate build dirs, Meson or the QEMU build system. Just 
make sure it builds with usual configure; make; make install and maybe 
print a line of text saying you find the build results in whatever dir and 
that's it. As long as this works most people will be happy. It you want 
people to contribute to QEMU then try to make their life easier not annoy 
them unnecesseraily. The way of submitting patches is already difficult 
enough to scare away most people, changing to an exotic build system would 
also result even less people being able to make any contribution.

Regards,
BALATON Zoltan

