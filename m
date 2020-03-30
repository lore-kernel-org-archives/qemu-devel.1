Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB243C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BEF20786
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BEF20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ0pS-0005gi-KE
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 16:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jJ0oj-0005Ae-MV
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jJ0oh-0007fC-HM
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:15:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:22134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jJ0og-0007Zc-LJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:15:27 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6D239747EA5;
 Mon, 30 Mar 2020 22:15:24 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3C5B9747EA3; Mon, 30 Mar 2020 22:15:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 39BF6747E00;
 Mon, 30 Mar 2020 22:15:24 +0200 (CEST)
Date: Mon, 30 Mar 2020 22:15:24 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Michal_Such=E1nek?= <msuchanek@suse.de>
Subject: Re: deprecation of in-tree builds
In-Reply-To: <20200330172955.GQ25468@kitsune.suse.cz>
Message-ID: <alpine.BSF.2.22.395.2003302201020.33183@zero.eik.bme.hu>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com> <20200330143759.GD6139@linux.fritz.box>
 <20200330172955.GQ25468@kitsune.suse.cz>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1349375325-1585599324=:33183"
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
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1349375325-1585599324=:33183
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Mar 2020, Michal Such=E1nek wrote:
> On Mon, Mar 30, 2020 at 04:37:59PM +0200, Kevin Wolf wrote:
>> Am 30.03.2020 um 15:42 hat Daniel P. Berrang=E9 geschrieben:
>>> On Mon, Mar 30, 2020 at 02:31:52PM +0100, Peter Maydell wrote:
>>>> On Mon, 30 Mar 2020 at 14:26, Markus Armbruster <armbru@redhat.com> =
wrote:
>>>>>
>>>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>>>
>>>>>> AIUI from Paolo, the intention is to deprecate and eventually
>>>>>> stop supporting "in-tree" builds, so that the only option is
>>>>>> building in a separate build directory. I thought we should
>>>>>> probably mention that in the 5.0 changelog, so I wrote up some
>>>>>> text:
>>>>>>
>>>>>> https://wiki.qemu.org/ChangeLog/5.0#Build_Information
>>>>>
>>>>> Overdue.  Thanks for doing this!
>>>>>
>>>>>> Suggestions for changes/comments etc welcome.
>>>>>
>>>>> Looks fine to me.
>>>>
>>>> Consensus in the thread seemed to lean towards having
>>>> the 'configure/make' runes auto-create a build directory;
>>>> if we want to do that we should probably not say anything in
>>>> the release notes, because we'll cause people to change
>>>> unnecessarily. Or at least have them say "We recommend
>>>> out-of-tree builds. In future we might make the commands
>>>> that currently do an in-tree build automatically create
>>>> and use a build directory for you." rather than a blanket
>>>> "we're going to drop this and you should change what you
>>>> do now".
>>>>
>>>> Thoughts?
>>>
>>> When the time comes to switch to Meson, we'll be forcing a
>>> separate build directory & that will also potentially involve
>>> a change in build instructions for users.
>>>
>>> So if we expect Meson will arrive in QEMU soon (say before end
>>> of this year), then I'd try to keep changes related to make to
>>> the bare minimum, and have Meson switch as the "flag day" when
>>> developers are forced to adapt their build process.
>>>
>>> IOW, merely warn people that in-tree builds are deprecated and
>>> not tested by the project and enourage switching to out of tree
>>> builds. Dont try to magically create a separate build dir now.
>>
>> If manually dealing with separate build directories is inconvenient
>> today, it will still be inconvenient with Meson, so this would mean
>> introducing the automatic directly creation together with the other
>> changes to enable Meson. Which is fine by me, as long as it is really
>> done when the external directory becomes mandatory, so that people won=
't
>> have to switch back and forth between directories.
>
> From packaging point of view if something has auto* files the default i=
s
> IIRC to do in-tree build with most package managers. You have to adjust
> manually for out-of-tree build. I am not sure what is state of Meson
> support in packaging scripts across distributions. Most likely it will
> not be picked automagically so you have to provide a custom build scrip=
t
> anyway. Then it is the time to look up the canonical build instructions=
.
>
> In other words dealing with Meson is inconvenient either way. Building
> in-tree or out-of-tree becomes a non-issue whan you switch to exotic
> build system anyway.
>
> That's not to say that auto* tools are great. It's just the replacement=
s
> have issues that are not well understood by average Joe Packager while
> the auto* tools have good old issues people know how to deal with.

Actually QEMU does not use auto* tools, it just has a configure script=20
that mimics that. This may not be the best way to do it but this is=20
convenient for people trying to compile it and works as expected so I=20
think this behaviour should be preserved if possible just to not upset=20
developers and packagers unnecessarily.

Regards,
BALATON Zoltan
--3866299591-1349375325-1585599324=:33183--

