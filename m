Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA6EC47259
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2492320857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oaOjkM36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2492320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWup-0001Vn-8q
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWso-0006ha-47
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWsb-00064Z-SM
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:43:17 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUWsb-000644-Bc
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:43:05 -0400
Received: by mail-pg1-x544.google.com with SMTP id n11so4627957pgl.9
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8rjS/7TqCratD9XtbaLpFhAD42igKLbEmz+etE/cdlA=;
 b=oaOjkM36MGo4/L/AdnwFn/qc8sbTOaNEChyMZLAlq1QvPIOQM6APqn3cBwTP1KCQ+h
 Dv0nKM8sbDZ/mD9lBVxSlIJ12qMjU6pEHooxulZ2IZadBEYJsWWxwm55iEcwNt9LNVno
 JjbfpSgBNJeUmK+WKqIofEjINhXxsMAHxPFYghRFxL+pZ8ViCgm/kGZYnK0wV9p/cImy
 lFDcfFR/80qGfZGM6795Nx0rGzH46xRRUmKYo2cuy+ZQCR0t8J49YjdhjvFXT0byUaKe
 j6VWnaGbhBPLRek8rG7ox2f8tMh26e9yP0qLEP43tUeSKtUrLwjsN115JFRfhirgKvX1
 Gstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8rjS/7TqCratD9XtbaLpFhAD42igKLbEmz+etE/cdlA=;
 b=IaihIa/URQuIXc0z2hBb5eNyqlkcBEFXLGHPdKPlcSBc26a193GKlJuFd4f3p3Li+m
 NeCJqQgb4ngnhpIv8LHPWob0m3RhfXwYnfBMlb+iHUIQPu4NAfUh0o0r2tELp65DGGWW
 9EUgb00UDQSHHCKbmAi5xz7QcoELb0SquQpeElAOfrMko2mE0tV2mOH9LoJQ6mOpLI0R
 WjEjDIM8K7+HQBIj3ZKjtRZWgBamblydq8K/B1UKfpzLVd5hthw3sJbDN/92sRIH8kxV
 9iuFZm3k8FB5JFQhK935F5xFlDzs12GaHqlCSWDMCrxMyuhkk+gcX1hyUJCKhnRFHRGH
 D7lw==
X-Gm-Message-State: AGi0PuZRpQnLY91JEnR5d9uZN/tGUl+dklG2Cu/a48Q5Bk+QSbPDt2q3
 ShSIQiWsmFhQSXpC5ZtL6GcMaQ==
X-Google-Smtp-Source: APiQypI28e7uSv2XCnHThADNVgoS+YXYscwYVJc8DyGvm/En3RgLcXVVFnKKyp5qWfxa2+GsdW/3Iw==
X-Received: by 2002:a62:3784:: with SMTP id e126mr4423256pfa.303.1588344183744; 
 Fri, 01 May 2020 07:43:03 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d12sm2289472pjx.1.2020.05.01.07.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 07:43:03 -0700 (PDT)
Subject: Re: [PATCH v1 6/9] gdbstub/linux-user: support debugging over a unix
 socket
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200430190122.4592-1-alex.bennee@linaro.org>
 <20200430190122.4592-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <765cad43-990b-c4e8-d786-6adbf28dbca6@linaro.org>
Date: Fri, 1 May 2020 07:43:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430190122.4592-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:01 PM, Alex Bennée wrote:
> @@ -814,7 +814,7 @@ int main(int argc, char **argv)
>                  exit(1);
>              }
>          } else if (!strcmp(r, "g")) {
> -            gdbstub_port = atoi(argv[optind++]);
> +            gdbstub = g_strdup(argv[optind++]);

You've got one too many strdup.

The one here in bsd-user main, and a similar one in linux-user handle_arg_gdb,
are redundant with...

> +        gdbserver_state.socket_path = g_strdup(port_or_path);

... this one, in gdbserver_start.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

