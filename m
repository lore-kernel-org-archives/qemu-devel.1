Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB430C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9CA2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9CA2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJG71-0003WO-Q2
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jJG5Y-0002yD-BZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jJG5W-0000ii-GD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:33:51 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:55735)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jJG5W-0000eZ-8c
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:33:50 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8978B747EA7;
 Tue, 31 Mar 2020 14:33:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6201D747EA2; Tue, 31 Mar 2020 14:33:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6094E747EA3;
 Tue, 31 Mar 2020 14:33:46 +0200 (CEST)
Date: Tue, 31 Mar 2020 14:33:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: deprecation of in-tree builds
In-Reply-To: <875zel5722.fsf@dusky.pond.sub.org>
Message-ID: <alpine.BSF.2.22.395.2003311417190.73689@zero.eik.bme.hu>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <875zel5722.fsf@dusky.pond.sub.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> On Mon, 30 Mar 2020 at 14:26, Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> AIUI from Paolo, the intention is to deprecate and eventually
>>>> stop supporting "in-tree" builds, so that the only option is
>>>> building in a separate build directory. I thought we should
>>>> probably mention that in the 5.0 changelog, so I wrote up some
>>>> text:
>>>>
>>>> https://wiki.qemu.org/ChangeLog/5.0#Build_Information
>>>
>>> Overdue.  Thanks for doing this!
>>>
>>>> Suggestions for changes/comments etc welcome.
>>>
>>> Looks fine to me.
>>
>> Consensus in the thread seemed to lean towards having
>> the 'configure/make' runes auto-create a build directory;
>> if we want to do that we should probably not say anything in
>> the release notes, because we'll cause people to change
>> unnecessarily. Or at least have them say "We recommend
>> out-of-tree builds. In future we might make the commands
>> that currently do an in-tree build automatically create
>> and use a build directory for you." rather than a blanket
>> "we're going to drop this and you should change what you
>> do now".
>>
>> Thoughts?
>
> I'm wary of complicating the build system to save developers a minor
> change of habits.

How much complication is it? Looks like a few lines in configure (like the 
one submitted to print warning but instead of printing a long warning just 
run the commands (which is even shorter then the text). Then a Makefile in 
top level dir to do make -C build like someone has also posted in another 
email. This does not seem too much burden to make life of some people 
easier so I don't see why some of you insist to force everyone to change 
their ways even if it could be solved with some effort.

> We will have to ask developers to change habits anyway when we switch to
> Meson.  I agree with Daniel's recommendation to delay changes requiring
> habit-changes until then.  However, telling people to stay clear of the
> unloved and brittle in-tree build is simply good advice we should not
> withhold.

Can someone please explain why is it brittle and cannot be supported? It 
has worked well so far apart from some breakage due to being untested 
which is also not a techincal necessity just a decision by some 
maintiners to not test it. Adding a CI job to keep it working would also 
not be difficult or much complexity.

Regards,
BALATON Zoltan

