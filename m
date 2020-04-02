Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD58C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD952072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MyUNkBny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD952072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK7wK-0005Sp-3W
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 18:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jK7vj-000520-9I
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jK7vh-000502-37
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:03:17 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jK7vg-0004yq-Te
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:03:17 -0400
Received: by mail-pf1-x442.google.com with SMTP id u65so2439886pfb.4
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q1Wd66Qo3eYo4ZC1q5+stPWiu7mk19nCvwKp0Zuw60k=;
 b=MyUNkBny2ygiVN8SLPwHtPbkgHdmkZA/4Fvv1tuopZaCohumJZ/mFRBGTun1OtSThy
 yT1tyZVfmVWI1+Pr8jbPouKEB5KNvBn6+hqq+d/UyYCv+sJ+Tdp8ts2+uo4M+TUyJkdo
 XJLQW7QmnIkSWVSf7mP84M+eaMghSwC1yNctlaO4QlokfoO0ZR1SHp8K4tukaL5e+WfT
 rBfM3BnlkrVnxQGhuHhhGAq9BhqUksnsWnb+NC+13R17VS9kRnWV2FYeWnOWEyZzwdDu
 DAKC5VZirq0eC4eib0ZZlISLe79uyUs/SYiH6sQLlrjJe17pYVR/SgPiuBKlMNrXlhr3
 BGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q1Wd66Qo3eYo4ZC1q5+stPWiu7mk19nCvwKp0Zuw60k=;
 b=qn2RN4oOI/Kb+LciKwhJr2MtzMTQP0YCytzxmsEToWPM/KeQNNvBXyxn6VscMBefOh
 aa25dlUDzLCM06GVHTdq1zNr33GiilnXIsV1QYH2eM8dDQ1lzE9tTMPO1mHJe42Nl1tI
 Or5jyd+q8aQH4TuWdSGrOajJgG6JzWtg2Encae5084ap3qlkLHo3jemY9Grr6SrHWiBV
 ynKcfCw3I6d5dUljxycn6omsf1w7mOIYQg0jbFujq9QMMBsrQma00Cntbxd2Yr2jUsQN
 HHK++Fl54aWPTIzVbBWn9s9uhHF3SzWeebLGnMYosZoxPGMywaTaFrwaE4M9bWT3NN+c
 Sm2A==
X-Gm-Message-State: AGi0Pub3tFUifR71WM+bGV1+0TPFP4ifAbYEYVDDcc3OS5ZutN2QeBAo
 QKxjRQ8PYcRY0h2gkJS9/buJEQ==
X-Google-Smtp-Source: APiQypJVmMkRFQ1BbJPrmrOGaUeFpxqiCE2Ddu94ByGsp8EOpXLOVQYVJUpcR5xVtE4Ec9OnDSuU7w==
X-Received: by 2002:a63:6cc:: with SMTP id 195mr5332521pgg.12.1585864994622;
 Thu, 02 Apr 2020 15:03:14 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id o192sm1209748pfg.196.2020.04.02.15.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 15:03:13 -0700 (PDT)
Subject: Re: [PATCH v2 10/10] linux-user: completely re-write init_guest_space
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200401094759.5835-1-alex.bennee@linaro.org>
 <20200401094759.5835-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57e11cc4-8d65-415b-0d08-1a6b38298dca@linaro.org>
Date: Thu, 2 Apr 2020 15:03:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401094759.5835-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/1/20 2:47 AM, Alex Bennée wrote:
> +    /*
> +     * Now we are going to try and map something, we start by trying
> +     * to satisfy exactly what the guest wants. This is unlikely to
> +     * succeed but will make the code generators job easier if it can
> +     * be done.
> +     *
> +     * If the commpage check isn't happy after we allocate we need to
> +     * fall back to finding a big enough hole in the address space.
>       */
> +    map_addr = (void *) guest_start;
> +    if (mmap(map_addr, host_size, PROT_NONE, flags, -1, 0) == map_addr) {

Not recording the result of the mmap is wrong.

There are not just two options, as implied by your "== map_addr" check: you are
missing out on the mmap succeeds (!= MAP_FAILED) but still not equal to map_addr.

If the kernel gives us a different address than the one requested, we can
either decide to use it, or unmap it again.  We can't do either with the above.

This is definitely going to have to wait for 5.1.


r~

