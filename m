Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEA5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF36420781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF36420781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIY7-0004l8-0e
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jJIRJ-0003Nv-4n
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jJIRH-0003ve-80
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:04:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:61602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jJIRF-0003Xt-Ve
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:04:27 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 56E64745953;
 Tue, 31 Mar 2020 17:04:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CD293747EA2; Tue, 31 Mar 2020 17:04:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CC08B747EA7;
 Tue, 31 Mar 2020 17:04:16 +0200 (CEST)
Date: Tue, 31 Mar 2020 17:04:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: deprecation of in-tree builds
In-Reply-To: <20200331125030.GG353752@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003311632270.73689@zero.eik.bme.hu>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <875zel5722.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2003311417190.73689@zero.eik.bme.hu>
 <20200331125030.GG353752@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-84508624-1585667056=:73689"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-84508624-1585667056=:73689
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Mar 2020, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 31, 2020 at 02:33:46PM +0200, BALATON Zoltan wrote:
>>> We will have to ask developers to change habits anyway when we switch=
 to
>>> Meson.  I agree with Daniel's recommendation to delay changes requiri=
ng
>>> habit-changes until then.  However, telling people to stay clear of t=
he
>>> unloved and brittle in-tree build is simply good advice we should not
>>> withhold.
>>
>> Can someone please explain why is it brittle and cannot be supported? =
It has
>> worked well so far apart from some breakage due to being untested whic=
h is
>> also not a techincal necessity just a decision by some maintiners to n=
ot
>> test it. Adding a CI job to keep it working would also not be difficul=
t or
>> much complexity.
>
> Writing make rules to correctly handle both src-dir and build-dir scena=
rios
> is a non-negligible maint burden. If you look back through QEMU's histo=
ry
> we have a steady stream of patches which have broken one or the other
> build scenarios.

That's probably becuase there are no clear rules (such as always prefix=20
files in source dir with $(SRC_PATH), generated files with some BUILDDIR,=
=20
etc.) and these are not documented so every time someone touches it has t=
o=20
explore and debug it again. This could be avoided if these were written=20
down once but instead of trying to document and clean up the build system=
=20
the chosen direction is to just throw it out and replace it with somethin=
g=20
more complex and with more dependencies (Meson) and then to save=20
"additional complexity" it also breaks people's workflow and demand them=20
to adapt themselves. I'm not saying there should be no changes but if=20
there's a way to make them less painful it could be considered if it's no=
t=20
much extra work and in this case it does not seem to be.

> Developers will often not test both scenarios, just the one they prefer
> to use. This results in a maint burden on the subsystem maintainers who
> merge patches and then find they break & have to back them out. Sometim=
es
> even the subsystem maintainer gets it wrong and burden falls on Peter t=
o
> find & reject it.
>
> Even if we have CI to test both, it is still a burden on developers to
> debug failures reported by the CI and figure out what needs fixing. Wit=
h
> the number of builds we do & the time for a single CI cycle it gets ver=
y
> time consuming. I've personally wasted many many hours debugging src-di=
r
> vs build-dir problems in QEMU's makefiles - probably more than an entir=
e
> day was lost when I did the patches to split the trace.h header file.
>
> This all serves to divert time away from useful work on QEMU. If there
> was some critically important functional thing that src-dir builds offe=
r
> that can't be achieved by build-dir builds, then the extra maint work
> could be justified. I don't think that's the case though.

OK, so then only supporting out-of-tree builds but adding convenience=20
function and Makefile to still allow people to run configure; make from=20
source dir would solve this without also needing people to change what=20
they always did so why is that solution not acceptable?

Regards,
BALATON Zoltan
--3866299591-84508624-1585667056=:73689--

