Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2802AC2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E643620A8B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPUI8UFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E643620A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMuuL-0005L5-3r
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 10:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jMutI-0004Fl-5C
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jMutH-0004UL-69
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:44:20 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jMutH-0004T9-0e
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:44:19 -0400
Received: by mail-pg1-x544.google.com with SMTP id c5so1063657pgi.7
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sxKgp4+6IowN7KloiCvSUhWbu6aFX/0Rmfz4AXGiLnQ=;
 b=MPUI8UFxhKMmJ0OC8amSftyxwHsL9bgpk38+Fp/ZtHvOJP7WhuwyMocMXsE+NeMNee
 tkdBoBZpFyykhEgumrJqNBkDyRXCDXp98+4PTrayWmEmssMxj+rP7VowLG4kIKD/X2PN
 h8ou5tedSp6v41d/VhUB9uAvOyGiUM2NHQa9NHlPsOW2Y6fbpO3rCdmutImdgLZbXaRd
 et9IbWJPttfi8+ZBmuUKdGfRZ27yLIdlauNe5rxsD9Isp0VJ/khgu1ffeiV62VO8iKoU
 vvFy412DUd8EVBVtmovyquuAhmLWImnCIYmHV3oinoJHknluIYp41TtVnna/85ACnJUN
 Fn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sxKgp4+6IowN7KloiCvSUhWbu6aFX/0Rmfz4AXGiLnQ=;
 b=Ks5MoKrnltg6hQg4st2nzcuAmS75dEcVJk8NLS6suUVyPpzt+Pt67byYW25OL4XCzF
 WMhSkom25li8ako28YDUBBIw6wfu+16Ti7zxAFeaM2Urt2wa+dt7VnyxW+C1FitmzIPz
 WumFCteDiY0esemaFa3e4oHARl6l9lgANfFLr4hnoRqWaZbNj19gOYEyAVbRQS6xXkSp
 MiELiJn4Vmerf9cmo9XsX8vq89+hdR3nCAY88yghTvXnla+yKye6HZm9TXbQXWutwqJu
 cATAH1sxFFGBdsVcN+zSczjRbON8V6x/Vx67P/MA8Cl5AFG4ccNxz071YKl3NpmCPzgq
 WA3A==
X-Gm-Message-State: AGi0PuYMSuO/CEs3GW7fdyPOY6RwgImc+YnbUFLJPHoxcyzWQoedbm8K
 +kxl6jH51xRpNMYZuIcc86NguQ==
X-Google-Smtp-Source: APiQypKuISQqrRy6WKnw8HUi09GyOeLeJe+s5QsyLCXQOIQQ0hrvd2uMyNsnlGul0ZQ+6/GSQ2PyQw==
X-Received: by 2002:a63:ca41:: with SMTP id o1mr4955526pgi.419.1586529858150; 
 Fri, 10 Apr 2020 07:44:18 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b26sm1950246pfd.98.2020.04.10.07.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 07:44:17 -0700 (PDT)
Subject: Re: [PATCH v1 09/11] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eb994b95-e70e-50a0-fc60-8734d28f8bd6@linaro.org>
Date: Fri, 10 Apr 2020 07:44:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 2:15 PM, Alex Bennée wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> We should only pass in gdb_get_reg16() with the GByteArray* object
> itself, no need to shift.  Without this patch, gdb remote attach will
> crash QEMU.
> 
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200409164954.36902-3-peterx@redhat.com>
> ---
>  target/i386/gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


