Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021BBC2D0EC
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 19:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C506620714
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 19:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIlb9kcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C506620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIGqD-0006gy-TQ
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 15:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jIGpf-0006H5-EI
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 15:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jIGpe-0000MJ-DG
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 15:09:23 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jIGpd-0000Ld-Vv
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 15:09:22 -0400
Received: by mail-pg1-x544.google.com with SMTP id o26so6458590pgc.12
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J8cXnGfbgZ4LonKmAng8yD/jJOSymEbNgpuS+gy8I4s=;
 b=VIlb9kcCjE91wD1iAej2MzgM/TkjQ7SWvc7Mu2kXf8iNVhelw+DEyArI4eY/W+Eg0W
 bf4XZ8RqlQeA6qA0nFXz5j13v78KCOvIN3hNewTon+oAwWk6vg+2W+814slNJ3JC6pbt
 +xZ8MzAltwMKs4ngCDu+XT+ZIQkx+PlxRIroiTxWJHmvYW2aaaemXAT1VDRPy5yeVbbn
 p+knevOAAlNvXbk0nyelO8ev2E8lWS7M2k9ILdQebrq2qIfQHp4Mt2hhUTojtYRjXZYO
 bbQs22VF/NFsbyOZBcbKhNoWsEbxvsrN6U/tPx5yXfXVIgPR9g6k+hmQ4dyh1nz51UxS
 D+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J8cXnGfbgZ4LonKmAng8yD/jJOSymEbNgpuS+gy8I4s=;
 b=NBOja0n/FN0iI22/qa38LqKUK6e05ZLPKQUBF5Sm+CV5NJccXtAmUCIAQ+PdL33WCF
 6uPLNB6OybbZuEB8BW2Q/lTCd8B9kNL4Y4jKFJgbk+e7v2F7D+oXcZAKj7Kq/athCvhB
 tznngJ0GWilyoSA/bL1u/JFJSs37e+15LedzunLjTQed2+8GV93mS5dcSQfe4AghoPzc
 QE6HqwWXHkVI+5Wcd9SOXfzBwlhDpTN20H+50WpqxNtHunfc+4YE/ZEfdBYgTsqvpKxH
 8l+jgecyK1OA6qg+uEMTbVw0K++0w3KCeWsKY6UO8DfTf94EvUBtLWYEmMIBhTSRQOPD
 HVoA==
X-Gm-Message-State: ANhLgQ1NjWPZP20mSYDvq7Xykta8jUzDR+xWiHZlrUxVl9acyV7RB6rK
 XvWNiPjSYzrkq/q4M79pYdykEQ==
X-Google-Smtp-Source: ADFU+vtBL8BBUNYH6336DyMLevHn1CVJ0zbTUdLhiJzm6tFRBAdsQXIKRsm3z1fOTeDm6r2kria+ZQ==
X-Received: by 2002:a63:705:: with SMTP id 5mr5747813pgh.314.1585422560571;
 Sat, 28 Mar 2020 12:09:20 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id r9sm1958292pfg.2.2020.03.28.12.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Mar 2020 12:09:19 -0700 (PDT)
Subject: Re: [PATCH] target/mips: Add MAC2008 support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20200328090853.645433-1-jiaxun.yang@flygoat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b0dbaa9-a4de-fa91-9455-c6fcdeb29116@linaro.org>
Date: Sat, 28 Mar 2020 12:09:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200328090853.645433-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
 aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/28/20 2:08 AM, Jiaxun Yang wrote:
> -            gen_helper_float_madd_s(fp2, cpu_env, fp0, fp1, fp2);
> +            if (ctx->mac2008) {
> +                gen_helper_float_madd_s(fp2, cpu_env, fp0, fp1, fp2);
> +            } else {
> +                gen_helper_float_maddf_s(fp2, cpu_env, fp0, fp1, fp2);
> +            }
>  

Surely this test is backward, that mac2008 invokes maddf.


r~

