Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC569C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AF92077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZZ2m+fU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AF92077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtq1K-0007p3-UI
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 06:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtq0j-0007D5-Fp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:12:05 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtq0h-0001Kc-HT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:12:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id o8so5529358wmh.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GuTs3rjtpCsL6djToCJL3MWhitwdC/GJjlrGBFwbDnI=;
 b=SZZ2m+fUEjKnoimN7vYvJ8s25b0QVOwdjMHBXqCNvDfGiZeOk5JkVjyczscF8ABubf
 nlAPKm5PruNzsNRMLdtkQmBsaNjFUJ1ZBk6fTZsBZOD9eg3LbjOu4Gm77AD8NlYmZ9VU
 Y1p1iqkRcLK6z120BrEcqMFTbwJ1pZygA9TY/Efy4ctLlD5jrVT7843bTBDtynruPyID
 KMavzMYZGxToi3vnk6O9ObrJg0P+P8Mcox5tLAaWrm3KEUB0/D5WwEvbPEL90VFG1Ejg
 5qNx9WXMn9YxcZRN6EjMmaEk0EsuHcmzQNlknUd1Fh2DjJKr9IL6VZnBav4HPfvjgNKs
 GHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GuTs3rjtpCsL6djToCJL3MWhitwdC/GJjlrGBFwbDnI=;
 b=ueJZQ/SC9ZoExrXZueO5+7Sm+ooW2P2ITyI+SxMMv873xGEoZZ9lTCasTVCOWIsX4g
 x231vZEKwZhl6r5aIiQI1W9vHOzUo52lXin4seAPfgR7OtQ6qKLNgkcjLiY+OaFrBQ54
 nYdNZ1AXrLTk9Ibfcy5tqA2a9B9mRCKoq0PkCDUOTbHG3yAXrd8+Vz6T+Q9l7SZ/bE/E
 1Hs/iFvNULQmVQu232gLYU0yc0IuuKcfGwJXLgwgnBP13tLkmIglc030YO0HTaxBk2sh
 bKaJpTO1cXaINi8YROi/zXlYEsnJyeE6gOhTfU/bM/r3O86mHU2S/bBKWFgmwT2GbqPD
 llzQ==
X-Gm-Message-State: AOAM53373oMms/zqUmbjEW2HtxTLq1EVmZSscLs+8Nq+jljo98x9Amew
 XAGSUDO6oPE9v3vyM75Td/aWhiMcnXw=
X-Google-Smtp-Source: ABdhPJyGFDuP/gzASgM07XxPXME4nqZXK8DgF8heG/jKJ1Jg225M6S9BiyevaoUAku1HsGsF53D8oQ==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr4306472wmi.94.1594375921609; 
 Fri, 10 Jul 2020 03:12:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b62sm8639092wmh.38.2020.07.10.03.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:11:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 338821FF7E;
 Fri, 10 Jul 2020 11:11:58 +0100 (BST)
References: <CALTWKrUE3r4+BMKQY1YX6zMOriKcd_5QNyqGBk5Z_S5ZZPs+4w@mail.gmail.com>
 <87eepkn42e.fsf@linaro.org>
 <CALTWKrWONHNa2atJ+S6cnjqkHvWs_+A+U7e7V5ZYJLwdoKBf4Q@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#3] QEMU 5.0 and
 5.1-pre-soft-freeze Dissect Comparison
In-reply-to: <CALTWKrWONHNa2atJ+S6cnjqkHvWs_+A+U7e7V5ZYJLwdoKBf4Q@mail.gmail.com>
Date: Fri, 10 Jul 2020 11:11:57 +0100
Message-ID: <87sgdzllw2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, luoyonggang@gmail.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:

> On Thu, Jul 9, 2020 at 4:41 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>>
>> Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:
>>
>> > Hi,
>> >
>> > The third report of the TCG Continuous Benchmarking series utilizes
>> > the tools presented in the previous report for comparing the
>> > performance of 17 different targets across two versions of QEMU. The
>> > two versions addressed are 5.0 and 5.1-pre-soft-freeze (current state
>> > of QEMU).
>> >
>> > After summarizing the results, the report utilizes the KCachegrind
>> > tool and dives into the analysis of why all three PowerPC targets
>> > (ppc, ppc64, ppc64le) had a performance degradation between the two
>> > QEMU versions.
>>
>> It's an interesting degradation especially as you would think that a
>> change in the softfloat implementation should hit everyone in the same
>> way.
>>
>
> That's the same that I've thought of, but while working on next week's
> report, it appears that this specific change introduced a performance
> improvement in other targets!
>
>> We actually have a tool for benchmarking the softfloat implementation
>> itself called fp-bench. You can find it in tests/fp. I would be curious
>> to see if you saw a drop in performance in the following:
>>
>>   ./fp-bench -p double -o cmp
>>
>
> I ran the command before and after the commit introducing the
> degradation. Both runs gave results varying between 600~605 MFlops.
> Running with Callgrind and the Coulomb benchmark, the results were:
> Number of instructions before: 12,715,390,413
> Number of isntructions after: 13,031,104,137

You may have to average over several runs to see if there is a
detectable change. It could be although there are more instructions
being executed it makes no practical difference to the execution because
the processor is just as efficient in scheduling the work to the
execution units.

You have to remember on modern processors the relationship between
instructions and the utilisation of the eventual ALUs is tenuous at
best. After everything has been converted to uOps and scheduled you
might be doing broadly the same calculations. Pipeline and cache stalls
are probably a more important metric here although I doubt figure much
in the very tight loop of the benchmark.

>
>> >
>> > Report link:
>> > https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-5.0-and-5=
.1-pre-soft-freeze-Dissect-Comparison/
>>
>> If you identify a drop in performance due to a commit linking to it from
>> the report wouldn't be a bad idea so those that want to quickly
>> replicate the test can do before/after runs.
>>
>
> Report number 5 will introduce a new tool for detecting commits
> causing performance improvements and degradations. The report will
> utilize this tool to find out the specific commit introducing these
> changes.

Excellent - keep up the good work ;-)

>
>> >
>> > Previous reports:
>> > Report 1 - Measuring Basic Performance Metrics of QEMU:
>> > https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
>> > Report 2 - Dissecting QEMU Into Three Main Parts:
>> > https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
>> >
>> > Best regards,
>> > Ahmed Karaman
>>
>>
>> --
>> Alex Benn=C3=A9e
>
> Best regards,
> Ahmed Karaman


--=20
Alex Benn=C3=A9e

