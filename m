Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E54C52D49
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C17246A9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1H6Hp6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C17246A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JxX-0000Xb-UQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Jv1-00053D-25
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Juv-0007ad-Vg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:13:38 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7Jut-0007ZB-14
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:13:33 -0500
Received: by mail-pg1-x542.google.com with SMTP id z12so1551042pgl.4
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 06:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KgW+9E7EwcZMOIplumagac+L2Ccsg0eHY7YZpqQZCic=;
 b=h1H6Hp6IZPd0xTHXyv6GtWwklRIRiwu9ToEo/nxUo3HFI0hNMrzhCaZiS+1lZpR+cn
 svzmZPnuIG+6kcyyH6zTl0H1vj9o72c03Oz1veNeVOM2/yx6s7GK3tWxx/JNB4lASGeU
 9TpWdQ1GkYxmdbwKz6M32AK2QGw4Th4orYCxcjcXzJqw9CbDblNekSQ7Kgja9WWiocid
 9Ua3+O8u6rEYHa+IvVhoyvQZVCZX+ZmrpQzwpBOs1rOishClle8vpmU8dwbv2ncGsWSh
 Dl8oLPaiQlx78dpky3pwX47ggbsWQrXIdFaq3jZpPJ0vkVetzeoIAVNwMfodN2wDmdYB
 gpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KgW+9E7EwcZMOIplumagac+L2Ccsg0eHY7YZpqQZCic=;
 b=Xvkif3dWgs1gKp1Y0U+4zG/+uZUBjFsj6okHM4e+qKeWkRBZpIBvXZFJno3xeUqBh6
 IQzxiRi6RXgGBUBUQBYXf5S1lSz1l+6sfRPIOZPZLyZcHz8z0l7FHOb11oBYFYB9fkar
 4cymCojimOcouw9Ss3luaeP7K61aMd74G82kMaD8L0I9UQtJxz+l/nPRtBTPmfEvQowy
 /hdSNU3znsvT68o7DEXvi1wjt/ef82aEguK44G8LbH2D0zyQ74pPlT4cSJMhO5MvZNMM
 3I2P7604xuSjunOPPUf3BYYP16AKLZ/DB/ux0dyyQKFj/tt13KsgXkDI5rNAaVq246jf
 5luQ==
X-Gm-Message-State: APjAAAUYnZ/92oZdxc+spv4Qf+fH+SltHLjtfrqoxymDTfeWOrjlhlBD
 skCYtRvtzJt4fhYaljto/ySxMg==
X-Google-Smtp-Source: APXvYqzpEuEigZ4VDn2BLz94QuTkzr62vrjuyoAMBRUOJDZ47X2bbpQbX01AzpXTDnOPobJlpl+dOg==
X-Received: by 2002:aa7:86c3:: with SMTP id h3mr4038134pfo.243.1582812809559; 
 Thu, 27 Feb 2020 06:13:29 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 76sm7291666pfx.97.2020.02.27.06.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 06:13:28 -0800 (PST)
Subject: Re: [PATCH v3 05/12] scripts/qapi/parser.py: improve doc comment
 indent handling
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200225140437.20609-1-peter.maydell@linaro.org>
 <20200225140437.20609-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <376f873c-34da-30a1-3239-128d3f164a31@linaro.org>
Date: Thu, 27 Feb 2020 06:13:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225140437.20609-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 6:04 AM, Peter Maydell wrote:
> Make the handling of indentation in doc comments more sophisticated,
> so that when we see a section like:
> 
> Notes: some text
>        some more text
>           indented line 3
> 
> we save it for the doc-comment processing code as:
> 
> some text
> some more text
>    indented line 3
> 
> and when we see a section with the heading on its own line:
> 
> Notes:
> 
> some text
> some more text
>    indented text
> 
> we also accept that and save it in the same form.
> 
> The exception is that we always retain indentation as-is for Examples
> sections, because these are literal text.
> 
> If we detect that the comment document text is not indented as much
> as we expect it to be, we throw a parse error.  (We don't complain
> about over-indented sections, because for rST this can be legitimate
> markup.)
> 
> The golden reference for the doc comment text is updated to remove
> the two 'wrong' indents; these now form a test case that we correctly
> stripped leading whitespace from an indented multi-line argument
> definition.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: Update doc-good.out as per final para.
> ---
>  scripts/qapi/parser.py         | 82 +++++++++++++++++++++++++++-------
>  tests/qapi-schema/doc-good.out |  4 +-
>  2 files changed, 67 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

