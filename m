Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24041C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE6420657
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRb9Vn98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE6420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36791 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYQFr-0007jv-VF
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 03:22:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hYQED-0006bQ-SU
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hYQEC-0000H9-5e
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:20:57 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:39016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hYQEB-0000Fz-Ub
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:20:56 -0400
Received: by mail-qk1-x742.google.com with SMTP id i125so4531458qkd.6
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 00:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=U1zLkU5pz1XuVG4+G1IidtZr8Fv8ZxQTJnfojFUkkpc=;
	b=IRb9Vn98aTDmpg+yqzBOgkzP+hha6/8MKgBzYGxow0jKg2CaSNYK84xHC2YC/U8xsI
	IbbVZO+MG17+MqtWDe9Hhw0wKEHFTTDl4T3iHBGvLjTuCSGGPgLwdyad+uplIvOWRhkb
	NIGDqh+o9zjt8wI8LfnkQI52dectRO1c/hmjy23YKPoZlSxKRbYqfDdzI1GN4ZmIa8Jo
	sjpQceDFKMgoRk9CGE/m8rlPDnhNDriS30ke1Zfv6BxqFH/qQ3tVPpk9FfggHnhim7nm
	7XueinyBgeOoPGZ6goUkb03mpjQnXz8sz9Od7WDeC0vxa1nUxEl5H10f7uqgNTli+qg/
	V79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=U1zLkU5pz1XuVG4+G1IidtZr8Fv8ZxQTJnfojFUkkpc=;
	b=GdGXlfb8LNRR0/ynfMoxkyVBwskWkgw+I5TXPzDleYLYnUL5UnX+5SDj/VOiV8mB1V
	uR6+B7PTQWkbpWglzh5bNrxFOIQYEqrOedIdBe6Q8NonXw/xO5u8tA3Yla5u+B/eWlxQ
	xWxfLCechRY7ZCD4vX3sGKPQq17TA18DRphBYs0cy9rnpkMiK4keKadzBU4J58Ofy4II
	SxW/1lwW6iHD9H3eOjDxVizS8a7yVvxq01fLvgsFX+NRvFkJMsZfhVSslNnX8KU5psHF
	S/vEMB5J3iGyPFVdTUpcz5iCQM5kvfeqkIwFJnIrnXHafohgRhUX7c/d3Ek3Cv6wAW0z
	furg==
X-Gm-Message-State: APjAAAX9T5GKPFfb8nC9HEvhqx1jWFmBYqTaVCVZOxKruVF9KPhzsMiB
	1yr7c4b+wfK32z21lCZLZuOZk11CGFtH4poQLDsS7k24M3cHeQ==
X-Google-Smtp-Source: APXvYqx/O0UCneqXWJN6HvCdi2wwwD3UEli8llnKbbtvqpeWBNZg8FVSHz0KP2RgY4Vcx/Bb85r0M4qphOGXFQOUVrs=
X-Received: by 2002:a37:b8c5:: with SMTP id i188mr11847654qkf.7.1559719254686; 
	Wed, 05 Jun 2019 00:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-4-mrolnik@gmail.com>
	<402ba0b2-e2e0-6b7a-1862-4588e5f83357@linaro.org>
	<CAK4993iXV9oRr_VfabJHg4fCYEppW49i_PE9R0X_TBqk7TDkrQ@mail.gmail.com>
	<9e2acbbe-7ede-c45d-5e9f-bb269aa25fcc@linaro.org>
	<CAK4993hXTOSoW5FFjeur+pLzT18c-C=vwao-904ASyqMsT5eMQ@mail.gmail.com>
	<3bc0d426-bd59-055d-a010-b136cba555bf@linaro.org>
	<CAK4993j5JXgV9CYDckt99kwgQaG6w-GN-Tka7r2nahoh33rheQ@mail.gmail.com>
In-Reply-To: <CAK4993j5JXgV9CYDckt99kwgQaG6w-GN-Tka7r2nahoh33rheQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 5 Jun 2019 10:20:18 +0300
Message-ID: <CAK4993jWViasj8PKUCHcbMh-9SPJmELqua9eSbFvwL7gpm2e5A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::742
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH RFC v20 3/8] target/avr: Add mechanism to
 check for active debugger connection
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard.

I am still struggling with this one.

The spec says.
The BREAK instruction is used by the On-chip Debug system, and is normally
not used in the application software.
When the BREAK instruction is executed, the AVR CPU is set in the Stopped
Mode.
This gives the On-chip Debugger access to internal resources.
If any Lock bits are set, or either the JTAGEN or OCDEN Fuses are
unprogrammed, the CPU will treat the BREAK instruction as a NOP and will
not enter the Stopped mode.

I read is as follows
- If user has an intention of using debugger, BREAK should be translated to
QEMU debug breakpoint
- If user has no intention of using debugger, BREAK should be translated
into NOP.

however it seems that rising EXCP_DEBUG crashes QEMU when no debugger is
present or *-s* was not supplied.

This lead me to the following.
- checking for active GDB connection is not good, because it might change
but translated BREAK will not
- if *-s* is supplied BREAK should always raise EXCP_DEBUG exception
- if *-s* is not supplied BREAK should be translated into NOP

What do you think? How to check existence of *-s* option?

Regards,
Michael



On Mon, Jun 3, 2019 at 8:04 PM Michael Rolnik <mrolnik@gmail.com> wrote:

> Got it.
>
> Sent from my cell phone, please ignore typos
>
> On Mon, Jun 3, 2019, 7:37 PM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> On 6/3/19 11:29 AM, Michael Rolnik wrote:
>> > 1. There's a break
>> > instruction
>> https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_BREAK.html
>> > 2. There's a set of tests that use break.
>> >
>> > So I assume I have to implement this instruction as described in the
>> spec.
>>
>> The spec talks about fuses, not gdb.  A valid implementation of this
>> instruction is a no-op -- it say so right there in the spec.
>>
>> What does it mean to "test" break?  AFAIK, you can't test this at all from
>> within the cpu itself, since it does not generate a cpu-level exception.
>>
>> If gdb is setting a breakpoint via -S, it should be done via
>> cpu_breakpoint_test.
>>
>>
>>
>> > On Mon, Jun 3, 2019, 6:44 PM Richard Henderson <
>> richard.henderson@linaro.org
>> > <mailto:richard.henderson@linaro.org>> wrote:
>> >
>> >     On 6/1/19 4:12 PM, Michael Rolnik wrote:
>> >     > Hi Richard.
>> >     >
>> >     > If I implement it this way
>> >     >
>> >     > ```
>> >     >  static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
>> >     >  {
>> >     >      if (avr_feature(ctx->env, AVR_FEATURE_BREAK) == false) {
>> >     >          gen_helper_unsupported(cpu_env);
>> >     >      } else {
>> >     >          tcg_gen_movi_tl(cpu_pc, ctx->inst[0].npc);
>> >     >          gen_helper_debug(cpu_env);
>> >     >      }
>> >     >
>> >     >      ctx->bstate = BS_EXCP;
>> >     >
>> >     >      return true;
>> >     >  }
>> >     > ```
>> >     >
>> >     > qemu (without -s -S flags) crashes when debugger is not connected
>> >
>> >     I was not suggesting using the internal qemu EXCP_DEBUG, but
>> another AVR
>> >     specific exception, much the same way as every other cpu has a
>> cpu-specific
>> >     debug exception.
>> >
>> >     Or perhaps always do nothing.  Why is gdb insertting BREAK in the
>> first place?
>> >      It should be using the "hardware breakpoint" support that qemu
>> advertises as
>> >     part of the gdbstub protocol, and that you support here:
>> >
>> >     > +        if (unlikely(cpu_breakpoint_test(cs, OFFSET_CODE + cpc *
>> 2, BP_ANY))
>> >     > +                 || cpu_breakpoint_test(cs, OFFSET_DATA + cpc *
>> 2,
>> >     BP_ANY)) {
>> >     > +            tcg_gen_movi_i32(cpu_pc, cpc);
>> >     > +            gen_helper_debug(cpu_env);
>> >     > +            ctx.bstate = BS_EXCP;
>> >     > +            goto done_generating;
>> >     > +        }
>>
>>

-- 
Best Regards,
Michael Rolnik
