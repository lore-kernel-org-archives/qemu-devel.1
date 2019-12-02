Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021E9C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5BD20833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdKXEZFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5BD20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibbPe-0006WJ-RF
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 21:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibbOP-0005L0-0m
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibbON-0007Oc-QB
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:24:52 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibbON-0007O7-J2
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:24:51 -0500
Received: by mail-pl1-x641.google.com with SMTP id h13so15567200plr.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 18:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9uZMeOcjp69CcLk4kJoh51jLK8rzeIE59U8CnyNM9uw=;
 b=NdKXEZFPqImyiun752tSnpnNEyZG0dTjM0NwfMw7m/reaycfYDF5JhWaLkXPkOm+hW
 YtJqnFRYK+0i68KbHUGbwDX7xf2L5eRwOn0Z4XexdP5slDmA5M9LquKLrv4macGSEYB+
 s5lvW11sgcZfqb3Fz8f+XJD2vb21K0F+tofwnUu1/gRNzCoMkcxH2ttbHaiiykR0sR80
 zKnYQhYym+rUBSKupGJLIAaTPKdO44FmyaKa+ejylbqwcUx+cNLcEDR3D+he+esdPIw/
 sVYX/yIT9nXJNPQnA151wsnHZN1GMcCzCZX7udc5Evd2SyE0OrSvQbR5JwmWTD5ld3sc
 sV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9uZMeOcjp69CcLk4kJoh51jLK8rzeIE59U8CnyNM9uw=;
 b=IoyZvC0cajE/wsYrs2Wvi4oLl/s//SDFJWBm6ogJIqLR3QnU0JYucrqFztTo2NR18O
 iDYFeCUaCYEdIE2WwgCuVMgvN2YUEX4p/bX1YvtNx6Ot4nFmgdv8S73g3Srnil+dA83o
 AnozvExMxwqisH92TP1mtP89HP5koDDBVUHmtcrRlyi+A0wm+p/LHLyhX20ms1GKMvO8
 KEksnN+Gz2wnDGiDC1RnjI/KzkGeER5iRDLPTOuRo8oOFBcSZoigDFe9i0lfqKq3aaOY
 8eC1w0zSTOsq//kynhNi4BWYnmh4vL9E+Ol8lGOEKh9wzheSUfQ0DCSs525Ic7rsndgE
 m+Iw==
X-Gm-Message-State: APjAAAXOTzDoWUOyv5dVaoP9f5YbFroqikJ18mvaV7J6VV64JhOfYUq+
 z3cTupkCwQAQPFsP9vJ42xdh0g==
X-Google-Smtp-Source: APXvYqwNCsLHCmgtq4yEB82YTo8Go2tM/yn6Jyk+zdoQ0lb8zpr6smFP27PzPme3sWBdki3UBROaiw==
X-Received: by 2002:a17:90a:30a4:: with SMTP id
 h33mr32078066pjb.50.1575253490309; 
 Sun, 01 Dec 2019 18:24:50 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h3sm20818336pji.16.2019.12.01.18.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 18:24:49 -0800 (PST)
Subject: Re: [PATCH v2 08/14] gdbstub: extend GByteArray to read register
 helpers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e052df9d-d2bc-b257-adf1-33299bf7b6a5@linaro.org>
Date: Sun, 1 Dec 2019 18:24:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 luis.machado@linaro.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 alan.hayward@arm.com, "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 damien.hedde@greensocs.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 8:45 AM, Alex Bennée wrote:
> -static int cpu_read_virt_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
> +static int cpu_read_virt_reg(CPUS390XState *env, GByteArray *mem_buf, int n)
>  {
>      switch (n) {
>      case S390_VIRT_CKC_REGNUM:
> @@ -296,9 +296,9 @@ static int cpu_write_virt_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
>  /* total number of registers in s390-gs.xml */
>  #define S390_NUM_GS_REGS 4
>  
> -static int cpu_read_gs_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
> +static int cpu_read_gs_reg(CPUS390XState *env, GByteArray *buf, int n)

Sometimes you're changing the name from mem_buf and sometimes not.  Perhaps
better not to change it anywhere, or change it everywhere first, without
changing the type.


r~

