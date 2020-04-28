Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F0C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463CE206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LCcexQMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463CE206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTLzG-0001by-9h
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTLsS-0004kr-Jx
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTLjO-0002pv-Aa
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:38:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jTLjN-0002pJ-Mn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:36:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id d15so21980578wrx.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 01:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aLjxcCJPbI5yIwkt1tPCq3CebYIaw+uKoJdDPOol07Q=;
 b=LCcexQMUlFOKaAVmtkARkp1bjrxIOBDIAzYH3WZnE0TAgVS+USm1wfbu3zfp7zOSuc
 NOJEmV3ZNYIRQLrgAQGKj0ZOPLlqUd5c26buXu9giFSLwCpTNKF5lJhZRKIXx3QSn0Oz
 arIaDTZzK2K7eRPLTzRwlJ1bugBq0lE2EgPAjcvgwhwTZDCU6GkzDwSn/SaPLtG48NOv
 oNRIUAdPRpVBPXMfTUZykkd2AtHN9lTjX7DeY42dwfcy/H/7FPsE1RtQIy7AMOWLeKrM
 9Ts3r/Pdiv/Df91JEBMndgxGCGfa6FF+j3drPdcnUEE9BfBDfpXrPMA7TqVy7zAs0/UW
 p25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aLjxcCJPbI5yIwkt1tPCq3CebYIaw+uKoJdDPOol07Q=;
 b=speScHMYNdZs2/no8FzqNDBgRN96YS/nyxndFLSc0nqK4VcwmdrF4kHQMdEDfu1+Aw
 mbRbY4KnZyOWIUFYDPxbXoW6LQqFnn539HzwjG4FTF9JypQQur0rAqVLpbM1k0g/+K2y
 FCiRXJYSmE+J0h9+IwfIY0AB16Rx81XcGNlT5uRliCqpZlJOf9vAi8DpPmnVjyRWwAk2
 UNFfgsz8BAiYAD+kK/d+ssGUzxrmzyUk6NwjM+CCe5gC1ZSACTmQ6nGhlUV06/6u0GCz
 ltZMNQkk69nFstRGgcE/EPUocgNG4UJbgPO120XNIVKlIvuwPpr7kXXQOoZ0wywDGdqL
 L5Qg==
X-Gm-Message-State: AGi0PuYUPN1ATJ0OPAeTWk6gSrAeH6N/tBJmt4+58HBDWeCEI6XQrc4I
 tdQB4LkIsz9sNDCnZ9EDTquzIQ==
X-Google-Smtp-Source: APiQypJxEd+PJmNDcyxP4QzRwt3hU18x/fN6iSWfl4tW4RIpkWcDDV0kMuY5raGRzhK6CxHZnWCF5w==
X-Received: by 2002:adf:91e3:: with SMTP id 90mr32031468wri.206.1588062999782; 
 Tue, 28 Apr 2020 01:36:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m8sm25814928wrx.54.2020.04.28.01.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 01:36:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 663FF1FF7E;
 Tue, 28 Apr 2020 09:36:37 +0100 (BST)
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luoyonggang@gmail.com
Subject: Re: About hardfloat in ppc
In-reply-to: <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
Date: Tue, 28 Apr 2020 09:36:37 +0100
Message-ID: <87ftcoknvu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::431
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> I am confusing why only  inexact  are set then we can use hard-float.

The inexact behaviour of the host hardware may be different from the
guest architecture we are trying to emulate and the host hardware may
not be configurable to emulate the guest mode.

Have a look in softfloat.c and see all the places where
float_flag_inexact is set. Can you convince yourself that the host
hardware will do the same?

> And PPC always clearing inexact  flag before calling to soft-float
> funcitons. so we can not
> optimize it with hard-float.
> I need some resouces about ineact flag and why always clearing inexcat in
> PPC FP simualtion.

Because that is the behaviour of the PPC floating point unit. The
inexact flag will represent the last operation done.

> I am looking for two possible solution:
> 1. do not clear inexact flag in PPC simulation
> 2. even the inexact are cleared, we can still use alternative hard-float.
>
> But now I am the beginner, Have no clue about all the things.

Well you'll need to learn about floating point because these are rather
fundamental aspects of it's behaviour. In the old days QEMU used to use
the host floating point processor with it's template based translation.
However this led to lots of weird bugs because the floating point
answers under qemu where different from the target it was trying to
emulate. It was for this reason softfloat was introduced. The hardfloat
optimisation can only be done when we are confident that we will get the
exact same answer of the target we are trying to emulate - a "faster but
incorrect" mode is just going to cause confusion as discussed in the
previous thread. Have you read that yet?

>
> On Mon, Apr 27, 2020 at 7:10 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>>
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>
>> > On Mon, 27 Apr 2020, Alex Benn=C3=A9e wrote:
>> >> =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> wri=
tes:
>> >>> Because ppc fpu-helper are always clearing float_flag_inexact,
>> >>> So is that possible to optimize the performance when
>> float_flag_inexact
>> >>> are cleared?
>> >>
>> >> There was some discussion about this in the last thread about enabling
>> >> hardfloat for PPC. See the thread:
>> >>
>> >>  Subject: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
>> >>  Date: Tue, 18 Feb 2020 18:10:16 +0100
>> >>  Message-Id: <20200218171702.979F074637D@zero.eik.bme.hu>
>> >
>> > I've answered this already with link to that thread here:
>> >
>> > On Fri, 10 Apr 2020, BALATON Zoltan wrote:
>> > : Date: Fri, 10 Apr 2020 20:04:53 +0200 (CEST)
>> > : From: BALATON Zoltan <balaton@eik.bme.hu>
>> > : To: "=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)" <luoyonggang@gmail.c=
om>
>> > : Cc: qemu-devel@nongnu.org, Mark Cave-Ayland, John Arbuckle,
>> qemu-ppc@nongnu.org, Paul Clarke, Howard Spoelstra, David Gibson
>> > : Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
>> > :
>> > : On Fri, 10 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>> > :> Are this stable now? I'd like to see hard float to be landed:)
>> > :
>> > : If you want to see hardfloat for PPC then you should read the
>> > replies to : this patch which can be found here:
>> > :
>> > : http://patchwork.ozlabs.org/patch/1240235/
>> > :
>> > : to understand what's needed then try to implement the solution with
>> > FP : exceptions cached in a global that maybe could work. I won't be
>> > able to : do that as said here:
>> > :
>> > : https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00006.html
>> > :
>> > : because I don't have time to learn all the details needed. I think :
>> > others are in the same situation so unless somebody puts in the :
>> > necessary effort this won't change.
>> >
>> > Which also had a proposed solution to the problem that you could try
>> > to implement, in particular see this message:
>> >
>> >
>> http://patchwork.ozlabs.org/project/qemu-devel/patch/20200218171702.979F=
074637D@zero.eik.bme.hu/#2375124
>> >
>> > amd Richard's reply immediately below that. In short to optimise FPU
>> > emulation we would either find a way to compute inexact flag quickly
>> > without reading the FPU status (this may not be possible) or somehow
>> > get status from the FPU but the obvious way of claring the flag and
>> > reading them after each operation is too slow. So maybe using
>> > exceptions and only clearing when actually there's a change could be
>> > faster.
>> >
>> > As to how to use exceptions see this message in above thread:
>> >
>> > https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00005.html
>> >
>> > But that's only to show how to hook in an exception handler what it
>> > does needs to be implemented. Then tested and benchmarked.
>> >
>> > I still don't know where are the extensive PPC floating point tests to
>> > use for checking results though as that was never answered.
>>
>> Specifically for PPC we don't have them. We use the softfloat test cases
>> to exercise our softfloat/hardfloat code as part of "make
>> check-softfloat". You can also re-build fp-bench for each guest target
>> to measure raw throughput.
>>
>> >> However in short the problem is if the float_flag_inexact is clear you
>> >> must use softfloat so you can properly calculate the inexact status. =
We
>> >> can't take advantage of the inexact stickiness without loosing the
>> >> fidelity of the calculation.
>> >
>> > I still don't get why can't we use hardware via exception handler to
>> > detect flags for us and why do we only use hardfloat in some corner
>> > cases. If reading the status is too costly then we could mirror it in
>> > a global which is set by an FP exception handler. Shouldn't that be
>> > faster? Is there a reason that can't work?
>>
>> It would work but it would be slow. Almost every FP operation sets
>> the inexact flag so it would generate an exception and exceptions take
>> time to process.
>>
>> For the guests where we use hardfloat operations with inexact already
>> latched is not a corner case - it is the common case which is why it
>> helps.
>>
>> >
>> > Regards,
>> > BALATON Zoltan
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--=20
Alex Benn=C3=A9e

