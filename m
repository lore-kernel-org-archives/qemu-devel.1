Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5017C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05FE20B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvXQ2Lhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05FE20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3DW-0000t9-Bo
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 16:48:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51640)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hhyhR-0008Pg-Lz
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hhyhP-0005Rs-KC
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:58:37 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:39118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hhyhN-0005Q5-BH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:58:33 -0400
Received: by mail-wm1-f53.google.com with SMTP id z23so42600wma.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vLMOT2J/gp6XoPchNOUuZ6ogUV6NQsNUUQv5fdXkhzM=;
 b=bvXQ2LhmCUr6fKvXIYUzvUcnTy35gGJqRE2LGmDCx6XR2x3uJtMgoO9t3rlp/YN4wD
 0eKUUcxzku0SqEWKn2hhcVBGcQ0gZ7DCF3f3YV2PqUHeHgcPlzrhFeg3cs6Zlx8vponb
 nohzBa0uxKkwYTiMSvcBmSI+gfWmELVOufp06iAu7q8/Gpf9BwZoQKy8wPQbMXZv7T6H
 1oUxsA2R3RXWEcjc0UA4JzP9ZRxDzTFoUaI1BD4vKndbgCVcqaJY+HtG0JMXSSyDMgXp
 XN9H6SwhO9gu+UWXEf8SCk9+jCi723f90fUjMyT1efEjTbQENC6XJHhtpCzbU42Q4qvf
 fScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vLMOT2J/gp6XoPchNOUuZ6ogUV6NQsNUUQv5fdXkhzM=;
 b=N+mzDRm6TPAPJI1Sp/QAY+hLeX/Xzdrdt6Zy/H1NOPe9m46jeH3jf0PmCXHw1QlHqY
 fAe7ikuGLUUBx53uj9oLFdlxjcId9VZWcoCIRdpPrsMXdcObapwEUQwY7+6kFHZb0w8+
 lMjmyM2TObx19qg9fHV2XZxl/gc0QhaJJSAUJAneow3709l+z8FJI/rmDitRRjqwovcF
 Xvq1p6Hl5y8LXScpr3u8NWa+m3+W/wscnEEv9ZCnmyogo8fAPZpNFCM/T3W6k0mMuz1Q
 AMY1wee9aIC5y03ip3qgL1C8BUb/aoNQqsgfe/uW+neo1sO/hdjCUDBitBwLhcq7nfEO
 ACTQ==
X-Gm-Message-State: APjAAAVKaWObv8RlVzkyOWvWiwQCh7ZxkvhDXZDtRspAiToO76aJVArl
 oQ9D9pVhcXe/uwxU8cMjGB2LnQ==
X-Google-Smtp-Source: APXvYqxllQV/4QjvVqEvpvZFK5IhAzAA03su+8/VM6XdrI6q7HSw4B9MEjJhce7WdUjldRiBCadVJQ==
X-Received: by 2002:a1c:5f87:: with SMTP id t129mr7067wmb.150.1561996711939;
 Mon, 01 Jul 2019 08:58:31 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j7sm15103195wru.54.2019.07.01.08.58.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 08:58:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BD58B1FF87;
 Mon,  1 Jul 2019 16:58:30 +0100 (BST)
References: <20190624134337.10532-1-alex.bennee@linaro.org>
 <CAFEAcA_VPcqxVjmSkRYoRRYS9TvM9KXU7e7pww9UofApp42O7Q@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA_VPcqxVjmSkRYoRRYS9TvM9KXU7e7pww9UofApp42O7Q@mail.gmail.com>
Date: Mon, 01 Jul 2019 16:58:30 +0100
Message-ID: <874l45sq55.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.53
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 24 Jun 2019 at 14:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aea=
cde:
>>
>>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21=
-2019' into staging (2019-06-21 15:40:50 +0100)
<snip>
>
> OpenBSD also passes but has some output which my 'find warnings'
> grep picks up:
>
> con recv: WARNING: root is targeted by password guessing attacks,
> pubkeys are safer.

This is a warning the installer issues before it asks you the question:

  Allow root ssh login?

Again this will only occur on the initial setup.

Can you whitelist these warnings on your script?

--
Alex Benn=C3=A9e

