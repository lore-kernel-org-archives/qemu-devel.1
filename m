Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF68CC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9113206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHLBiqes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9113206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htDlp-0004CJ-PL
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 12:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51343)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htDia-0002k0-Fs
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htDiU-0000CZ-3P
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:14:14 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45929)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htDiS-0000Ao-FD
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:14:08 -0400
Received: by mail-pg1-x542.google.com with SMTP id o13so34451342pgp.12
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 09:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rLvsgKkqYJ7j19En0jZSStMGf581It3GMdNjWupgBvo=;
 b=JHLBiqeskvBe7eV19jwIATdL/fnktaLzFlgub6AqzGTObhQIB/lassehCWDyoS9r62
 iPRKsXQxHaH7d8NKGZVU/45lMZ3EgBoU7KYC6ShsbxkLYgBi4rscAvoufRYijcfvc39m
 JtY7XlFA4dwhpY2xcgr2VAGEiYBmV59NPcKTiQI6/Nvn9lrLCvzmOp93tSOu0LGXDX8x
 4ZeVQ/6dGTQZcX2uPr8NIJiDi3YIDZGs4sbgQ/odo981Mw4tzyyQsdt8YKCVqRxSlTlu
 ObB2XQV5KXYFlDxCr8Cj0RJyVN2ja6fZ5FkDcjWXEmNbTHnSsEWYZ8AxD8WgfzqkNOBI
 xEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rLvsgKkqYJ7j19En0jZSStMGf581It3GMdNjWupgBvo=;
 b=tQ2Ef08ecfAfI4kjG0xqKh0ZBs4XSKyCuUOuHBkz3BIT8riK/mCQ470ZVTt/ygXo/d
 btL9yD6uw9eiy+mtmtFko0q/GKTOqWOIWJbu2NrFiVfPlG/VQaotxBLZe9EYJzvjVqeE
 nO9/fB/Q+LbUsZFW8auJ18WgKa3hbHc2vpsuMtk2FQuR3eAKtgXOqoBq1slRbIBiDabh
 5OnN9hlI8GnD/H7R4KwmOecsqD0kafNfDqGKafqNo1ABU5f7zx0FY7sJSvEmU8Rr3hPp
 O00YOno+Sldpw8GZR+WMW0VnKa5L5s6Cz3dnBm9ucV7Q0P4tu+ApgocNKPl2buMQGHX1
 9RPQ==
X-Gm-Message-State: APjAAAWBEo1FuOnI0FsmAJf21WUGC2d4NgovDJdm18kdF5s++6SvnMiO
 Z8LxA7dpUZecBtv1te/ci32+sQ==
X-Google-Smtp-Source: APXvYqziWyopAXiPPj5kDxeVQJvKetF2x0H457iKpBIOzZ3qdnIMY6Op5BCbHE4zDCtv/Wu2uexi5A==
X-Received: by 2002:a62:6c1:: with SMTP id 184mr52965976pfg.230.1564676046685; 
 Thu, 01 Aug 2019 09:14:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k5sm4897642pjl.32.2019.08.01.09.14.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 09:14:05 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cf60fdb1-dbb5-189e-f806-a161d780efbb@linaro.org>
Date: Thu, 1 Aug 2019 09:14:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v4 15/54] plugin: add implementation of the
 api
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
Cc: bobby.prani@gmail.com, cota@braap.org, aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> +uint64_t qemu_plugin_hwaddr_to_raddr(const struct qemu_plugin_hwaddr *haddr)
> +{
> +#if 0 /* XXX FIXME should be SOFTMMU */
> +    ram_addr_t ram_addr;
> +
> +    g_assert(haddr);
> +    ram_addr = qemu_ram_addr_from_host(haddr);
> +    if (ram_addr == RAM_ADDR_INVALID) {
> +        error_report("Bad ram pointer %p", haddr);
> +        abort();
> +    }
> +    return ram_addr;
> +#else
> +    return 0;
> +#endif
> +}

What would a plugin do with an raddr?  This seems like a qemu internal thing,
and not really related to anything that the plugin could match up to the hw.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

