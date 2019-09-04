Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E187C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE14206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjXNObO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE14206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5WGu-0002Xi-2M
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5WGC-000290-Iz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5WGB-0006bn-93
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:27:48 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5WGB-0006az-1C
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:27:47 -0400
Received: by mail-wm1-x341.google.com with SMTP id r195so4049121wme.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bPpGmuwKU+Oh6azYselaBDRQz9FshZg6zrB2CPnR/aQ=;
 b=OjXNObO88rr5SCvbZShip70MUFDOjtAFuOP8T8kbPGxpPLutdbrRvynqteIADIPlOi
 BADME2/e0q5LBN29jynxJiAi33vICLSigqdWxk1Un6XMsIwyTCHOSPWko1Zjm14TJxXQ
 9bX2B4Ld5rndMS5xg8u9plo8aog9ozcalIQYQ7UxYipLj8ahwFKsKjQFDZveDVNoRMjW
 eTU+fSlZPmsBGGmL/HxZ37vF/tsa02AaJxHj8Y9kMiKnRUskZVA8+YYm+wHNRHY1WXis
 7TY3KRF0cAdTTryGCR3bMmyWxrpyX1EqkmeSCwK2T19R8BOgzDac5j+wpwLyTsIdTOdp
 tjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bPpGmuwKU+Oh6azYselaBDRQz9FshZg6zrB2CPnR/aQ=;
 b=QDxmU7o795YLGKXsQztZOkjS5o/xMiSDgjwLjckwGBTr6E+FhVUEW9/o+9spGGHGJG
 pWnf/MsNHRdEvQOraScBsF1dN0JRSiccxQA8s/Vr/W1YGxIwwhDwvwb0g6w66vc5b0dF
 bKVZAJDGBfO0YzcdXIQmrILEuACGgN4zA9qiaPFrvy4v9kfit6oeYffBS51+lTrEdpka
 VvT5EqMWpSYbp4t8k8uFLGG16iUi3COhSeXSuLgzMeDeIM7Hs3xPZDhORWogxuSNgJk/
 YqeL3lhgHZl7gpSd72QA8IoQuZp/PQkOQyRz7n3Bo7b+SbA6sEvpDdg1zqRC14YTafq3
 JELQ==
X-Gm-Message-State: APjAAAVPsMaVSYqpEedApE1n8oEniqDl+y0H2Rag9NGjdlNZzDyjcDiv
 aXebrtUmFBQ86MXWiu/GP3X2oNrjZr8=
X-Google-Smtp-Source: APXvYqxbtRg5A8SPfwbgdh3pUf3kkHKbhFs+yS6zDhRKz3C2ZrRNPiUnD5aG1K3OpL8/ggEDj+jACw==
X-Received: by 2002:a1c:1f44:: with SMTP id f65mr4555950wmf.11.1567607264228; 
 Wed, 04 Sep 2019 07:27:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g73sm5244784wme.10.2019.09.04.07.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 07:27:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E05A51FF87;
 Wed,  4 Sep 2019 15:27:42 +0100 (BST)
References: <20190807143523.15917-1-pbonzini@redhat.com>
 <CAHFMJ7tA08jsVVJCCcMp3Q+FA3PBKcYNq+yFS7y6Sw5f_K4_oA@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <CAHFMJ7tA08jsVVJCCcMp3Q+FA3PBKcYNq+yFS7y6Sw5f_K4_oA@mail.gmail.com>
Date: Wed, 04 Sep 2019 15:27:42 +0100
Message-ID: <87blw06srl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 0/3] tests/tcg: disentangle makefiles
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> Ping?

Sorry I should have said I've queued it to testing/next. I'll post the
series shortly after I've squashed the last annoying python 3.<>6
problem.

>
> Paolo
>
>
> Il mer 7 ago 2019, 16:35 Paolo Bonzini <pbonzini@redhat.com> ha scritto:
>
>> The tests/tcg rely a lot on per-target informations from
>> the QEMU makefiles, but most of the definitions in there
>> aren't really relevant to TCG tests.
>>
>> This series is just a cleanup, but it could also be
>> a useful start in making it possible to compile tests/tcg
>> out of QEMU's tree, and/or making it a submodule, and/or
>> unifying the system emulation tests with kvm-unit-tests.
>>
>> Paolo
>>
>> v1->v2: fix configure from fresh directory, do not use $SHELL
>>
>> Paolo Bonzini (3):
>>   tests/tcg: use EXTRA_CFLAGS everywhere
>>   tests/tcg: cleanup Makefile inclusions
>>   tests/tcg: move configuration to a sub-shell script
>>
>>  Makefile                                  |   1 +
>>  Makefile.target                           |   3 -
>>  configure                                 | 155 ++-------------
>>  tests/Makefile.include                    |  25 +--
>>  tests/tcg/Makefile.include                |  88 ---------
>>  tests/tcg/Makefile.prereqs                |  18 ++
>>  tests/tcg/Makefile.probe                  |  31 ---
>>  tests/tcg/Makefile.qemu                   |  95 +++++++++
>>  tests/tcg/{Makefile =3D> Makefile.target}   |  15 +-
>>  tests/tcg/aarch64/Makefile.include        |   8 -
>>  tests/tcg/aarch64/Makefile.softmmu-target |   4 +-
>>  tests/tcg/aarch64/Makefile.target         |  12 +-
>>  tests/tcg/alpha/Makefile.include          |   2 -
>>  tests/tcg/alpha/Makefile.softmmu-target   |   4 +-
>>  tests/tcg/arm/Makefile.include            |   8 -
>>  tests/tcg/arm/Makefile.softmmu-target     |   6 +-
>>  tests/tcg/configure.sh                    | 228 ++++++++++++++++++++++
>>  tests/tcg/cris/Makefile.include           |   6 -
>>  tests/tcg/hppa/Makefile.include           |   2 -
>>  tests/tcg/i386/Makefile.include           |   9 -
>>  tests/tcg/i386/Makefile.softmmu-target    |  12 +-
>>  tests/tcg/i386/Makefile.target            |  13 +-
>>  tests/tcg/m68k/Makefile.include           |   2 -
>>  tests/tcg/minilib/Makefile.target         |   2 +-
>>  tests/tcg/mips/Makefile.include           |  20 --
>>  tests/tcg/ppc/Makefile.include            |  10 -
>>  tests/tcg/riscv/Makefile.include          |  10 -
>>  tests/tcg/s390x/Makefile.include          |   2 -
>>  tests/tcg/sh4/Makefile.include            |   4 -
>>  tests/tcg/sparc64/Makefile.include        |   2 -
>>  tests/tcg/x86_64/Makefile.softmmu-target  |  36 ++++
>>  tests/tcg/x86_64/Makefile.target          |   7 +-
>>  tests/tcg/xtensa/Makefile.include         |  11 --
>>  tests/tcg/xtensa/Makefile.softmmu-target  |   4 +-
>>  34 files changed, 435 insertions(+), 420 deletions(-)
>>  delete mode 100644 tests/tcg/Makefile.include
>>  create mode 100644 tests/tcg/Makefile.prereqs
>>  delete mode 100644 tests/tcg/Makefile.probe
>>  create mode 100644 tests/tcg/Makefile.qemu
>>  rename tests/tcg/{Makefile =3D> Makefile.target} (90%)
>>  delete mode 100644 tests/tcg/aarch64/Makefile.include
>>  delete mode 100644 tests/tcg/alpha/Makefile.include
>>  delete mode 100644 tests/tcg/arm/Makefile.include
>>  create mode 100644 tests/tcg/configure.sh
>>  delete mode 100644 tests/tcg/cris/Makefile.include
>>  delete mode 100644 tests/tcg/hppa/Makefile.include
>>  delete mode 100644 tests/tcg/i386/Makefile.include
>>  delete mode 100644 tests/tcg/m68k/Makefile.include
>>  delete mode 100644 tests/tcg/mips/Makefile.include
>>  delete mode 100644 tests/tcg/ppc/Makefile.include
>>  delete mode 100644 tests/tcg/riscv/Makefile.include
>>  delete mode 100644 tests/tcg/s390x/Makefile.include
>>  delete mode 100644 tests/tcg/sh4/Makefile.include
>>  delete mode 100644 tests/tcg/sparc64/Makefile.include
>>  create mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/xtensa/Makefile.include
>>
>> --
>> 2.21.0
>>
>>


--
Alex Benn=C3=A9e

