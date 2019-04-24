Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251F8C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 02:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBB121773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 02:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AF/pCFvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBB121773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ7UN-00075Q-RP
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 22:18:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7TE-0006ht-4d
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7TD-00011H-A4
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:17:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:37223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ7TD-00010A-4f
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:17:11 -0400
Received: by mail-pf1-x432.google.com with SMTP id 8so8459335pfr.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=MjRZP6PAH0DOOAZPj/Uiem5ZT7K5TgESGXX3wbk8UMM=;
	b=AF/pCFvG6XRq8/N08KbhpeYLIaqs/+kRyBKf0111/dWrPl3gsSz/xWyLboFfCM157H
	11qsZFj+T9+LAE08woLEgHOOjE8FsJZklbI2MtfqsPbmKeu3xu0MVbJGY+I9UgDwAYcq
	xJdpvRclwu/1DYOT+FMNyXggObEFsFUxgNQpJf6uwI/u72/CzI0LCz41znUk0FyOpkxk
	Vt+tty6QxSrlOm0eh1m3vjtnZFQ4Q1NqHEksopJYMcde45bE+irYr7Ty9k9uK62aPnn3
	XXVAfHOBFG34LQbPoOx3ySUnAOi01TrCbQiHexUJbi8jkByE+KKzHLy0gPfsBAfZD4sK
	4TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MjRZP6PAH0DOOAZPj/Uiem5ZT7K5TgESGXX3wbk8UMM=;
	b=nNc/chrmgTpJoTIXR87wueFWa/rLaR/9smsM1zjqo+CZOefe1ymmiMK9GYOHjDcSuR
	sLlJoLDiAB+uIhHMAl3F4+wRqcHOg02+0wtOtUXAIA0eekIX8NLt/g17NFfPq5RnP3mk
	QfsEFK69BYxDbImpEmdg1OEQC7bQi7EC3BtJ+Ccr9vvUOTKJM3iCnu8rc08oCEL/qkjQ
	OLu4bBJszEEXHStSsGJkT028zkP1kcCNngPX/IrcNwVu6seelJH3IiLzwl0l3vO1KFde
	BYLSm/OVotefGEBIzzKZXuH5EbK0xboZfqPFSt1DbUvSw08TBmlcQ7ExZCLw7lwpEwof
	LslA==
X-Gm-Message-State: APjAAAXTIgSIoEfk7GV7xVXK/IZsoxg92SYV4H1d62XPLxPwKqvPpuYC
	cDCJd6FR82W/CAHTonmCHh19Csd0gbU=
X-Google-Smtp-Source: APXvYqyQd9MPm9pdbNVYtcfOwGeiWgrLv5JECp3+qItcCJO9B78+1DIFFEZNjEBahGb12ekzPNwkcA==
X-Received: by 2002:aa7:8518:: with SMTP id v24mr23345152pfn.219.1556072229453;
	Tue, 23 Apr 2019 19:17:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	u17sm22319753pfn.19.2019.04.23.19.17.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 19:17:08 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-25-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b16e2960-e35d-7dc2-2613-3d29a0d7f735@linaro.org>
Date: Tue, 23 Apr 2019 19:17:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-25-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::432
Subject: Re: [Qemu-devel] [PATCH 24/26] target/arm: Implement VLSTM for v7M
 CPUs with an FPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424021706.DU1a8FzGS8omWXErbTkeJuPxMOk_LnNQh81eh_rkmm8@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Implement the VLSTM instruction for v7M for the FPU present case.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       |  2 +
>  target/arm/helper.h    |  2 +
>  target/arm/helper.c    | 84 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate.c | 15 +++++++-
>  4 files changed, 102 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


