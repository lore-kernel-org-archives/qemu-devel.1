Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D253C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE23215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMwdJq8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE23215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6sJ-0002w3-4o
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59579)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hb6aX-0004Kc-Gl
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hb6aW-0003Il-0u
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:59:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:35138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hb6aV-0003De-BC
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:59:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id c6so7317683wml.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PTGsry3opnQf6SM0psrvilwbnxrgl8P2sFHyFQzxYf4=;
 b=wMwdJq8AMg7FzfEgag5OBOYamLzp+NEe+zFzODHNHBBoYgCwcwocxzRvGLBCemxTqs
 KXxrm5InthDHBzqcRpnxpUkXIUJu+SADj12/7Mk/Ewbw1rMjRNNcGX5FdueQwsya4Wh/
 +ja/g5GqO+u+i6sfwqhU1Y5zfOFV3gtD9jK5CZwcpzZEoxFVEGEEf66ov5QEzt7dWAe0
 g06nS5GEZyR6wXLZb2M2gOmyi/nEc+44JSte8GrtaDpVySJOCYwYvu0xEfmBzicwwEbZ
 0viy9h+2c9ViglV62Fr1L7lPcQFXYB8p5FwbuFTKQyGGxKxnBVHnu856OHjfYwL7MmnY
 xeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PTGsry3opnQf6SM0psrvilwbnxrgl8P2sFHyFQzxYf4=;
 b=iL+9ee/pATf+66marFKoegRfmJdDWfgBSjjdVSplWEV0HY4kQZIc2GUXh4zrr6ojaP
 kej8G/vFCizL7bpPBOocgsDzuhVsq7sMjWuOUg76nK0N5UVI/eWlr0tBLcFAV0qNluCN
 MDcE0vIRhNUC4Kmgmx5pDxJkFtZ+91Nw7K59OwXeEU1cQO0ALK9/H0pRtrzaGFj3kE8r
 uNiZZ95rbqQF+DsiaDR3mBTJbADRcg4TVCCVFxrPiEi9lMTEP1p2bQw3iLgHRdMOUwWz
 lb24SGnnK5V/6GGY49jrOAnlnxnl8GcNVaxP+KED5IGtYcO6znS/hCHnx0u3iScDZZ+m
 IYDA==
X-Gm-Message-State: APjAAAXDbo2+g2fvaXOyhEyTc+dCdyt5hG8UaXCEjP/LTTeN6bWGZJyE
 AKdiwJcpkA45sFxEsisxazpTbA==
X-Google-Smtp-Source: APXvYqxZc2/Cn0EFuVol3N00cYaEM9rWbCFyFX+a/0DtXjIm+3PjqaERjJ2k0vQM9asriopI9Z+FLA==
X-Received: by 2002:a1c:b68a:: with SMTP id g132mr168582wmf.66.1560358740975; 
 Wed, 12 Jun 2019 09:59:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a81sm436830wmh.3.2019.06.12.09.59.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 12 Jun 2019 09:59:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 008011FF87;
 Wed, 12 Jun 2019 17:58:59 +0100 (BST)
References: <20190612111949.25117-1-alex.bennee@linaro.org>
 <CAFEAcA9cKcTpyU_SpzVH91JnQfU2g14bNuk_oWkObbbYYxdXQw@mail.gmail.com>
 <CAHDbmO0+DV0EP=xrHfXa8SUFC5TWWZvwPOE_D0ZpT8c0SPnoNw@mail.gmail.com>
 <CAFEAcA_KjH9hnO4FaXU=iX1FAbNGumxi-=5hwNKbe99SK73ptA@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA_KjH9hnO4FaXU=iX1FAbNGumxi-=5hwNKbe99SK73ptA@mail.gmail.com>
Date: Wed, 12 Jun 2019 17:58:59 +0100
Message-ID: <87r27yeo4s.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: Re: [Qemu-devel] [PULL v2 00/52] testing, gdbstub and cputlb fixes
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

> On Wed, 12 Jun 2019 at 17:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> It looks like it's still trying to use the system QEMU (which is
>> broken for this in hackbox) to launch. Is there a built
>> qemu-system-x86_64 in your build directory?
>
> No -- the build process here is just make -C build vm-build-openbsd
> (etc) on a configured tree. I can add the 'do a local built in
> this tree' step to my scripts, but I wonder if maybe the test
> target should depend on something so it gets built before it's used?
>
> PS: NetBSD worked fine.

I dropped the NetBSD autoinstall over serial. I suspect we have a
combination of dodgy serial emulation combined with something the BSD's
exercise.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

