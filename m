Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD43C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D912084E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjelhcfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D912084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlMM-00048x-N7
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:53:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOlKU-0003Dv-9u
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOlKT-0000F3-Ao
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:51:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOlKT-0000Ek-4G
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:51:29 -0400
Received: by mail-pl1-x642.google.com with SMTP id a5so1337341pls.12
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=D4+kb96N2FXHyDZm78o7SuTUsj+qZaCSox4Y2QdmyMY=;
	b=fjelhcfTRhfj4O5rY8Z4HiAklE/1NC5SlBEt0WHkvM3Z24dG9uCYsXI7bTd3+90PgM
	DHLx0iJ+DVhSt+/1y9tpLAjqBn+jvXd3AkX1SbNSMJgTtgxOVp5a6Le+FCPPPmjfyIo4
	lQ7WSJx/q3MCfpoBdc8QJ7juNeQABuMGFqAceo6PuM580uP/knOpUNC2l/TsZC3XFJSj
	WGolbyFxGZYRE22WUzL23kihEKA+XAfJkNwp96c+9iF0/nGGydiKgjzuGxSunFwwPF/C
	MEh+b7uiOPP3/lCUWa2oI+jvjy4xLQgc25ZxsIQOJl8z5Eksi/PUpkLY8p2ksOYEdTQY
	0WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=D4+kb96N2FXHyDZm78o7SuTUsj+qZaCSox4Y2QdmyMY=;
	b=gexvBfmGF5Kx04hue6S5qMJN/jenEzzUerf3tN3pDG7Ybf22l/wUmon+tiuxS5RMj1
	6jsBMIqZz7hQwnar9t5PWMAlHO02qak35+wcATj1xyxD51YsF/v37znhJV90IGP88KoV
	Sz8BB+h4lZXWyJmS3ZGzcOduZUrUmM+FGE/VPBo0Cfow/ekoj7nSgO2mu0PqDEKo9c3t
	IhMjQPy46ae2madOqAuSQb2nv0SiqYGEKVUs+m7AxHOUNiiOj8AoyCSAJCNg9oMyaxMy
	SuPic75tpo55LKVrDBwoMJLGNRzZ+efJLSM0hkp1dYtOeRQX6MCDHooVtbsKFTLNmjVJ
	Swcg==
X-Gm-Message-State: APjAAAWTj1bK1406VTYG/fKnoiuSy/z53Z7PKXK+yeEi2chqmW5yCkOW
	FE0pXO7yN1jTK+U26zqvfWCe6Q==
X-Google-Smtp-Source: APXvYqx8u8rQloUlfbtFBnvWTK1qjxg6gGdK7QC78L4lsEJNqmJzYsI6BuWiOcjHLecdpInAWPEnnw==
X-Received: by 2002:a17:902:2a2b:: with SMTP id
	i40mr6135289plb.170.1557417086775; 
	Thu, 09 May 2019 08:51:26 -0700 (PDT)
Received: from [172.31.99.192] (50-248-210-99-static.hfc.comcastbusiness.net.
	[50.248.210.99]) by smtp.gmail.com with ESMTPSA id
	d186sm3012150pgc.58.2019.05.09.08.51.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 08:51:26 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
	<20190509060246.4031-21-richard.henderson@linaro.org>
	<CAFEAcA_2SbYfaOf4_p1r5O2iCLmoBWixWpgBnAcZYaWixr2KKQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <03b875ce-ad72-368f-202f-5240cb9db60e@linaro.org>
Date: Thu, 9 May 2019 08:51:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2SbYfaOf4_p1r5O2iCLmoBWixWpgBnAcZYaWixr2KKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v2 20/27] target/sparc: Convert to
 CPUClass::tlb_fill
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 6:35 AM, Peter Maydell wrote:
>> +    if (probe) {
>> +        return false;
>> +    }
>> +
>> +    if (env->mmuregs[3]) { /* Fault status register */
>> +        env->mmuregs[3] = 1; /* overflow (not read before another fault) */
>> +    }
>> +    env->mmuregs[3] |= (access_index << 5) | error_code | 2;
>> +    env->mmuregs[4] = address; /* Fault address register */
>> +
>> +    if (access_type == MMU_INST_FETCH) {
>> +        cs->exception_index = TT_TFAULT;
>> +    } else {
>> +        cs->exception_index = TT_DFAULT;
>> +    }
>> +    cpu_loop_exit_restore(cs, retaddr);
>>  }
> 
> ...but in the new code we only set them if we're really
> going to fault.

Yes, I made change assuming that would allow probe to work, which would seem to
require that the FSR not be modified.

> The v8 SPARC architecture manual appending H says that
> when the NF bit is 1 faults detected by the MMU cause
> FSR and FAR to be updated even though no fault is generated
> to the processor. So I think the change here is not correct.
> 
> (The spec also says that ASI 9 is supposed to be special and
> not affected by NF==1; and I think that since we put entries in
> the TLB for the NF case we won't correctly set the fault address
> register if the CPU makes two successive accesses to the same
> page, because the second access won't take the slow path and
> won't update the FAR. But those are pre-existing bugs.)

Thanks for the pointers.  They do look like pre-existing bugs.

I think the only thing to do for sparc is the same as i386 -- assert that probe
is unset.  If someone ever decides to use tlb_vaddr_to_host from the sparc
backend, they'll have to come back and untangle this.


r~

