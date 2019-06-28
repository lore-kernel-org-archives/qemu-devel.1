Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD8C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B0E208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v55u2VWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B0E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgxsr-0000c0-0M
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 16:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hgxrB-0007tA-GK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hgxrA-0002MK-1K
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:52:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hgxr9-0002KT-O3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:52:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id p11so7561658wre.7
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 13:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EKb4RF57baXzskwCVcEzAL5dtk+Az4vPRmC9wc0Crd4=;
 b=v55u2VWtHsnf04oFoUmD5OgSW1PoCtj38fvL2QdilLbag6bHKzGGPcA1ZltSZiwJGu
 YaxobjjwjLUgsiGb/vwjFh+W+DgMsrTs5ILw0Tkgfx86UoNAwAFjujQeSjNwBVvEewLJ
 fovA8swVJQyedO5Zsq9PJcUj4SWNDlynjqdhaK7lz58aQUPTUWJUXKZwfV4aQ/b0+l+p
 gtXeFknKdrkb/hPsq72Tlk28QEXdI2FoKA056EOwprN7JYhJ1RJwDpXlFinN8iajvtlN
 RkwBvJHqmA5BaIfvK89s9ApHLiRtKZ5Iy7tLcnuhtIWJ9xxz858ecm4qfm0yjmhsU4rS
 AGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EKb4RF57baXzskwCVcEzAL5dtk+Az4vPRmC9wc0Crd4=;
 b=MAAYZViNb2ayHBJ3FBRXISDC3KVhtGTDq3tUBUMs7ZD6vHBSj8jGplp02NKkgmXGxn
 ygaeTkyCyPCeEV4RI7AhfhStR2ZPO6PYg+8cD1ekT49M9MavVU4jPBY/syAUJyHqbDxN
 8R2io0KcuTP8+iFx/gQ3DfEmuORBtNtfam8d/wB+hjBQ2EHI+UyHeayVyR6qeNu09jHw
 I3upBNIPB8M13In5jbb6XUqquWFsoj07g5ZdszGk/GiaHs1cc9wRtp7EdCe9UT7+Dmsp
 9grDOGU6ZDH8Mr35onFEYt5nOdgKOLi6/lLIVjQ0T+jF8URZgL8MTJQK6cOxiykdBHwQ
 WMZw==
X-Gm-Message-State: APjAAAXs6Ce3UFMyJYwJbpRrwqJuxMF/gotiG4bpfsk8eTgCRJ7efxp8
 +riPP6ImB8Uro2GaXJoPKX/pLA==
X-Google-Smtp-Source: APXvYqzCSqv4AsjqmqN6zYXs5b+GJFaHqNym57TYLC6vFxqAVr4t6gYj8SFCkLK05vUnlg8cCZImHg==
X-Received: by 2002:adf:e2c6:: with SMTP id d6mr1976270wrj.326.1561755144860; 
 Fri, 28 Jun 2019 13:52:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x11sm3325183wmi.26.2019.06.28.13.52.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 13:52:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 90FB51FF87;
 Fri, 28 Jun 2019 21:52:23 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-20-alex.bennee@linaro.org>
 <20190628153044.GB26345@quinoa.localdomain>
 <87mui1ab4j.fsf@zen.linaroharston>
 <20190628175756.GC26345@quinoa.localdomain>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
In-reply-to: <20190628175756.GC26345@quinoa.localdomain>
Date: Fri, 28 Jun 2019 21:52:23 +0100
Message-ID: <87lfxla0vs.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument
 memory accesses
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:

> On Jun 28 18:11, Alex Benn=C3=A9e wrote:
>> Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:
>> > On Jun 14 18:11, Alex Benn=C3=A9e wrote:
>> >> From: "Emilio G. Cota" <cota@braap.org>
>> >>
>> >> Here the trickiest feature is passing the host address to
>> >> memory callbacks that request it. Perhaps it would be more
>> >> appropriate to pass a "physical" address to plugins, but since
>> >> in QEMU host addr ~=3D guest physical, I'm going with that for
>> >> simplicity.
>> >
>> > How much more difficult would it be to get the true physical address (=
on
>> > the guest)?
>>
>> Previously there was a helper that converted host address (i.e. where
>> QEMU actually stores that value) back to the physical address (ram
>> offset + ram base). However the code for calculating all of this is
>> pretty invasive and requires tweaks to all the softmmu TCG backends as
>> well as hooks into a slew of memory functions.
>>
>> I'm re-working this now so we just have the one memory callback and we
>> provide a helper function that can provide an opaque hwaddr struct which
>> can then be queried.
>
> To make sure I understand - you're implying that one such query will
> return the PA from the guest's perspective, right?

Yes - although it will be two queries:

  struct qemu_plugin_hwaddr *hw =3D qemu_plugin_get_hwaddr(info, vaddr);

This does the actual lookup and stores enough information for the
further queries.

  uint64_t pa =3D qemu_plugin_hwaddr_to_raddr(hw);

will return the physical address (assuming it's a RAM reference and not
some IO location).

>
>> The catch is you can only call this helper during a
>> memory callback.
>
> Does this mean it will be difficult to get the physical address for the
> bytes containing the instruction encoding itself?

Hmm good question. We track the hostaddr of the instructions as we load
them so we should be able to track that back to the guest physical
address. There isn't a helper for doing that yet though.

>
>> I'm not sure if having this restriction violates our
>> aim of not leaking implementation details to the plugin but it makes the
>> code simpler.
>
> Assuming that the purpose of "not leaking implementation details" is to
> allow the same plugin interface to work with other backend
> implementations in the future, isn't this probably fine?

Quite. We don't want plugin authors to make any assumptions about the
internals of the TCG. It's not totally opaque because there are
translation time events where we offer the plugin a chance to instrument
individual instructions (or even a "block") which obviously exposes
there is a JIT of some sort.

> It may add an
> unnecessary limitation for another backend driving the same plugin
> interface, but I don't think it likely changes the structure of the
> interface itself. And that seems like the sort of restriction that could
> easily be dropped in the future while remaining backwards-compatible.
>
>> Internally what the helper does is simply re-query the SoftMMU TLB. As
>> the TLBs are per-CPU nothing else can have touched the TLB and the cache
>> should be hot so the cost of lookup should be minor. We could also
>> potentially expand the helpers so if you are interested in only IO
>> accesses we can do the full resolution and figure out what device we
>> just accessed.
>
> Oh, so you're already working on doing just what I asked about?

Yes.

>
>> > This is important enough to me that I would be willing to help if
>> > pointed in the right direction.
>>
>> Well I'll certainly CC on the next series (hopefully posted Monday,
>> softfreeze starts Tuesday). I'll welcome any testing and review. Also if
>> you can tell us more about your use case that will help.
>
> Awesome, thanks!
>
> In terms of our use case - we use QEMU to drive studies to help us
> design the next generation of processors. As you can imagine, having the
> right physical addresses is important for some aspects of that. We're
> currently using a version of Pavel Dovgalyuk's earlier plugin patchset
> with some of our own patches/fixes on top, but it would obviously make
> our lives easier to work together to get this sort of infrastructure
> upstream!

Was this:

 Date: Tue, 05 Jun 2018 13:39:15 +0300
 Message-ID: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-=
T60>
 Subject: [Qemu-devel] [RFC PATCH v2 0/7] QEMU binary instrumentation proto=
type

There have certainly been a lot of attempts to getting some sort of
plugin functionality into QEMU. I make no promises this one will be the
one but we shall see!

What patches did you add on top?

>
> -Aaron


--
Alex Benn=C3=A9e

