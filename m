Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A38EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426192078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJis9n/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426192078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkpPl-0006kd-HL
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 09:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jkpOx-0005uv-Ak
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:43:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jkpOu-0006za-Oe
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:43:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id l17so14717272wmj.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zIkrK4BoVHyz1xvPEY4aIU+SUvF6F89BF9GSMD2TovQ=;
 b=gJis9n/bUis2pRs1rvmrnaTgMMRz1M7zDa+5iDrIYJf+luB6iz6DUB8An0xLZEnRBC
 9FkdYgSz/g3Kk6bjraoy1D53UmioqqZeZlf4yET2aNIDkZZvcb6CS1p6zxnms2KhVV9Q
 iBhh/orWInH0sPTJzHTJaKpJ2SsMLoFdUISnPLZHD8Pe+O540sV1H8wVtyH5+dFYx87E
 3wG1v4d6qO9YNiEjxd35GDBCsEbhr6aa71bHiTlmrGgIWsjQYGlaFjc2/AfDaTBrKUze
 ch1PqLSITVIrgjM316ZK8Fq9ND6ix3Q+i/bkqJdrv5t3KNoXd6gPov6auowKbFIQ/tY4
 kNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zIkrK4BoVHyz1xvPEY4aIU+SUvF6F89BF9GSMD2TovQ=;
 b=NdSC4l1qCQtnERJFv3PCEXaZQQm56st2QhCvvZsZXoZKjxtuhCpSC4Uj1TK51o12wy
 YfyIPphjO6amKgF2kCcTD3WyeijUjUP684Elf+zAfy/ujPR8Pi0cydBddLw0mRgwhgfk
 vCWAT1DVNon5/WuzrAI653XLh+VVCX/AzJkEiiybPN5ZOoVf2J4ziKbQtffyIdtH/tyI
 ODnDi02ZS8MW2Kw6CfD56w/R2fa2STkfr/MHS+E4xUTj201uvWB6tREzbEwECtzGEE+L
 CJ02tYdVUQyEhrQSOKkXGubACqmHR8Npl5upXm861srr8gfrokBKKTI5QDZzFZWrA679
 NH+A==
X-Gm-Message-State: AOAM532KROZ6v36dIsOmSg6FnKbS/lz7/91gD/DOuwiuZDZc2W7LshWe
 2CrsY1tfYJ40WBgqL8A20iq5/g==
X-Google-Smtp-Source: ABdhPJx33k5y/8PPQ7grx4Nx2gwn6KEw7Y6AeHOKBLuWDl7CJb+7xU2gQAwE0mfQZcCABUf1QZ31pw==
X-Received: by 2002:a1c:7d4c:: with SMTP id y73mr13012596wmc.188.1592228626870; 
 Mon, 15 Jun 2020 06:43:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w17sm25548893wra.71.2020.06.15.06.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 06:43:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C31DD1FF7E;
 Mon, 15 Jun 2020 14:43:42 +0100 (BST)
References: <20200612160755.9597-1-pbonzini@redhat.com>
 <20200612160755.9597-2-pbonzini@redhat.com>
 <530b3231-0e47-80af-4bb1-17e50e231efa@redhat.com>
 <bdc40c92-6518-5c9f-646e-817af94d548e@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PULL 082/116] target/i386: correct fix for pcmpxstrx substring
 search
In-reply-to: <bdc40c92-6518-5c9f-646e-817af94d548e@redhat.com>
Date: Mon, 15 Jun 2020 14:43:42 +0100
Message-ID: <87k1081m29.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 6/15/20 12:18 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 6/12/20 6:07 PM, Paolo Bonzini wrote:
>>> From: Joseph Myers <joseph@codesourcery.com>
>>>
>>> This corrects a bug introduced in my previous fix for SSE4.2 pcmpestri
>>> / pcmpestrm / pcmpistri / pcmpistrm substring search, commit
>>> ae35eea7e4a9f21dd147406dfbcd0c4c6aaf2a60.
>>>
>>> That commit fixed a bug that showed up in four GCC tests with one libc
>>> implementation.  The tests in question generate random inputs to the
>>> intrinsics and compare results to a C implementation, but they only
>>> test 1024 possible random inputs, and when the tests use the cases of
>>> those instructions that work with word rather than byte inputs, it's
>>> easy to have problematic cases that show up much less frequently than
>>> that.  Thus, testing with a different libc implementation, and so a
>>> different random number generator, showed up a problem with the
>>> previous patch.
>>>
>>> When investigating the previous test failures, I found the description
>>> of these instructions in the Intel manuals (starting from computing a
>>> 16x16 or 8x8 set of comparison results) confusing and hard to match up
>>> with the more optimized implementation in QEMU, and referred to AMD
>>> manuals which described the instructions in a different way.  Those
>>> AMD descriptions are very explicit that the whole of the string being
>>> searched for must be found in the other operand, not running off the
>>> end of that operand; they say "If the prototype and the SUT are equal
>>> in length, the two strings must be identical for the comparison to be
>>> TRUE.".  However, that statement is incorrect.
>>>
>>> In my previous commit message, I noted:
>>>
>>>   The operation in this case is a search for a string (argument d to
>>>   the helper) in another string (argument s to the helper); if a copy
>>>   of d at a particular position would run off the end of s, the
>>>   resulting output bit should be 0 whether or not the strings match in
>>>   the region where they overlap, but the QEMU implementation was
>>>   wrongly comparing only up to the point where s ends and counting it
>>>   as a match if an initial segment of d matched a terminal segment of
>>>   s.  Here, "run off the end of s" means that some byte of d would
>>>   overlap some byte outside of s; thus, if d has zero length, it is
>>>   considered to match everywhere, including after the end of s.
>>>
>>> The description "some byte of d would overlap some byte outside of s"
>>> is accurate only when understood to refer to overlapping some byte
>>> *within the 16-byte operand* but at or after the zero terminator; it
>>> is valid to run over the end of s if the end of s is the end of the
>>> 16-byte operand.  So the fix in the previous patch for the case of d
>>> being empty was correct, but the other part of that patch was not
>>> correct (as it never allowed partial matches even at the end of the
>>> 16-byte operand).  Nor was the code before the previous patch correct
>>> for the case of d nonempty, as it would always have allowed partial
>>> matches at the end of s.
>>>
>>> Fix with a partial revert of my previous change, combined with
>>> inserting a check for the special case of s having maximum length to
>>> determine where it is necessary to check for matches.
>>>
>>> In the added test, test 1 is for the case of empty strings, which
>>> failed before my 2017 patch, test 2 is for the bug introduced by my
>>> 2017 patch and test 3 deals with the case where a match of an initial
>>> segment at the end of the string is not valid when the string ends
>>> before the end of the 16-byte operand (that is, the case that would be
>>> broken by a simple revert of the non-empty-string part of my 2017
>>> patch).
>>>
>>> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
>>> Message-Id: <alpine.DEB.2.21.2006121344290.9881@digraph.polyomino.org.u=
k>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  target/i386/ops_sse.h                |  4 ++--
>>>  tests/tcg/i386/Makefile.target       |  3 +++
>>>  tests/tcg/i386/test-i386-pcmpistri.c | 33 ++++++++++++++++++++++++++++
>>>  3 files changed, 38 insertions(+), 2 deletions(-)
>>>  create mode 100644 tests/tcg/i386/test-i386-pcmpistri.c
>>>
>>> diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
>>> index 01d6017412..14f2b16abd 100644
>>> --- a/target/i386/ops_sse.h
>>> +++ b/target/i386/ops_sse.h
>>> @@ -2089,10 +2089,10 @@ static inline unsigned pcmpxstrx(CPUX86State *e=
nv, Reg *d, Reg *s,
>>>              res =3D (2 << upper) - 1;
>>>              break;
>>>          }
>>> -        for (j =3D valids - validd; j >=3D 0; j--) {
>>> +        for (j =3D valids =3D=3D upper ? valids : valids - validd; j >=
=3D 0; j--) {
>>>              res <<=3D 1;
>>>              v =3D 1;
>>> -            for (i =3D validd; i >=3D 0; i--) {
>>> +            for (i =3D MIN(valids - j, validd); i >=3D 0; i--) {
>>>                  v &=3D (pcmp_val(s, ctrl, i + j) =3D=3D pcmp_val(d, ct=
rl, i));
>>>              }
>>>              res |=3D v;
>>> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.t=
arget
>>> index 43ee2e181e..53efec0668 100644
>>> --- a/tests/tcg/i386/Makefile.target
>>> +++ b/tests/tcg/i386/Makefile.target
>>> @@ -10,6 +10,9 @@ ALL_X86_TESTS=3D$(I386_SRCS:.c=3D)
>>>  SKIP_I386_TESTS=3Dtest-i386-ssse3
>>>  X86_64_TESTS:=3D$(filter test-i386-ssse3, $(ALL_X86_TESTS))
>>>=20=20
>>> +test-i386-pcmpistri: CFLAGS +=3D -msse4.2
>>> +run-test-i386-pcmpistri: QEMU_OPTS +=3D -cpu max
>>=20
>> This test fails on our CI:
>> https://travis-ci.org/github/qemu/qemu/jobs/698006621#L4246
>
> FYI Paolo's analysis from 'make V=3D1' output
> https://api.travis-ci.org/v3/job/698459904/log.txt:
>
> timeout 60
> /home/travis/build/philmd/qemu/build/i386-linux-user/qemu-i386 -cpu max
> test-i386-pcmpistri >  test-i386-pcmpistri.out
>
> timeout 60
> /home/travis/build/philmd/qemu/build/i386-linux-user/qemu-i386  -plugin
> ../../plugin/libbb.so -d plugin -D
> test-i386-pcmpistri-with-libbb.so.pout test-i386-pcmpistri >
> run-plugin-test-i386-pcmpistri-with-libbb.so.out
>
> "incorrect qemu invocation, missing -cpu max in the second".

Just testing some patches now.


--=20
Alex Benn=C3=A9e

