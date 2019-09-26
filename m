Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37BFC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE9A222C6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6jojtwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE9A222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDVy6-0003nH-FF
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDVlN-0002p4-3s
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDVlJ-0002KK-8G
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:32:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDVlJ-0002Jo-2F
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:32:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so3286657wmp.4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3QAQ1jdEQCflQutRvKO+cVS07L3PA/oq52e0xJNXIuU=;
 b=O6jojtwSle4hIvvehmw/j6WqpivH0r4DqH3MgPDQRoavI4RDFtVO3RcCiXMy+kllsR
 pkzJJ42CtjP//Ll089EUfzPHWWXQtj4mGpzxTEi08c7sJrs7I4+L9uqtdpyCEmZ5Ue1O
 EGDkjJgxVQhnhDmZqgy2vqyiaZFP3LcL1oXaehRH/lhFFwBM2YnHv2IQcuZSlMahgPXl
 1vDWmMm86bcQMz4+2Bf5CdBJ6z06OW+5nnhtTXRD6/oxjnZhvGgrK/y74VLkoQrl+338
 ylXE5o5d0SS4RM1/P6CBYZ4h9+AUM/RL3AEPenaiGwHTSWFhRrbNsOSs4xJ8Lvdyz55c
 2Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3QAQ1jdEQCflQutRvKO+cVS07L3PA/oq52e0xJNXIuU=;
 b=odwRUw3czylkRWmAWlKmzLKAsAt+fJLGY2zACD99RiNCg3StYs8P+DcaJQz8T9P9cN
 YhIhCTTFi+UFI9d2Xf5n0TWlsw4dmtbb6jcMszaaSKa+Dn4363rCLB9n8R4gwdj1SBTs
 TUpED1I9hKJYOvztLo125FYQ1rR1bRkAmc5KLN74tEE/AxMZlhZQNaajubWIrn9fLWXH
 I2HF3vb9DaXD3Nt1iq2RjQrHDEbyW2lnt1DjoURjTwvX4bi5eQeE0PrGzOAWO+MXDu/l
 +cw31aoSbeVSH4p+luq+m+qve45kxYxZ0TmzpltmSUSIG9DgqQjDXJ4fZds8mY3Cmi4y
 SGdw==
X-Gm-Message-State: APjAAAU0g0tiVFSgzktE7IaAAnK/P2X7QtAprIjCNFY7ihXOUQrr8s1B
 O6ZneGHfrgCuYeHTyNzNR8Vyfw==
X-Google-Smtp-Source: APXvYqwTzUjnKBCmTy9t5p6VOQGz4nr6zBa38TyCXKbhCjHf+OnUE8724dXO0VWXrPCTn8peMnsnSw==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr3534521wma.131.1569511915772; 
 Thu, 26 Sep 2019 08:31:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l10sm4575125wrh.20.2019.09.26.08.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 08:31:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 400B91FF87;
 Thu, 26 Sep 2019 16:31:54 +0100 (BST)
References: <20190925233013.6449-1-alex.bennee@linaro.org>
 <CAFEAcA9vb5_Mi_axWpu7269Zg0xMLbiiV80ofLeyDpfws3G4nQ@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] configure: deprecate 32 bit build hosts
In-reply-to: <CAFEAcA9vb5_Mi_axWpu7269Zg0xMLbiiV80ofLeyDpfws3G4nQ@mail.gmail.com>
Date: Thu, 26 Sep 2019 16:31:54 +0100
Message-ID: <87blv79iqd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc@nongnnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 26 Sep 2019 at 00:31, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The 32 bit hosts are already a second class citizen especially with
>> support for running 64 bit guests under TCG. We are also limited by
>> testing as actual working 32 bit machines are getting quite rare in
>> developers personal menageries. For TCG supporting newer types like
>> Int128 is a lot harder with 32 bit calling conventions compared to
>> their larger bit sized cousins. Fundamentally address space is the
>> most useful thing for the translator to have even for a 32 bit guest a
>> 32 bit host is quite constrained.
>>
>> As far as I'm aware 32 bit KVM users are even less numerous. Even
>> ILP32 doesn't make much sense given the address space QEMU needs to
>> manage.
>
> For KVM we should wait until the kernel chooses to drop support,
> I think.

I can certainly do that - although I'd still like to know who actually
uses 32 bit kvm support these days.

>
>> @@ -745,19 +744,22 @@ case "$cpu" in
>>    ;;
>>    armv*b|armv*l|arm)
>>      cpu=3D"arm"
>> -    supported_cpu=3D"yes"
>>    ;;
>
> I'll leave others to voice opinions about their architectures,
> but I still have 32-bit arm in my test set for builds, and
> I'm pretty sure we have users (raspi users, for a start).

raspi is probably the most common one because of the 32 bit userspace
they use even though they are running on 64 bit chips.

>
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

