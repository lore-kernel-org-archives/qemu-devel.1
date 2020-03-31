Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91167C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6159220781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6159220781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJFD-0000Dr-IG
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jJJEP-0007n7-Bn
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jJJEN-0003sT-EE
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:55:12 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:61250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jJJEL-0003pD-L3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:55:10 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 32489747DFB;
 Tue, 31 Mar 2020 17:55:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 07FD77475F6; Tue, 31 Mar 2020 17:55:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 068B174638A;
 Tue, 31 Mar 2020 17:55:05 +0200 (CEST)
Date: Tue, 31 Mar 2020 17:55:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: deprecation of in-tree builds
In-Reply-To: <20200331152317.GL353752@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003311734540.73689@zero.eik.bme.hu>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <875zel5722.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2003311417190.73689@zero.eik.bme.hu>
 <20200331125030.GG353752@redhat.com>
 <alpine.BSF.2.22.395.2003311632270.73689@zero.eik.bme.hu>
 <20200331152317.GL353752@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1604181391-1585670105=:73689"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1604181391-1585670105=:73689
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Mar 2020, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 31, 2020 at 05:04:16PM +0200, BALATON Zoltan wrote:
>> OK, so then only supporting out-of-tree builds but adding convenience
>> function and Makefile to still allow people to run configure; make fro=
m
>> source dir would solve this without also needing people to change what=
 they
>> always did so why is that solution not acceptable?
>
> There's several scenarios discussed. Currently we don't do anything to
> prevent src-dir builds, so there's no need to extra make magic describe=
d
> I proposed a patch to add a warning, but it still allows src-dir builds=
,
> so nothing functional has changed.
>
> We could forbid src-dir builds now and add the magic to redirct to a
> build-dir. That would work, but I don't think we should block src-dir
> builds in make, assuming we have a switch to meson arriving in the
> near-ish future.

So then why print a warning when it will change again when the build=20
system is replaced? Isn't it enough to worry about it at that point? If i=
t=20
works now as before then no need to constantly bug people at every=20
cofigure invocation. Simply put a warning in changelog that current build=
=20
system is deprecated and will be replaced with something else like Meson=20
in some future release and that should be enough to notify people about=20
the coming change. You don't print warnings for every other deprecated=20
features either.

> Once we switch to Meson there will inevitably be some disruption in
> build system ussage as it is a completely new tool. That makes it a
> good flag day for forbidding src-dir builds. Given that it is a flag
> day, I don't think there's any need to create makefile magic at that
> time.

Ideally a change in build system should make it more convenient to work=20
with not more inconvenient otherwise it's questionable if we want to=20
introduce it at all but we'll see then. But then why bug people with a 14=
=20
line warning now if they'll have to change their ways again shortly? I=20
thought you wanted to get rid of in-tree builds now to ease the=20
maintenance of current make system and the convenience makefile would=20
help that.

> IMHO we shouldn't be so afraid of change that we need to try to preserv=
e
> every precise way of working we've had in the past. In the long term th=
is
> frame of mind holds back the project and promotes a negative impression
> of QEMU as an old, outdated project resistant to any kind of change.

I did not say that. What I said was that you can change or replace the=20
build system with whatever you want as long as I can still run make (or=20
equivalently simple command) in source dir and it will build the project.=
=20
I can live with build results moved to a subdir to ease your task of=20
managing build system so you don't have to support two ways of building=20
now. But if you say this will still work for now and don't mind continue=20
to support it as before at least until a new build system is introduced=20
I'm happy with that too. I'll raise same complaints against new build=20
system then when it's about to be merged.

Regards,
BALATON Zoltan
--3866299591-1604181391-1585670105=:73689--

