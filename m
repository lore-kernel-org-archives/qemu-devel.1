Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE18C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D93320714
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYAVeNrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D93320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ0Et-00024R-Ij
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 15:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJ0E7-0001FF-Pa
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJ0E5-0005Ql-WF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:37:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJ0E5-0005Pf-KV
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:37:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id 26so379506wmk.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gZOldwHLnIB+1kjUriZ+cS7+MrenkoEssoMj1VlIBa8=;
 b=sYAVeNrWZw1HjFtX7b8rvLC0fXwiqy3oGBOi4uiP8uah4ql6QKCA5NrMwTgWE63qx6
 zQfVHGfxrrAeao0RA7IfXNHsjMxsz7pksgg2vfEtfh43Wf6M3ru5LQFhnLAumVSB1k1i
 8MCN0eh7Ajy+UpUkEyuuD8rqwaooMOcxggq/kwFM9n9Nuct6SjTeui8W5X2hCjnUGzwA
 BXiE706ujMoUIpj4vIQ0QSzMf3q9BzoLJMUdTZ+r4JhD3mWlb7w4P/nAoGJ/cbi9tq3D
 bYjGAe59g8be8mxtLyQ3ssH/yOMHX6VQrLxi12VbPjZulu7kFEBQqmjEDSHfdSk8LfiS
 SA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gZOldwHLnIB+1kjUriZ+cS7+MrenkoEssoMj1VlIBa8=;
 b=cICul10bodjZtrofXmOJ0rjN3lmA4MrW4Kf9XfI8MazZEto53adaTDc7EkseaPOtCu
 BDa+3vP41UKNcv5ZzbwDXV/Ebmxf9WUICzgAr+5TC7qfT7bW9oxhpKcj8bDt66KnGXeB
 DxTveKsuT+jVNBPLbm1+IbgJ5wGnHstfhQ+4CoS8M3cRCqpX010jV6H/TDev0DbMokef
 Z+0f/tK9NJY0UMgKXDfEw+7jAyl6xF8RIcE6nXBAq/TTp7ZpnGwtwr59UEjWBu9LtHEf
 BypkA6wwiWr4XuZaEj9PgHlLq12sibHE+1dQ5B/ryeNT4vcUgAjpzXA6cKwKsyDmt489
 4d7g==
X-Gm-Message-State: ANhLgQ2llmU8e+KDEXDY9JACry00T07b5w/lZ1chxXJpUXaLPYJzWsuv
 vUBoF080ow0jxWGmuE1jlLaJ/Q==
X-Google-Smtp-Source: ADFU+vtdJad/xV/MNGXeL+1k4LGUbLgFe+zCAtyw/Nln6LuNwZPnFI8JhKf9voIFOiDFz8FLQaDIoQ==
X-Received: by 2002:a1c:de87:: with SMTP id v129mr876463wmg.68.1585597056297; 
 Mon, 30 Mar 2020 12:37:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w9sm25557193wrk.18.2020.03.30.12.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 12:37:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3EF521FF7E;
 Mon, 30 Mar 2020 20:37:34 +0100 (BST)
References: <CAOragkw8XgbEOiaE9n=wKzPAMkzdOcqA5VA5ihN80v-g7V8TRw@mail.gmail.com>
 <20200329111311.272958fe@luklap> <878sjhho0s.fsf@linaro.org>
 <CAOragkwcnAYYdGOjaHWc1F7-hRnB9CHbgoUqEcc40A7muV+06Q@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Benjamin <benjamin@thatjames.org>
Subject: Re: Qemu TCG Plugins - how to access guest registers?
In-reply-to: <CAOragkwcnAYYdGOjaHWc1F7-hRnB9CHbgoUqEcc40A7muV+06Q@mail.gmail.com>
Date: Mon, 30 Mar 2020 20:37:34 +0100
Message-ID: <87wo71fxc1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Lukas Straub <lukasstraub2@web.de>, "Emilio G . Cota" <cota@braap.org>,
 qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Benjamin <benjamin@thatjames.org> writes:

> Thanks for your quick response.
>
> On Mon, Mar 30, 2020 at 9:15 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>>
>> Lukas Straub <lukasstraub2@web.de> writes:
>>
>> >> My question is, how do I access the guest memory and registers from t=
he
>> >> plugin callback function? The API seems to indicate that it is possib=
le,
>> >> since the callback registering requires you to say if you will access
>> them,
>> >> and if it's RW or just read.
>>
>> Currently we document what plugins can do in docs/devel/tcg-plugins.rst:
>>
>>   TCG plugins are unable to change the system state only monitor it
>>   passively. However they can do this down to an individual instruction
>>   granularity including potentially subscribing to all load and store
>>   operations.
>>
>> This was a conscious decision to avoid plugins being used as an end-run
>> around the GPL to implement proprietary out-of-tree extensions.
>>
>> That is not to say we might relax the rules in the future - it was a
>> topic of discussion at the maintainers summit and we wanted to document
>> some guidelines around interfacing with QEMU so people didn't get the
>> wrong idea about what these APIs provide (c.f. multi-process qemu and
>> vhost-user which could also be abused in similar ways).
>>
>
> I understand restricting the API so that the system state cannot be
> changed, only inspected.  I should have been more specific in my question.
> I am attempting to create a plugin that tracks all memory accesses, so I
> can emulate cache behavior.

Emulate or measure? By the way there is a GSoC project proposal to add
this:

  https://wiki.qemu.org/Internships/ProjectIdeas/CacheModelling

> The reason I would like to read the registers,
> is because many load/store instructions depend on register values, which I
> can only be sure of at run-time.

You don't need the registers at that point because at run time QEMU will
have already resolved the address and will pass it via the
qemu_plugin_register_vcpu_mem_cb. The hotpages and mem plugin examples
demonstrate the use of the API.


> Some of the concepts you mentioned I am not very familiar with; I am simp=
ly
> emulating an ARM A9 processor in bare-metal mode, to give you a point of
> reference of my use case.
>
>
>> Indeed Emilio's original tree did contain these more invasive hooks and
>> while we deliberate upstream it will hopefully not be as hard to
>> maintain a light out-of-tree fork should you need such functionality now.
>>
>
> Could you please point me towards this tree?  I haven't run across it yet
> in my investigating of all of this.

His tree is at:

  https://github.com/cota/qemu

But I'm not sure what his latest branch is. I've CC'd him.

>
>
>> >> Are there any examples of using this part of the API? I realize this =
is
>> a
>> >> very new part of Qemu functionality.
>>
>> So far the examples represent the totality of the API that has been
>> exercised and I'm keen we add more as new extensions to the API are
>> added. As to the specific question about accessing register values that
>> is exactly down to the newness of the API.
>>
>> Register access is a tricky problem because of the fact that QEMU
>> supports so many guest architectures. I wasn't keen on slapping in a
>> functional but ugly API that hard-coded values like gdb register ids so
>> I left it out for the time being. I'd happily accept patches to add that
>> functionality assuming it meets the projects quality and taste
>> guidelines.
>>
>> Some approaches we could take include:
>>
>>   - hook into tcg_global_*_new and allow plugin to introspect registers
>>   - hook into gdbstub in some way
>>
>> The first approach elides over the fact that a lot of registers aren't
>> actually known to the TCG - pretty much all vector registers tend to be
>> loaded into anonymous TCG temps as we go. Maybe this could just be fixed
>> by just providing a few more registrations functions at the start even
>> if the TCG itself wouldn't use that knowledge.
>>
>> The gdbstub provides a lot more visibility of register state and for
>> some architectures this can be quite comprehensive - for example in
>> system mode you can access pretty much every ARM co-processor register.
>> However the gdb interface is a little clunky as there are a lot of magic
>> register id numbers and the canonical way to enumerate this is to chew
>> through a bunch of XML that each target generates (see
>> gdb_register_coprocessor). I'm not keen on exposing that pile of XML via
>> the register interface. Maybe there is scope to improve our internal
>> APIs so the enumeration of registers can be handled by helpers that
>> record mappings and ids and generate the XML for the gdbstub centrally?
>>
>> There may be other approaches we could take and I'm open to suggestions.
>>
>
> I'd be happy to look into ways to implement this functionality.  However,=
 I
> just started using Qemu this year, so these things sound like they would
> have a steep learning curve for me.
> The gdbstub approach seems like it would provide the most introspection
> ability.  What would you suggest as a starting point for looking into thi=
s?
> All of this being said, if you think my project is too complicated, to
> implement a cache emulator with TCG plugins, then I could always try just
> hacking together some custom helper functions.

As I said above I don't think you need register values to do cache
emulation as you have the addresses. You will need to decode some of the
cache management instructions though. Fortunately you can do that at
translation time and only instrument the ones you need. See howvec for
examples.

--=20
Alex Benn=C3=A9e

