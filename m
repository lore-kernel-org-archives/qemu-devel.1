Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3360CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FE3206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIbygkgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FE3206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1xk-0007MX-3q
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv1ws-0006ts-TD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv1wr-0004Md-Dx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:36:46 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv1wr-0004M9-5v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:36:45 -0500
Received: by mail-wr1-x444.google.com with SMTP id j42so2705520wrj.12
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oywCRLOgN4LhOSUnxvTQCMRbRy7Tp6fcb+avtz3svKk=;
 b=iIbygkgZtbuKeN4LahQzMVrx2CecHGcc69POBWYEgsPDILGrAYNvl9n2W3ESL5cGS5
 7mHs6JwgauMprI03UP6CUQAjMqO0T3WbuluJfVGeT80fTySm7fKkzM18etW8t/RmIw+y
 JJcVAee9ODhIAIYTP17UU+W2YdPlUws6S/Diy1Su0ftW4tlfaoJz0rtF5hjWCBbYLOal
 pq4JhmCiIo+3msr5hAfNgBQPw0VdvJdgg7XbQW0C1RvZND4kYlda4h05OCDzrQCqmiM3
 KwOMuE2Bqn5GSnUXIX/wy5rbX8DwzG1SeAkwl9BrmLpB6Or+NKRNedEGlNSKyjQWKeC8
 K/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oywCRLOgN4LhOSUnxvTQCMRbRy7Tp6fcb+avtz3svKk=;
 b=Q2uAFe2FLZ/lB2rlpJYCKQIu4BGrtT/2i96yoQht9r6iZuKiI3W85+WuXr/aD80Z+z
 TP757aQlDWiv/eeZvLLGsayLHeBC7qRZ0su3ClVk0OVSKxEvMjUpuBBBCbhu98vakiP6
 +fSVdxit2GuNao2Y14S2I9Nu5h9WukUdSxNe4MrgN2cVJtbYSZQwrxjZmftU2J8oZEgD
 l0pwkGdUMpL7436ovdjvEbLH030b7uESSLQ9WZZ5I/ODdGsbUbf8BeoH8x3EIssIBbdV
 PPcWAwysD7p4oRdHTYYV0zmr8XYr5+45rE+94ougYfWBKGCOfDUNNAUZRsn4qIVx+v9m
 UEZw==
X-Gm-Message-State: APjAAAUFsMxwLDODCZWYXoCYdX+H0o0IkikZ4VVHLsb4Uld0GQFX8S2Z
 RnsX46ZpFVtErYB+jOMuQCR9Sw==
X-Google-Smtp-Source: APXvYqxoh4iUeM8QSKSC37w5xvFg4kXgXw4KCcEUoaZKH12Z0V2wjOKG9mCkMIUktO0JvdQYgQdLdg==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr5135703wrv.259.1579883803528; 
 Fri, 24 Jan 2020 08:36:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i8sm8303823wro.47.2020.01.24.08.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:36:42 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C797B1FF87;
 Fri, 24 Jan 2020 16:36:41 +0000 (GMT)
References: <BL0PR2101MB1026C24DACAFB1771DE47706D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Henry <robhenry@microsoft.com>
Subject: Re: QEMU for aarch64 with plugins seems to fail basic consistency
 checks
In-reply-to: <BL0PR2101MB1026C24DACAFB1771DE47706D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>
Date: Fri, 24 Jan 2020 16:36:41 +0000
Message-ID: <87eevoak12.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Henry <robhenry@microsoft.com> writes:

> I wrote a QEMU plugin for aarch64 where the insn and mem callbacks
> print out the specifics of the guest instructions as they are
> "executed".  I expect this trace stream to be well behaved but it is
> not.

Can you post your plugin? It's hard to diagnose what might be wrong
without the actual code.

> By well-behaved, I expect memory insns print out some memory details,
> non-memory insns don't print anything, and the pc only changes after a
> control flow instruction.

Exactly how are you tracking the PC? You should have the correct PC as
you instrument each instruction. Are you saying qemu_plugin_insn_vaddr()
doesn't report a different PC for each instrumented instruction in a block?

> I don't see that gross correctness about 2%
> of the time.


>
>
>   1.  I'm using qemu at tag v4.2.0 (or master head; it doesn't matter), r=
unning on a x86_64 host.
>   2.  I build qemu using   ./configure --disable-sdl --enable-gtk --enabl=
e-plugins --enable-debug --target-list=3Daarch64-softmmu aarch64-linux-user
>   3.  I execute qemu from its build area build/aarch64-linux-user/qemu-aa=
rch64, with flags --cpu cortex-a72 and the appropriate args to --plugin ...=
 -d plugin -D .....
>   4.  I'm emulating a simple C program in linux emulation mode.
>   5.  The resulting qemu execution is valgrind clean (eg, I run qemu unde=
r valgrind) for my little program save for memory leaks I reported a few da=
ys ago.
>
> Below is an example of my trace output (the first int printed is the cpu_=
index, checked to be always 0). Note that the ldr instruction at 0x41a608 s=
ometimes reports a memop, but most of the time it doesn't.  Note that 0x41a=
608 is seen, by trace, running back to back. Note that (bottom of trace) th=
at the movz instruction reports a memop.  (The executed code comes from gli=
bc _dl_aux_init, executed before main() is called.)
>
> How should this problem be tackled? I can't figure out how to make each t=
cg block be exactly 1 guest (aarch64) insn, which is where I'd first start =
out.
>
> 0 0x000000000041a784 0x000000000041a784 0xf1000c3f cmp x1, #3
> 0 0x000000000041a788 0x000000000041a788 0x54fff401 b.ne #0xfffffffffffffe=
80
> 0 0x000000000041a78c 0x000000000041a78c 0x52800033 movz w19, #0x1
> 0 0x000000000041a790 0x000000000041a790 0xf9400416 ldr x22, [x0, #8] 0 me=
m  {3 0 0 0} 0x0000004000800618
> 0 0x000000000041a794 0x000000000041a794 0x17ffff9d b #0xfffffffffffffe74
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!  =
0 mem  {3 0 0 0} 0x0000004000800620
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!  =
0 mem  {3 0 0 0} 0x0000004000800630
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1
> 0 0x000000000041a7dc 0x000000000041a7dc 0xf9400418 ldr x24, [x0, #8] 0 me=
m  {3 0 0 0} 0x0000004000800638
> 0 0x000000000041a7e0 0x000000000041a7e0 0x17ffff8a b #0xfffffffffffffe28
> 0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1 0 mem  =
{3 0 0 0} 0x0000004000800640

I'd like to see the -d in_asm,op,op_opt for that unexpected memop operation.

--=20
Alex Benn=C3=A9e

