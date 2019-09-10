Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02EFC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FDD2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AE6b2W7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FDD2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7k9w-0002wo-Jh
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 13:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7k9A-0002Un-A7
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7k99-0005wM-58
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:41:44 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7k98-0005vm-Ty
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:41:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id c10so503304wmc.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=13ZLcUNRuE1br664O6/KfPn7t6FX2PcmdNwYuj6i1zQ=;
 b=AE6b2W7EPaNRX+MQ2UCqAa/5w6Q8/v3Zn73A1+je7HwkW0SfB9vrSR0xBKYHQHJC/b
 1gEcNReja7pPcq6iIVI/JKwUMbIWjzcDbd+p5+a3vpK69B5PKANAmdfIuDO+M+ivPWwX
 TIJcTBZL56+BTzYhKqwcUSv036IOoPNosikFO3uo5yBE4+VfemSP+UzBXWDAP5j5kBZG
 D2mlM+Nm7DD7jMYmPVirScZ6gDtIRJz8Z+A9MSRA/fCFvbvDgWNHOO6GS3pfAAN0bE46
 DTQwt6j68Lhf4bcSGa5X59shEVHBTlO7jEqECkizL6cbJ1cwCJblG2S6q/Pg8j4EIuEW
 sL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=13ZLcUNRuE1br664O6/KfPn7t6FX2PcmdNwYuj6i1zQ=;
 b=du2xsarOyVSxSCiDN4SmlPReIxkFakN1Y/XcFBeI6be09capWCGfajAk6Mb6bjEboa
 JXBwAT4g5VYwAuuyVKPSd+LkJENPtEEutwIuILsLRz5fCCrKBzm8aQ8BF115OHldLkcK
 QeT+ZF+rmiQkBHTKwdaqLmzl0q0XLor5AtnqWldfSgUGUx/8Nd/cAsuA18lEEQjtFq1/
 qKBOCuBTuP7eCO7ITxjga7G/xJKHNPxv6jDOAltkYhRwAwxavRmAF3+E9j0lcwTwGTRE
 L5Vem0Zpgh1r0Tr7JGiyxSIjLGzwS9hMSE9JBcxkZq0DxKR29i9hClNkppIIsknwQOVh
 GPvg==
X-Gm-Message-State: APjAAAXaQqBU6M94ckHX+1pVeQEht33PIjvbtExX4LzOAvuavennJvld
 4VltT474lo2KR6Kp918c7KujJg==
X-Google-Smtp-Source: APXvYqzC4CfTLLbdJO2AsaYyhYdvf96q1n7LAvhYX2aR2fQoOwMxIf/NboPXAmq7ij6dagNZ67uIJg==
X-Received: by 2002:a1c:a90b:: with SMTP id s11mr570309wme.92.1568137301484;
 Tue, 10 Sep 2019 10:41:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w12sm27970106wrg.47.2019.09.10.10.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 10:41:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 553391FF87;
 Tue, 10 Sep 2019 18:41:40 +0100 (BST)
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-14-alex.bennee@linaro.org>
 <20190802182541.GO5034@quinoa.localdomain> <877e6lz0g2.fsf@linaro.org>
 <20190910162452.GB20976@quinoa.localdomain>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
In-reply-to: <20190910162452.GB20976@quinoa.localdomain>
Date: Tue, 10 Sep 2019 18:41:40 +0100
Message-ID: <87ftl41223.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH  v4 13/54] plugin: add user-facing API
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
Cc: "bobby.prani@gmail.com" <bobby.prani@gmail.com>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:

> On Sep 06 20:31, Alex Benn=C3=A9e wrote:
>> Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:
>>
>> > One thing I would find useful is the ability to access register values
>> > during an execution-time callback. I think the easiest way to do that
>> > generically would be to expose them via the gdb functionality (like
>> > Pavel's earlier patchset did [1]), though that (currently) limits you =
to
>> > the general-purpose registers. Ideally it would be nice be able to
>> > access other registers (i.e. floating-point, or maybe even system
>> > registers), though those are more difficult to do generically.
>>
>> ARM already has system register support via the gdbstub XML interface so
>> it's certainly doable. The trick is how we do that in a probable way
>> without leaking the gdb remote protocol into plugins (which is just very
>> ugly).
>
> What do you mean by "in a probable way"?
>
> I agree that simply exposing the gdb interface does not seem like a
> clean solution.

That was a typo - portable was what I was aiming for. The problem with
the gdb interface is how you tie register id's to something useful
rather than having to encode the arbitrary gdb register enumeration into
your plugins.

>
>> > Perhaps if we added some sort of architectural-support checking for
>> > individual plugins like I mentioned in another response to this
>> > patchset, we could allow some limited architecture-specific
>> > functionality in this vein? I confess I haven't thought through all the
>> > ramifications of that yet, though.
>>
>> I was wondering if exposing the Elf Type would be enough? It's portable
>> enough that plugins should be able to work with it without defining our
>> own architecture enumeration.
>
> I can't think of a reason that wouldn't work, assuming you're referring
> to exposing a value corresponding to the `e_machine` ELF header.

Yes exactly that - I started but uncovered some hideousness in our
current Elf support so there will be a short diversion to re-factor that
into something a bit more usable across the code base.

>
> -Aaron


--
Alex Benn=C3=A9e

