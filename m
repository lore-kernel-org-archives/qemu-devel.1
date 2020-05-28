Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354A0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 14:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40082075F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 14:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jADyyfEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40082075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeJLy-0004TF-7X
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 10:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeJKp-0003qh-Ag
 for qemu-devel@nongnu.org; Thu, 28 May 2020 10:16:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeJKn-0006qC-SN
 for qemu-devel@nongnu.org; Thu, 28 May 2020 10:16:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so28143967wru.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JpmGLWtCaiqLNcqlylgX1iNZHZ4Sj2lAuU2BKosx9+s=;
 b=jADyyfEbIPMEXgDmYRfzwYc85vq6dLRtXXTp1AYFDilOv+HKQEEKMTzrdxH1gVTRjq
 otkSBrtopvGYYzy1N+YRQXDTDFznKzEheCl3AH7NkOvZXkUNjr9PePRPbl62vx4PaRqk
 gDHvOImM0Swk/GKsmABdxW99foW2zjADTKPGwpJpWyt4KW71hbSWzPRhrChVNQoBibO1
 fCklxPm/im1xaPd1B6H3tVQm1BLj0hJsOM0ayOHMB2KGAOZG/Lmt3+cw2OVzNYNrLOrK
 GlTgjkrE39f4do1B/CCtW7yzRZpdu/hvRGJf/4kuOToEFgVS8S1DWpbDsY71qvJYInPC
 F7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JpmGLWtCaiqLNcqlylgX1iNZHZ4Sj2lAuU2BKosx9+s=;
 b=TQwairYaG8Q0l8kWLOliyvn9cvDfYOpFVouKZj4VnZ8tDBM8AERf6Hah+t+RvMZcP1
 m9hXj1wy7nuWSwyyj6pezrfs7m1SaK063GchpVuEmnWi3RbvQ4fWZa//I6KFz2Kg/GP0
 2u7YiLu7Z5ftYzv1K66MYWmTRl8wZMJF4D+N0zuhzJO7Wiu5rqK3nrwU+LrbU48qd9II
 0yKu17oX6+D6D2Q8BvJ+sqjlwUTVtGGsloVL9glQhsy7duXY8niPQcw2n9PcQWrRlcGM
 glBg7EE/R7jPfwLTUo6ZJ+Yxzm1ycuTu7A+qguOjZLjc5JIzLQ5FYLDsZwrLcL8p/+cT
 Yr6A==
X-Gm-Message-State: AOAM530wBiUnM6/HyE9HHjHTbIsDsVd7QVtRH3fv4LOZJ/r6D+olqTxy
 RtsHXUyKE9jaMFsoO1DDvK2acw==
X-Google-Smtp-Source: ABdhPJyfYn0843Z40gLi+4DBW5Gku1QJY2XexEtRQh/VgWyKLAPQO6/c4tO4lwGo3xa7+k2sRI1HeQ==
X-Received: by 2002:a05:6000:ce:: with SMTP id
 q14mr4075402wrx.105.1590675395190; 
 Thu, 28 May 2020 07:16:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g82sm7024032wmf.1.2020.05.28.07.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 07:16:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 93AF21FF7E;
 Thu, 28 May 2020 15:16:31 +0100 (BST)
References: <20200527145455.2550-1-alex.bennee@linaro.org>
 <CAFEAcA_LrZjBY_y3UR=fdOtDvnY=zGG-10Yeq0ZjbBc=EsvRfw@mail.gmail.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/12] testing and plugin fixes
In-reply-to: <CAFEAcA_LrZjBY_y3UR=fdOtDvnY=zGG-10Yeq0ZjbBc=EsvRfw@mail.gmail.com>
Date: Thu, 28 May 2020 15:16:31 +0100
Message-ID: <87eer4401s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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

Weird... I'll have a look at whats going on.

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

