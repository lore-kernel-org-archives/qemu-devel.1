Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF04C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948FE20848
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtq38iOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948FE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqmu-00014z-Oi
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibqmG-0000Yr-HN
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibqmF-0005Jf-EE
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:50:32 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibqmF-0005JL-6Z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:50:31 -0500
Received: by mail-pg1-x543.google.com with SMTP id b1so84766pgq.10
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+ZhOA4nPq7w1FdoOufX76lLTaz3Hehg9Uq95HAturIs=;
 b=xtq38iOyzz5GdE+XsBHzVUod0vO0foGDa+X/c7a8kyQLv9HzysZ33MiKgNgNy/lELu
 1eMjbnBY88tkniUZoKqXXgdyIxhkpOfnpHxQNFTi7n7ko/mB1JLjTUBBdRbQF+1IpKat
 wi6gV81MYiLIapsLkEyPC/EuUJEjIEWy1quu45oRUz7Z9CV9Hy0a+5aUCAjOpEwFY7m3
 pD9HtX+Jqrd5I/GuZFNL8zpE7Qstho363/qfVH0+CyOCZ0c1Vusr8qsOCVnSu34E75N+
 bQMhFG9VQuYKu+Sxi7r3FzxI8O1YTsvT7VRu5up6GECCUyu9nzzTmsxm16F+X4ELofch
 Sthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+ZhOA4nPq7w1FdoOufX76lLTaz3Hehg9Uq95HAturIs=;
 b=paCjmCATauQfFZg/BF66pxtksS4h/2Jt5xQoXe+KGjjMTso0ReVp3biBUa2OBEj/S8
 jrxk8BlL5uzsoqUXdN8mBFVoZHeVMdzZS8iqoKOH+xsIyhkV9B69dvZQQvh40e/vOrZb
 LtW45ci1x0/0dLhg5v5oXXlAKxebvGxHJME2rmNhybD2/hOMdHalRV1I6wnuv1SiioHB
 qutcAoYGkfM0Wuik9hqG7O0h+r3AiVtzKdV9tprl+IXX2PaoyAjTAApCy6X3b1LyuF1O
 Oxc3IvXxav4Gx8pP+k7hqigI96KFZt2L7uDF4H3IkUgn/5ACJHTYRcLPbsRsTZceIGEq
 oUqA==
X-Gm-Message-State: APjAAAUfABpdy17GJnfd9CsaeidWUiu3BRXVklmcTRjMwYXQhN9iahua
 VEfR3N5cYzMRu22hz9HZahBWrg==
X-Google-Smtp-Source: APXvYqychSSbfb4N8GUl747fsMTvYtbaLFnHKGAhP8MfD2IUx3cbNhNAQScBGaFMh3K9enQAukG5lQ==
X-Received: by 2002:a63:201b:: with SMTP id g27mr609913pgg.56.1575312630086;
 Mon, 02 Dec 2019 10:50:30 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g191sm221753pfb.19.2019.12.02.10.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 10:50:29 -0800 (PST)
Subject: Re: [PATCH v2 13/14] tests/guest-debug: add a simple test runner
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ace0322-339c-447c-9cb0-96715e3d3341@linaro.org>
Date: Mon, 2 Dec 2019 10:50:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 8:46 AM, Alex Bennée wrote:
> The test runners job is to start QEMU with guest debug enabled and
> then spawn a gdb process running a test script that exercises the
> functionality it wants to test.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/guest-debug/run-test.py | 57 +++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100755 tests/guest-debug/run-test.py

Looks plausible.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

