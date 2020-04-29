Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD466C83009
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DD02087E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIcbZYiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DD02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmw2-0003VJ-Lq
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTmux-0002kK-2T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTmuv-0002V5-OC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:38:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:44914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jTmuv-0002Uc-9S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:38:25 -0400
Received: by mail-wr1-x430.google.com with SMTP id d17so2537603wrg.11
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yfH9Ib8urADT/bMWeg1xr56qLdhOEDuW26ehTPXTj9s=;
 b=ZIcbZYiqS0YkwiMQ08qPF05QZRwhqTLFVtKBrPuRlw242Dcgso0E9tMO8Co52ZA4Ww
 kgK7RF4wacinfOMoW5AQRxqB71lK5fKEtp9xP62DcaHDV8pWolLpavSZLMv/mq5k3TnY
 NNvYGmeQ4qqBF4M++uX7/Nqjaw71WpZo6KwDmg71I/yGnEA6Ai0APJyvT8k4SRxZF205
 BYk+AhwZvE6jxUIyvh5MrfMa7EZqUu/YT1tRe4am+xWTgaEEn1ujgrI2KLL7SlGjFmwf
 F6FCO5e7HZcD/T4ccKgQMVSgCtk8MXXuoPHYN+y3PlMWuvenq5bAubaKKwxNI9YTyi9q
 A2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yfH9Ib8urADT/bMWeg1xr56qLdhOEDuW26ehTPXTj9s=;
 b=WSxPtQrg9JE3OvTrZemgZQGMxawNwAPc6sCcsQ9HSv3xRu26SccMApdt/Eow12Xxy0
 OqelsHjkRlkdR/KGEcUW/B4EJ7v6OvXOi96LgrHvmhoJVdWY/6XrAVueJBegfI2Xu/Nb
 ErYMDO6ugvQd4p1RTGkr9vLnEq1UGbSIIQvyHQUS+jli2Zubohym3VZk9JheNP7pDzId
 BzToLF8ttVJzi6VFFmYo1a9qxzo/op3+gzvapqo6z+hKgDPJcavWGx5gn6GL2ES2Pqzj
 +bPfDLxMZDwn5K1CgSs4QFqEfW9YPa23WxFDF4O+zRixC3VRT2/By8KEQ1ckYBouH/Hg
 4D3g==
X-Gm-Message-State: AGi0Pua6XvA0J89ijGI5unBGujTpbFiagERirli5h3+vZ0s0E0lI2xFh
 gGxynZ4SCW68txmWVmDjsjKgWw==
X-Google-Smtp-Source: APiQypIfguxP3vsU+lZSz1wtg9ZiP+bamXnat1GH99vXYrY234pqaBePuAynTbcDEW33CS1Iszc5QQ==
X-Received: by 2002:a5d:470a:: with SMTP id y10mr38496718wrq.63.1588167503303; 
 Wed, 29 Apr 2020 06:38:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l6sm30759334wrb.75.2020.04.29.06.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 06:38:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5DA121FF7E;
 Wed, 29 Apr 2020 14:38:20 +0100 (BST)
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <CAE2XoE-6bRUsgJ2rvcb6Wb_OqSDoQEkMy2T==h_qjU5k7XawPA@mail.gmail.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luoyonggang@gmail.com
Subject: Re: R: About hardfloat in ppc
In-reply-to: <CAE2XoE-6bRUsgJ2rvcb6Wb_OqSDoQEkMy2T==h_qjU5k7XawPA@mail.gmail.com>
Date: Wed, 29 Apr 2020 14:38:20 +0100
Message-ID: <87y2qejttf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Dino Papararo <skizzato73@msn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> On Wed, Apr 29, 2020 at 7:57 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>>
>> Dino Papararo <skizzato73@msn.com> writes:
>>
>> > Hello,
>> > about handling of PPC fpu exceptions and Hard Floats support we could
>> consider a different approach for different instructions.
>> > i.e. not all fpu instructions take care about inexact or exceptions
>> bits: if I take a simple fadd f0,f1,f2 I'll copy value derived from addi=
ng
>> f1+f2 into f1 register and no one will check about inexact or exception
>> bits raised into FPSCR register.
>> > Instead if I'll take fadd. f0,f1,f2 the dot following the add
>> instructions means I want take inexact or exceptions bits into account.
>> > So I could use hard floats for first case and softfloats for second ca=
se.
>> > Could this be a fast solution to start implement hard floats for PPC??
>>
>> While it may be true that normal software practice is not to read the
>> exception registers for every operation we can't base our emulation on
>> that. We must always be able to re-create the state of the exception
>> registers whenever they may be read by the program. There are 3 cases
>> this may happen:
>>
>>   - a direct read of the inexact register
>>   - checking the sigcontext of a synchronous exception (e.g. fault)
>>   - checking the sigcontext of an asynchronous exception (e.g. timer/IPI)
>>
>> Given the way the translator works we can simplify the asynchronous case
>> because we know they are only ever delivered at the start of translated
>> blocks. We must have a fully rectified system state at the end of every
>> block. So lets consider some cases:
>>
>>   fpOpA
>>   clear flags
>>   fpOpB
>>   clear flags
>>   fpOpC
>>   read flags
>>
> So we only need clear flags for before the fp op that are running before
> the read flags are
> triggered?  So the key point is finding all the read flags op, and find t=
he
> latest clear flags op
> before the latest fp op instuction that before the read flags. May this be
> expressed in TCG ops?

In the simple case of flags not being able to be read from a chain of
operations this could all be handled in the front end by using a
different set of helpers (or maybe tweaking the helper to handle a NULL
fpst?) when it knows the values won't be needed.

The trouble is scanning forward enough to know this is the case as the
way the decoders currently work is by dealing with an instruction at a
time. There are some cases where we use tcg_last_op() to save the
location of an operations and then tcg_set_insn_param() update a
parameter after the fact. Your could save the location of every fpOp
with tcg_last_op() and then go through each on updating the parameters
to the helper to indicate if you care about calculating the flags or
not.

>> Assuming we know the fpOps can't generate exceptions we can know that
>> only fpOpC will ever generate a user visible floating point flags so we
>> can indeed use hardfloat for fpOpA and fpOpB. However if we see the
>> pattern:
>>
>>   fpOpA
>>   ld/st
>>
> What does ld/st means? load and store float point values?

Generally any load or store to memory has the potential to fault
regardless of what it is actually storing. There may be other
potentially faulting instructions as well - it will depend on your
architecture.

--=20
Alex Benn=C3=A9e

