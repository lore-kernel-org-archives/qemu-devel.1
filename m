Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 14:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331FF2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 14:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLRDZ7YE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331FF2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeJzG-0000l8-C5
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 10:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeJyH-00082C-Hi
 for qemu-devel@nongnu.org; Thu, 28 May 2020 10:57:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeJyG-0002dm-E7
 for qemu-devel@nongnu.org; Thu, 28 May 2020 10:57:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id x13so13585241wrv.4
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tJUT5MjaIRsd73esX8dWJaSForj5PRZHK3Jic/MgHbI=;
 b=BLRDZ7YElqTEjm2140vkZKf1hpQQQiDL+Kx5J50wJprQyfv6fmd5qrWKb7HbTreqXs
 5ORq3FJWF2c0TGYHZKJjwoNaXLMK2+Nb0ECsJbY4oI+rP1t42YnAL0tFOHUaDMAXeFdB
 2VSJEqbsLhP6tEfwtUIiBy7y2Qw85xOc3NwM632OhjY+iFrnzL/kK6Kaa40AXkRpDUcD
 i2s8gmXPjpKrSkVOyDGiTAULS6x55Gkw/SPJ0VZFXqeRBV9FIBrFC/L1n/qijR3unYB2
 y+239lH8zBCx6ihWg4+6+2gHdydI+c9828uJG3ow+47XkAsksuzfr4YvZgHNd/31nrxL
 XQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tJUT5MjaIRsd73esX8dWJaSForj5PRZHK3Jic/MgHbI=;
 b=gb+0DaUjByb9ScVaNJjSKpAC7cqPXlqrZaQlKkddqocZnebBImkvO6Oz3m9fdC6/Gp
 XlVBK/RabgvEtRBBUncMF4pXSy2HD/5o9AV1WFWzzCBPxpzqR5Y2pDtARA/1wZ/eXMb9
 xGWI92xp9zFyNZOzdi4ONGc76th3ohAe89sjmqKwRAIf3/j8XQYodC2OH2mZcg9a4fdE
 PMA7B6hJibI351gd5EU+pcrWdwcPEkBFsSmTAkaV72748RzaC/5iimGYIhacA0AbTCR0
 g7HXQZ5vzHATdWLIqtwCCozrqdx8Qb7bSCQtkfGOc5DhXU1JfHB2metfWLnTSHnGHa+a
 Pwmg==
X-Gm-Message-State: AOAM532MyjUz5LybqiVnyV2awT4NUsMDU8c6STyHJMc6nuCWyivsGkQX
 mLtyDFXGcMCjCfL62JZzV6Hp4g==
X-Google-Smtp-Source: ABdhPJyhHMezBGFzj9jrv7QyJ+LasPDU1i5Uc3ReHoayxWA93VFvmf3kR5wbO9lRq4q6hpdgl5lAPA==
X-Received: by 2002:a05:6000:146:: with SMTP id r6mr4071398wrx.9.1590677842660; 
 Thu, 28 May 2020 07:57:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b185sm9061422wmd.3.2020.05.28.07.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 07:57:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 335DF1FF7E;
 Thu, 28 May 2020 15:57:16 +0100 (BST)
References: <20200527145455.2550-1-alex.bennee@linaro.org>
 <CAFEAcA_LrZjBY_y3UR=fdOtDvnY=zGG-10Yeq0ZjbBc=EsvRfw@mail.gmail.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/12] testing and plugin fixes
In-reply-to: <CAFEAcA_LrZjBY_y3UR=fdOtDvnY=zGG-10Yeq0ZjbBc=EsvRfw@mail.gmail.com>
Date: Thu, 28 May 2020 15:57:16 +0100
Message-ID: <87blm83y5v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 27 May 2020 at 15:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac63=
510:
>>
>>   Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' i=
nto staging (2020-05-26 14:05:53 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-testing-tcg-plugins-2705=
20-1
>>
>> for you to fetch changes up to 919bfbf5d6569b63a374332292cf3d2355a6d6c3:
>>
>>   tests/tcg: add new threadcount test (2020-05-27 14:26:49 +0100)
>>
>> ----------------------------------------------------------------
>> Testing and one plugin fix:
>>
>>   - support alternates for genisoimage to test/vm
>>   - add clang++ to clang tests
>>   - fix record/replay smoke test
>>   - enable more softfloat tests
>>   - better detection of hung gdb
>>   - upgrade aarch64 tcg test x-compile to gcc-10
>>   - fix plugin cpu_index clash vs threads
>
> This makes the NetBSD tests/vm setup spit out a huge pile of extra warnin=
gs:
> every link has something like:
>
> ld: warning: libintl.so.1, needed by /usr/pkg/lib/libglib-2.0.so, may
> conflict with libintl.so.8
>
> or some variant like:
> ld: warning: libintl.so.1, needed by /usr/pkg/lib/libcurl.so, may
> conflict with libintl.so.8
> ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may
> conflict with libintl.so.8

I get these on commit ddc760832fa8cf5e93b9d9e6e854a5114ac63510:

    LINK    arm-softmmu/qemu-system-arm
  ld: /usr/lib/libc.so and /usr/lib/crt0.o: warning: multiple common of `en=
viron'
  ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conf=
lict with libintl.so.8
  ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conf=
lict with libintl.so.8
  ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conf=
lict with libintl.so.8
  ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conf=
lict with libintl.so.8
  ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conf=
lict with libintl.so.8

which makes me think the build environment has changed and it was simply
that my PR triggered a re-build of the NetBSD VM.

--=20
Alex Benn=C3=A9e

