Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A722AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DFB20772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9oNHBxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DFB20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt5nU-0007GR-MI
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 04:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jt5mu-0006ln-2y
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 04:50:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jt5mr-0001pG-M9
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 04:50:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id f18so39920964wrs.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 01:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eLsIOGZdHk4Gp7Y1XgmROcI14u3FSsfWEs4HhMTs1wk=;
 b=y9oNHBxNn9UQ1fzElQYGGH2p0eGVqqtE6aIKiSylnfjhv1pLySKMj9H+FUB7Y5KQ3l
 Wm2Xibk+N/Sawu3kzswGH1YhvPL4xoGCO6DBI2w9SsOQ92Bw6BFqTQ2pjZDrKuRJIpXp
 n7XDb2nhjDAKIZ2E7SbVw9MB4fX/HT7ybV15hqrg4DKyqExcpVk4/3PQv+W3tdDq1N45
 oO5Rnfefua0Gp5oFDwZg3xlAFlH50hPZVYjPOhVR85esXbMVlqEKTwZfv1G9wjn3mCdc
 4hqIYqQrqR68YSVm3pMQO36Y6CbnrxmpDDCUeIMcNZKRrceG7CCc+LzMXsVBkiIQVSsR
 Rh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eLsIOGZdHk4Gp7Y1XgmROcI14u3FSsfWEs4HhMTs1wk=;
 b=COSV/P0ODCa+GQn4FTqqJDsUZATxRmeOswYWPZ1koccxrutKgcCaP6zlXTpoP59b75
 s6PoyfXM3SbNUy6ZV+CvJ9SxwT4jsLZKrjlVw1YLO71JolzHSAI0j77ga8Ls1eND+hYg
 oGmBUqLxpwd/DL8iiYrelmQrB5LHxYDPCzw+YZdkuNlMS9rpDFDTWq5HFb/3aGD4v9mx
 KQ96f9fYafxyfetVLAD4qRkJ2e69Po5J0HpI+TATebAY3QImz8ZkVVktWscPd+6Joi+2
 5Bor8drHJPcYM8X2QMMzEU0DyUCD57UiGJzbRl4NHrBSpcgdwOnxLUBBUOJdx1jB8NQ5
 J1cA==
X-Gm-Message-State: AOAM533syzmgNRroTFkzBjMy55V1oMtctYHhUfc/Lx25LA4L7+noFoZw
 NkTsevhRifHWIULr81eHcxtNlQ==
X-Google-Smtp-Source: ABdhPJwHPkpv7Nn0Oz8K+kwuaB/K19PKnCNoWZXh9k2C45xLEvY8eUbieCAmGwQsc1K7HfqoJ2fZ7Q==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr63863589wrw.347.1594198239886; 
 Wed, 08 Jul 2020 01:50:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g82sm5188678wma.37.2020.07.08.01.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 01:50:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB93F1FF7E;
 Wed,  8 Jul 2020 09:50:37 +0100 (BST)
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <87pn97o93a.fsf@linaro.org>
 <CAMo8BfLH2jVLjbdMMWCCuhmh+i40NyHQFK-=bAUw3sSoAxwPww@mail.gmail.com>
 <873663nnap.fsf@linaro.org>
 <CAMo8BfJkp3Dr+cg5aoovD+Key+p5hm4Y0dD0xmBS0um2fnCyzg@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 00/21] target/xtensa: implement double precision FPU
In-reply-to: <CAMo8BfJkp3Dr+cg5aoovD+Key+p5hm4Y0dD0xmBS0um2fnCyzg@mail.gmail.com>
Date: Wed, 08 Jul 2020 09:50:37 +0100
Message-ID: <87zh8amluq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Filippov <jcmvbkbc@gmail.com> writes:

> On Tue, Jul 7, 2020 at 12:21 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>> Well it ran some xtensa tests thanks to the docker cross compiler
>> support. Do you know what toolchains we need?
>>
>> Currently we have the following:
>>
>>   ENV CPU_LIST csp dc232b dc233c
>>   ENV TOOLCHAIN_RELEASE 2018.02
>>
>>   RUN for cpu in $CPU_LIST; do \
>>           curl -#SL http://github.com/foss-xtensa/toolchain/releases/dow=
nload/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
>
> Oh, that's a familiar URL. Let me do the new batch of toolchains and
> add FPU2000/DFPU configurations there.
> And this is tests/docker/dockerfiles/debian-xtensa-cross.docker,
> right?

Yep - you could also tweak tests/tcg/configure.sh if you want to handle
the presence of the toolchain in your local environment. We might want
to expand the configurations emitted to
tests/tcg/config-xtensa-softmmu.mak to handle the multiple binaries
though unless a single binary can call the relevant toolchains with
tweaks to CFLAGS?

> I can add new configurations there as well and add one more patch
> to this series.

Cool ;-)

--=20
Alex Benn=C3=A9e

