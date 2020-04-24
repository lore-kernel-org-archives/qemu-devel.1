Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7513DC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FCB205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivlctq7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FCB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRyJH-0007mv-F2
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 09:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRyIS-0006yu-Jw
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRyIR-0006uv-N7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:23:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRyIR-0006qf-1t
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:23:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id t14so10762081wrw.12
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wixBzal9tsivTqUJhXcbaIrRxfzuIbR6n5EuseLtOO0=;
 b=ivlctq7ijYC++HGgPI5VBV4KK/aVmdUT0RXzcbqEP4JXSgODjcwWq/J95mupmosoKz
 qniWi6T9mq3zBRcgJ/OO7kssqgCjQyqPAgCmZxpIl2AaQmjThUD/O9hzjFFO183sPRmQ
 nZ1DFFhRXGjvFyep7+UMUKJ8K2WhoYCBzTErfYZEwNFKkGL6LLg4OKk9Qyn1+aHmIWli
 yFtqFa84eFg5dPcFBoXMF6zsg33aGzgFWfiNgG/p/IkW6jHeprSN7Vej4dk0WS/YIHF8
 jWkIyeSrRs/n3gPMCadydImu76Zqj20sIiq9lyNcLcNXeaBoaLIeTsPOnayd0RKldQQW
 CPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wixBzal9tsivTqUJhXcbaIrRxfzuIbR6n5EuseLtOO0=;
 b=D8iaMEORMgVt/aQ2PbR4/v7J3eFBSG1OiOJb0k9Yez3PMthOoUMXp5tOz965tv5T8b
 ZWVKb00RyeU4VAPTj1ZPa4gQvuQUZmfc05lhDQHtIw1F4/WcwsyW6QPNBVYYXmXKnTnh
 uGlPXNZC6L67+M6cBmxtrK1bqdLDWY1mkocah+OFTT+vMpq5jaJK9P2Ap+/+xNAnyUgZ
 e8nyqZC1mluvPgZNyYwq1FgcAPx4GaSea/nKNvhogGSZYgtGeJzKbrcK+bNLwsIBv13b
 s6/4nH8fTsBUklDxxm5YV5pO9OyZ4A9m10z29bVwuhVE105ditmn14efZlZyeDYvtWF8
 18mA==
X-Gm-Message-State: AGi0PuZ8317F/Ei+r2lC0ScGtKPyeIss4lEVYbo8e8P7cLEzQIrwB9hT
 3gk+htvYCjOhw0gBqdnQNjf+qQ==
X-Google-Smtp-Source: APiQypI/j5bo6/ivgE3U0AvPBLpA1kT6dh4GNBPvtNcjWLYOYn/Onq6E+YGKLgGEZ1v331kC2GTn6w==
X-Received: by 2002:a5d:6b85:: with SMTP id n5mr11284855wrx.370.1587734589007; 
 Fri, 24 Apr 2020 06:23:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l9sm8266488wrq.83.2020.04.24.06.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 06:23:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A25D01FF7E;
 Fri, 24 Apr 2020 14:23:06 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-14-richard.henderson@linaro.org>
 <87ftcvb82k.fsf@linaro.org>
 <df8292e5-5b27-31eb-1e4a-3e8f835481fc@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 13/36] tcg: Use tcg_constant_{i32,i64} with tcg int
 expanders
In-reply-to: <df8292e5-5b27-31eb-1e4a-3e8f835481fc@linaro.org>
Date: Fri, 24 Apr 2020 14:23:06 +0100
Message-ID: <87d07x9fwl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/22/20 1:04 PM, Alex Benn=C3=A9e wrote:
>>=20
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>=20
>> We have a regression. Setting up a build dir with:
>>=20
>>   ../../configure --disable-tools --disable-docs --target-list=3Dsparc-s=
oftmmu,sparc64-softmmu
>>   make -j30 && make check-acceptance
>>=20
>> And then running a bisect between HEAD and master:
>>=20
>>   git bisect run /bin/sh -c "cd builds/bisect && make -j30 && ./tests/ve=
nv/bin/avocado run ./tests/acceptance/boot_linux_console.py:BootLinuxConsol=
e.test_sparc_ss20"
>>=20
>> Fingers:
>>=20
>>   a4d42b76dd29818e4f393c4c3eb59601b0015b2f is the first bad commit
>>   commit a4d42b76dd29818e4f393c4c3eb59601b0015b2f
>>   Author: Richard Henderson <richard.henderson@linaro.org>
>>   Date:   Tue Apr 21 18:16:59 2020 -0700
>>=20
>>       tcg: Use tcg_constant_{i32,i64} with tcg int expanders
>>=20
>>       Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>       Message-Id: <20200422011722.13287-14-richard.henderson@linaro.org>
>
> Ho hum.  I can reproduce this, but after a day of debugging I'm no closer=
 to
> figuring out what's wrong than when I started.
>
> I'm going to put this whole section of TEMP_CONST to the side for now.

From my own poking around I can say the hang occurs when you first
introduce just:

  void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
  {
      tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
  }

and nothing else. Which indicates the problem has to be in the core
plumbing itself. This is odd because all the other architectures are
fine. I wonder if there is something special about sparc's constant
generation?

Eyeballing the numbers it does seem like sparc generates more negative
numbers than ARM does - although ARM does generate some. I thought I'd
just have a check to see what happens so I looked at the first
occurrence in the sparc test:

  0x00006224:  sethi  %hi(0xffdcf000), %g6
  0x00006228:  mov  %g6, %g6      ! 0xffdcf000
  0x0000622c:  sethi  %hi(0xffd00000), %g4
  0x00006230:  mov  %g4, %g4      ! 0xffd00000
  0x00006234:  sub  %g6, %g4, %g6
  0x00006238:  sub  %g1, %g6, %g3
  0x0000623c:  sethi  %hi(0x1000), %g5
  0x00006240:  sub  %g3, %g5, %g3
  0x00006244:  sub  %g3, %g5, %g3

Which seems to be translated into ops ok:

   ---- 00006224 00006228
   mov_i32 g6,$0xffdcf000

   ---- 00006228 0000622c

   ---- 0000622c 00006230
   mov_i32 g4,$0xffd00000

   ---- 00006230 00006234

   ---- 00006234 00006238
   sub_i32 tmp0,g6,g4
   mov_i32 g6,tmp0

   ---- 00006238 0000623c
   sub_i32 tmp0,g1,g6
   mov_i32 g3,tmp0

   ---- 0000623c 00006240
   mov_i32 g5,$0x1000

   ---- 00006240 00006244
   sub_i32 tmp0,g3,g5
   mov_i32 g3,tmp0

   ---- 00006244 00006248
   sub_i32 tmp0,g3,g5
   mov_i32 g3,tmp0

and looks like its doing the expected constant folding here.

   ---- 00006224 00006228

   ---- 00006228 0000622c

   ---- 0000622c 00006230

   ---- 00006230 00006234

   ---- 00006234 00006238
   movi_i32 tmp0,$0xcf000                   pref=3D0xffff
   mov_i32 g6,tmp0                          dead: 1  pref=3D0xffff

   ---- 00006238 0000623c
   sub_i32 tmp0,g1,g6                       dead: 1 2  pref=3D0xffff
   mov_i32 g3,tmp0                          dead: 1  pref=3D0xffff

   ---- 0000623c 00006240
   mov_i32 g5,$0x1000                       sync: 0  dead: 0  pref=3D0xffff

   ---- 00006240 00006244
   sub_i32 tmp0,g3,$0x1000                  dead: 1  pref=3D0xffff
   mov_i32 g3,tmp0                          dead: 1  pref=3D0xffff

   ---- 00006244 00006248
   sub_i32 tmp0,g3,$0x1000                  dead: 1  pref=3D0xffff
   mov_i32 g3,tmp0                          sync: 0  dead: 1  pref=3D0xf038


One other data point is it is certainly in the optimisation phase that
things go wrong because:

  //#define USE_TCG_OPTIMIZATIONS

means the test passes.


>
>
> r~


--=20
Alex Benn=C3=A9e

