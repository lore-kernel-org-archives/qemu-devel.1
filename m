Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4016BC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1233020836
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/J+diWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1233020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiG29-0005F1-9e
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47739)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hiG1I-0004nA-Ay
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hiG1H-0002oI-9a
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:28:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hiG1H-0002mP-0z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:28:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id n9so337742wmi.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=byaHEHBgaY/ChmH+L5CBIr67s12auCxd8tYOunBJa0A=;
 b=G/J+diWYwzOjp2OL1YKqqLLLL8/MKMJoodNI+D/H/Sl1DkW87qPAnNzS645gvCi+mo
 ItT6hrRsVWEnhHciaZcANwZygW8k+i0mmZJgiwG5Yf0pomWHexkl04U8DVW0AZXWSYGE
 QOrQ6VFG9PyhL6ju+TIxwPIvb2GcTX6F330bdJCrHnZTPNj22FGDASRkcA5a3QnvrSo+
 ZTqaRl1JYPsoGY75X6P3RzEd0rLr7Rv6cK6vnpXivOu1CvWhaw+WQu+BpoA+dvToBr9u
 buixW6HigrJ5K8yhuHLVKqa8cHjjLFxNbbmW8znpUbYdancMlmNRrP+7kxyJFA8AniPj
 cBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=byaHEHBgaY/ChmH+L5CBIr67s12auCxd8tYOunBJa0A=;
 b=OxCZ+nftodGPfxFqz3GjVNlqmNWzbmWB3HKLz2S7Y3jMYSKbMkAPntGwbH0cWwOba8
 d99jnQh1xbGaGnWewkoKbfjPH8xMfPTpajnyvDG3Eft70OfU5RALr4HzTsEXPnCee3bG
 RFrwvwDfK+sIRmWZldTo5PZslURumrbQ/Q4bnVRlsUSwna7fmy4eBw0sTGI5rLgC3i6Z
 DpS2BmRAtQbOI712nTQtDk3XU3oWThQy8oqV+OqrMoUWIvVMGjl1WVIYZt+bDpdaaq71
 qU5GD7XE55XZ6YR46BQaFLJulV8Yo+mtHIpRweRMXC4Rx/1rFX0NyciGawbaf/3ta595
 HxGw==
X-Gm-Message-State: APjAAAUMnUTGHauDXKdsp8Dw+XJMR/SvK/T5/9BF2X/t+Gjk2bY7l4sK
 5g1WXr5Fo9NoBGJHJphBVq+cig==
X-Google-Smtp-Source: APXvYqyjQuOSiYPTlUQA2wbN23qi/xDnaiJHfEDTroYld9NAMU5zmCMevltEeu1DpMq/9EK9GUblFA==
X-Received: by 2002:a1c:2dd2:: with SMTP id t201mr3107776wmt.109.1562063293609; 
 Tue, 02 Jul 2019 03:28:13 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u13sm11218392wrq.62.2019.07.02.03.28.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 03:28:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 911271FF87;
 Tue,  2 Jul 2019 11:28:12 +0100 (BST)
References: <20190624134337.10532-1-alex.bennee@linaro.org>
 <CAFEAcA_VPcqxVjmSkRYoRRYS9TvM9KXU7e7pww9UofApp42O7Q@mail.gmail.com>
 <874l45sq55.fsf@zen.linaroharston>
 <c803aca4-aa53-845b-fc35-8d221df036a1@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <c803aca4-aa53-845b-fc35-8d221df036a1@redhat.com>
Date: Tue, 02 Jul 2019 11:28:12 +0100
Message-ID: <87zhlwrarn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PULL 00/19] testing/next (tests/vm,
 Travis and hyperv build fix)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/1/19 5:58 PM, Alex Benn=C3=A9e wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Mon, 24 Jun 2019 at 14:43, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>>>
>>>> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2a=
eacde:
>>>>
>>>>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-=
21-2019' into staging (2019-06-21 15:40:50 +0100)
>> <snip>
>>>
>>> OpenBSD also passes but has some output which my 'find warnings'
>>> grep picks up:
>>>
>>> con recv: WARNING: root is targeted by password guessing attacks,
>>> pubkeys are safer.
>>
>> This is a warning the installer issues before it asks you the question:
>>
>>   Allow root ssh login?
>>
>> Again this will only occur on the initial setup.
>>
>> Can you whitelist these warnings on your script?
>
> Hmm if this is installer-only warning, why not filter it in
> OpenBSDVM::build_image()?

We could I guess. I'd prefer it if we could have the check for warnings
script in the source tree and documented so it's easier to see when we
trip up this stuff.

--
Alex Benn=C3=A9e

