Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B640C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90FC206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+LjWOoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90FC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isBYU-0002bJ-Vy
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 15:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1isBXp-00029y-M6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1isBXo-0006yj-3j
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:15:09 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1isBXn-0006xb-Qm
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:15:08 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so5149878wmb.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 12:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fXaesIKoGQGeZU0nbRX/pIXE+M1iLPRYjJ8BP8agBZ0=;
 b=V+LjWOoESG65Zn3JggSeVw+MYq24Ri46LSMcBASGi8OwVdzsx4rkazgTkzbNUgU86Y
 NrhipiWabFuvKsQySLjm4mcs3VG5uKZMgI5d7s/n+PanDhZV2PC3sKO6lnzluA7pYBVQ
 Cs/bPtajZ6zyDEcJB8Cgjk5buF+Bl1eFvXOm/Axq7miJGqIsr7cJfSqSt5rAKtW3PJVI
 7ElXEGLIakj3KxfpFebn6C97JU+uQ3ClHbJCFc3wEhIfCoQYQEhV4tjZU0vi0dx+C+n8
 3a+x6h0d+RczIVXFW4ydyN03Pdw5NzF6TEuMg1PWNo3FDeEYCJSd0tiVxipQfuExsbGS
 Tc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fXaesIKoGQGeZU0nbRX/pIXE+M1iLPRYjJ8BP8agBZ0=;
 b=cFLz+vq1VmjVdkgMgO/40q70ub68RAiyaAuKstKl3A0gj+b/H6+DGc36bGW+O5Obj1
 780Wg0NU8OmG2ifUgLcBPdB9+6lXjDtcGGakhTBFuE/3yyliRIgldqRgd3wbaQtmL3Da
 2HELrjn0x0Oxva759kHi5nFja7LJsAy8syJPxhjgyXHUzisqyiTHP02JD55AzC5mrT/U
 k+P9QCVpGt2TKQFVCXClLgS6lD+FP98kL9DtOuy3/ebfcnYMUuzRJf1bJLBPUqmWAm2l
 MAcFlYrZ2queb5cI4IIEYHBNI0EMNOPc0aCprXCaGvbLUmhccxo4K0J/P7rpxf3UU7Gj
 6WMQ==
X-Gm-Message-State: APjAAAWBCbClTffh0UVFjMJP89P2Zss5CXgikynIZPQvSEIlRwAolod0
 FjIAtVPPgW6hTEj/iKktBLjojQ==
X-Google-Smtp-Source: APXvYqy5H+okbQiNxBIX1lSl3as19FOak3Q03pKBlnpUNB3XsU+Yu3txeCMalDbJv1WCmkpgmFxFHA==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr876629wmg.16.1579205706078; 
 Thu, 16 Jan 2020 12:15:06 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z6sm30373579wrw.36.2020.01.16.12.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 12:15:04 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 22C4F1FF87;
 Thu, 16 Jan 2020 20:15:04 +0000 (GMT)
References: <20200114210921.11216-1-richard.henderson@linaro.org>
 <20200114210921.11216-4-richard.henderson@linaro.org>
 <87ftgfl64x.fsf@linaro.org>
 <3733f2cd-9262-d7f9-ab9c-c8a3032732df@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 3/3] linux-user/i386: Emulate x86_64 vsyscalls
In-reply-to: <3733f2cd-9262-d7f9-ab9c-c8a3032732df@linaro.org>
Date: Thu, 16 Jan 2020 20:15:04 +0000
Message-ID: <87d0bjkvjr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, riku.voipio@iki.fi,
 laurent@vivier.eu, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 1/16/20 6:26 AM, Alex Benn=C3=A9e wrote:
>>> +    /*
>>> +     * Perform the syscall.  None of the vsyscalls should need restart=
ing,
>>> +     * and all faults should have been caught above.
>>> +     */
>>> +    ret =3D do_syscall(env, syscall, env->regs[R_EDI], env->regs[R_ESI=
],
>>> +                     env->regs[R_EDX], env->regs[10], env->regs[8],
>>> +                     env->regs[9], 0, 0);
>>=20
>> How come the register ABI to the syscall is different to the others. I
>> can see why syscall doesn't come from EAX but the others are a different
>> set to normal syscalls which might be why:
>
> Cut and paste error, I assume.
>
> That said, the three syscalls have a maximum of 2 arguments,
> so I could really just pass EDI and ESI and 0 for the rest...
>
>> I'm seeing a EFAULT on the gettimeofday failure:
>
> What getttimeofday failure?  Is this related to the mention of /sbin/ldco=
nfig
> in your previous message?

No - the buster x86064 ldconfig seg is unrelated to this series. It has
however spawned an additional bug in gdbstub while it was at it ;-)

>
>>    #0  do_syscall (cpu_env=3Dcpu_env@entry=3D0x5555577d2b10, num=3Dnum@e=
ntry=3D96, arg1=3D0, arg2=3D0, arg3=3D4211016, arg4=3D8, arg5=3D27488867718=
4, arg6=3D274886295415, arg7=3D0, arg8=3D0) at /home/alex/lsrc/qemu.git/lin=
ux-user/syscall.c:12076=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
>>    #1  0x0000555555609b6e in emulate_vsyscall (env=3D0x5555577d2b10) at =
/home/alex/lsrc/qemu.git/linux-user/x86_64/../i386/cpu_loop.c:180
>>    #2  cpu_loop (env=3D0x5555577d2b10) at /home/alex/lsrc/qemu.git/linux=
-user/x86_64/../i386/cpu_loop.c:246=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>>    #3  0x000055555559640e in main (argc=3D<optimized out>, argv=3D<optim=
ized
>>    #out>, envp=3D<optimized out>) at
>>    #/home/alex/lsrc/qemu.git/linux-user/main.c:865
>>=20
>> arg1/arg2 don't seem right here.
>
> Why?  NULL value for arg1 is legal, though semi-useless.
>
> Ah, I see that our implementation of gettimeofday doesn't honor NULL.
>
>
> r~


--=20
Alex Benn=C3=A9e

