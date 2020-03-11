Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C9BC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6146920873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOKenboG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6146920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBuXG-0000j2-Is
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuWV-0007tb-JV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuWU-0000lj-G9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:07:19 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBuWU-0000gh-7B
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:07:18 -0400
Received: by mail-pf1-x444.google.com with SMTP id b72so678733pfb.11
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=klMLPirH7ru2EDINPtWByz+VfotpZS0bqaeR6CMsAtU=;
 b=gOKenboG1TF8LaF3ViRb4WYJXEc0F6CBfi47sa/kznjEP2V3DO9JlrtjB+gYt2MAo7
 aGRg+OeY+mEp8CnPDjbMuTXjCMJ6+FgTO0OKHAA3sqJoqFhKerCQY5s0e+F6f/zu6XcK
 1rweLWstlXXqbyQaLcDDECQ7TuqMGIQW6AXasFnpqfMkQRxwpRBV+LMPWH3mg5BVkDSD
 xIpmXvytZHev2PzO7p9k9gAVpKGkoFi0d+1RsP0jWI6RGQ6JrjeFypCc0tmJf9tgqx4w
 mwxVRDWw9aiDIiSugQ6N6h9y/n/q4RgNn7x/DTT5Pr1csuWV4GuQ5eUSzymxCCpUnn5a
 eWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=klMLPirH7ru2EDINPtWByz+VfotpZS0bqaeR6CMsAtU=;
 b=YeeqSre64U10XsUac86LdCv9YpilYEMmXZ9mHSAQCBVKbPS30+biiSPzF9eJZaYWYO
 m9Dsn/kq9guSMRfo9BO3Z0xrvyTCyCNEfxVAcaK02mQML0qhya0au46eaX9ZdNin3Ky7
 tf6pzCP2ogrdMY8sqMPTWAWZCJ7cmQ+qDBunulkO3eWcDe5Y7E6ehRCQN/gnkM77zgNG
 3Q17x0DSHpCszebIOBrthK4l0Cq1u56Ys73gtcszlltynfxuCvhEg5qQlIa38/zYBK5N
 7/YxULWxsH44rdBTI7B0Zwxh2iV6X11oG2q4XG2LHF242t2h7JejesVjqZZ79zuS/+5H
 GmoA==
X-Gm-Message-State: ANhLgQ3GwtkdX/L2KWfBTShX3j+rt7yiw9jz14IYyHGe3JSeNfL8TEyk
 QECSzT1GVkLr834iXzNDh/4iuA==
X-Google-Smtp-Source: ADFU+vuNcY91EWUjO1jdFXUGVQH2vjPN7xI7CeX4jRAVU78VXA6kACxshZXyAPlVGw5vE7WJFup+1w==
X-Received: by 2002:aa7:9467:: with SMTP id t7mr1274373pfq.97.1583906837338;
 Tue, 10 Mar 2020 23:07:17 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 13sm47835988pgo.13.2020.03.10.23.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:07:16 -0700 (PDT)
Subject: Re: [PATCH v4 04/18] tests/qapi/doc-good.json: Clean up markup
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57ca9623-28b8-8c91-3e65-4f63ce14bae5@linaro.org>
Date: Tue, 10 Mar 2020 23:07:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 8:43 AM, Peter Maydell wrote:
> doc-good.json tests some oddities of markup that we don't want to
> accept.  Make them match the more restrictive rST syntax:
> 
>  * in a single list the bullet types must all match
>  * lists must have leading and following blank lines
>  * indentation is important
>  * the '|' example syntax is going to go away entirely, so stop
>    testing it
> 
> This will avoid the tests spuriously breaking when we tighten up the
> parser code in the following commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> New patch in v2
> ---
>  tests/qapi-schema/doc-good.json | 25 +++++++++++++------------
>  tests/qapi-schema/doc-good.out  | 12 ++++++------
>  tests/qapi-schema/doc-good.texi | 12 +++---------
>  3 files changed, 22 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

