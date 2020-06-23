Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C47C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E0420738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/P1kWBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E0420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jneCJ-0004cW-8m
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jneBi-00043P-HC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:21:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jneBg-00013V-Ha
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:21:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id g75so2093342wme.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 01:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Zj0UT/e6KB63EvemT3G99hMk9FSebnqp177CT4m+/qA=;
 b=C/P1kWBsiQ3rOABGyOqu5uXt/h074gEqTLiAwLcQe7pIL99l6DQJs3r90AaZcR1R3+
 Vt/+uMEOjkGsKQ50ozRV3rgsDu1CiYMIBTPV+GMZW1Pd7JsnO7DbIaws5QOHSaUY3/wn
 EqFjOmtXnEac3e3E1bkPL3bTB4hkJQuW7FuLC3p3YxkZelmIK/zp29PIS8AAyq7+OGJx
 Nzcd8QEhAHtq+rAhHpYGAAlgxqpIbEGvNAxGP9Pq4Xm2MEEULangQVi0vgdAyLYNl4jB
 mP2P8UTQTHgbLp9TVDNQ3dpKw+VCjl+tnnLF/wub2jC0KHyUOOHSkgnh0LJGJ612yxze
 /Nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Zj0UT/e6KB63EvemT3G99hMk9FSebnqp177CT4m+/qA=;
 b=SmiNu/AT3db+RTZOmuLsp8axNLJWCTQMq1oSPfe31KJroWnNiFbuFNXhDcOKKraVAC
 76qW3rWDlABZoL3RXtz0n07oNmAyyLdJF+eOuK5zv74Mn4Tm7SaWpSyoxRaetcjE5Y+h
 wZxVZjL2Oj5ts+12TutaVy6g/Y5FjbkCm5GN7ycDdOwOA919ByW4uanoKU7ABY0iCKt7
 eUlXi5xat/s0jlc2sdZLOraCXa0glpXLcdSyn88qjV54+Zq2s6ws9xXn0z4Tc0rVpCgt
 25aKbGaEHKjLmr8LbH80vib9jDZOXnrzTGyEF+1tMvkoc4WLAP3cQtq72thA2U+Nkkd/
 VLbw==
X-Gm-Message-State: AOAM533dMRU70Flepbv7cqpoYX1qCivHU819hf8P+CyIH+os06z2KSBP
 Ug2D6lCP64qkkROlkrnlayOLPA==
X-Google-Smtp-Source: ABdhPJyATGvAskKaQyHf2c7KZTbM14mV3bzJgrlawGca7ONt0b6eoe6Getj/aBc/94E33YFp6L5XBA==
X-Received: by 2002:a1c:2b01:: with SMTP id r1mr23794359wmr.26.1592900506614; 
 Tue, 23 Jun 2020 01:21:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p4sm10975699wrx.63.2020.06.23.01.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 01:21:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5EAA71FF7E;
 Tue, 23 Jun 2020 09:21:44 +0100 (BST)
References: <20200612014606.147691-1-jkz@google.com>
 <20200612014606.147691-5-jkz@google.com> <87h7vbyowf.fsf@linaro.org>
 <CADgy-2uOn835LrnOBDacbqznW8MR7ZQy55kBmpjDbK2Uy1xPEg@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Josh Kunz <jkz@google.com>
Subject: Re: [PATCH 4/5] linux-user: Support CLONE_VM and extended clone
 options
In-reply-to: <CADgy-2uOn835LrnOBDacbqznW8MR7ZQy55kBmpjDbK2Uy1xPEg@mail.gmail.com>
Date: Tue, 23 Jun 2020 09:21:44 +0100
Message-ID: <877dvy9opz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Josh Kunz <jkz@google.com> writes:

> Thanks for the responses Alex. I'm working on your comments, but
> wanted to clarify some of the points you brought up before mailing a
> second version. Responses inline.
>
> On Tue, Jun 16, 2020 at 9:08 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>> Which by the way fail on some targets:
>>
>>     TEST    linux-test on alpha
>>   /home/alex/lsrc/qemu.git/tests/tcg/multiarch/linux-test.c:709: child d=
id not receive PDEATHSIG on parent death
>>   make[2]: *** [../Makefile.target:153: run-linux-test] Error 1
>>   make[1]: *** [/home/alex/lsrc/qemu.git/tests/tcg/Makefile.qemu:76: run=
-guest-tests] Error 2
>>   make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:851: run-tc=
g-tests-alpha-linux-user] Error 2
>>
>> Have you managed a clean check-tcg with docker enabled so all the guest
>> architectures get tested?
>
> I've gotten this Alpha failure to reproduce on my local build and I'm
> working on a fix. Thanks for pointing this out. I'll make sure I get a
> clean `make check-tcg` for `linux-test` on all guest architectures.
>
>> > In this patch, I've employed an alternative approach: spawning a thread
>> > an "stealing" its TLS image for use in the child process. This approach
>> > leaves a dangling thread while the TLS image is in use, but by design
>> > that thread will not become schedulable until after the TLS data is no
>> > longer in-use by the child (as described in a moment). Therefore, it
>> > should cause relatively minimal overhead. When considered in the larger
>> > context, this seems like a reasonable tradeoff.
>>
>> *sharp intake of breath*
>>
>> OK so the solution to the complexity of handling threads is to add more
>> threads? cool cool cool....
>
> The solution to the complexity of shared memory, but yeah, not my
> favorite either. I was kinda hoping that someone on the list would
> explain why this approach is clearly wrong.
>
>> > * Non-standard libc extension to allow creating TLS images independent
>> >   of threads. This would allow us to just `clone` the child directly
>> >   instead of this complicated maneuver. Though we probably would still
>> >   need the cleanup logic. For libcs, TLS image allocation is tightly
>> >   connected to thread stack allocation, which is also arch-specific. I
>> >   do not have enough experience with libc development to know if
>> >   maintainers of any popular libcs would be open to supporting such an
>> >   API. Additionally, since it will probably take years before a libc
>> >   fix would be widely deployed, we need an interim solution anyways.
>>
>> We could consider a custom lib stub that intercepts calls to the guests
>> original libc and replaces it with a QEMU aware one?
>
> Unfortunately the problem here is host libc, rather than guest libc.
> We need to make TLS variables in QEMU itself work, so intercepting
> guest libc calls won't help much. Or am I misunderstanding the point?

Hold up - I'm a little confused now. Why does the host TLS affect the
guest TLS? We have complete control over the guests view of the world so
we should be able to control it's TLS storage.

>> Have you considered a daemon which could co-ordinate between the
>> multiple processes that are sharing some state?
>
> Not really for the `CLONE_VM` support added in this patch series. I
> have considered trying to pull tcg out of the guest process, but not
> very seriously, since it seems like a pretty heavyweight approach.
> Especially compared to the solution included in this series. Do you
> think there's a simpler approach that involves using a daemon to do
> coordination?

I'm getting a little lost now. Exactly what state are we trying to share
between two QEMU guests which are now in separate execution contexts?

--=20
Alex Benn=C3=A9e

