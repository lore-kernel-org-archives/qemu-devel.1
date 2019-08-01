Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9670C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C782080C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4qRHnjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C782080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htCTd-0003XZ-Ot
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 10:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59693)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htCSV-00030e-Iz
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htCSU-0002TC-KI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:53:35 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htCSU-0002SZ-Az
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:53:34 -0400
Received: by mail-pg1-x541.google.com with SMTP id n9so28123732pgc.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MWsR468tIvrM3cAel2+h/IK2I8O0glNd0lF4xCbxLn4=;
 b=j4qRHnjH0VbNLvTj4+kFZJswQvJsnB0SanrrT5OadMfuDjldxC4Znt7Y4jmKiTVDdR
 6aZKDysyJRzsHRe1fT3LSGWvV4/Y3kvLICzCCcF7DAODvoravyQbOgeEUf4tWaaybXZs
 8hzSUPzMse4Yw0VSpX4HbvKfmoQLwaczwV+a7bqvgIzPS7Yk75H+yg3qF/T/nys5ehnM
 9CXvv1HkR25rGtW7NKYO4CheA9rgGXpseOZb0PwJYlT6sMlEDNUIXtiD4GFu3Dqy+fT9
 l9qxw7c89DVC3djdAmaVV3RigSLuLvZWRbYvnYGcZthUWfoKPFFKvcPCi20dM23uprL6
 65Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MWsR468tIvrM3cAel2+h/IK2I8O0glNd0lF4xCbxLn4=;
 b=TTlxXkvx4gYagflBug/efb/sKFbticc0W1paMSXqZMFzi7dxZgaRbh7B9BQBpcozcB
 FPuTEIa+Vhl367+Hp+m9SygsjX7K4qLwSDLQsVDnqMr1W3hE3eoZzQY5lrnhvhZu/7EH
 nROrmGaZ5wvYr57/1Yv7Sn9S+Xskfmddj9sPFMfAiKzjgMocTNbcyQ8GMLRVlw/ykoCA
 L/3/tnP7rDnGWw+vz+VIO5GBwi++Aw6cHbZWTES73OP+eC/9rWBBOSmchDjkhk4ODSal
 CbCEyy0gfo6CAEuwVthHn7JY3O2vTbvH5jWznwDWR9h26N/vIg9fDof8KxbMzxNPEAJu
 DTew==
X-Gm-Message-State: APjAAAVCn9co/bVYPossN1doOLFqmQv731C6sL5wZChGJtrdRxFsIV+n
 tkeesV/WrxDl46//H+5C/WVtnQ==
X-Google-Smtp-Source: APXvYqwa2AUTiqBWCnShkEMIDIZfcbcI8PrTItWzNTqe8ieIw/nzfDbKCqg5kdeHksuDDXuPe3/JeA==
X-Received: by 2002:a62:2582:: with SMTP id l124mr53554217pfl.43.1564671212952; 
 Thu, 01 Aug 2019 07:53:32 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y23sm74089182pfo.106.2019.08.01.07.53.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 07:53:32 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d7e3ade9-b0f6-b767-e0a1-dfe56f04c842@linaro.org>
Date: Thu, 1 Aug 2019 07:53:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v4 04/54] target/arm: remove run time
 semihosting checks
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
Cc: Peter Maydell <peter.maydell@linaro.org>, aaron@os.amperecomputing.com,
 cota@braap.org, bobby.prani@gmail.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> -static inline bool check_for_semihosting(CPUState *cs)
> +/*
> + * Do semihosting call and set the appropriate return value. All the
> + * permission and validity checks have been done at translate time.
> + *
> + * We only see semihosting exceptions in TCG only as they are not
> + * trapped to the hypervisor in KVM.
> + */
> +static void handle_semihosting(CPUState *cs)
>  {
>  #ifdef CONFIG_TCG

Let's move the ifdef outside the function...

> -    if (check_for_semihosting(cs)) {
> +    if (cs->exception_index == EXCP_SEMIHOST) {
> +        handle_semihosting(cs);
>          return;
>      }

... and put another one here.

Peter described how we can't get EXCP_SEMIHOST here from kvm, and suggested an
assert.  Well, the assert is already present just below:

    assert(!excp_is_internal(cs->exception_index));

All we need to do is not return early beforehand.


r~

