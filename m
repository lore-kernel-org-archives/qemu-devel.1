Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29DDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA34206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuInzzq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA34206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKBY-0004rX-MH
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiKAQ-0003zm-H9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:58:30 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiKAO-0006sA-If
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:58:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id x13so17993792wrv.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=c3RLKlnrgqwTHM30JFIUcbabhGWrWy1voGZA+hJAzAU=;
 b=JuInzzq1IvwaHgUHvqlMl/rrQpgU7VWAWS51sbIErjXREKwtHlCfLy5Kh1rRtpq06m
 0AWoDi6Q8Qj52ExWH1noSgH9qo0rOM/gc3MwEBsyWIcOdXC0dLR1m9VK2JWxsQ6cgH/c
 Mb9qmSnbakiS4Ac30AhRwrG54kdpOTnyjYOW7he6adFFDkmvZn5IwsAi0KEDaluxWk1D
 /sCOevdZKi2qKP4rUozsZzH3wRohmFbh051F3xvU+5ZPIHEbhTktDc3UY4YdQ6VFb8uL
 FNqYh5Htv4ob9jU6K22RlcXIl8v0Nwt/6fMHexfQvFf/fZMdWT7k5iQ5XgCi/Z5dcdV+
 V9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=c3RLKlnrgqwTHM30JFIUcbabhGWrWy1voGZA+hJAzAU=;
 b=JK5ncsKQwUUv/r29Z+qwnYfILQ80VuFhNvjVYHLURy5KPc81E9hBzk89DPHeYN2bIO
 5ZwgVYAtCOhHP9dCtNeroyLDu/kE7c3rEZVRjAGWRd4bAlzoEcutwHId8DYleGTIqVC4
 x8z12eidwx6hShVlKx3PyEr8Tqfj467vi9CtLEs86LzSjypKosNWhKr//NOX+QpOKnoW
 mvm2u3FwUWu1+PHhFQLbyhlBSoyKhZ4EBtemPOYdlVJgHFz6fGWQdZC/AUWXJxLyF2Uj
 TeAS86rKHeg/kOjYXTIgIx2u3hHC/gQKTJhGl8IW9x+nNpmPVq8fSVoBGsXp0qsf1hOU
 +z/Q==
X-Gm-Message-State: AOAM530DQmbOADL22L0bHwUUms67fCGgtX2ojSHfZkmITiP6gJoLBEwQ
 Dja0L4ZXIcd5ZKB3wpVzV8CJ4C9FduI=
X-Google-Smtp-Source: ABdhPJzirFLeBJJhAr8ZqK9wY2DHMrzVqIdVJ6K3LbQtj03r9V1wIv8RLgs4daXJdH/HkWpBGpz2bw==
X-Received: by 2002:a05:6000:100e:: with SMTP id
 a14mr23914558wrx.349.1591631905825; 
 Mon, 08 Jun 2020 08:58:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p1sm159832wrx.44.2020.06.08.08.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 08:58:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B26A91FF87;
 Mon,  8 Jun 2020 16:58:23 +0100 (BST)
References: <20200605154929.26910-1-alex.bennee@linaro.org>
 <f6d93916-b950-4688-3826-5c4de4cc033d@redhat.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 00/14] various fixes for next PR (testing, vhost,
 guest_base fixes)
In-reply-to: <f6d93916-b950-4688-3826-5c4de4cc033d@redhat.com>
Date: Mon, 08 Jun 2020 16:58:23 +0100
Message-ID: <87d0695z34.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 05/06/2020 17.49, Alex Benn=C3=A9e wrote:
>> Hi,
>>=20
>> These are all the patches I've currently got which are ready for a
>> pull request next week. I've included some patches which are destined
>> to go in via other trees so I can keep the testing green on the CI.
>>=20
>> In summary:
>>=20
>>  Some simple plugin cleanups (the reset remain in plugins/next)
>>  Reliability fixes for travis/shippable
>>  iotest 194 fix (going in via block tree?)
>>  docker updates (ubuntu and tricore fix)
>>  vhost-user and TCG fix
>>  more linux-user guest_base fixes
>>=20
>> I'll certainly include the testing stuff in my PR but if others are
>> happy for me to include bits touching their areas then shout and I'll
>> include them in the PR.
>>=20
>> The following need review:
>>=20
>>  - linux-user: detect overflow of MAP_FIXED mmap
>>  - linux-user: deal with address wrap for ARM_COMMPAGE on 32 bit
>>  - linux-user: provide fallback pgd_find_hole for bare chroots
>>  - tests/docker: fix pre-requisite for debian-tricore-cross
>>  - hw/virtio/vhost: re-factor vhost-section and allow DIRTY_MEMORY_CODE
>>  - .shippable: temporaily disable some cross builds
>>  - exec: flush the whole TLB if a watchpoint crosses a page boundary
>>=20
>> Alex Benn=C3=A9e (10):
>>   tests/plugin: correctly honour io_count
>>   exec: flush the whole TLB if a watchpoint crosses a page boundary
>>   .travis.yml: allow failure for unreliable hosts
>>   .shippable: temporaily disable some cross builds
>>   tests/docker: fix pre-requisite for debian-tricore-cross
>>   hw/virtio/vhost: re-factor vhost-section and allow DIRTY_MEMORY_CODE
>>   linux-user: provide fallback pgd_find_hole for bare chroots
>>   linux-user: deal with address wrap for ARM_COMMPAGE on 32 bit
>>   tests/tcg: add simple commpage test case
>>   linux-user: detect overflow of MAP_FIXED mmap
>>=20
>> Emilio G. Cota (1):
>>   qemu-plugin.h: add missing include <stddef.h> to define size_t
>>=20
>> Paolo Bonzini (1):
>>   docker: update Ubuntu to 20.04
>>=20
>> Philippe Mathieu-Daud=C3=A9 (1):
>>   scripts/clean-includes: Mark 'qemu/qemu-plugin.h' as special header
>
> What about Philippe's "tests: Remove unused bison/flex packages" v2
> patch series from May 15th? I think you could include it here, too.

Sure - grabbed.

--=20
Alex Benn=C3=A9e

