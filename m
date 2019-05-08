Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227E6C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA21205C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA21205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFfr-0003d2-2G
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:03:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFer-0003HG-Ag
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFeq-0004gO-F5
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:02:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOFeq-0004gE-9V
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:02:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id e11so12415847wrs.0
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 23:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=B0q/Nk2o5gY1DCAW1FE/T7NdN+C+yzwSIYmIeFdI0vU=;
	b=JMEB646zJFdmqdEKd5Q9LHGeqqQ09W1eWPhsamBJjWkDyrWzHY9BWA+DnwpR5ILCRW
	mN6zrCPDHkecJP9fWZ92ET7e2qneZUQZ+y55UWp9lOMPZ4cpFmk3YpIdpXpLkhklJ/e8
	rJTuobca4RYAdqn2TVh1azKKd5miH+gDDgs7jgCiVg08f9xM5uibW4zkib9LshyUYQO1
	SvNm2qU9oG49/ygDMTOzbwlODB6Is2ZBsEIcdsE4fpjHKjpqXAxPsqK2rgOgjm5t+9kS
	g6DpcDpBQzuzc3oth6CWswTklYY/PTwVV/bb+YG6olvyCTh8a2tjQPGjpcjwSBKtwogG
	Od0g==
X-Gm-Message-State: APjAAAW5s2qyu8nm8AZDfFNjAPSVIKXNTNODKKxDAkAvXiWjxbbAUAvl
	cSJg/RA23anjGiXsoYwQuJuNYXjaoXY=
X-Google-Smtp-Source: APXvYqxkvjk7FDFTSJf8kZpgiz0sl93EIMKUVNjR9WmzUe59NMruchkNTNx6ktwTzou4we1qylrssw==
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr14363678wrw.210.1557295342771; 
	Tue, 07 May 2019 23:02:22 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	y184sm1251145wmg.7.2019.05.07.23.02.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 23:02:21 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-25-richard.henderson@linaro.org>
	<CAFEAcA8qcQoBdYJFhZ9ka=MekSM8U=PfVr1+ZdogHk_K0PuxRQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <84b81f05-11fa-8037-f0e9-c48d2f05d280@redhat.com>
Date: Wed, 8 May 2019 08:02:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8qcQoBdYJFhZ9ka=MekSM8U=PfVr1+ZdogHk_K0PuxRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 24/26] tcg: Use CPUClass::tlb_fill in
 cputlb.c
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/19 7:28 PM, Peter Maydell wrote:
> On Wed, 3 Apr 2019 at 05:05, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We can now use the CPUClass hook instead of a named function.
>>
>> Create a static tlb_fill function to avoid other changes within
>> cputlb.c.  This also which also isolates the asserts implied.
> 
> I'm not sure what this sentence is trying to say ?

s/which also// ?

> 
>> Remove the named tlb_fill function from all of the targets.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

