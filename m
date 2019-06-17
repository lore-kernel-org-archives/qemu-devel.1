Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3E9C31E49
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F302089E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhBKRWe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F302089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hch94-000055-V0
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 22:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hch8b-00088J-Fw
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hch8a-0000bm-Dq
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:12:49 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hch8a-0000bJ-7G
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:12:48 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so215937pgj.7
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 19:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6nhEZfUKY51Ni0fROaIXR8gyiV2tiCNAYpg5H3bdvIo=;
 b=WhBKRWe+p8GX3fCHYheuqaOrj8p7TV0HO8bpJr/cCunsq6fr+n2PfXOah7z5gbDicJ
 rXYFuoFHhET9lFe2AjBB1ITw3iT0nxle4nOKP5TIBXrbVldby9yQSO3h8HL5sd8nOlst
 x9MThruf4kBYhLSb6rpebIy6QcsUu2utfnMB5O2hLEIyFKdWX+QLhJfqRpU62blfGM/n
 kGUCEukrBxPtAZZRIATbcj13vC3W0p6ek67QdzljWopA0+KgwG2HojXc0fuV0bN9/GFJ
 ZO4UA6G1uWGNvnJNGW+r/rkhRP8EM4/3pJF1kRls3KkA5DM0M0XSAir/NvqoO+gBE5wn
 E5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6nhEZfUKY51Ni0fROaIXR8gyiV2tiCNAYpg5H3bdvIo=;
 b=LAtJkFWox0CjGScOcfS/BqyKWMhLAkcsXYnErDuedyrBocYY4P/ZJnzi6MsjLdpkkO
 Onw7jUzTI6/uVi3p6Tl4SM4MZ9hlxX09jIad5mR4iAOFeBu4WmT05QAtKOjTFzmVYWmF
 G3RXuWAkAIFiTE6wcGodMdwtQLd4Z6gU0ns1HoGLv0PbYJPC5q2Dc4ZEwuUR/FlQpcbj
 QZRHqVDxOxrvNv+8yGt+3k74Ry0AjxdskeitJSlZuXGEebuHC95o7NCfezNLx3P77VAv
 lafQPVzVO13EpMB2rkhsny8m/2nHbAfy3Z9ZbmdIqroFLcf9TEHLJKmWDCxyF+Jiovgb
 I++g==
X-Gm-Message-State: APjAAAWWaOfoQAMhNBvEWK1EmcCW8CCVzPKdUcGAnEeQJ6XlEYpNwGnz
 0gIFJ/EIcmbKSjLsD87woLTABA==
X-Google-Smtp-Source: APXvYqzQgkKSWGr4XJ3Fgpp4cHYGVMXwIGQv5+pFt92BoHdI0I8rvk+Xtjyvy8HP4ddkMPaKusv36A==
X-Received: by 2002:a63:4185:: with SMTP id o127mr6240685pga.82.1560737567027; 
 Sun, 16 Jun 2019 19:12:47 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 d5sm9857195pfn.25.2019.06.16.19.12.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Jun 2019 19:12:46 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <68f400ee-9186-f1f7-687d-9c96bde89c7d@linaro.org>
Date: Sun, 16 Jun 2019 19:12:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v3 01/50] trace: expand mem_info:size_shift
 to 3 bits
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
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> This will allow us to trace 16B-long memory accesses.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/trace-events b/trace-events
> index 844ee58dd9..037169aab3 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -159,7 +159,7 @@ vcpu guest_cpu_reset(void)
>  # Access information can be parsed as:
>  #
>  # struct mem_info {
> -#     uint8_t size_shift : 2; /* interpreted as "1 << size_shift" bytes */
> +#     uint8_t size_shift : 3; /* interpreted as "1 << size_shift" bytes */
>  #     bool    sign_extend: 1; /* sign-extended */
>  #     uint8_t endianness : 1; /* 0: little, 1: big */
>  #     bool    store      : 1; /* wheter it's a store operation */
> 

Well, 128B-long memory accesses.  But SVE supports 256B memory accesses
already.  So why not add one more bit now.


r~

