Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BA1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 10:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBB120679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 10:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NV+uDE0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBB120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgQcj-0006dm-00
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 06:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgQag-0004cy-AZ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 06:25:46 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:35217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgQac-0002j7-2i
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 06:25:45 -0400
Received: by mail-wr1-x429.google.com with SMTP id x14so1773160wrp.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 03:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yM7ccoOjIlHcfCrTHErjg5t21HrhgQH2bwHf/Gyv8p8=;
 b=NV+uDE0/uGe1EbJxIUCkYYSMf0l+WuXQqPEsDM+M/SVKcCXmC4fjLEOVAXDO99Qtbo
 fUAa01MTcKlhoFLHKtxBI5+ka477QgJ8pSucsYb6wOvDgVWHcvItBS51Ao1wOmV82/7u
 J8Hofviwywdl6KzdyI16/lxZzKQ2VnabVGhEev9Klw3WHUIiMy5Ms/4icKkQ/XM6EWsU
 YhG/mkw8kCr5qjUeqdbODkGX58oZhivvD5JKfSVYw+61H38KFcijGMiQr6cGObyT2+di
 we8+NuzuvlEoB6/Zz9XGW14t0KdHW14zn5hcFsYR+FJowH77Sk6UhWDEdsuVclQnhR4N
 UKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yM7ccoOjIlHcfCrTHErjg5t21HrhgQH2bwHf/Gyv8p8=;
 b=tswXhpTx2l9FcUiGlbLWNBZC7kIuX7p3DO0EcrU7M2jZKy0nYIMZhd+f8uNGwu0AGO
 R72/kiOiLM/qEM+nsHPO+OtsSZQ1OE7zZHxBm+9bWPRoarHSdBLGZGPTGEEStxMj3Ckd
 XyyqOpf4aHZs1AmKT2DE2oxcQa4pm/BjB/qlPpRWZBwIwty60QT4gOuwzAbJHYbtNdUt
 1pGFmU5n6u2e/a78z65fimhSg95f4eubuULNzvY/LY3PsMZz+j2jszvpRB+/4/WRaERQ
 ekRiC37dz3TvymEcmSk59yUU+eNDJPy+q1c0e7Tj/lCDZGNyd9pvRhhlGRkysJ2FYTHP
 jivA==
X-Gm-Message-State: AOAM530QliBq6kNadNy3uwCyWDJ1sLtoTVFj1VI8WH5t70PJL5CjA8pS
 EeRv77QaokXgbhIjzWUjwTbmXQ==
X-Google-Smtp-Source: ABdhPJwWTtCivqFZyliyxQfq3VNVovMnG1KTUWR67REDWrCaCLDwpWWT5G2UHn+5VyPbv5ZNmB8guA==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr30473772wro.155.1591179939643; 
 Wed, 03 Jun 2020 03:25:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j5sm2692786wrm.57.2020.06.03.03.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 03:25:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 449C91FF7E;
 Wed,  3 Jun 2020 11:25:36 +0100 (BST)
References: <20200603095137.lt6dafpqpa4jzx2n@schnipp-desktop>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: Re: How do I add my tcg tests to check-tcg?
In-reply-to: <20200603095137.lt6dafpqpa4jzx2n@schnipp-desktop>
Date: Wed, 03 Jun 2020 11:25:36 +0100
Message-ID: <87v9k85tun.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> Hi Alex,
>
> I have some time again to integrate my tcg tests patch for TriCore [1]. H=
owever,
> I'm struggeling a bit to get through the details of the Makefiles. I'm as=
suming
> the right rule to run is 'make check-tcg'. I tried running that for
> xtensa-softmmu, arm-softmmu, and aarch64-softmmu, but they are always ski=
pped.
> Digging into the Makefiles I found that there is some way to use the dock=
erfiles
> to run the test. Can someone elighten me on how to properly use this?

The configure script in tests/tcg/configure.sh will probe for available
cross compilers (or take a passed in one). Failing that you can fall
back to a docker image which has the compilers included.

The result should end up in:
  $(BUILD_DIR)/tests/tcg/config-$(PROBE_TARGET).mak

Assuming you have a CROSS_CC_GUEST or DOCKER_IMAGE and
DOCKER_CROSS_CC_GUEST defined there the makefiles should allow building
of the tests.

For linux-user we include the tests/tcg/multiarch/Makefile.target as
well as the target specific one. The CC variable should already be setup
to build either via docker or using the installed setup.

We don't have a linker or assembler in the tooling so everything is
invoked via the compiler with the appropriate flags to call the
sub-tools if required. Most rules are single file compile and link.

For softmmu tests things are a bit more bespoke. The tooling will make
sure things are setup and then include
tests/tcg/multiarch/system/Makefile.softmmu-target and=20
tests/tcg/$ARCH/Makefile.softmmu-target. The main purpose of the arch
specific Makefile is to provide the appropriate build instructions to
build a system image for the multiarch tests and any target specific
tests.

To support the multiarch tests you need a boot.S and a kernel.ld that
defines a simple boot and a __sys_outc helper function. There is a
minilib which provides for a basic printf like output. The boot should
call main and then return the int code via some mechanism to signal the
pass/fail of the test. For aarch64 this is done with semihosting.

Please let me know if you have any more questions.

>
> Thanks and cheers,
> Bastian
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg00074.html


--=20
Alex Benn=C3=A9e

