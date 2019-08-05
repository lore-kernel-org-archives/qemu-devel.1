Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DF6C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 19:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5E920B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 19:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOMto01/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5E920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huiUX-00078z-O1
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 15:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1huiUA-0006jB-Lh
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1huiU8-0005aj-Gk
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:17:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1huiU7-0005Zs-C1
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:17:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id v19so74093622wmj.5
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WJb5Kh0WPH9aH7zEukVf4NjT2/5R/KTU9EON3Pgy+b0=;
 b=sOMto01/1xjHwV2rkg/e4cu4TgLzFSBnR7hwIymv8OsKPrDeI8mySE+vvSV9kU3Wva
 s6DHXyrxsO+mkWCTLWKqjHY1U/iPz4tLnva+Vcam6t5RzwXTOQgN1vM4BK+KdgLGm9X9
 Lfgy56cs/lDRA3gG5MgGnynFRZtCfc0CzmMXGsVH+K/LFoDQn1vUjs9jx1eCoilBPS6p
 /ewdtkWJz1c6aGDVdyndidCMTDeZKY8wTVOg8Ij22uqSU8VXYhC18LubkKkyS4/6gzPf
 25MxTkQlIurB9SR3cL2ODdP7N5e/bIXj1SZuPCvqD7F1rhA3LKd6TP14SQANdtr8S0lO
 EiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WJb5Kh0WPH9aH7zEukVf4NjT2/5R/KTU9EON3Pgy+b0=;
 b=Jr0I/07FjiifwqlHw6iBOn+vnOUHtKIYKINH3k7YcqtbgezYJVh/2U1To4OGNxlVVi
 SsLicddyiDc5DF7hvPATn1Zt0ZcC2AUmydX/kyLRLrk8qtUdVfebrpwNmlvZKxIUeaYn
 NxGcrct7A/E9gQDPK5Wnp/4Y64iV+Ev8ZzsDgxy4I4DJ9zsEbAcIQ4q3RwPEBVu/qc0O
 2O4RscHp8jGKk2+/5NoqKxNJigmTD2vk+w3OH1d5eK58QUGRDG0s0zXybGluBEsj3Qv9
 e0QJa8/ABC0MA281hpQkpcKic7JofF6Ci55wuA8YDANecyhAMqrc88I6Jm06A7OrqymX
 TPYg==
X-Gm-Message-State: APjAAAVXEuVzOyBfke9Pqg3cBjEzBsna5dyKUYnnzYo94E2UCk0sP3mY
 fN+EN0Xe3E1/m6deec7SNoEZQA==
X-Google-Smtp-Source: APXvYqwh0vZBBugegKRLj1njzsMCCcmntltrL70rlqWhxcy84+V/s99KR90BiGchp53r+k6gzFK/9w==
X-Received: by 2002:a1c:ca14:: with SMTP id a20mr19213733wmg.71.1565032649712; 
 Mon, 05 Aug 2019 12:17:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h1sm66496904wrt.20.2019.08.05.12.17.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 12:17:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB8E51FF87;
 Mon,  5 Aug 2019 20:17:28 +0100 (BST)
References: <BN6PR2201MB1251F757F3129C433E540F9AC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA8NE=hy4a-WuDuKeysi3KOjy8=ybHbLKkvzPM=ELvXBnQ@mail.gmail.com>
 <BN6PR2201MB12512C8AF64BD24CFFA9BCCFC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <BN6PR2201MB1251F3D9E077A24F1E6106B6C6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
In-reply-to: <BN6PR2201MB1251F3D9E077A24F1E6106B6C6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Date: Mon, 05 Aug 2019 20:17:28 +0100
Message-ID: <87y307ifqv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: Re: [Qemu-devel] [BUG] gcov support appears to be broken - solved?
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <amarkovic@wavecomp.com> writes:

>>> #./configure --enable-gcov
>>> #make
>>> #make check
>>> #make coverage-report
>>>
>>> It seems that first three commands execute as expected. (For example,
>>> there are plenty of files generated by "make check" that would've not
>>> been generated if "enable-gcov" hadn't been chosen.) However, the
>>> last command complains about some missing files related to FP
>
>> So your failure mode is no report is generated at all? It's working for
>> me here.
>
> Alex, here is the thing:
>
> Seeing that my gcovr is relatively old (2014) 3.2 version, I upgraded it =
from git repo to the most recent 4.1 (actually, to a dev version, from the =
very tip of the tree), and "make coverage-report" started generating covera=
ge reports. It did emit some error messages (totally different than previou=
s), but still it did not stop like it used to do with gcovr 3.2.
>
> Perhaps you would want to add some gcov/gcovr minimal version info in our=
 docs. (or at least a statement "this was tested with such and such gcc, gc=
ov and gcovr", etc.?)
>
> Coverage report looked fine at first glance, but it a kind of
> disappointed me when I digged deeper into its content - for example,
> it shows very low coverage for our FP code (softfloat), while, in
> fact, we know that "make check" contains detailed tests on FP
> functionalities. But this is most likely a separate problem of a very
> different nature, perhaps the issue of separate git repo for FP tests
> (testfloat) that our FP tests use as a mid-layer.

I get:

68.6 %	2593 / 3782	62.2 %	1690 / 2718

Which is not bad considering we don't exercise the 80 and 128 bit
softfloat code at all (which is not shared by the re-factored 16/32/64
bit code).

>
> I'll try how everything works with my test examples, and will let you kno=
w.
>
> Your help is greatly appreciated,
> Aleksandar
>
> Fond regards,
> Aleksandar
>
>
>> Alex Benn=C3=A9e


--
Alex Benn=C3=A9e

