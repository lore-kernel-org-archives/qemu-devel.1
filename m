Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316FBC4CEC5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008262067D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+faA8gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008262067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ly8-0006vs-Vl
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8lwP-0005Cr-LT
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8lwO-0001Nz-Lp
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:48:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8lwO-0001NK-FY
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:48:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id n10so2904318wmj.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OfQkhSIZJUY0cOjz5IPwTr0Un9wmHs6cxWfvTefSN3g=;
 b=i+faA8gvSB79b9LRQccVf/ZH0EwrnrvuuyO4Y4S5YEYvtNGaxKbu7cIL4ZmntYgm7q
 jTLXykkeGm3AMOmstdMxxG/nx0jJlz7bP1cNblpnfevsDbTFv7EACFcTaEcT4gd3bKRJ
 4w7ibjrWnia2aJFzJycznrQzJQPhQO0MWkoiNgWfxwu3pb/b1/CqrY/BaPL9hmaPrR3l
 XD4TQF0lX2GM/kzvhDauzLxULD/QrvNkmSGU+VtH9qF4It7WJBHsn7zCQVbrQfN1lcOb
 6NlSdc6fgIfxljW3UnSFINXXsC+F7EU05CYrtX63sAojhL8wEFJsC6HQSe5reNpU7M8C
 qJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OfQkhSIZJUY0cOjz5IPwTr0Un9wmHs6cxWfvTefSN3g=;
 b=ENxhlDFTPf3hMnOFJnUPsmxMBP2+papfybQRcLQkC09tqkCeY4yC/bX2nMpj4uDHm0
 gcvnGyNcV4cbo5lWjMeZt7YzszRfEGSw8DqziMgL7VEMRBHkMqlia2WtGed1e1xuXPAJ
 VAyRREIcBCExwwnCv/jQ6rq9kLZvF6Q4KrPA3xFv+Rxg7AKW2rSn69RYkwuHxToHZLnf
 kH6RgZVfZaPKcE0GpgFufMT4DI6nWn/nrgzAKjYGCHVCdrlPFQ92id26z61E+7UUDbnt
 pyjelPuTXrT/p77ew63oa1LLoG/qIlHcvfEPGUguDJJ6srLT2MUAgxozf/gWTbbAXrjc
 F9/g==
X-Gm-Message-State: APjAAAVMBwztog3YpBEXRhJB51G4Ah8et05q1kM0wERmlED0eCGKH3uI
 D1irsmH9rlPmE1j9y2DpYtWt7w==
X-Google-Smtp-Source: APXvYqzoWtUA01iJK6PaSgVhXxvgrVs9Oq2ZyRCmiH2iFQMTLk7aNTRbhkyqifXPAwnL/3MmZ5jRKQ==
X-Received: by 2002:a05:600c:2256:: with SMTP id
 a22mr3564731wmm.79.1568382526901; 
 Fri, 13 Sep 2019 06:48:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 189sm5353773wma.6.2019.09.13.06.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 06:48:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 757DF1FF87;
 Fri, 13 Sep 2019 14:48:45 +0100 (BST)
References: <20190911164959.11003-1-alex.bennee@linaro.org>
 <20190911164959.11003-3-alex.bennee@linaro.org>
 <CAFEAcA8NsdpEMOH1MFDta0LUswyqSDHCgtOh6g5k3+EU0FVuHA@mail.gmail.com>
 <875zlwz5o1.fsf@linaro.org>
 <CAFEAcA-6BmxkFND4nZBFs70nVPEFzSFrE6RMQ1O3ftqozYYoBA@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA-6BmxkFND4nZBFs70nVPEFzSFrE6RMQ1O3ftqozYYoBA@mail.gmail.com>
Date: Fri, 13 Sep 2019 14:48:45 +0100
Message-ID: <874l1gz4qq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v5 2/5] target/arm: handle M-profile
 semihosting at translate time
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 13 Sep 2019 at 14:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > This is still disabling semihosting for the linux-user-mode
>> > build for M-profile, isn't it ?
>>
>> Sure - as rth suggested. But m-profile doesn't run Linux so why would we
>> support it in linux-user?
>
> (a) Linux does support Cortex-M, since it has no-mmu uCLinux style
> support these days

TIL

> (b) gcc test case binaries, which tend to get run on linux-user
> even though in theory they're not actually Linux binaries

Ahh ok - that's fair. I'll add the ifndef for that then.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

