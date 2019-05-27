Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70BDC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 21:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B584C20673
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 21:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B584C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVNHo-0000Wn-HR
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 17:36:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVNGx-00007T-IH
	for qemu-devel@nongnu.org; Mon, 27 May 2019 17:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVNGt-0004FF-AV
	for qemu-devel@nongnu.org; Mon, 27 May 2019 17:35:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVNGr-0004Bg-Uf
	for qemu-devel@nongnu.org; Mon, 27 May 2019 17:35:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so9669349wru.11
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 14:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=slypFxVKZWHk6Irsn+MsTOCn7v7oSS5YXMPvpwdap+c=;
	b=C9oE3IQfzDCMjWJM0HX44jtkbw8ffk0pqsys+81KURA6jOXm8qGm8JHObwxeILQYYz
	th5szuLWCcDDJ/fgEDXbR3B8ZgaKl9pEylrD5icckKJT1SXobAnuhAfZJ33VEMchUgsK
	2mkJFVGtpjUWU0Mauc8s0SP+qWJPJ2BHgjuDKWEd+LgTXiIQA+cdTrOlG+QI8VPi+buH
	mwf5QXS9UM8MAWHkyxwh1rZCDoIH7tm9M+2ux+Cf0RAuBxFsEDgG1naR+dnPhYNO1y4S
	e2kB9IZIFHL6KCy8abFHsgCdVPc6FquohQafHHK2/HiEx2Hg0exv0EzWBD5L8/KlfDw3
	S9Jw==
X-Gm-Message-State: APjAAAVchPBsHrOUJMRSPwrHigh+qyVIZOsLN2zGL4MoI+7sOtFd4CVN
	LjQDfZQoIILaqp0UGmVHNDeMYw==
X-Google-Smtp-Source: APXvYqxcei3URSJ1GNuDvLCEk+FDby5SaHViExIIU907ndNhNej7vR7/uAlNBet/Z0Q1qXWNlzbAuQ==
X-Received: by 2002:adf:aa0a:: with SMTP id p10mr29136228wrd.125.1558992904321;
	Mon, 27 May 2019 14:35:04 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	34sm29820974wre.32.2019.05.27.14.35.02
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 14:35:03 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190311005618.19007-1-philmd@redhat.com>
	<CAL1e-=hJVsaMDFyB5O-7JWtNEZ8JE7hbe8-n35yDxKD=znT=XA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6781ecbf-27b8-8925-11f9-6b746f14ef9d@redhat.com>
Date: Mon, 27 May 2019 23:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hJVsaMDFyB5O-7JWtNEZ8JE7hbe8-n35yDxKD=znT=XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Kconfig dependencies for MIPS
 machines (but Malta)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>,
	Thomas Huth <thuth@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
	James Hogan <jhogan@kernel.org>, qemu-devel@nongnu.org,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 5/27/19 8:31 PM, Aleksandar Markovic wrote:
> 
> On Mar 11, 2019 1:56 AM, "Philippe Mathieu-Daudé" <philmd@redhat.com
> <mailto:philmd@redhat.com>> wrote:
>>
>> Express the MIPS machine dependencies with Kconfig.
>>
>> Due to its complexity, the Malta board fill follow in a different
>> series.
>>
> 
> Philippe,
> 
> What would be the status of this series? I am willing to integrate all
> this, including all followups, but have hard time sorting out what
> happend after this submission, what is the most complete version etc.
> Can you enlighten me please?

Thanks for your interest in this series :)

I was chatting with Thomas about this series earlier today!
I addressed your comment about the ITU/CPS devices, then wanted to join
all the Malta patches in the same series, but there are too many for a
single series so I'll keep them separate.
About Malta, I can do it two ways: one quick and dirty, and one clean
but long. Problem with long series is they can take too long before
landing. I'm trying to figure a quick but not that dirty way to solve
this, then we can improve later.

I'll resend during the week.

Regards,

Phil.

