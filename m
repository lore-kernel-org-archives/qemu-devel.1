Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECB7214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxZE2C87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECB7214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifEJk-0008PS-VU
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 21:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifEIz-0007xf-JU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifEIy-0005L2-IA
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:34:17 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifEIy-0005KT-Bm
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:34:16 -0500
Received: by mail-pf1-x444.google.com with SMTP id y206so309240pfb.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 18:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4s0MN3ZlO09ISGRQVqR7EBVDLgHindaSLJAsZ93Bj7I=;
 b=LxZE2C87jCpCXCkIT6PG5yrBrhoqIS0pbUxcYgWhpA8XSZeI1Q5PaBT33Dz5IQXzGI
 GmqQQERofzaQNqETRkUPNMygR1l+AZTR1CLC/RmaO+Qv4ippHHmES28FnBtYcQykt8vC
 ADSPdoaSux8gagRfEN9aRAAHSJu+46d06gXAa7hYDdUOEpKgwd6S0gyIRuKGNcEd39hi
 MoUegn5BGrwBDt7zt2LDloc51fqDdO27y1LjgwPS6QeVVmKLfCwwVxdbwQbWZq+c/vpW
 3OPfae4DJUR6uct+xOwbN/zFlRplkEbZv5iYk18vXMbDaYS0sBuPpVj9DPQ7DIv8em8H
 h4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4s0MN3ZlO09ISGRQVqR7EBVDLgHindaSLJAsZ93Bj7I=;
 b=VahiSDvbb4pHlpvdyZ2ykCOX8CGFrHHl7ngO1iRMPLRbqCxihJxYhN9sbc7adfmKKE
 sjDzVgh53sW2Gsmae71G+G6xpv/OzV/OR4RWSD4Cwm2gos3JbE/cCzppO7gLSB8Zlpwr
 /rrtq8gFFLSCgMv57VjfG/VpZ93rx9hvX2xCf2HIB5pydBwIHGsY+pAZsbXyOqQU4DfB
 qukWPj+HNpRvTN81LUqnYJFeS3SDA6+AOuH3WCot1qql2WhXjFs69LEI+pA8gQE14jvF
 imuhGa7zcoEkm+4Xj4DAsZShIsops4ch7C2knAL7YY9S4mfOaE2YblUcQVk98jlI7bd3
 aRKQ==
X-Gm-Message-State: APjAAAXlgblAqYY/XPR77JrjjzeKMgbKcawJ4h84be4gtys+2S0FmSUa
 qzcM5FeH/fK32c0fcu+2oGki9A==
X-Google-Smtp-Source: APXvYqy8EmiJq9WV7Dx12wX04rc1kc0gQ6Rk8mkFPxO8lBlQNsii8d/oEILRfVbU0IRC2wFZvtbyXQ==
X-Received: by 2002:a63:3f47:: with SMTP id m68mr7805713pga.411.1576118054996; 
 Wed, 11 Dec 2019 18:34:14 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm4601818pfg.170.2019.12.11.18.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 18:34:14 -0800 (PST)
Subject: Re: [PATCH v3 16/20] tests/tcg: ensure we re-configure if
 configure.sh is updated
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57cb488c-9720-1b0c-fef6-c833d2583289@linaro.org>
Date: Wed, 11 Dec 2019 18:34:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211170520.7747-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: damien.hedde@greensocs.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 9:05 AM, Alex Bennée wrote:
> We were only doing this if docker was enabled which isn't quite.

Isn't quite ... a complete sentence?  ;-)

> 
> Fixes: fc76c56d3f47
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/Makefile.prereqs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


