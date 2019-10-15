Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8FFC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC0B20854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxBd1Ktx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC0B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKSDq-0000Xu-3m
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 15:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iKSCY-00080x-Bx
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iKSCX-00053K-3q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:09:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iKSCW-00052P-SC
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:09:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id v8so25205630wrt.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3KFHf8YJUcAAbi1mXMZE1xa8jaVMs+4t2pxpxJYEBqg=;
 b=pxBd1Ktx7ckLnMA85gNj/l3YwB81KUK68/auB9cfuMX94AQ1kZhTJyDRpy1eBTgQa6
 qFbklR+xPwvYSY8Bsp0boaD0Nf+hQ+HOCWmmt62nJ/ze8pyyA3NgzyEfYY2fHn8b7wHL
 DCmeF007XJFgZdruuBawYUspbgXuzfwUeJ19lZPzLXCQkTVPynvrPpQe5HbIXN2EQ2Ui
 lxVqPDxflqnuGpN6QxCmYXK/MtjMESc0OagmO1kF5x+mB4ISDWpvPX2LpS/iqgcGZu/i
 nVvk30dtDhhu0tEY4yOnoX1IRuwmnAA3/ncen2jLieMUB9ooLgSecn4B6xyzj/b/uAOH
 /eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3KFHf8YJUcAAbi1mXMZE1xa8jaVMs+4t2pxpxJYEBqg=;
 b=qe6ELNtffOj3MBgjFDbsKgDhetFIEohGg3eL0Dkt4Rei2/wh2ZxajcdfqNOK+LY56J
 WB0cMgMiQcFgveUUglcwF6s+oHHrcgH1DJ1HA8Uhqir5eH4o7gi6N4dGMO7PMd5BioyQ
 OBlCv/0+PdVUjX2+9Z9rF/dw2+JMyl/tLPTqnxJnYRd+RCEda0BM+xEmG29yJDE8vQsI
 sTGM99R5fEFNpADZVzPpdmanlq2AEScSuX1j6/LNhDGCXreHOd2t92PM9ETqyaXLzZxS
 o+y9j4iZ5aIdTWR3nCs7dqJNQCj51K0/rU+isUI7rW/Oj+fk60XD6JeouqBc+2/K5Iqs
 L3HA==
X-Gm-Message-State: APjAAAWof6dY9eEAT6nPWAP/AmRbDHiuTffoW4QUig2/YQNbYEoQAioD
 pWNFcqz7PnGX9K6Qa2/683IVTQ==
X-Google-Smtp-Source: APXvYqwgz3dRp5qkxVLeOmcgLWIEKM5Zeas9NFgJrfKXKFD7DQMqer5lB4hYtTOToON+ri/a0xu9yw==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr21476748wrm.348.1571166583128; 
 Tue, 15 Oct 2019 12:09:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t83sm270741wmt.18.2019.10.15.12.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 12:09:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 77D941FF87;
 Tue, 15 Oct 2019 20:09:41 +0100 (BST)
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-54-alex.bennee@linaro.org>
 <3ce497fe-9dc1-5fa3-acf6-155ae16e0793@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 53/55] plugins: add sparc64 instruction
 classification table
In-reply-to: <3ce497fe-9dc1-5fa3-acf6-155ae16e0793@linaro.org>
Date: Tue, 15 Oct 2019 20:09:41 +0100
Message-ID: <87wod5ltai.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: aaron@os.amperecomputing.com, cota@braap.org, qemu-devel@nongnu.org,
 peter.puhov@futurewei.com, robert.foley@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/14/19 3:49 AM, Alex Benn=C3=A9e wrote:
>> +InsnClassExecCount sparc32_insn_classes[] =3D {
>> +    { "Call",                "call",   0xc0000000, 0x40000000, COUNT_CL=
ASS},
>> +    { "Branch ICond",        "bcc",    0xc1c00000, 0x00800000, COUNT_CL=
ASS},
>> +    { "Branch Fcond",        "fbcc",   0xc1c00000, 0x01800000, COUNT_CL=
ASS},
>> +    { "SetHi",               "sethi",  0xc1c00000, 0x01000000, COUNT_CL=
ASS},
>> +    { "FPU ALU",             "fpu",    0xc1f00000, 0x81a00000, COUNT_CL=
ASS},
>> +    { "ALU",                 "alu",    0xc0000000, 0x80000000, COUNT_CL=
ASS},
>> +    { "Load/Store",          "ldst",   0xc0000000, 0xc0000000, COUNT_CL=
ASS},
>> +    /* Unclassified */
>> +    { "Unclassified",        "unclas", 0x00000000, 0x00000000, COUNT_IN=
DIVIDUAL},
>> +};
>> +
>
> Unused.  You'd see this if they were static.

How similar are the sparc and sparc64 decodes? Is there a canonical
table you can point to?

>
>
> r~


--
Alex Benn=C3=A9e

