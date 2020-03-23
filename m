Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03765C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 00:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA8320732
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 00:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA8320732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGB56-0006if-VL
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 20:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jGB4T-0006Ih-EJ
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 20:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jGB4R-0000Zz-Iv
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 20:36:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:15024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jGB4P-0000QL-B3
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 20:35:59 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7600C74637E;
 Mon, 23 Mar 2020 01:35:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4D7327461AE; Mon, 23 Mar 2020 01:35:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4B205745953;
 Mon, 23 Mar 2020 01:35:46 +0100 (CET)
Date: Mon, 23 Mar 2020 01:35:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: deprecation of in-tree builds
In-Reply-To: <CAFEAcA_GR__MVOU=LVUuQwnwM23DYxbp4Gi00mKJCoLrxL9j0g@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2003230113170.33355@zero.eik.bme.hu>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <CAL1e-=gKB0qRxGntXrU0im2gjMh1tq_SLGTm+HsmgBRGXQ9+Bg@mail.gmail.com>
 <CAFEAcA-Yn_O=G-63O1Ug9=HYqN0_o_NH_nLpWmBv2bjk2Y_85A@mail.gmail.com>
 <CAHiYmc4Qv4yL8LMp_nFqx20bq-hRO-umh5R899H6hdSyKrpNBA@mail.gmail.com>
 <CAFEAcA_hfhusu8n8OXLg=vjiMSw09HVy2zhVr=R2hmGdEQJtew@mail.gmail.com>
 <alpine.BSF.2.22.395.2003222134560.60771@zero.eik.bme.hu>
 <CAFEAcA_GR__MVOU=LVUuQwnwM23DYxbp4Gi00mKJCoLrxL9j0g@mail.gmail.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 22 Mar 2020, Peter Maydell wrote:
> On Sun, 22 Mar 2020 at 20:46, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Sun, 22 Mar 2020, Peter Maydell wrote:
>>> Before you told me about the gprof issue, the *only* thing
>>
>> Was that gprof or gcov?
>
> Sorry, gcov; I always get those two mixed up in my head.
>
>> Plus potentially any scripts people might use to build stuff and distro
>> packagers that might use in-tree build. They would suddently find their
>> previously working scripts are now broken and they need to adapt.
>
> It is to avoid the "suddenly" part that we announce in advance
> that features are going away :-)  More generally, distro packagers

People usually don't read docs so they'll find out "suddenly" anyway...

> must adapt for any new QEMU release -- new features appear that
> they may need to update their dependency lists to handle, old
> features are sometimes removed and the corresponding configure
> --enable-foo options stop working, existing features need new
> dependencies.

It's true they'll occasionally have to adapt and probably most packagers 
already use out-of-tree builds but if there's something that can make 
their life easier without putting too much burden on QEMU I think it's a 
good thing to make it convenient for people compiling QEMU.

> If somebody wants to write patches to cause 'configure' to create
> a new build tree that's OK I guess (though I'd be dubious because
> I think that hidden magic like that is overall often going
> to confuse people, and it's still extra machinery in the
> makefile and the configure script). But I don't really see
> much point in maintaining two different mechanisms which add
> complication and where one of them is just not overall as useful
> as the other.

A convenience Makefile in top level to call make -C builddir and maybe a 
few lines in configure to create it does not seem to be too much extra 
machinery but I don't know the build system that well. Also it does not 
have to be hidden, it can print a message to user to tell it created a 
build dir and that the build results are found there. It's probably less 
confusing to people who never used out-of-tree builds before and relieves 
them from having to learn something new which a lot of people like to 
avoid if possible.

> I fairly often see posts from people on eg stackoverflow
> who are trying to compile and modify QEMU, and they're
> usually using in-tree build and I usually mention in a
> PS to answering their question that they'd really be
> better off with an out-of-tree build. I think we should
> stop making it easy to default to a setup that we don't
> recommend.

I think this proves my point that a lot of people expect this to work and 
the answer should not be to annoy them and force them to change their ways 
but to support it in some way. If this is a problem with the make system 
then auto-creating build dir could avoid this problem without imposing 
things on people so if it's not too much effort it's probably worth doing.

Regards,
BALATON Zoltan

