Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8124C4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BD820838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSlC6bz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BD820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43667 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vrq-00057c-Q6
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6vnp-0008QE-2N
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6vnm-0000lU-Q4
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:28:36 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6vnl-0000gS-J3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:28:33 -0500
Received: by mail-wm1-x343.google.com with SMTP id a141so2058429wme.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 04:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GebF3YCAUV6iq6BoBFA5/3vZx76lWoG1RufaLzGRksA=;
 b=kSlC6bz4T+MbNACHpKHLxmIHh1WGc8lSST+gd+lGhF0MzYvs7s8WJxYfdC4ubPD2/f
 bVh5CbZ8e28Kq68nDMcqPwifhBursQD7+9Vs490qHqp55nKIxD1QDXbOxFOu0WGFMg0k
 evWrQhDPDU049ROL91Y7qaRrd0/HrLL2LvtRcc5yQb9zM7rpN6XAEKaaor14gLVbvn1v
 8e7nC+vDHFm/XDULygZIAoF7oDbOqQb7iE5/dNaD0fSSyHQtf25CyWdLuGW+Tc36npHl
 3EVHMzWq4ESif4R7o/TlJ+vRu1puqbpDvH8K/XeuKYazwJ39Urc1RkHHz8+qfUX0cu5b
 BZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GebF3YCAUV6iq6BoBFA5/3vZx76lWoG1RufaLzGRksA=;
 b=dEKAneCaKpERXSPl4o4zo6bnC9bK54p8Qczzlgz/hDlgKkEl5qTAME2pqDUWaaxcx1
 kDkLasov3CXq87ot4qRNMOrbPLbpMT4e5CMQ2h2YlW9uE5xeGSJwWdOxmsNGkZeNVsRe
 t+XjYcx1PuBjJV7E2ptkEgMg8naXQn62QOmYDNLTJ5BrKTRvzZWu0tPsO6MQcXl6SrtS
 hoXiXlsyeF4NOU2poXUSDYSwLRsQsvlhl3O4lr97z1VuQeD4DtM2Wpf3Ls6incxZNutW
 rjoBaVF4VZocE+z7TWKkTab0UdihNQSwRMUR0Id6MD/lhhB3DEiegOaCMBWW9pub7Dy/
 0ZAw==
X-Gm-Message-State: APjAAAVhBVwcHeKv2w9qHwIO0pjkfmbsdcXXYJcbYWyjeix//Nocv7q3
 JR4LScEiNRUYKFrlBQgi3NwN1g==
X-Google-Smtp-Source: APXvYqygh02oNUgmHFYo6q1TXKu1zcASlSz2R/V5AAez2z2qCQkb5NabqRUpgdr8sTU+JfUs8nWVyg==
X-Received: by 2002:a05:600c:34b:: with SMTP id
 u11mr5348522wmd.69.1582720111972; 
 Wed, 26 Feb 2020 04:28:31 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d7sm2592694wmc.6.2020.02.26.04.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 04:28:30 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA8441FF87;
 Wed, 26 Feb 2020 12:28:29 +0000 (GMT)
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <d9d4fba7-2dcf-8f09-8f3a-7e0408c297b6@linaro.org>
 <alpine.BSF.2.22.395.2002211643480.45267@zero.eik.bme.hu>
 <CAFEAcA-teH7KXACL=5m0-X+g692EXKtqOy9d_uGjw6XA8S3vzA@mail.gmail.com>
 <alpine.BSF.2.22.395.2002211807380.69986@zero.eik.bme.hu>
 <CAFEAcA9-VzUXij1_vFr+d7KuMOw+Tdv0hvxW2WmfGxt=fAKvjg@mail.gmail.com>
 <alpine.BSF.2.22.395.2002212034570.8472@zero.eik.bme.hu>
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-reply-to: <alpine.BSF.2.22.395.2002212034570.8472@zero.eik.bme.hu>
Date: Wed, 26 Feb 2020 12:28:29 +0000
Message-ID: <87mu95y1le.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Fri, 21 Feb 2020, Peter Maydell wrote:
>> On Fri, 21 Feb 2020 at 18:04, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>> On Fri, 21 Feb 2020, Peter Maydell wrote:
>>>> I think that is the wrong approach. Enabling use of the host
>>>> FPU should not affect the accuracy of the emulation, which
>>>> should remain bitwise-correct. We should only be using the
>>>> host FPU to the extent that we can do that without discarding
>>>> accuracy. As far as I'm aware that's how the hardfloat support
>>>> for other guest CPUs that use it works.

Correct - we only use hardfloat when we know it will give the same
result which is broadly when the inexact flag is already set and we are
dealing with normal floating point numbers.

We added a whole bunch of testing to ensure we maintain accuracy when
the code went in.

<snip>
>>
>> I don't know much about PPC, but if you can't emulate the
>> guest architecture accurately with the host FPU, then
>> don't use the host FPU. We used to have a kind of 'hardfloat'
>
> I don't know if it's possible or not to emulate these accurately and
> use the FPU but nobody did it for QEMU so far. But if someone knows a
> way please speak up then we can try to implement it. Unfortunately
> this would require more detailed knowledge about different FPU
> implementations (at least X86_64, ARM and PPC that are the mostly used
> platforms) than what I have or willing to spend time to learn.
>
>> support that was fast but inaccurate, but it was a mess
>> because it meant that most guest code sort of worked but
>> some guest code would confusingly misbehave. Deliberately
>> not correctly emulating the guest CPU/FPU behaviour is not
>> something I want us to return to.
>>
>> You're right that sometimes you can't get both speed
>> and accuracy; other emulators (and especially ones
>> which are trying to emulate games consoles) may choose
>> to prefer speed over accuracy. For QEMU we prefer to
>> choose accuracy over speed in this area.
>
> OK, then how about keeping the default accurate but allow to opt in to
> use FPU even if it's known to break some bits for workloads where
> users would need speed over accuracy and would be happy to live with
> the limitation.

About the only comparison I can think of is the thread=3Dsingle:multi
flags for TCG which is mostly there to help developers eliminate causes
of bugs. The default for MTTCG is it is enabled when it's safe. If you
enable it via the command line where QEMU hasn't defaulted it on you
will get lots of loud warnings about potential instability. The most
commonly used case is thread=3Dsingle when you want to check it's not a
MTTCG bug.

I'm as cautious as Peter here about adding a "faster but broken" command
line flag because users will invariably read up to the "faster" and then
spend a lot of time scratching their heads when things break.

> Note that i've found that just removing the define
> that disables hardfloat for PPC target makes VMX vector instructions
> faster while normal FPU is a little slower without any other changes
> so disabling hardfloat already limits performance for guests using VMX
> even when not using the FPU for cases when it would cause inaccuracy.
> If you say we want accuracy and don't care about speed, then just
> don't disable hardfloat as it helps at least VMX and then we can add
> option to allow the user to say we can use hardfloat even if it's
> inaccurate then they can test their workload and decide for
> themselves.
>
> Regards,
> BALATON Zoltan


--=20
Alex Benn=C3=A9e

