Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C9C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D70C20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlxX0dOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D70C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkZJ-00044d-Og
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izkWF-0000uh-Gg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izkWE-0003JZ-0v
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:00:47 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izkWD-0003Gw-ON
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:00:45 -0500
Received: by mail-wm1-x341.google.com with SMTP id a9so864792wmj.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PwCJ1s1OGrumu9EE0RiVxmLvtLCoj2/jQQ3z7Oc+eeI=;
 b=PlxX0dOiRKF+w9egsSSSTOIGbFuuQYe797sKVNxBubqTXEZ6T5huhThseh3PbS5n9M
 GVTeHjLfl4yGIDH90JkhsAmWfMnx+QKnFu0Jx2tjD4cikP3TX0oCzBL9nUjQPOWdrqPU
 cELShXh74O/jLFKOlDa+jHLenPmDx1M8uR+WrKoQUPmKHepJFDkZB6jJJUwQbJJOWB1N
 F9dWdmgGoCR608u6LMOp6KGLyz/MM13FQC7QkXEDqSvQ6HIcVrIIQonTf9JYuGWizvUx
 09l7wEp66n0wmH+7G/xHStfM2TEc1pNWIOKXkslC+qnymNxC+No2nGX/i5ApSl8C1rth
 QH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PwCJ1s1OGrumu9EE0RiVxmLvtLCoj2/jQQ3z7Oc+eeI=;
 b=tjXVrKFjnOSA1WTUTCr2Soy2EBe+ybiO+tL6vxkin2ECXm98GwsXB/T8XkNSOZwPh5
 4K5qTV3D/V5QLxkb5gYzpD65qQ56MFyFB1hhgDEKTF4127OAWufd78IEI1u7K1jwC/Bj
 iuxmjuvHCcb5qcV9kqcDeyw1fJgqPUowZABQTUJQCc3fgj2oZh8LOZpSsTQi7p7wT0Ql
 Ws5ZxtTeQ4SUXHwfGfy5rOArAbuhbAHhNBCptvKD+Ao5Bjgh69XEsrIsMtItIZOxK2/s
 OZRm7i+oy47PS9hnkSNW1WEArEPI3AUTMqxf7GMUa/3SlLJ3LmaxbOsZ0VLDS5rNZnjw
 W2qQ==
X-Gm-Message-State: APjAAAVviaJxtn3AbxaorjcQ4G5+Fg21Cc0x6q7S+rLjlxj01WeLaXfP
 wnRU9teL5HuyeCdbttF8aOvUzg==
X-Google-Smtp-Source: APXvYqx+ZqfsmnS9DmKNHaLROpwQbgyPQ8GH0qG5NxrcoxtCYYVG7AtmsTuP31XkKHoCx9V6SlbpwQ==
X-Received: by 2002:a1c:b486:: with SMTP id d128mr5691154wmf.69.1581008444254; 
 Thu, 06 Feb 2020 09:00:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t81sm146938wmg.6.2020.02.06.09.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:00:43 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 545E31FF87;
 Thu,  6 Feb 2020 17:00:42 +0000 (GMT)
References: <20200110161626.31943-1-alex.bennee@linaro.org>
 <20200110161626.31943-3-alex.bennee@linaro.org>
 <CAFEAcA9H8oNBX4QcKjSB3jFqDq==6tr392yEzJwF2Dxnw9EFcw@mail.gmail.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 2/2] tests/tcg: add a vtimer test for aarch64
In-reply-to: <CAFEAcA9H8oNBX4QcKjSB3jFqDq==6tr392yEzJwF2Dxnw9EFcw@mail.gmail.com>
Date: Thu, 06 Feb 2020 17:00:42 +0000
Message-ID: <874kw38xc5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 10 Jan 2020 at 16:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Bug: https://bugs.launchpad.net/bugs/1859021
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/aarch64/system/vtimer.c         | 80 +++++++++++++++++++++++
>>  tests/tcg/aarch64/Makefile.softmmu-target |  4 ++
>>  2 files changed, 84 insertions(+)
>>  create mode 100644 tests/tcg/aarch64/system/vtimer.c
>>
>> diff --git a/tests/tcg/aarch64/system/vtimer.c b/tests/tcg/aarch64/syste=
m/vtimer.c
>> new file mode 100644
>> index 00000000000..2f6299b5d2c
>> --- /dev/null
>> +++ b/tests/tcg/aarch64/system/vtimer.c
>> @@ -0,0 +1,80 @@
>> +/*
>> + * Simple Virtual Timer Tests
>> + *
>> + * Note: kvm-unit-tests has a much more comprehensive exercising of
>> + * the timer sub-system. However this test case can tweak _EL2 values
>> + * to trigger bugs which can't be done with that.
>> + *
>> + * Copyright (c) 2020 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include <inttypes.h>
>> +#include <minilib.h>
>> +
>> +/* grabbed from Linux */
>> +#define __stringify_1(x...) #x
>> +#define __stringify(x...)   __stringify_1(x)
>
> Code 'grabbed from Linux' is unlikely to be GPL-2-or-later...
>
> QEMU already has a stringify() macro in compiler.h.

Hmm I don't think I can include compiler.h in a system mode test. I can
certainly copy and paste our local version though ;-)

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

