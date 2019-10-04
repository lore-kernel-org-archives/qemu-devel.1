Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A16C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C6620862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ob1XssN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C6620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMJl-0000D0-KR
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iGLuQ-0004i0-9E
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iGLuO-0003Cs-SX
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:38:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iGLuO-0003BA-KT
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:38:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id j18so5958839wrq.10
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zlS4SinMN0E3y3WlwHxzr2QA+yW1dc8yGWKS5yNMovQ=;
 b=ob1XssN4qd3Vq+oa+0UTz5HSW0p+AS2asfCNOw9suRebhVnFudDOL0BdYKHIrR7MYA
 xRWJBefPjz5FhAZ8TIL0VaJalBX4HxgdWZol0jAR02p4A8/iEydNqj+8yraiSoFNUq6s
 4gbXuH5UhDn6uLvzJRyP58ypIknrEu9akbSO98ruCw5pTpxz9xTwGfWttEWyQiZBfFBm
 o0lMv6Zy/uTGfPRi3GoxXat3ST+BJxzU9x7RvGgFoMDgX7JwNzxwlhLanwkXSg9nTEHo
 jyPsLLg+5cUjDhWZJufq+N4c7P4s9SvqNf8Lwq6DS8jYlq2NigyXpqLiEeGfjbFpIuYq
 oiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zlS4SinMN0E3y3WlwHxzr2QA+yW1dc8yGWKS5yNMovQ=;
 b=fp7DqHtrZpl8Lab46dniuRkTH27KFxRK1QsiBsSOI/6+jYzJlphXc+rU2M7sUWCwH2
 APJUZ0Sgxj2DpE7p4thJ6p4ErBNxRIWb7yDxI0xkYV6iKAja1vlCvTR1+4Hd4nQdjtmX
 EGfaeW0EejfteWdzvUB1us5qRwIhaDyqfOX6V3HSWwYTMC4Mpa1L0lh6LRPT+ufTtut+
 JSq/+lpqIATgtv3TSi9TIB1NjZXETwTOmGztl6DVlJnbfpzd0lN0IKRqTQvLsCTAQK7y
 lRwc3ei1PoVWPyZRLbqaK2FqKxc2n+31ZPJag2t9ZAzx146FGor/fOTmqn2zyFb78tfo
 mmYQ==
X-Gm-Message-State: APjAAAVN1vqCkKinzfNWWFmuk/UxALxgiSl6OLP1s+vTKT3aa6RP+hGE
 dOtRDbJ7fJuV5lkA9kdKfa55Ww==
X-Google-Smtp-Source: APXvYqw+58ByxLGT+nabkKwENxZmBdMhgQ17YKbaufAOCqGY/uy5ZNGXxChHH83yQtK47M9t3eqvlg==
X-Received: by 2002:a5d:4290:: with SMTP id k16mr12180682wrq.265.1570189081043; 
 Fri, 04 Oct 2019 04:38:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d193sm5982206wmd.0.2019.10.04.04.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2019 04:38:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD7AF1FF87;
 Fri,  4 Oct 2019 12:37:59 +0100 (BST)
References: <20191002082636.7739-1-david@redhat.com>
 <87zhijjwph.fsf@linaro.org>
 <0479ad1f-348e-ed40-c2c6-aef168afdb7e@linaro.org>
 <379c2065-adfe-0847-46f3-7f25c7650df9@linaro.org>
 <17a008ed-8ec0-2732-347d-bb04b6d832e8@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] s390x/tcg: MVCL: Exit to main loop if requested
In-reply-to: <17a008ed-8ec0-2732-347d-bb04b6d832e8@redhat.com>
Date: Fri, 04 Oct 2019 12:37:59 +0100
Message-ID: <87h84oivvs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> On 02.10.19 21:34, Richard Henderson wrote:
>> On 10/2/19 9:47 AM, Richard Henderson wrote:
>>> There is still the special case of EXECUTE of MVCL, which I suspect mus=
t have
>>> some failure mode that we're not considering -- the setting and clearin=
g of
>>> ex_value can't help.  I have a suspicion that we need to special case t=
hat
>>> within helper_ex, just so that ex_value doesn't enter into it.
>>
>> I had a walk and a think.  I now believe that we're ok:
>>
>> (1) TB with EXECUTE runs, at address Ae
>>
>>     - env->psw_addr stored with Ae.
>>     - helper_ex() runs, memory address Am computed
>>       from D2a(X2a,B2a) or from psw.addr+RI2.
>>     - env->ex_value stored with memory value modified by R1a
>>
>> (2) TB of executee runs,
>>
>>     - env->ex_value stored with 0.
>>     - helper_mvcl() runs, using and updating R1b, R1b+1, R2b, R2b+1.
>>
>> (3a) helper_mvcl() completes,
>>
>>      - TB of executee continues, psw.addr +=3D ilen.
>>      - Next instruction is the one following EXECUTE.
>
> Right, and whenever we inject an interrupt (e.g., access exception or an
> asynchronous one), we have to use addr=3Dilen of EXECUTE, not of the
> execute target. And that is guaranteed to reside in env->psw_addr/rewind
> info
>
>>
>> (3b) helper_mvcl() exits to main loop,
>>
>>      - cpu_loop_exit_restore() unwinds psw.addr =3D Ae.
>>      - Next instruction is the EXECUTE itself...
>>      - goto 1.
>
> Sounds about right to me. Thanks for verifying.
>
>>
>> If we can agree that the result is undefined if registers R1a, X2a, B2a =
overlap
>> R1b, R1b+1, R2b, R2b+1, or if the memory address Am is modified by the
>> interrupted MVCL, then we're ok.
>
> So the Programming Note 5. for EXECUTE says:
>
> When an interruptible instruction is made the tar-
> get of an execute-type instruction, the program
> normally should not designate any register
> updated by the interruptible instruction as the R1,
> X2, or B2 register for EXECUTE or R1 register for
> EXECUTE RELATIVE LONG. Otherwise, on
> resumption of execution after an interruption, or if
> the instruction is refetched without an interrup-
> tion, the updated values of these registers will be
> used in the execution of the execute-type instruc-
> tion. Similarly, the program should normally not
> let the destination field in storage of an interrupt-
> ible instruction include the location of an execute-
> type instruction, since the new contents of the
> location may be interpreted when resuming exe-
> cution.
>
> So, if I read correctly
> - The updated register content *will* be used
> - The updated memory content *may* be used
>
> However, also "the program normally should not"/"the program should
> normally not" which to me sounds like "just don't do it", in which case
> we are fine.
>
> So shall we leave this patch as-is (adding a summary of what you
> explained to the description) or shall we somehow factor out the
> TCG-internal-thingy check?

It would be nice to avoid this internal detail in the guest specific
code but I can live with it for now.

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

